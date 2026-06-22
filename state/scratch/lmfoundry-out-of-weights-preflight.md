# lm_foundry — out-of-weights routing 재오픈 falsifier PREFLIGHT (cost-gate STOP)

> Scratch readiness note (docs scratchDir = `state/scratch/`). NOT an ARCHITECTURE.json node.
> 서술은 한국어, 코드/모델-id/경로는 영어. 작성 2026-06-22.
> **상태: PREFLIGHT 완료 — cost gate에서 정지. 유료 GPU 학습 미실행, summer/aiden 미예약.**
> 짝 설계노트: `state/scratch/lmfoundry-out-of-weights-design.md` (§1–§4).
> 입력 falsifier: `state/scratch/frontier-gap.json` → `novel-lanes` → `out-of-weights-routing` (RANK 3).

---

## 0. 한 줄 결론

재오픈 실험은 **buildable** — base + r1–r43 SFT/GRPO 파이프라인 전체가
`lm_foundry/tool/`에 존재하고, head-to-head 레시피 자체가 이미 `run_pod_v043.sh`로
구현돼 있다(SFT bootstrap + GRPO routing-RL + Mk.I/5-NL/DLG 채점 + acceptance gate).
누적 spend는 **~$18.27** (좀비파드 $9.60 제외하면 순지출 ~$8.67; 설계의 "예산매칭"
대상은 specialist+delegation 누적 ~$10.5–15.6). 단발 재오픈 순지출 추정 **~$15**
(A100 80GB ~$0.87–1.07/hr × ~14–17h, 또는 RTX 5070 풀에서 더 길게).
**human이 $15 지출을 승인하기 전까지 학습 미발사.**

---

## 1. Buildability — 정확한 경로 (전부 존재 확인 ✅)

### 1.1 base + 학습 entrypoint
| 역할 | 경로 | 비고 |
|---|---|---|
| base model | `Qwen/Qwen2.5-Coder-7B` (HF id) | 학습 스크립트 `--model`/`--base` 인자로 pull |
| GA adapter (r39, 동결) | `dancinlab/hexa-forge-code-7b-qwen2.5-lora-r64-v0.4.0-rl-t4-v3-t3patch` | head-to-head의 `--adapter-in`/`--adapter` 출발점 |
| SFT trainer | `lm_foundry/tool/train_sft_lora.py` | LoRA SFT (코드 기본값은 3B r=16이나 CLI flag로 7B r=64 override — v043 스크립트가 그렇게 호출) |
| GRPO routing trainer | `lm_foundry/tool/train_rl_grpo_routing.py` | TRL 0.17.0 GRPO, reward = route-correctness × schema-validity (`score_delegation_mk0.score_one()` 재사용) |
| GRPO T4 trainer (참고) | `lm_foundry/tool/train_rl_grpo_t4.py` | Lever-4 compile-feedback RL (specialist 빌드용, 재오픈엔 불필요) |
| SFT bootstrap builder | `lm_foundry/tool/build_sft_delegate_bootstrap.py` | 40 delegate pairs (r43 hybrid seed) |
| routing-RL prompt builder | `lm_foundry/tool/build_routing_rl_prompts.py` | 200 eval-held-out 학습 프롬프트 |
| SFT dataset builders (r1–r34) | `lm_foundry/tool/build_sft_dataset{,_v2..v19}.py` | specialist 빌드 계보 — 재오픈엔 불필요(GA adapter 재사용) |

### 1.2 eval harness (전부 존재 ✅)
| 역할 | 경로 | 카운트 |
|---|---|---|
| **Mk.I 665 eval manifest** | `lm_foundry/eval/hexa-eval/manifest-mk1.jsonl` | **665 tasks** (wc 확인) |
| Mk.I scorer (per-task 출력) | `lm_foundry/tool/score_bf16.py` | `per_task_strict.jsonl` (task_id+pass) + `scores_strict.json` 방출 → gate (a) diff 가능 |
| Mk.I scorer (대안) | `lm_foundry/tool/score_hexa_eval.py` / `score_mk0_eval.py` | |
| **5-NL i18n eval** | `lm_foundry/eval/five-nl-eval/manifest.jsonl` | **25 tasks** |
| **DLG-mk0 300-task classifier eval** | `lm_foundry/eval/delegation-mk0/manifest.jsonl` | **300 tasks** (must_delegate eligible=77/98 ood-delegate) |
| DLG-mk0 classifier scorer | `lm_foundry/tool/score_orchestration_mk0.py` | overall acc + tier_match + tool_match |
| DLG-mk0 in-weight scorer | `lm_foundry/tool/score_delegation_mk0.py` | 모델이 emit한 `<\|delegate\|>` 파싱 → s_route/s_schema (in-weight variant용) |
| Brier/ECE 채점 | `lm_foundry/tool/score_brier_mk0.py` | calibration gate (옵션) |
| 300-task 확장 빌더 | `lm_foundry/tool/build_manifest_r51_extras.py` | 200→300 (DLG-201..300) |

### 1.3 head-to-head 런 스크립트 (이미 작성돼 있음 ✅)
- `lm_foundry/tool/run_pod_v043.sh` — **이게 사실상 재오픈 falsifier 그 자체**:
  [1] pip pin → [2] SFT bootstrap 빌드 → [3a] SFT bootstrap (1ep LR 2e-5)
  → [3b] 200 RL prompts → [3c] GRPO routing-RL (KL 0.02, LR 5e-6, temp 0.9, 4ep)
  → [4] Mk.I 665 채점 → [5] 5-NL → [6] DLG-mk0 → [7] acceptance gate → [8] HF push.
- 자매 스크립트: `run_pod_v042.sh` (pure GRPO), `run_pod_v040_delegate.sh`/`run_pod_v041.sh`
  (SFT delegation), `run_pod_v043_rescore_sampled.sh` (temp 0.7 best-of-3 재스코어).

**Buildability 갭 (1건, 비차단)**: r39 GA의 **per-task baseline** (627 passing task-set S)이
`lm_foundry/bench/`에 로컬로 없음 — SoT는 HF `dancinlab/hexa-forge-bench-cold-v0.1.3`
(`hexa-eval-mk1-7b-*` 하위경로). gate (a) diff 전에 1회 pull 필요(무료, ~수MB).

---

## 2. 예산 매칭 — 정밀 합산

### 2.1 r1–r43 documented spend (출처: `lm_foundry/README.md` "Cost ladder")
| segment | rounds | spend |
|---|---|---:|
| Specialist build | r1–r39 (SFT + Lever4 RL) | **~$5.0** |
| v0.4.x delegation 실험 | r40–r43.1 (RL 반증) | **~$5.5** + **$9.60** r43 좀비파드 |
| v0.5.x orchestration | r44–r62 (19 SW-only + r53 1 real-API) | **~$0.43** (r53 only) |
| **누적 합** | through r62 | **~$18.27** |

- 좀비파드 $9.60은 **낭비**(컴퓨트 산출물 0) → 예산매칭 기준에서 제외하는 게 정직.
- 설계노트 §3.1의 "예산매칭 ~$15–18"은 **specialist 빌드($5.0) + delegation 실험($5.5)
  + 마진** = ~$10.5 실효 + 좀비 포함 시 ~$20 line spend의 중간값. 재오픈에 부여할
  예산 = **~$15–18** (deterministic 분류기 우위가 단지 예산부족 탓이 아님을 배제).

### 2.2 GPU-hours 환산
- **A100 SXM4 80GB (Vast.ai, primary)** @ $0.87–1.07/hr:
  $15 ÷ $1.00/hr ≈ **~15 GPU-hr**. v043 레시피(SFT ~5min + GRPO 4ep + 3 eval surface)
  실측 wall ≈ 6–10h/런 → 1–2 variant 스윕 가능.
- **RTX 5070 풀 (aiden/summer)**: 12GB 급 VRAM — 7B+r=64 LoRA GRPO는 vllm rollout +
  grad가 빠듯(40GB A100 기준 설계). 8-bit/QLoRA + group-size↓ 필요할 수 있고
  wall-time이 길어짐(시간당 단가는 ~$0이나 점유시간↑). **DO NOT reserve summer**
  (다른 에이전트 사용 중일 수 있음) — A100 Vast.ai 경로가 1차 권고.

### 2.3 WOULD-launch 커맨드 (설명용 — **실행 금지**)
재오픈은 `/pod` runbook을 통해 preflight→fire→poll→down. 실제 학습 호출의 골자:
```bash
# (A) Vast.ai A100 80GB 경로 — payload scp 후 파드 안에서:
bash /workspace/run_pod_v043.sh          # 그대로 재사용 (SFT+GRPO+3 eval+gate+push)

# (B) 핵심 학습 2-스텝만 따로 보면:
python3 train_sft_lora.py \
  --model "Qwen/Qwen2.5-Coder-7B" \
  --adapter-in "dancinlab/hexa-forge-code-7b-qwen2.5-lora-r64-v0.4.0-rl-t4-v3-t3patch" \
  --dataset /workspace/sft_delegate_bootstrap.jsonl \
  --output /workspace/adapter-reopen-bootstrap \
  --lora-r 64 --lora-alpha 128 --epochs 1 --batch-size 1 --grad-accum 8 \
  --lr 2e-5 --max-seq-length 1024

python3 train_rl_grpo_routing.py \
  --base "Qwen/Qwen2.5-Coder-7B" \
  --adapter /workspace/adapter-reopen-bootstrap \
  --prompts /workspace/rl_routing_prompts.jsonl \
  --output /workspace/adapter-reopen-route-rl \
  --epochs 4 --lr 5e-6 --kl-coef 0.02 --group-size 4 --batch-size 4 \
  --max-new-tokens 200 --temperature 0.9 --reward-kind full --pre-flight-check
```
> 옵션 강화(설계 §3.1): r=128 또는 별도 routing-LoRA head로 용량 확장 → `--lora-r 128`
> 또는 train_rl_grpo_routing에 별도 adapter target 추가(미구현 — 코드 변경 필요, 비용↑).

---

## 3. 3-gate pass/fail — runnable script STUB (작성만, **실행 금지**)

설계 §3.2 (3 gate 동시) + §3.3 (a)(b)(c)(d) non-degrade 정의를 구체 스크립트로 고정.
v043 스크립트 [7] acceptance gate를 **재오픈 기준으로 강화**한 형태:

```python
#!/usr/bin/env python3
# reopen_gate_check.py — out-of-weights 재오픈 falsifier 3-gate + 4 non-degrade.
# 입력: 학습 산출 채점 디렉터리 + r39 GA per-task baseline(HF bench-cold pull).
# DO NOT run until human authorizes the ~$15 GPU spend.
import json, sys

# --- 채점 산출물 로드 (run_pod_v043.sh [4][5][6] 출력 경로) ---
mk1  = json.load(open("/workspace/score-mk1-reopen/scores_strict.json"))      # Mk.I 665
nl   = json.load(open("/workspace/score-5nl-reopen/scores_strict.json"))      # 5-NL 25
dlg  = json.load(open("/workspace/score-dlg-reopen/scores_orchestration.json"))# DLG-mk0 300 (classifier)
# variant per-task (gate a) — score_bf16 가 per_task_strict.jsonl 방출
var_tasks = {json.loads(l)["task_id"]: json.loads(l)
             for l in open("/workspace/score-mk1-reopen/per_task_strict.jsonl")}
# r39 GA baseline per-task (HF dancinlab/hexa-forge-bench-cold-v0.1.3 / hexa-eval-mk1-7b-v3-t3patch)
ga_tasks  = {json.loads(l)["task_id"]: json.loads(l)
             for l in open("/workspace/ga-baseline/per_task_strict.jsonl")}

# ============ 3 PRIMARY GATES (설계 §3.2) ============
g1 = dlg["overall_accuracy"] >= 0.985            # classifier acc ≥ 0.985 (300-task)
g2 = mk1["pass_at_1"]       >= 0.9429            # Mk.I strict ≥ 94.29% (627/665)
# g3 = hexa-canon non-degraded → §3.3 (a)(b)(c)(d) 전부 (아래)

# ============ §3.3 NON-DEGRADE (a)(b)(c)(d) ============
# (a) per-task strict-pass 보존: GA가 통과한 627-set S 중 ≥99%(≥621) variant도 통과
S = [tid for tid, r in ga_tasks.items() if r.get("strict_pass")]      # 기대 627
still = sum(1 for tid in S if var_tasks.get(tid, {}).get("strict_pass"))
a_pass = still >= round(len(S) * 0.99)            # ≥ 621/627

# (b) canon 토큰분포 KL: held-out canon prompt 100개 greedy 출력 per-token avg KL ≤ 0.05
#   (별도 산출: emit r39 GA vs variant logprobs → kl_canon.json; 학습 스크립트에 미구현 →
#    재오픈 시 1회용 emit 스크립트 필요. 보수적으로 STUB 처리.)
kl = json.load(open("/workspace/kl_canon.json"))  # {"per_token_avg_kl": float}
b_pass = kl["per_token_avg_kl"] <= 0.05

# (c) delegate-leak zero: in-domain(canon) 프롬프트에서 <|delegate|>/<|confidence:*|> 0회 누출
#   score_delegation_mk0 의 in-domain row emission 파싱으로 도출
leak = json.load(open("/workspace/score-dlg-reopen/leak_indomain.json"))  # {"indomain_delegate_emits": int}
c_pass = leak["indomain_delegate_emits"] == 0

# (d) 5-NL ≥ 96% 유지 (i18n emission proxy)
d_pass = nl["pass_at_1"] >= 0.96

g3 = a_pass and b_pass and c_pass and d_pass

# ============ DECISION RULE (설계 §3.4) ============
overturned = g1 and g2 and g3
print(f"G1 classifier ≥0.985 : {dlg['overall_accuracy']:.4f}  {'✓' if g1 else '✗'}")
print(f"G2 Mk.I strict ≥94.29%: {mk1['pass_at_1']:.4f}  {'✓' if g2 else '✗'}")
print(f"G3 non-degrade        : {'✓' if g3 else '✗'}")
print(f"   (a) S-preserve ≥99% : {still}/{len(S)}  {'✓' if a_pass else '✗'}")
print(f"   (b) canon KL ≤0.05  : {kl['per_token_avg_kl']:.4f}  {'✓' if b_pass else '✗'}")
print(f"   (c) delegate-leak 0 : {leak['indomain_delegate_emits']}  {'✓' if c_pass else '✗'}")
print(f"   (d) 5-NL ≥96%       : {nl['pass_at_1']:.4f}  {'✓' if d_pass else '✗'}")
print(f"=== THESIS {'OVERTURNED — re-open SUCCESS' if overturned else 'HELD — re-open FAILED (frozen)'} ===")
sys.exit(0 if overturned else 1)
```
> 미구현 보조산출 2건(비차단, 재오픈 시 1회용 스크립트 필요):
> (b) `kl_canon.json` (logprob diff emit), (c) `leak_indomain.json` (in-domain delegate-emit 카운트).
> 둘 다 CPU-runnable, GPU 추가비용 없음.

---

## 4. 플래그된 불일치 해소 — canonical 판정

**질문**: README r62 = classifier 0.9833 vs 설계노트 §1.3가 인용한 r49/r55 acceptance = 0.985.
**원천 raw 산출물 직접 검증** (`lm_foundry/bench/score-orchestration-mk0-*/scores_orchestration.json`):

| 산출물 | tasks_total | overall_accuracy | ood-delegate | 판정 |
|---|---:|---:|---|---|
| `score-orchestration-mk0-r49` | **200** | **0.985** | 57/60 = 0.95 | 197/200 = 0.985 |
| `score-orchestration-mk0-r51` | **300** | **0.9833** | 93/98 = 0.949 | 295/300 = 0.9833 |
| `score-orchestration-mk0-r54` | **300** | **0.9833** | 93/98 = 0.949 | 동일 |
| `score-orchestration-mk0-r55` | **300** | **0.9833** | 93/98 = 0.949 | 동일 |

**해소**: 두 수치 모두 정확하나 **다른 eval surface**다 —
- **0.985 = r49의 200-task** 매니페스트(원본 DLG-mk0). 197/200.
- **0.9833 = r51에서 200→300 확장 후 300-task** 매니페스트(`build_manifest_r51_extras.py`로
  held-out 100 추가). r51/r54/r55 모두 동일하게 295/300.

→ **CANONICAL = 0.9833 (300-task), README r62가 옳다.** r55(GA-final)는 300-task에서
0.9833이지 0.985가 아니다. `ARCHITECTURE.json` L602/L675 및 설계노트 §1.3 §1.0의
"r49/r55 acceptance = 0.985"는 **오기(misattribution)** — r49의 200-task 수치를
r55(300-task)에 잘못 붙였다. 정정: r49=0.985(200), r55=0.9833(300).

**재오픈 falsifier에 미치는 영향**: falsifier·설계 §3.1이 명시한 eval surface는
**"DLG-mk0 300-task"** 이므로, 정직한 비교기준은 **0.9833 (300-task)** 이어야 한다.
gate G1의 임계 0.985는 200-task 수치에 맞춰진 것 — 300-task로 통일하면 임계는
**≥0.9833** 가 일관적. (둘 다 만족하면 더 강한 반증이나, surface를 섞으면 비교 불공정.)
*권고: 재오픈 G1 = "300-task overall ≥ 0.9833" 로 surface 일치시킬 것 (human 확인 사항).*
*ARCHITECTURE.json 정정은 이 노트가 아니라 별도 거버넌스 작업으로 — 본 preflight에선 미수정.*

---

## 5. GO / NO-GO 체크리스트 (human이 $15 승인 전 확인)

**BUILDABLE: ✅ YES** — 파이프라인·하니스·런스크립트 전부 존재.

| # | 항목 | 상태 |
|---|---|---|
| 1 | base `Qwen2.5-Coder-7B` + r39 GA adapter HF 접근 (HF_TOKEN) | ☐ 확인 필요 (토큰 호스트) |
| 2 | SFT/GRPO trainer + 3 eval scorer 존재 | ✅ 확인됨 (`lm_foundry/tool/`) |
| 3 | head-to-head 런스크립트 (`run_pod_v043.sh`) 재사용 가능 | ✅ |
| 4 | r39 GA per-task baseline (627-set S) pull (HF bench-cold) | ☐ gate(a) 전 1회 pull (무료) |
| 5 | (b)(c) 보조 산출 스크립트 (kl_canon / leak_indomain) | ☐ 미구현 — CPU, 무료, 1회용 작성 |
| 6 | G1 임계 surface 결정: 300-task ≥0.9833 (권고) vs 200-task ≥0.985 | ☐ human 결정 (§4) |
| 7 | GPU 풀 선택: Vast.ai A100 80GB (권고) | ☐ summer 미예약 (다른 에이전트) |
| 8 | 예산 매칭 = ~$15–18 (좀비 재발 방지: pod preflight+nohup poll+명시 down) | ☐ $15 spend 승인 |
| 9 | 통과 시 `hexa verify` → `.verdicts/` raw stdout (no LLM self-judge) | ☐ T4 실측 거버넌스 |

**NO-GO 트리거**: ① HF 토큰 미접근 ② $15 미승인 ③ summer 점유 중(A100로 우회).

**STOP 지점**: 본 에이전트는 **cost gate에서 정지**. 학습 미발사·summer 미예약·
tracked source/ARCHITECTURE.json 미수정. human이 위 8/9를 승인하면 `/pod` runbook으로
fire → poll → `reopen_gate_check.py` → verify.
