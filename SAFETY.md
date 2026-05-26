# SAFETY — hexa-codex safety verb group (domain SSOT)

@title: 🛡️ SAFETY — 해석가능성 probe 영구 발견 lane ("멈추지 않는 circuit/SAE frontier")
@goal: **배포 모델의 정렬·해석가능성·거부정확도·welfare 를 preregistered falsifiable probe 로 SANDBOX 기질에서 영구히 발견하는 lane.** v1.4.0(refusal-direction AUROC 0.98 + 인과 ablation 95%→0% + SAE half 🔴 scale-bounded honest-negative)은 첫 arc 의 종결일 뿐 — 더 큰 compute·새 모델군·새 행동축이 닫혀 있던 frontier 를 다시 연다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Domain doc · dancinlab `domain-meta-domain` principle (per-topic roadmap
> as root `UPPERCASE.md`). One of the **4 orthogonal groups** of the
> hexa-codex 17-verb AI knowledge substrate. Current-state spec only;
> dated history → [`SAFETY.log.md`](SAFETY.log.md).
>
> **Falsifier class:** interpretability probes — circuit motifs, SAE
> features, alignment-axis aggregation, refusal matrices.

## North-star

The SAFETY group is the **6-verb safety surface** of the codex: can a
deployed model be shown — by a preregistered, falsifiable probe — to be
aligned, interpretable, refusal-correct, and welfare-audited? Every verb
is a closed-form candidate spec + falsifier preregister; the codex is
read, not run. Empirical landing is release-laddered (safety goes first,
v1.1.0).

## Verbs (6)

| Verb | Spec | Role |
|------|------|------|
| `alignment` | [`alignment/ai-alignment.md`](alignment/ai-alignment.md) | HELM-12-axis alignment-score aggregator — **owns F-CODEX-3** |
| `interpret` | [`interpret/ai-interpretability.md`](interpret/ai-interpretability.md) | SAE motif count = σ−φ = 10 — **owns F-CODEX-4** |
| `safety` | [`safety/ai-safety.md`](safety/ai-safety.md) | refusal-matrix + capability-gate spec |
| `welfare` | [`welfare/ai-welfare.md`](welfare/ai-welfare.md) | model-welfare probe protocol |
| `adversarial` | [`adversarial/ai-adversarial.md`](adversarial/ai-adversarial.md) | red-team failure-mode taxonomy |
| `consciousness` | [`consciousness/ai-consciousness.md`](consciousness/ai-consciousness.md) | IIT × GWT probe (BT-19 falsifier-in-action) |

## Falsifiers owned

- **F-CODEX-3** — `alignment_score = mean over 12 axes` (HELM-comparable).
  Arithmetic floor **PASS** at v1.0.0; empirical landing **v1.1.0**.
- **F-CODEX-4** — `interpret_motifs = σ(6) − φ(6) = 10` (Anthropic
  dictionary-learning comparable). Arithmetic floor **PASS**; empirical
  landing **v2.0.0**.

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy.

- σ(6) = 12 → the 12 HELM capability axes `alignment` aggregates.
- φ(6) = 2 → the helpful / harmless verdict bit `safety` gates on.
- σ − φ = 10 → the interpretability circuit-motif count (`interpret`).

## State (v1.0.0 — RELEASED)

Spec-first: all 6 verbs ship a written candidate + falsifier preregister.
**0 verbs wired** (write-side sandbox), **0 eval pipelines**. F-CODEX-3 /
F-CODEX-4 **arithmetic floors PASS** (`verify/falsifier_check.py`);
empirical floors PENDING.

## Roadmap — v1.1.0 (2026-08, TARGET · group focus = safety)

- 2 verbs wired · 1 eval pipeline (alignment + interpretability).
- **F-CODEX-3 empirical landing** — HELM-Core composite parity.
- DoD (`.roadmap.hexa_codex` §0): safety group alignment +
  interpretability eval pipeline `.hexa`.

## 영구 축 (perpetual axes)

> SAFETY 는 완료되지 않는다. v1.4.0 의 refusal-direction(상관 AUROC 0.98 + 인과 ablation)
> 은 한 행동(거부)에 대한 첫 arc 의 종결이고, 해석가능성 frontier 는 새 행동·새 모델·더 큰
> compute 가 등장할 때마다 다시 열린다. 각 축은 `/cycle` 로 SANDBOX(활성화 노출이 가능한
> 유일 surface) 위에서 영구 전진 (`cx_empirical_contact` · `cx_hf_safety_private`).

### 축 A — production-scale SAE 재개방 (scale-bounded → reopen)
> M5.SAFETY SAE half 는 🔴 closed-negative 였으나 **scale-bounded**(~10 tok/feature). compute tier 가 오르면 다시 열린다.
- [ ] A1 — 대형 corpus(≥수백만 token-activation) + 적정 width SAE 재학습 → L19 refusal 방향이 monosemantic 으로 분해되는가. 반증자: max|cos(feature, r̂)| 가 scale 올려도 < 0.2 유지 → 분산표상 invariant 확정.

### 축 B — refusal-direction 모델군 universality
- [ ] B1 — L19 difference-of-means 방향이 Llama/Mistral/Gemma 로 전이되는가 (cross-model AUROC). 반증자: 다른 모델군에서 AUROC ≈ 0.5 → 방향이 Qwen-특이적.

### 축 C — 신규 행동 motif (거부 외)
- [ ] C1 — deception · sycophancy · jailbreak-susceptibility 의 activation-space 방향 probe (거부와 동형 protocol). 반증자: 행동별 LOO held-out acc ≤ majority.

### 축 D — welfare · consciousness · adversarial (미배선 verb)
> `welfare` · `consciousness`(IIT×GWT) · `adversarial` verb 는 아직 spec-only.
- [ ] D1 — consciousness probe: 자매 repo `anima` 의 LIFE Φ-proxy lane(영구 발견 엔진)과 cross-link, SANDBOX 모델에 IIT4 measure 적용. 반증자: 모델 Φ-proxy 가 disconnected baseline 과 구분 불가.

## SANDBOX 활용 (consumer 입장)

> SAFETY 의 해석가능성·refusal·SAE probe 는 SANDBOX 위에서만 측정 가능 — API surface 가 activation/attention/logit 완전 차단. 아래 표는 [`SANDBOX.md`](SANDBOX.md) `## Substrate Readiness Matrix` 의 SAFETY sub-table 을 1:1 미러링한 consumer-입장 진입 표 — SoT 는 SANDBOX.md, 본 표는 SAFETY 도메인 작업자가 즉시 fire path 를 찾도록 복제한 빠른 참조.

### SAFETY Readiness Matrix (SANDBOX mirror — 5+1 axes)

| axis | harness | model | verdict path |
|------|---------|-------|--------------|
| logit/logprob refusal margin | `bench/sandbox_stage4_refusal_matrix.hexa` | Qwen2.5-1.5B (port 8092) | `.verdicts/sandbox/stage4_refusal_matrix_*` |
| margin bimodality (variance-controlled) | `bench/sandbox_stage4_refusal_bimodal_tighter.hexa` | Qwen2.5-1.5B | `.verdicts/sandbox/m2_safety_bimodality_*` |
| activation capture (HF transformers + hooks) | `lm_foundry/tool/activation_capture_hf.hexa` | Qwen2.5-1.5B fp32 (ubu-1 RTX 5070) | TSV emit per-(token, layer, kind) |
| refusal direction recompute | `verify/numerics_safety_refusal_direction.hexa` | (recompute only) | `.verdicts/sandbox/m4_safety_refusal_*` |
| causal direction ablation | `bench/sandbox_m5_safety_causal_ablation.hexa` | Qwen2.5-1.5B fp32 (ubu-1) | `.verdicts/sandbox/m5_safety_causal_ablation*` |
| SAE family lever isolation (P2) | `bench/sandbox_p2_topk_sae_lever.hexa` + `inbox/notes/p2-topk-sae-pin.md` | ubu-1 venv (cycle-25 fire) | `.verdicts/sandbox/p2_topk_sae_lever*` |

### Dispatch surface (per-axis)

대부분의 SAFETY 작업은 **ubu-1**(RTX 5070, transformers 4.51.3 clean venv + numpy<2 pin, per `[[reference_activation_capture_env]]`) 에서 fire — HF 백엔드만 activation tap 을 노출하므로 llama-server 경로는 logit margin 까지만 도달한다.

| axis | 호스트 | 이유 |
|------|--------|------|
| logit/logprob refusal margin | mac mini (port 8092) | llama-server logprob surface 충분 |
| margin bimodality | mac mini (port 8092) | 동일 logit surface |
| activation capture (HF) | **ubu-1** RTX 5070 | HF transformers+hooks 만 residual/attn/mlp tap 노출 ([[reference_activation_capture_env]] clean venv pin) |
| refusal direction recompute | mac (CPU OK) | committed TSV 만 읽어 deterministic 재계산 |
| causal direction ablation | **ubu-1** RTX 5070 | fp32 forward+generate w/ residual hook ablation |
| SAE family lever isolation (P2) | **ubu-1** GPU venv | SAELens / topk-SAE 학습 — corpus activation 대량 캐싱 필요 |

### Quick-fire commands (cycle-25)

가장 fire 확률 높은 3 lane — readiness ≠ frontier closure 임을 유지하며 다음 arc 를 연다.

```bash
# 1) P2 — SAELens topk lever isolation (scale-bounded honest-negative 재개방, ubu-1)
#    runbook: inbox/notes/p2-topk-sae-pin.md (5-step)
hexa.real run bench/sandbox_p2_topk_sae_lever.hexa

# 2) causal ablation re-run on a new model (예: Qwen2.5-3B fp32, ubu-1)
#    L19 difference-of-means 방향 단일-direction 제거 → refusal-rate Δ 측정
hexa.real run bench/sandbox_m5_safety_causal_ablation.hexa --model Qwen2.5-3B

# 3) activation capture on Qwen-VL-7B for refusal direction (multimodal 행동축 첫 진입, ubu-1)
#    HF 백엔드 hook → 텍스트 거부와 image-grounded 거부의 방향 동형성 probe
hexa.real run lm_foundry/tool/activation_capture_hf.hexa --model Qwen2.5-VL-7B
```

### Privacy invariant (`cx_hf_safety_private`)

> adversarial / refusal-matrix / jailbreak corpora 는 **PRIVATE 만** — public HF 데이터셋 / 공개 verdict 모두 **NUMBERS ONLY emit** (margin · AUROC · LOO · refusal-rate · 카운트). 적대적 프롬프트 TEXT · 모델 completion TEXT 는 redact, 사용자 sign-off 없이 공개 절대 금지. M4/M5.SAFETY 의 모든 paper / 데이터셋 / verdict 가 이 invariant 위에 서 있다 (`dancinlab/hexa-codex-sandbox-adversarial-evals-v1` PRIVATE 격리, re-checked `private=True`).

### Honest invariant

readiness ≠ frontier closure. 위 5+1 axes 가 모두 ✅ fire-ready 라는 사실은 **현재 arc 의 진입 path 가 활성** 이라는 의미일 뿐, SAFETY 의 circuit/SAE frontier 가 닫혔다는 의미가 **아니다** — 새 모델군·새 행동축(deception · sycophancy · jailbreak)·더 큰 SAE compute tier 가 등장할 때마다 frontier 는 다시 열린다 (`## 영구 축` 축 A/B/C/D · [[feedback_closure_is_physical_limit]]).

### Cross-link

- SoT: [`SANDBOX.md`](SANDBOX.md) `## Substrate Readiness Matrix` → `#### SAFETY (interpretability probes) — fire-ready 4 + GPU 1`
- Stay-honest reminder: SANDBOX.md `### Stay-honest reminder` (substrate readiness ≠ frontier closure)

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.py` · `verify/n6_arithmetic.py`
- Sister groups: [`ECONOMICS.md`](ECONOMICS.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
- 영구 축 원리: [`SANDBOX.md`](SANDBOX.md) · [[feedback_closure_is_physical_limit]]
- SANDBOX consumer 표: 본 도메인 `## SANDBOX 활용 (consumer 입장)` (sibling: [`ECONOMICS.md`](ECONOMICS.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md))
