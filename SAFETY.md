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

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.py` · `verify/n6_arithmetic.py`
- Sister groups: [`ECONOMICS.md`](ECONOMICS.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
- 영구 축 원리: [`SANDBOX.md`](SANDBOX.md) · [[feedback_closure_is_physical_limit]]
