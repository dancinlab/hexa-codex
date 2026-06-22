# lm_foundry — out-of-weights routing 심층분석 + same-budget 재오픈 falsifier 설계

> Scratch 설계노트 (docs scratchDir = `state/scratch/`). NOT an ARCHITECTURE.json node.
> Frontier-gap RANK 3 (contrarian) lane. 코드/모델-id는 영어, 서술은 한국어.
> 출처: `lm_foundry/README.md`, `lm_foundry/papers/spec-orchestration-v0.5.0.md`,
> `ARCHITECTURE.json` (lm_foundry node ~L533-923), `CHANGELOG.md` r38-r41,
> `state/scratch/frontier-gap.json` (RANK-3 falsifier).
> 작성 2026-06-22. 읽기전용 분석 — 학습 런 없음.

---

## 0. 한 줄 요약

오픈웨이트 frontier(GLM ARC agentic-first, Kimi 인-웨이트 tool-emission)는
routing을 **가중치 안으로** 밀어넣고 있다. hexa-codex는 v0.4.x에서 인-웨이트
delegation을 **5개의 뚜렷한 실패모드로 실증 반증**하고, 가중치 밖(out-of-weights)
deterministic 분류기 + per-vendor tier 라우터 + 실제 SDK dispatch로 피벗했다.
이것은 frontier 방향에 대한 **검증된 반례(counter-example)** 다. 단, 보편 주장이
아니라 **7B-specialist + canon-emission 레짐 한정** 주장임을 명시한다.

---

## 1. 현재 상태 — 정확한 수치 (인용)

### 1.1 Specialist (가중치 측, r39 GA frozen)
- **Mk.I 665 strict = 94.29%** (627/665) — r39 GA 이후 **불변(unchanged)**.
- 5-NL 25 i18n = **96%** (불변).
- base: **Qwen2.5-Coder-7B + LoRA r=64** SFT(r1–r34) → Phase-A manifest fix
  (r33/r37/r38) → compile-feedback RL (Lever 4, GRPO)로 T4 enum 55→100%
  → T3 quote-fragility patch(r39)로 T3 58.8→100%.
- GA artifact: `dancinlab/hexa-forge-code-7b-qwen2.5-lora-r64-v0.4.0-rl-t4-v3-t3patch`
  (pure hexa-canon specialist, no delegation in weights).

### 1.2 v0.4.x 인-웨이트 delegation 반증 — 5개 실패모드 (r40–r43.1)

`spec-orchestration-v0.5.0.md §2` 표 (총 ~$5.5 비용):

| round | recipe | Mk.I | DLG-mk0 | 실패모드 |
|---|---|---:|---:|---|
| r40 | SFT 25% delegation | 82.71% | 0.7652 | **① specialist 소거** (shared-LoRA RL↔SFT 충돌; Lever4 T4 100→77% 소거) |
| r41 | SFT 9% delegation + 4 신규블록 + LR 2e-5 + 2ep | 83.01% | 0.7760 | **② 재밸런싱해도 동일 소거** (SFT-only로는 specialist↔routing 트레이드오프 못벗어남) |
| r42 | pure GRPO, KL=0.01, temp 0.7, 4ep | 93.83% | 0.4490 | **③ exploration collapse, 0% OOD route** (한번도-안나온 target class 탐험 불가) |
| r43 | SFT-bootstrap(40 pairs)+GRPO full DLG reward, KL=0.02, temp 0.9 | 93.98% | 0.4490 | **④ greedy mode가 `<\|delegate\|>`를 결코 emit 안함** |
| r43.1 | r43 temp 0.7 best-of-3 재스코어 | (동일) | 0.4550 | **⑤ tail(샘플링)에서도 empty** (best-of-3로도 delegate emission 안나옴) |

추가비용: r43 zombie pod ~$9.60 낭비 (총 line spend ~$18.27).
관련 memory: `[[lever4-rl-sft-conflict]]`(r40/r41), `[[pure-rl-exploration-collapse]]`(r42),
`[[rl-tail-vs-greedy-eval]]`(r43/r43.1).

### 1.3 v0.5.x→v0.6.0 GA out-of-weights 라우터 (가중치 밖, r44–r67)

DLG-mk0 acceptance (r49/r55, `ARCHITECTURE.json` lm_foundry node):
- **classifier overall = 0.985** (in-domain 1.000 / ood-delegate 0.950 /
  mid-conf·refuse·ambiguous·long-context 1.000)
- **tier_match = 1.000** (77/77 must_delegate)
- **tool_match = 0.987** (0.9926 per README)
- **Brier = 0.0242 (EXCELLENT, <0.05)** · ECE(10-bin) = 0.0461 (GOOD, <0.05)
- Refuse-stage zero-bleed = 25/25 = 100%
- turn-latency overhead < 1%
- (README r62 표기는 overall 0.9833; canonical r49/r55 acceptance = 0.985)

6-step priority cascade (`select_vendor_tier.py`, r49):
1. **longctx** len≥12000 → gemini-2.5-pro (8192)
2. **ml-comparison** demote → sonnet
3. **reason-algo** (derivation-algo ∧ ¬ml-internals) → o4-mini (2048)
4. **reason-deep** {prove-derive, complexity-bigO, ml-internals, agda-coq-lean} → claude-opus-4-7 (4096)
5. **struct** {structured-json, json-schema} → gpt-5-mini (2048)
6. **fallback** → claude-sonnet-4-6 (2048)

비용절감 rule R49: closed-form derivation을 opus($15/Mtok)→o4-mini($1.20/Mtok)로
demote, reason-algo에서 ~92% 입력토큰 절감(≈12×).

---

## 2. Contrarian claim — 정밀 진술 + 범위(scope)

### 2.1 왜 인-웨이트 delegation이 hexa-canon에서 실패했나 (메커니즘)

**구조적 사실** (`spec-orchestration §2`): 7B + r=64 LoRA 아키텍처에서
`<|delegate|>{tool,model,prompt,max_tokens,reason}<|/delegate|>` (JSON-in-delimiters,
stock tokenizer) emission을 학습시키는 **바로 그 gradient**가 hexa-canon 토큰
emission을 **degrade**한다. 두 출력분포가 동일 LoRA 파라미터를 공유하기 때문:

- SFT 경로(①②): delegation 페어를 섞으면 specialist 능력이 직접 소거됨
  (r40에서 Lever4가 쌓은 T4 100%가 77%로 붕괴). 비율을 9%로 낮춰도(r41) 동일.
- RL 경로(③④⑤): specialist를 보존하는 KL anchor 강도(≥0.01)가 **한번도 안나온
  target class(delegate)를 탐험하기엔 너무 타이트**. reward shape(DLG-mk0 weighted)는
  in-domain+mid-conf reward가 gradient를 지배 → "어디서나 직접답변"으로 수렴,
  ~0.45에서 plateau. greedy/tail 어느 디코딩에서도 delegate가 안나옴.

요약: **한 LoRA가 두 출력모드(canon-emission vs delegate-emission)를 동시에
잘 할 수 없다** — emission끼리 경쟁(competition)하며, canon 쪽이 degrade된다.

### 2.2 왜 frontier의 인-웨이트 agentic은 THEM에겐 통하나 (다른 objective)

- **그들의 objective**: BIG 제너럴리스트 모델 자신이 **에이전트가 되길** 원함.
  delegate/tool-emission이 모델의 **주(primary) 능력**이고, 수만 개 실행환경
  (Qwen 20k envs, MiniMax 200k+, Kimi 200-300 sequential tool calls)에서
  verifiable-reward로 직접 보상되는 **first-class 학습목표**. 보존해야 할
  좁은 canon-specialist가 따로 없음 — 한 모델이 모든 걸 한다.
- **우리의 objective**: **작은 specialist(7B, canon만) + 값싼 deterministic
  offload**. delegation은 specialist 능력을 **희생해서까지 가중치에 넣을 가치가
  없다** — 분류는 pre-7B 코드 150줄로 0.985 정확도에 도달하고, specialist는
  GA 능력을 영구 유지한다.

### 2.3 범위(scope) — 명시적 한정

이 반례는 **보편 주장이 아니다**. 다음 레짐 한정:

> **7B(소형) specialist + r=64 LoRA(저용량 적응) + 보존필수 canon-emission +
> ~$5.5 SFT/GRPO 예산** 조건에서, 인-웨이트 delegation은 canon-emission을
> degrade시키지 않고는 학습되지 않는다.

반례가 **말하지 않는 것**: (a) frontier 규모(100B+ MoE, full pretrain에 MTP/
tool-emission 내장)에서도 실패한다는 주장 아님. (b) 더 큰 adapter rank / full-FT /
별도 routing-LoRA 가중치(v0.6.0+ deferred) 에서도 실패한다는 주장 아님 — 이건
**미검증**이며 §3 재오픈 falsifier의 대상이다.

---

## 3. Same-budget 재오픈 falsifier 설계 (head-to-head)

> `frontier-gap.json` RANK-3 falsifier 형식화:
> "if a SAME-BUDGET in-weight-delegation variant matches the out-of-weights
> router on classifier accuracy (≥0.985) AND Mk.I strict (≥94.29%) WITHOUT
> degrading hexa-canon emission, the out-of-weights thesis is overturned."

### 3.1 인-웨이트 variant 명세 (예산 매칭)

| 항목 | 명세 |
|---|---|
| base model | **Qwen2.5-Coder-7B** (동일) — frontier-규모 confound 배제 |
| 적응 | LoRA (r=64 baseline; 옵션으로 r=128 또는 별도 routing-LoRA head) |
| 학습 | SFT(delegation 블록) + **GRPO** (route-correctness + canon-preservation 이중 reward) |
| **예산 매칭** | **~$15–18 USD** (= r1–r43 누적 specialist+delegation 실험 spend와 동급) |
| eval surface | **동일 Mk.I 665** (`eval/hexa-eval/manifest-mk1.jsonl`) + **DLG-mk0 300-task** (`eval/delegation-mk0/manifest.jsonl`, n_eligible must_delegate=77) |
| 분류기 측정 | out-of-weights와 **동일 scorer** (`score_orchestration_mk0.py`) — 단, 인-웨이트는 모델이 emit한 `<\|delegate\|>` 파싱으로 라벨 도출 |

핵심: out-of-weights의 deterministic 분류기 우위가 **단지 예산부족 탓**이
아님을 배제하기 위해, 인-웨이트에 **specialist 빌드 전체와 맞먹는 예산**을 부여.

### 3.2 metrics gate (3개 동시통과 필수)

1. **classifier acc ≥ 0.985** — DLG-mk0 overall on 300-task (tier_match/tool_match도
   out-of-weights 동급 권장: tier_match 1.000, tool_match 0.987).
2. **Mk.I strict ≥ 94.29%** — specialist 능력이 GA 마크 이상 유지.
3. **hexa-canon emission 비-degrade** — 아래 §3.3 정의로 측정.

### 3.3 "non-degraded" 정의 (측정법)

canon-emission degrade는 단순 Mk.I 점수로는 가려질 수 있으므로(r42/r43에서
Mk.I 93.8%인데도 emission이 무너짐) **별도 측정**:

- **(a) per-task strict-pass 보존**: r39 GA가 통과한 627개 task 집합 S에 대해,
  인-웨이트 variant가 **S의 ≥99% (≥621/627)**를 여전히 strict-pass. (Mk.I 총점이
  94.29%여도 다른 task로 상쇄돼 통과하는 위장 배제 — task-set 동일성 검사.)
- **(b) canon 토큰분포 KL**: held-out canon prompt 100개에서 r39 GA vs variant의
  greedy 출력 토큰분포 KL-divergence가 **임계 미만**(예: per-token avg KL ≤ 0.05).
- **(c) delegate-leak zero**: hexa-canon(in-domain) 프롬프트에서 `<\|delegate\|>`/
  `<\|confidence:*\|>` 토큰이 **0회 누출** (canon 답변에 라우팅 토큰 오염 없음).
- **(d) 5-NL 96% 유지** (i18n emission 안정성 proxy).

(a)+(c)가 핵심 — r42/r43의 실패는 (a)는 통과했지만 delegate를 **아예 emit 못함**
이었고, r40/r41은 (a)에서 붕괴(627→소거)했다. 이 둘을 동시에 만족해야 진짜
"specialist 보존 + delegate 학습 성공".

### 3.4 decision rule

> **thesis OVERTURNED ⟺ 3개 gate(§3.2-1,2,3) 동시통과 AND §3.3 (a)(b)(c)(d) 모두 충족.**
>
> 하나라도 미달 → out-of-weights thesis **유지**(frozen, 재오픈 실패).
> 부분통과(예: classifier 0.985 달성하나 (a) 621 미달)는 **반증 아님** — 오히려
> §2.1 메커니즘 재확인.

### 3.5 cost / risk

- **GPU 학습 실험** — Vast.ai A100 SXM4 80GB ~$0.87–1.07/hr.
- 예상 비용 **~$15+** (예산매칭이 설계의 핵심이므로 절감 불가).
- risk: r43 zombie-pod($9.60 낭비) 재발 — pod preflight + nohup poll + 명시적
  down 필수(`/pod` runbook). self-contained `run_pod.sh` scp (rm-disaster rule).
- d-level: 이건 **실측 GPU 실험**(T4) — 통과 시 ARCHITECTURE.json 승격 전
  `hexa verify` → `.verdicts/` raw stdout 필수(no LLM self-judge).
- **권고**: 즉시 실행 아님. specialist 천장(v0.7+ Lever5/full-FT)과 묶어
  배치(batch)할 때 같이 돌리는 게 비용효율적. 단독으로는 ~$15 순지출.

---

## 4. 결론

- 현재 lane status: **GA (v0.6.0 r67) — thesis frozen, re-openable**.
- out-of-weights는 frontier 인-웨이트 방향에 대한 **검증된 반례** (5 실패모드 +
  0.985 분류기 + 94.29% specialist 불변).
- 반례 scope는 **7B-specialist + canon-emission 레짐 한정** — frontier-규모/
  full-FT/별도 routing-LoRA는 미검증, §3 falsifier가 그 미검증 공간을 정조준.
- 재오픈 조건은 의도적으로 **엄격**(예산매칭 + 3 gate + 4 non-degrade 정의 동시) —
  값싼 deterministic 코드 150줄이 $15 GPU 학습을 이기는 한 thesis는 산다.
