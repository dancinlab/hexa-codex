# ECONOMICS — hexa-codex economics verb group (domain SSOT)

@title: 💰 ECONOMICS — AI 경제법칙 영구 측정 lane ("멈추지 않는 비용곡선 frontier")
@goal: **AI 경제법칙(train·infer·quality 비용곡선)을 SANDBOX 기질에서 verify-driven 으로 영구히 재측정·반증하는 lane.** v1.4.0(F-CODEX-2 🔴 τ̂=0.524 반증 + 2-성분 측정 비용모델)은 첫 arc 의 종결일 뿐 도메인의 종결이 아니다 — 새 모델·양자화·serving 기질이 등장할 때마다 비용법칙은 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Domain doc · dancinlab `domain-meta-domain` principle. One of the
> **4 orthogonal groups** of the hexa-codex 17-verb AI knowledge
> substrate. Current-state spec only; dated history →
> [`ECONOMICS.log.md`](ECONOMICS.log.md).
>
> **Falsifier class:** cost-curve fits — training / inference scaling
> laws checked against published model economics.

## North-star

The ECONOMICS group is the **3-verb cost surface** of the codex: what
does it cost to train a model of size N, to serve it at context length
C, and what quality does that buy? Each verb is a closed-form scaling
candidate fit against external reference models (Chinchilla / GPT-3 /
Llama-2 / PaLM / Claude 4.7); `train_cost` and `infer_cost` additionally
preregister a falsifier (F-CODEX-1 / F-CODEX-2).

## Verbs (3)

| Verb | Spec | Role |
|------|------|------|
| `train_cost` | [`train_cost/ai-training-cost.md`](train_cost/ai-training-cost.md) | Chinchilla-fit `N^J₂` scaling — **owns F-CODEX-1** |
| `infer_cost` | [`infer_cost/ai-inference-cost.md`](infer_cost/ai-inference-cost.md) | `context^τ = context^4` latency fit — **owns F-CODEX-2** |
| `quality_scale` | [`quality_scale/ai-quality-scale.md`](quality_scale/ai-quality-scale.md) | HumanEval+ / hexa-eval quality aggregate |

## Falsifiers owned

- **F-CODEX-1** — `training_cost ∝ N^(σ·φ) = N^24` (Chinchilla-fit).
  Arithmetic floor **PASS** at v1.0.0; empirical landing **v1.2.0**
  (parity vs Chinchilla 70B / GPT-3 175B / Llama-2 70B / PaLM 540B).
- **F-CODEX-2** — `inference_cost ∝ context^τ = context^4`.
  Arithmetic floor **PASS**; empirical landing **v1.3.0** (parity vs
  GPT-3.5 16k / Claude 2 100k / Gemini 1.5 1M / Claude 4.7 1M).

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy.

- J₂ = σ·φ = 24 → the `train_cost` scaling exponent `N^24`.
- τ(6) = 4 → the `infer_cost` context exponent `context^4`.
- φ(6)/σ(6) = 2/12 = 1/6 → the `quality_scale` loss-fit exponent
  `α = β = 1/6` (Chinchilla `loss = E + A·N^-α + B·D^-β`).

## State (v1.0.0 — RELEASED)

Spec-first: all 3 verbs ship a closed-form scaling candidate. **0 verbs
wired**, **0 eval pipelines** — production wiring is v1.2.0+ roadmap.

Verification surface (recipe §3 ladder — see `docs/closure_status.md`):

- `train_cost` (F-CODEX-1) / `infer_cost` (F-CODEX-2) — T1 algebraic +
  T2 numerical/solver + T3 published-ref parity all PASS; the closed-form
  arithmetic floor is self-proving via `verify/falsifier_check.hexa`.
  Empirical curve fits PENDING (F-CODEX-1 → v1.2.0, F-CODEX-2 → v1.3.0).
- `quality_scale` — reached recipe §3 closure on 2026-05-23, the first
  non-falsifier ECONOMICS verb to do so: T1 `calc_quality_scale.hexa`,
  T2 `numerics_quality_scale{,_solver}.hexa`, T3
  `numerics_quality_scale_parity.hexa` (8 + 10 + 10 + 10 checks).
- ECONOMICS 3-pillar cross-cutter
  `verify/numerics_economics_cross_pillar.hexa` (10 checks) ties the
  three verbs to one n=6 lattice: lattice closure σ·φ = n·τ = J₂,
  exponent recovery per verb (`N6_EXP·(J₂+1)=J₂` / `τ·n=J₂` /
  `α·σ=φ`), triad ordering 0 < α (1/6) < N6_EXP (24/25) < 1 < τ (4),
  3-pillar composite at the Chinchilla 70B / 1.4T / 8k anchor, and the
  quality↔infer orthogonality (quality_scale free of ctx, infer_cost
  free of (N,D)).
- ECONOMICS scaling-law sweep
  `verify/numerics_economics_scaling_laws.hexa` (10 checks) verifies
  the full closed-form ratio surface: q-side halving / 4× in N and D,
  train doubling in N and D, train ND quadrupling, infer ctx doubling
  and 4×, and the cost-vs-quality competition ratio
  `N6_EXP / α = 144/25 = 5.76` (per log doubling, training cost rises
  ~5.76× as fast as the quality reducible-loss term shrinks).
- ECONOMICS recipe §3 ladder report
  `verify/report_economics_ladder.hexa` (10 checks) emits the
  per-verb closure table and gates on all 3 verbs reaching
  `closure_pct = 100%` (T1+T2+T3) simultaneously, plus the X-ECON
  cross-cutter row 3/3 and the T4-stub row 3/3.
- ECONOMICS Pareto envelope
  `verify/numerics_economics_pareto.hexa` (10 checks) verifies the
  closed-form (N, D) ↔ (loss, train_cost) trade-off: iso-loss
  contour monotone, Lagrangian optimum `(N/D)^α = A/B` (for n=6:
  N/D ≈ 0.94 — almost symmetric), equal-reducible identity at the
  optimum, asymptotic E floor, poles at N → 0 / D → 0, monotone
  partials, iso-cost hyperbola `N·D = const`, and the
  n6-vs-Chinchilla allocation gap |D/N_n6 − D/N_chinchilla| > 15
  (n=6 predicts ≈ 1.07, Chinchilla published ≈ 20).

## Roadmap — v1.2.0 (2026-10, PLANNED · group focus = economics)

- 5 verbs wired cumulative · 2 eval pipelines.
- **F-CODEX-1 empirical landing** — `n = 6` training-cost scaling fit.
- DoD (`.roadmap.hexa_codex` §0): economics group training-cost /
  inference-cost `n = 6` scaling fit (GPT-4 vs Claude 4.7).

## M5.ECON release-gate criteria — formal

The M3.ECON harness `verify/numerics_economics_empirical_landing.hexa`
(commit 843b241, cycle-9) is the closed-form recompute that decides
the v1.2.0 / v1.3.0 release gates. The harness ships the structure
as a 10-check verifier; this section publishes the explicit pass /
defer / fail bands so the gates have a release criterion, not just
an open milestone. Honesty: today both gates are 🟠 INSUFFICIENT
(1 of 4 scale rungs on v1.2.0 · 0 of 4 context rungs on v1.3.0);
see `currently` row of the cross-ref table below.

### v1.2.0 — F-CODEX-1 empirical landing gate (`training_cost ∝ N^σφ = N^24`)

- **Data.** Stage-2 manifest accuracy on the `{0.5B, 1.5B, 3B, 7B}`
  scale grid (4 scale rungs minimum; the M3.SUBSTRATE saturation
  point is the upstream prereq — the 4 rungs come from that ladder).
- **Verifier.** `verify/numerics_economics_empirical_landing.hexa`
  (commit 843b241) check 8 — `check_f_codex_1_residual` invokes
  `f_codex_1_residual()` which runs the closed-form log-log OLS slope
  on `(SCALE_GRID_PARAMS, row_mean_live(STAGE2_ACCURACY_*))`.
- **Pass condition.** `f_codex_1_residual <= EPS_RESIDUAL_THRESHOLD`
  with `EPS_RESIDUAL_THRESHOLD = 0.10` (harness L124) AND all 4
  `STAGE2_ACCURACY_*` rows live (no `PENDING_SENTINEL = -1.0` row).
- **Defer condition.** `k_active_scales() < 2` → `f_codex_1_residual`
  returns `NAN_SLOPE` (= -999.0) and check 8 records DEFERRED.
- **Fail condition.** `k_active_scales() == 4` AND
  `f_codex_1_residual > 0.10` → verdict-line emits 🔴 FALSIFIED
  (harness L579–585, `exit(1)`).
- **Verdict tier.** 🟢 SUPPORTED-NUMERICAL minimum, 🔵
  SUPPORTED-FORMAL preferred (per recipe §3 ladder + g5 rubric).
- **Currently.** 🟠 INSUFFICIENT — `k_active = 1` (only 0.5B row is
  live from cycle-6 `.verdicts/sandbox/stage2_persona_scaled_summary.txt`;
  1.5B in flight from cycle-9 sibling-agent ada5; 3B + 7B PENDING).

### v1.3.0 — F-CODEX-2 empirical landing gate (`inference_cost ∝ context^τ = context^4`)

- **Data.** Per-context latency on the `{1k, 2k, 4k, 8k}` context
  grid (4 context rungs — harness `CONTEXT_GRID`, L211–216, anchored
  to the `CTX_REF = 8192` cross-verifier in
  `verify/numerics_economics_scaling_laws.hexa`).
- **Verifier.** Same `verify/numerics_economics_empirical_landing.hexa`
  check 9 — `check_f_codex_2_residual` invokes `f_codex_2_residual()`
  which runs the closed-form log-log OLS slope on
  `(CONTEXT_GRID, LATENCY_MS_PENDING)`.
- **Pass condition.** `f_codex_2_residual <= 0.10` (same
  `EPS_RESIDUAL_THRESHOLD`) AND `LATENCY_MS_PENDING` fully populated
  (no `PENDING_SENTINEL`).
- **Defer condition.** Any `LATENCY_MS_PENDING[i] == -1.0` →
  `f_codex_2_residual` returns `NAN_SLOPE` and check 9 records
  DEFERRED.
- **Fail condition.** All 4 latency rungs live AND
  `f_codex_2_residual > 0.10` → 🔴 FALSIFIED.
- **Verdict tier.** 🟢 SUPPORTED-NUMERICAL minimum, 🔵
  SUPPORTED-FORMAL preferred.
- **Currently.** 🔴 FALSIFIED — 4 of 4 context rungs measured
  (cycle-16, `bench/sandbox_stage4_context_scaling.hexa`, Qwen2.5-1.5B,
  -np 1 -cb port 8091, $0 local M3 Metal). The substrate's measured
  context exponent is **τ̂ = 0.524** (log-log OLS slope of
  (context_len, mean_wall_ms) = (1024,569)/(2048,670)/(4096,1005)/
  (8192,1668) ms, R²≈0.956), residual `|0.524 − 4| = 3.476 ≫ ε=0.10`.
  The n=6 τ=4 quartic context-cost law does NOT fit the substrate's own
  latency curve — wall_ms is **sub-linear** (rises only ~2.9× across an
  8× context sweep), dominated by the fixed-decode mem-bandwidth wall +
  cached-prefix prefill (modern paged-attention regime, §S7.6). Verdict
  `.verdicts/sandbox/m3_econ_fcodex2_latency_fit.txt` (10/10 checks PASS,
  verdict-line 🔴 FALSIFIED, exit 1).
- **Honesty note (g34).** F-CODEX-2 has no harness data yet, even
  at 1 of 4 — v1.2.0 starts at 1/4, v1.3.0 starts at 0/4.

### Cross-ref table

| release | falsifier | harness | gate condition | currently |
|:---|:---|:---|:---|:---|
| v1.2.0 | F-CODEX-1 (`N^σφ`) | `verify/numerics_economics_empirical_landing.hexa` ch.8 | residual ≤ 0.10 across 4 scale rungs | 🟠 1/4 |
| v1.3.0 | F-CODEX-2 (`context^τ`) | `verify/numerics_economics_empirical_landing.hexa` ch.9 | residual ≤ 0.10 across 4 context rungs | 🔴 4/4 measured · τ̂=0.524 vs τ=4 · residual 3.476 FALSIFIED |

The verdict-line truth-table (harness check 10
`check_verdict_line_consistency`) is the final gate composer:

- `k_active < 2` → 🟠 INSUFFICIENT (exit 0)
- `k_active == 4` AND both residuals ≤ ε → 🟢 GREEN (exit 0)
- `k_active == 4` AND any residual > ε → 🔴 FALSIFIED (exit 1)
- `k_active ∈ {2, 3}` → 🟠 PARTIAL (exit 0, gap surfaced)

The M3.ECON SANDBOX.md checkbox flips `[ ] → [x]` only on the GREEN
branch, which is the v1.2.0 + v1.3.0 release-cut signal for the
ECONOMICS group.

## 영구 축 (perpetual axes)

> ECONOMICS 는 완료되지 않는다. 위 v1.x State/Roadmap 은 첫 arc 의 측정 잔여이고,
> 비용곡선 자체는 새 모델·기질·축이 등장할 때마다 다시 열린다. 각 축은 `/cycle` 로
> SANDBOX 위에서 영구 전진 (`cx_empirical_contact` · `cx_lab_sandbox`).

### 축 A — F-CODEX-1 scale-cost 잔여 (현 🟠 1/4)
> 측정 scale grid 가 0.5B 1-rung 만 live. 4-rung 채워 `N^σφ` residual 재계산.
- [ ] A1 — 1.5B/3B/7B Stage-2 정확도 rung 측정 → `numerics_economics_empirical_landing.hexa` ch.8 residual ≤ 0.10 게이트. 반증자: 4-rung live AND residual > 0.10 → 🔴 FALSIFIED.

### 축 B — 측정 비용법칙 일반화 (재측정 영구)
> v1.4.0 의 2-성분 모델(decode_fixed 370ms + prefill_slope 0.168ms/tok, R²=0.997)이 다른 기질에서도 성립하는가?
- [ ] B1 — vLLM/paged-attn · 양자화(Q4/Q8/fp16) · batch regime 별 재측정 → 상수 이동량 정량. 반증자: 2-성분 R² < 단일 power-law R².

### 축 C — Pareto 비용-품질 frontier (영구 재적합)
- [x] C3 — inference-side stacking: quant × spec-dec 결합 throughput (C2 × F3 composition). **CYCLE-41 (2026-05-27):** `verify/numerics_economics_c3_quant_specdec_stacking.hexa` ✅ 6/6 PASS · 🔵 SUPPORTED-FORMAL (multiplicative bound) + 🟠 realized value. **pool 호스트 ubu-1 에서 `hexa build` 네이티브 컴파일+실행** (인터프리터 아님; transpiler 가 stale-build segfault 라 `hexa cc` 로 재빌드 후 통과). 두 최적화 직교 (quant=per-token bytes · spec-dec=sequential passes) → 곱셈 결합. Q4(1.89×) × spec-dec α=0.5(1.44×) → **결합 throughput ∈ [2.45×, 2.72×] vs Q8-greedy**; ceiling 2.72× = α quant-invariant 일 때(F5 유추), floor 2.45× = Q4 draft 가 α 0.5→0.4 떨굴 때; interference floor 2.45× > best-single 1.89× → 스태킹은 floor 에서도 이득. 단 realized 값은 quant-α-sensitivity(미측정) 의존 → 🟠, gap=0.27×. self-strawman 아님 (C2+F3 내부 검증 결과 합성, 외부주장 반증 X). **frontier OPEN** — cycle-42+ T4 (SANDBOX Q4-draft vs fp16-draft α_eff 측정). verdict: `.verdicts/economics/c3_quant_specdec_stacking_verdict.txt`.
- [x] C2 — inference-side Pareto: Q4 vs Q8 dominance (F1+F2+F5 composition). **CYCLE-40 (2026-05-27):** `verify/numerics_economics_c2_inference_pareto_q4_dominance.hexa` ✅ 7/7 PASS · 🟢 SUPPORTED-NUMERICAL + 🟠 scope-limited. 3 검증된 F-law 합성 — F1 (energy∝bytes, memory-bound) · F2 (bytes∝bpw) · F5 (measured quality quant-invariant). 결론: F5-measured regime 에서 **Q4_K_M 이 Q8_0 을 Pareto-DOMINATE** — 통계적 동일 품질 (|Δ|=1 < 2SE=14) · byte/energy ratio 0.529 · throughput 1.89× · 47.1% 비용절감. Dettmers "Q4 Pareto-optimal" 을 COST axis 로 SUPPORT (Q3 quality cliff 아님). 반증자: F5 quant-invariance 가 무너지면 (Q8 품질 > Q4) dominance 약화 → **🟠 scope-limited** (1.5B·arithmetic·n=200·k-quants). cost RATIO 는 $-agnostic (🟢), 절대 $/tok 은 hardware rental rate 필요 (🟠). 운영규칙 = ENGINE A1 router 의 cost-sensitive class 에 feed 가능 (deferred, ENGINE 은 이 세션 범위 밖). verdict: `.verdicts/economics/c2_inference_pareto_q4_dominance_verdict.txt`. **frontier OPEN** — composition close ≠ multi-task substrate close.
- [x] C1 — 새 모델 landing 마다 (N,D)↔(loss,cost) 측정점 추가 → 닫힌형 envelope vs 측정 재적합. 반증자: Lagrangian 최적 (N/D)^α ≠ A/B. **CYCLE-44 (2026-05-27)**: Sardana inference-amortization 방향성 닫힌형 복제 — `verify/numerics_economics_c1_sardana_inference_amortized.hexa` ✅ 10/10 PASS · 🔵 STRUCTURAL · **pool ubu-1 `hexa build` 네이티브 컴파일+실행** (`hexa cc` 재빌드 후 1-shot window). Sardana 2024 (arXiv:2401.00448) cost C_total = 6·N·D + 2·N·T_inf 의 KKT* 조건 (3D+T_inf)·β·B·N^(α+1) = 3N·α·A·D^(β+1) 에서: (1) T_inf=0 limit ⇒ cycle-43 Hoffmann IDENTITY 회복 (LHS 계수 3D, duality 9999/10000 EXACT), (2) T_inf>0 ⇒ LHS 에 strictly positive +T_inf 추가 (예: T_inf=1000 → LHS +1000) ⇒ 최적이 **∂N\*/∂T_inf < 0, ∂D\*/∂T_inf > 0** 방향으로 shift, (3) 격자 비교 (T_inf=0,500,1000) → N: 100→75→50 monotone non-increasing · D: 2000→3000→4000 monotone non-decreasing · D/N: 20.0→…→80.0 monotone growth. cycle-26 의 EMPIRICAL 갭 (modern dense D/N ∈ [22, 1875] vs Hoffmann ~20) 이 Sardana shift 방향과 **qualitatively 일치** (sign-level, pointwise 아님). **honest residual**: absolute N_inf-opt(T_inf, L0) 은 Besiroglu 2024 가 dispute 하는 G_N/G_D 상수 필요 → g5 fabrication-guard 로 direction-only 유지 (🔵 STRUCTURAL, not 🟢 SUPPORTED-NUMERICAL). **frontier OPEN** — cycle-45+ 자연 후속 = per-vendor T_inf telemetry + Besiroglu-replicated G_N/G_D ⇒ pointwise N_inf-opt. verdict: `.verdicts/economics/c1_sardana_inference_amortized_verdict.txt`.
  - **CYCLE-43 (2026-05-27)**: `verify/numerics_economics_c1_lagrangian.hexa` ✅ 8/8 PASS · 🔵 SUPPORTED-FORMAL · **Mac 로컬 `hexa build` 컴파일+실행** (sidecar sign local 토큰). Hoffmann Lagrangian 닫힌형 IDENTITY 재계산: α+β=0.62 · N_opt ∝ C^0.4516 · D_opt ∝ C^0.5484 · DUALITY a+b=1.0 EXACT · D/N C-지수 = (α−β)/(α+β) = 0.097 SMALL (sub-linear → "D/N≈20 rule" 근사 scale-invariant, 10× compute → D/N ~25% drift) · α=β degenerate ⇒ D/N C-지수=0 (반증자 IDENTITY (N/D)^α=A/B 자체 확인). cycle-26 의 EMPIRICAL 갭 (modern dense D/N ∈ [22, 1875] vs Hoffmann ~20) 은 formula 버그 아니라 train-only ASSUMPTION 부족 (Sardana 2024 inference-amortization 으로 회복). verdict: `.verdicts/economics/c1_lagrangian_verdict.txt`.
  - cycle-26 batch 1: 12 modern landings (Llama3 8B/70B/405B · Qwen2.5-72B · DeepSeek-V3 671B/37B-act · Phi-3 mini/small/medium · Gemma-2 2B/9B/27B) + Chinchilla 70B anchor → `.verdicts/economics/c1_chinchilla_envelope.tsv` (🟡 SUPPORTED-BY-CITATION) + verifier `verify/numerics_economics_c1_envelope.hexa` 10/10 PASS (`.verdicts/economics/c1_chinchilla_envelope_verdict.txt`). 핵심: 12/12 modern dense 모두 overtraining (dev ∈ [1.10, 93.75]), Llama3 family N-역단조 (8B>70B>405B), DeepSeek-V3 active-37B/14.8T = dev 20.000 정확 (Chinchilla-on-active emergence). 반증자 평가: closed-form Lagrangian (N/D)^α = A/B 는 IDENTITY (Pareto verifier check 2) — 닫힌형 envelope는 falsify 안됨. 단 modern 실제 (D/N) ∈ [22, 1875] 가 n=6 lattice 최적 ~1.07 도 Chinchilla rule-of-thumb 20 도 모두 빗나감 → envelope의 ASSUMPTION (train-compute-only) falsified. 잔여: per-row loss 미공개 → 🟢 escalation 위해 lm_foundry serving 측 measured-CE 필요.

### 축 D — 신규 비용 축 (seed 백로그)
- [ ] D1 — 토큰당 에너지/$ · KV-cache 비용곡선 · speculative-decoding 비용모델 — 새 falsifiable 축 seed → `.discoveries/`.

### 축 E — 🆕 NOVEL: MoE vs Dense scaling law divergence (cycle-27, ⭐ MAIN priority lane)
> **⭐ 다음 cycle 우선 진행 lane** (NOVEL axis 메인 정책, cycle-28 cross-domain 동시 적용). cycle-26 C1 cross-cycle 발견에서 spawn: 12 modern dense (Llama3·Qwen2.5·Phi-3·Gemma-2) 모두 Chinchilla overtraining (D/N ∈ [22, 1875])인 반면 **DeepSeek-V3 active-37B/14.8T 만 D/N=20.000 정확 hit** (cycle-26 `.verdicts/economics/c1_chinchilla_envelope.tsv` 13-row). MoE active-param 가 dense 와 *다른 scaling law family* 일 가능성 — 측정 가능한 영구 axis. cycle-27 first-probe verdict: 🟢 SUPPORTED-NUMERICAL (directional, n=1, `.verdicts/economics/e1_moe_dense_divergence_verdict.txt`).
- [ ] E1 — MoE active-param scaling law 분리: ≥3 MoE landing (DeepSeek-V3 · Mixtral 8x7B · Qwen3-MoE 등) (N_total, N_active, D) 수집 → active-only 와 total 의 D/N 분포 분리 평가. 반증자: ≥3 MoE 의 active-D/N 가 dense D/N 분포 (median ≈250)와 KS-test p≥0.05 → MoE divergence FALSIFIED (단순 동일 분포의 outlier). 외부 anchor: DeepSeek-V3 arXiv:2412.19437 · Mixtral 8x7B arXiv:2401.04088 · Sardana 2024 arXiv:2401.00448 (inference-amortization).

### 축 F — 🆕 NOVEL: Inference-substrate efficiency scaling laws (cycle-35, ⭐ MAIN priority lane)
> **⭐ E 다음 MAIN 우선 lane** (NOVEL axis, cycle-35 spawn). cycle-34 E1 의 n=11 PARITY 가 publication-bias bottleneck (D-disclosed MoE pool ≈ 11, Mistral family 비공개) 에 부딪힘 — 추가 sample 확보가 vendor 정책 의존이 됨. F axis 는 이를 우회하는 **orthogonal axis** spawn: A-E 가 모두 training-time scaling law / Chinchilla family 인 반면 F 는 **inference-substrate efficiency** family — 모든 seed 가 SANDBOX 위에서 측정 가능 (vendor D-disclosure 비의존). 외부 anchor: Patterson 2021 J/inference · Ainslie 2023 GQA · Leviathan 2023 spec-dec · Dettmers 2023 4-bit Pareto. Seeds → [`.discoveries/economics-f-cost-axis-spawn.tape`](.discoveries/economics-f-cost-axis-spawn.tape) (4 seeds, cheapest first probes 모두 $0 closed-form recompute).
- [x] F1 — 토큰당 에너지 (J/tok) 가 active-param N 에 대해 닫힌형 power law 인가, 그리고 k_energy = ? 가설: H100/A100 memory-bandwidth regime 에서 k_energy ≈ 0.5–0.7 (sub-linear), compute-saturated regime 에서만 k_energy = 1.0. 반증자: published MLPerf Inference v4.0 에서 k_energy = 1.0 ± 0.10 → memory-bandwidth-wall claim FALSIFIED. 외부 anchor: Patterson 2021 (arXiv:2104.10350) · MLPerf Inference v4.0 energy track. **CYCLE-38 first probe (2026-05-27):** `verify/numerics_economics_f1_energy_per_token_scaling.hexa` ✅ 6/6 PASS · 🔵 roofline model + 🟠 empirical k_energy. **KEY FINDING**: decode AI=1 FLOP/byte ≪ A100 ridge 153 → deeply memory-bound; roofline t/tok ∝ N EXACT; pure weight-stream k_energy=1.0 EXACT. seed 의 "memory-bandwidth-wall → sub-linear energy (k<1)" 가설은 **structurally MISATTRIBUTED** — bandwidth wall 은 LATENCY 악화시키지 energy N-exponent 안 굽힘. apparent k<1 은 오직 fixed overhead E0 (affine E/tok=E0+k1·N) 에서 (slope=0.5 at E0=k1·N, →1.0 as N grows). **단 actual k_energy 는 측정 E0/k1 필요 → 🟠** (verbatim MLPerf ladder 없음, fabrication=g5 위반). external claim "energy scales with model size (k≈1)" 은 roofline weight-streaming limit 에서 SUPPORTED. **frontier OPEN** — exponent close 는 cycle-39+ T4 (SANDBOX nvidia-smi power.draw Qwen2.5 0.5/1.5/3/7B-Q4 ladder). verdict: `.verdicts/economics/f1_energy_per_token_scaling_verdict.txt`.
- [x] F2 — KV-cache bytes ∝ ctx^p_ctx · batch^p_batch · n_kv_heads^p_heads 닫힌형 정확도 + GQA/MQA 가 effective heads 만 줄이는지 (지수 자체는 1.0 유지) 검증. 가설: 세 지수 모두 1.0 EXACT, GQA/MQA 는 계수 (n_kv_heads/G) 만 변경. 반증자: closed-form 이 published HBM-occupancy 와 ε > 5% 어긋남 → 추가 항 (attention-sink 등) 필요. 외부 anchor: Ainslie 2023 GQA (arXiv:2305.13245) · Shazeer 2019 MQA (arXiv:1911.02150) · Pope 2023 (arXiv:2211.05102). **CYCLE-36 first probe (2026-05-27):** `verify/numerics_economics_f2_kv_cache_memory_law.hexa` ✅ 7/7 PASS · 🔵 SUPPORTED-FORMAL. 3 지수 = 1.0 EXACT (perturbation-demonstrated) · GQA G=8 → 8× · MQA → 64× = n_kv 계수의 EXACT consequence · Llama3-8B 1.000 GiB / Llama2-70B 20.00 GiB @ 8k EXACT. per-model 절대 occupancy 는 🟡 (arch-spec-derived, HBM telemetry 미측정). **frontier OPEN** — closed-form close ≠ substrate-measured close; cycle-37+ T4 nvidia-smi prefill slope 확인 deferred. verdict: `.verdicts/economics/f2_kv_cache_memory_law_verdict.txt`.
- [x] F3 — Leviathan-Kalman s(α, c, N) = (1−α^(N+1))/((1−α)(cN+1)) 닫힌형 검증 + production prompt-mix 의 α 분포 측정 → deployment-weighted average s. 가설: production-mix α ≈ 0.5 (translation/summarization 의 0.75–0.85 보다 낮음) → realistic speedup s ≈ 1.5–2.0 (headline 2.5–3.0× OVERSTATED ~1.5×). 반증자: 모든 common class 에서 α ≥ 0.7 → published headline 이 production 에서도 성립. 외부 anchor: Leviathan & Kalman 2023 ICML (arXiv:2211.17192) · Medusa (arXiv:2401.10774). **CYCLE-37 first probe (2026-05-27):** `verify/numerics_economics_f3_spec_dec_speedup.hexa` ✅ 10/10 PASS · 🔵 formula + 🟠 deployment-α. PART A: 6-point algebraic self-check vs Table 2 (ε≤1%) = 🔵 deterministic. PART B: headline α=0.85 → s=2.768× (published 2.5–3.0 reproduced) vs production α=0.5 → s=1.442× → overstatement 1.91×; non-monotone draft-length 확인 (N=4 peak > N=16). **단, production α≈0.5 는 ASSUMPTION (미측정)** — overstatement 결론은 🟠 INSUFFICIENT, α≈0.5 조건부. self-strawman 회피 ([[feedback_negative_paper_external_claim]]): PUBLISHED headline 타겟, 미측정 premise 로 closed-negative paper 안 만듦. **frontier OPEN** — PART B close 는 cycle-38+ T4 (SANDBOX P4 spec-dec harness, per-class α 측정) 필요. verdict: `.verdicts/economics/f3_spec_dec_speedup_verdict.txt`.
- [x] F5 — Quality(b_bits) 가 saturation-in-bits 닫힌형 curve quality(b) = q_max × (1 − exp(−(b−b_min)·γ)) 따르는지 + quality-cliff b_cliff = ? 가설: γ ≈ 0.5–0.7/bit, b_min ≈ 3, b_cliff = 3 (Dettmers 2023 4-bit Pareto 재확인). 반증자: 닫힌형이 published or SANDBOX P4 측정 점과 ε > 10% 어긋남 → 단일-parameter law 부족, per-method (k-quants vs GPTQ vs AWQ) 분리 필요. 외부 anchor: Dettmers & Zettlemoyer 2023 NeurIPS (arXiv:2212.09720) · GPTQ (arXiv:2210.17323) · AWQ (arXiv:2306.00978). **CYCLE-39 first probe (2026-05-27):** `verify/numerics_economics_f5_quantization_tax.hexa` ✅ 6/6 PASS · 🟢 numerical (measured P4 데이터) + 🟠 Dettmers scope-limited. SANDBOX P4 measured ladder (Qwen2.5-1.5B k-quants, n=200, byte_exact): Q3_K_M 44.0% / Q4_K_M 43.0% / Q8_0 42.5%. **KEY FINDING**: accuracy QUANT-INVARIANT — max Δ=3 counts < 2·SE=14 (binomial pooled p̄=0.432) → 3 bands statistically INDISTINGUISHABLE, **NO Q3 cliff** (b_cliff<3.5 HERE); saturation-rise 부재 → γ fit under-determined. **단 Dettmers b_cliff=3 비교는 SCOPE-LIMITED 🟠** (single 1.5B/arithmetic/n=200/k-quants≠GPTQ/accuracy≠perplexity) — clean closed-negative 아님 ([[feedback_negative_paper_external_claim]]). **frontier OPEN** — cycle-40+ Q2/Q5/Q6 + harder task + larger model 로 non-flat curve 에서 γ fit. verdict: `.verdicts/economics/f5_quantization_tax_verdict.txt`.

### 축 G — 🆕 NOVEL: Agentic / multi-turn compute amortization scaling laws (cycle-45, ⭐ MAIN priority lane)
> **⭐ F 다음 MAIN 우선 lane** (NOVEL axis, cycle-45 spawn). A-E 가 모두 training-side scaling, F 가 single-call inference-side, 그리고 cycle-44 D1-Sardana 가 per-MODEL-LIFETIME amortization 인 반면 G axis 는 그 사이의 **per-CONVERSATION-LIFETIME (multi-turn / per-task) time-horizon** orthogonal axis. 2026 production economics 는 single-turn 이 아니다 — Anthropic prompt caching (Sep 2024, 90% read 할인 · 1.25× write surcharge) · OpenAI prompt caching (Oct 2024, 50% 할인) · DeepSeek context caching (Dec 2024, 74% 할인) · ReAct/Reflexion/SWE-Agent 류 agentic loops (turn 당 5–50 LLM call, prefix 거의 reuse) 모두 multi-turn amortization 면이 dominant cost driver. F 가 답하지 못하는 5 차원 (cache-pricing N_break · k_agent power-law · hit-rate decay vs divergence · α turn-drift · per-conversation KV growth) 을 다룬다. 외부 anchor: Anthropic / OpenAI / DeepSeek pricing pages · Yao 2023 ReAct · Shinn 2023 Reflexion · Xiao 2024 StreamingLLM · Zhang 2024 H2O. Seeds → [`.discoveries/economics-g-agentic-amortization-spawn.tape`](.discoveries/economics-g-agentic-amortization-spawn.tape) (5 seeds, cheapest first probes 모두 $0 closed-form recompute).
- [x] G1 — Prompt-cache amortization curve $/task(N_turns) — 3 vendor pricing tier (Anthropic/OpenAI/DeepSeek) 닫힌형 N_break 해석 + amortization saturation 검증. 가설: prefix:delta ≥ 10:1 인 typical agent loop 에서 N_break ≤ 2 (turn 2 부터 cache win), 점근 할인 ≈ (1 − c_r/c_f). 반증자: N_break > 5 → 'published 90% 할인' 헤드라인이 typical workload 에서 misleading. 외부 anchor: Anthropic prompt-caching docs · OpenAI prompt-caching announcement · DeepSeek context-caching api-docs. **CYCLE-46 (2026-05-27)**: `verify/numerics_economics_g1_prompt_cache_amortization.hexa` ✅ 8/8 PASS · 🔵 SUPPORTED-FORMAL · pool ubu-1 native compile (`hexa cc` 재빌드). **핵심 결과**: seed 의 "N_break ≤ 2" 가설 **off-by-one 으로 corrected → 실제 N_break = 3** (3 vendor 모두, p=10k/d=500 20:1 비율에서). 점근 할인 (N→∞): Anthropic 85.8% vs 90% headline = 4pp **delta-token tax** (delta tokens 는 never cache). 운영규칙: prompt-cache 는 turn 3 부터 pays off (turn 2 아님). self-correction = internal refinement, external strawman 반증 아님 ([[feedback_negative_paper_external_claim]]). **frontier OPEN** — cycle-47+ T4 SANDBOX llama-server prefix-cache hit-rate 측정. verdict: `.verdicts/economics/g1_prompt_cache_amortization_verdict.txt`.
- [x] G2 — Agent trajectory cost scaling law $/task ∝ N_tool_calls^k_agent — ReAct vs Reflexion vs SWE-Agent 의 k_agent 측정. 가설: context 누적형 (Reflexion/SWE-Agent) 은 k_agent ≈ 1.5–2.0 (per-call input length linear-in-N → 총비용 quadratic-in-N), caching 켜면 k_agent → 1.0 으로 회복. 반증자: k_agent ≤ 1.1 all-methods → 'context-accumulation makes agents quadratic' 가설 FALSIFIED, agent 비용은 fixed RTT overhead dominated. 외부 anchor: Yao 2023 ReAct (arXiv:2210.03629) · Shinn 2023 Reflexion (arXiv:2303.11366) · Princeton SWE-Agent (arXiv:2405.15793) · SWE-Bench Verified leaderboard. **CYCLE-47 (2026-05-27)**: `verify/numerics_economics_g2_agent_trajectory_cost.hexa` ✅ 8/8 PASS · 🔵 SUPPORTED-FORMAL · pool ubu-1 native compile. **closed-form**: total(N) = c_f·N·base + c_f·s·N(N-1)/2 — STRUCTURALLY super-linear. operating point base=10000/s=500 (20:1) 에서 N=5→50 cost ratio = **20.2× → k_agent ≈ 1.3** (seed 의 1.5-2.0 범위는 base/s 비율 작을 때만; **operating-point dependent refinement**). quadratic component (183.75M) > linear component (150M) at N=50 → 누적이 지배. **caching 효과**: cache ratio 7.65× < nocache 20.2× ⇒ caching FLATTENS slope (k → ~1 로). 단 c_r·s·N²/2 quadratic term 잔존 — pure-linear 아님 (full-accumulated-context caching 필요). 외부 paper anchor 검증 (ReAct/Reflexion published cost traces) 은 cycle-48+ WebFetch 로 deferred. **frontier OPEN** — structural close ≠ empirical close. verdict: `.verdicts/economics/g2_agent_trajectory_cost_verdict.txt`.
- [x] G3 — Cache-hit-rate decay law p_hit(divergence_offset) — vendor block-granularity (Anthropic 1024-tok block · OpenAI 128-tok prefix) 닫힌형 + multi-turn realistic hit rate. 가설: Anthropic step-function decay (1024-tok block boundary 매우 민감), realistic 20-turn 에서 effective hit ≈ 0.5 → 효과적 할인 ~0.55× (Anthropic) / ~0.75× (OpenAI), 헤드라인 0.1× 와 큰 격차. 반증자: effective hit < 0.5 even on longest-stable-prefix → published 90% 할인이 production 에서 unachievable. 외부 anchor: Anthropic Claude prompt-caching docs (1024-tok min block) · OpenAI prompt-caching docs (128-tok prefix) · DeepSeek context-caching docs. **CYCLE-48 (2026-05-27)**: `verify/numerics_economics_g3_cache_hit_decay.hexa` ✅ 9/9 PASS · 🔵 SUPPORTED-FORMAL · pool ubu-1 native compile. **핵심 결과**: (a) Anthropic step-function — div=500 (< 1024 block) ⇒ cache 0 (useless); div=10000 ⇒ 9216 cached (9×1024, 784 tok remainder lost). (b) OpenAI 128-block 8× 더 div-tolerant (div=500 ⇒ 384 cached). (c) 20-turn aggregate hit = 5128/10000 ≈ 0.51 (system 10k / total 19.5k). (d) **EFFECTIVE 할인 at hit=0.5**: Anthropic 0.55× (**45% saving vs 90% headline · 45pp gap**), OpenAI 0.75× (**25% saving vs 50% headline · 25pp gap**). 운영 결론: vendor headline = per-token; per-task realistic saving 은 **약 2× overstated**. self-refinement (vendor 주장 자체 확인하되 per-task 해석 가짜 강도 정정) — [[feedback_negative_paper_external_claim]] 준수. **frontier OPEN** — cycle-49+ T4 SANDBOX llama-server cache-hit 실측. verdict: `.verdicts/economics/g3_cache_hit_decay_verdict.txt`.
- [x] G4 — Multi-turn spec-dec α drift α(turn_index) — F3 single-call α 가 multi-turn 에서 invariant 인지, tool-output OOD 토큰이 α 떨어뜨리는지. 가설: α(turn) ≈ α₀ · (1 − 0.02·turn) (turn 당 ~2% 점감), 20-turn 평균 speedup 이 F3 single-call 대비 ~15–20% 저하. 반증자: 측정 α 가 20-turn invariant (drift < 1%) → 'multi-turn drift breaks F3' FALSIFIED, F3 per-class α 가 그대로 multi-turn 일반화. 외부 anchor: Leviathan & Kalman 2023 (arXiv:2211.17192) · Cai 2024 Medusa (arXiv:2401.10774) · Li 2024 EAGLE-2 (arXiv:2406.16858). **CYCLE-49 (2026-05-27)**: `verify/numerics_economics_g4_multi_turn_specdec_drift.hexa` ✅ 9/9 PASS · 🔵 formula + 🟠 drift_rate. pool ubu-1 native compile. F3×linear-drift α(t)=α₀(1−r·t) 합성, r=0.02/turn 가정 → s(α=0.5) 1.442× → s(α(20)=0.30) 1.090× (24% end-of-loop drop). 3-pt avg over 20 turns ≈ 1.260× → **avg degradation 12.6%**, seed 의 15-20% 범위 **하한 아래로 corrected** (closed-form refinement). 운영: spec-dec 는 여전히 avg 로 이득 (1.26× > 1) 이지만 turn-budget cutoff 가치 있음. drift_rate r 은 ASSUMPTION (🟠 conditional); 실측 α(turn) curve 는 cycle-50+ T4. **frontier OPEN**. verdict: `.verdicts/economics/g4_multi_turn_specdec_drift_verdict.txt`.
- [x] G5 — Conversation-state KV-bytes growth law KV(N_turns) — F2 single-call KV-byte 의 multi-turn 확장 + compress-vs-keep break-point K_opt = sqrt(c_summarize / cost_per_byte_hour / ctx_per_turn). 가설: naive multi-turn KV 는 linear-in-N_turns, StreamingLLM/H2O sliding 정책으로 cap, DeepSeek MLA 같은 architectural 압축이 ≈0.06× MHA. 반증자: substrate 측정 slope 이 sub-linear (engine 이 이미 implicit eviction) → 'naive multi-turn linear KV' FALSIFIED, policy-side 압축은 이중계산. 외부 anchor: Xiao 2024 StreamingLLM (arXiv:2309.17453) · Zhang 2024 H2O (arXiv:2306.14048) · Liu 2024 Scissorhands (arXiv:2305.17118) · DeepSeek-V2 MLA (arXiv:2405.04434). **CYCLE-50 (2026-05-27)**: `verify/numerics_economics_g5_conversation_kv_growth.hexa` ✅ 9/9 PASS · 🔵 SUPPORTED-FORMAL · pool ubu-1 native compile. **핵심 결과**: (a) Llama3-8B GQA KV/tok = 128 KB (F2 formula), 30-turn ctx=500/turn → **1.83 GiB** linear. (b) Sliding K=20 cap → 1.22 GiB (StreamingLLM). (c) K_opt = sqrt(2·c_s/(ctx·rate)) sqrt-shape 확인: doubling c_s → ×1.444 (√2≈1.414), doubling ctx → ×0.722 (1/√2≈0.707). (d) typical op point ($0.10/summary, 500tok, $0.01/GB-hr) → **K_opt = 18 turns** (seed의 10-20 범위 적중). (e) MLA / MHA ratio = 0.062 (DeepSeek-V2 architecture). **frontier OPEN** — cycle-51+ T4 SANDBOX KV growth 실측. verdict: `.verdicts/economics/g5_conversation_kv_growth_verdict.txt`.

### 축 N — ⭐ N1 NOVEL MAIN: Cost-performance production spread (cycle-10 reorg · FRONTIER F5 흡수)
> **⭐ MAIN priority lane** — ECONOMICS 의 self-NOVEL. same-acc-tier 모델 간 50× 비용 분산 · LXT 2026 + Artificial Analysis Index anchor. 도착지 없음 ([[feedback_closure_is_physical_limit]]). FRONTIER meta-domain 이 cycle-10 reorg 에서 dissolve 되며 cost-performance spread 축이 ECONOMICS 의 자연스러운 self-NOVEL 로 이관 — A-E training-side · F single-call inference-side · G agentic amortization 과 달리 N 은 **production deployment cost-perf 분산** (vendor 가격 시장 surface) family. 이 N⭐ 가 ECONOMICS 의 front NOVEL MAIN lane; 기존 E/F/G NOVEL lane 은 그 뒤 차순위로 정렬 (N1 ≻ E ≻ F ≻ G).
- [x] N1 — $ per correct answer · 같은 acc 50× cost variation (ECONOMICS 의 NOVEL — production cost-perf spread). 반증자: cheapest 가 most-expensive 의 1/10 이하 못 도달. **CYCLE-10 reorg (2026-05-28 · FRONTIER F5 흡수)** ✅ 🔵+🟡 · 7/7 PASS · `verify/numerics_economics_n1_cost_performance_spread.hexa` · 5-frontier pool=5000/100 (50× · GPT-5 $15 vs DeepSeek V4 $0.30) fires · single-family 2.66× silent. bench `bench/economics_n1_cost_performance_spread.hexa` · verdict `.verdicts/economics/n1_cost_performance_spread_verdict.txt`. external anchor: LXT 2026 · Artificial Analysis Index 2026 · Kili Technology 2026 · OpenAI/Anthropic/DeepSeek V4 pricing. **frontier OPEN** — cycle-11+ T4 Artificial Analysis daily-pricing fetch + same-acc-tier (MMLU-pro/LMSys/LiveBench) validation + per-correct-answer (cost/M ÷ avg-acc) conversion DEFERRED (`cx_lab_sandbox`).

## SANDBOX 활용 (consumer 입장)

ECONOMICS 의 모든 T4 (empirical) 측정은 SANDBOX 위에서 fire — API surface 가 cache/stop/max-tok/batch knob 없음, 측정 불가.

> 본 섹션은 [`SANDBOX.md`](SANDBOX.md) "Substrate Readiness Matrix" 의 ECONOMICS row 를
> consumer 도메인 입장에서 그대로 미러링한 entry-point 표다. SANDBOX 가 substrate-side
> SSOT 이고 본 섹션은 ECONOMICS group 의 consumer-side SSOT — 두 표는 1:1 sync 유지.

### Readiness — ECONOMICS axes (mirrors `SANDBOX.md` Readiness Matrix · 6 axes)

| axis | harness | model | verdict path |
|------|---------|-------|--------------|
| 단일 LLM call cost | `bench/sandbox_stage0_poc.hexa` | Qwen2.5-0.5B-Q4_K_M | `.verdicts/sandbox/stage0_*` |
| persona 3-tier ratio | `bench/sandbox_stage1_tier_persona.hexa` | Qwen2.5-0.5B-Q4_K_M | `.verdicts/sandbox/stage1_*` |
| scale-stratified manifest | `bench/sandbox_stage2_persona_scaled*.hexa` | Qwen2.5-{0.5B,1.5B}-Q4_K_M | `.verdicts/sandbox/stage2_*` |
| context cost (F-CODEX-2) | `bench/sandbox_stage4_context_scaling.hexa` | Qwen2.5-1.5B-Q4_K_M | `.verdicts/sandbox/m3_econ_fcodex2_*` |
| measured 2-component cost | `verify/numerics_economics_measured_cost_model.hexa` | (recompute only) | `.verdicts/sandbox/m3_econ_measured_*` |
| quant-band Pareto (P4) | `bench/sandbox_p4_quant_band_pilot.hexa` | Qwen2.5-1.5B {Q3_K_M,Q4_K_M,Q8_0} | `.verdicts/sandbox/p4_quant_band_*` |

### Dispatch surface (어느 axis 가 어느 dispatch lane 쓰는가)

| ECONOMICS axis | `route_dispatch` | `pool` | `hexa cloud` |
|---|:---:|:---:|:---:|
| 단일 LLM call cost | ✅ | — | — |
| persona 3-tier ratio | ✅ | — | — |
| scale-stratified manifest | ✅ | (옵션, ubu-1 GPU rung) | (옵션, 7B rung) |
| context cost (F-CODEX-2) | ✅ | — | — |
| measured 2-component cost | (recompute only) | — | — |
| quant-band Pareto (P4) | ✅ | — | — |

> 대부분 `route_dispatch.hexa` 단일 LLM call wrapper 로 충분 — ECONOMICS 는 process-수준
> serving knob 측정 (per-call cost · context curve · quant tier) 이라 multi-host / GPU pod
> 는 옵션. scale rung 이 7B+ 로 올라가거나 분산 측정으로 갈 때만 `pool` / `hexa cloud` 활성.

### Quick-fire commands (cycle-25)

```sh
# P4 quant-band pilot rerun (PER_STRATUM_N 40→400, 풀 N=2000)
hexa.real run bench/sandbox_p4_quant_band_pilot.hexa

# F-CODEX-2 context-cost rerun (확장 context grid {1k,2k,4k,8k,16k})
hexa.real run bench/sandbox_stage4_context_scaling.hexa

# scale-cost rung 추가 측정 (1.5B → 3B → 7B Stage-2 정확도 → 축 A residual)
hexa.real run bench/sandbox_stage2_persona_scaled_1_5b.hexa
```

### Honest invariant

위 표 의 `✅` / `fire-ready` 는 **entry path 활성** 신호일 뿐 — 각 lane verdict 가
GREEN 으로 닫혀도 ECONOMICS frontier (비용곡선 자체) 가 close 되는 것이 아니다.
@goal line 의 "**종료 조건 없음 · 진행바 100% 미도달 = 설계**" 가 그대로 적용된다
([[feedback_closure_is_physical_limit]]). readiness ≠ frontier closure — 새 모델 ·
새 양자화 · 새 serving 기질이 등장하면 비용곡선은 다시 열린다 (`## 영구 축` 참조).

Cross-link: [`SANDBOX.md`](SANDBOX.md) Substrate Readiness Matrix (substrate-side SSOT).

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.hexa` · `verify/lattice_check.hexa` · `docs/closure_status.md` — runnable verify surface
- 영구 축 원리: [`SANDBOX.md`](SANDBOX.md) (공유 측정 기질) · [[feedback_closure_is_physical_limit]]
- SANDBOX consumer 표: 본 도메인 `## SANDBOX 활용 (consumer 입장)` (sibling 도메인은 [`SAFETY.md`](SAFETY.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md) 동일 패턴)
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
