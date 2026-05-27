# ENERGY — log

Append-only history sister of `ENERGY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — N2 MEASURED FIRE: qwen2.5-1.5b Q8 vs Q4 양자화 실측 (cycle-11 · 🔵+🟡 → 🟢 SUPPORTED-NUMERICAL · 첫 measured contact)

GPU fire — placeholder 7B 티어를 실제 추론으로 닫음. SANDBOX substrate (mini Apple Silicon Metal GPU · llama-server · `cx_lab_sandbox` · 외부 API 아님). qwen2.5-1.5b-instruct Q8_0 vs Q4_K_M · 15-prompt 고정셋 · 결정론적 greedy (temp=0 top_k=1 seed=0).

- [x] 측정 ledger: Q8_0 size 1894532128 B · 32.91 tok/s · 13/15 · Q4_K_M size 986048768 B · 45.29 tok/s · 14/15.
- [x] 압축 **1.921×** (정확 바이트) · 속도 **1.376×** (Q4 더 빠름 — weight bandwidth 감소) · 둘 다 placeholder 아닌 REAL 측정.
- [x] 품질: Q4≈Q8 답변 일치 **15/15 (100%)** · semantic divergence 0. 점수차 +1 Q4 = `seven`vs`7` 포맷 artifact (continents · 지식 아님). 유일 오답(blue+yellow→yellow) = Q8·Q4 공유 (양자화 탓 아님).
- [x] verifier `ENERGY/verify/measured_energy_n2_quantization_qwen15b.hexa` 🟢 **7/7 PASS** · verdict `ENERGY/verdicts/n2_quantization_measured_qwen15b_verdict.txt` · raw `ENERGY/bench/measured/n2_quantization_qwen15b_q8_vs_q4.jsonl`.
- [x] ENGINE/I1 selector 결정 measured-correct: normal budget → Q4 선택이 옳음 (작고·빠르고·손실 미검출).
- **placeholder 관계**: closed-form 의 'Q4=3% 손실'은 이 15문항 해상도(~6.7pp)로 **반증 안 됨 — 상한일 뿐** (측정값 아님).
- **honest residual (feedback_closure_is_physical_limit)**: N=15 floor ~6.7pp ('0 손실'='<6.7pp', 정확히 0 아님) · full MMLU/GSM8K per-level re-eval = 더 깊은 frontier OPEN (cost-bearing) · Metal-specific tok/s (RTX 5070 cross-check 미실시) · fp16/int8/gguf_q2 는 disk 부재로 🟡 유지. 5 레벨 중 1 쌍만 🟢 contact — 나머지 OPEN.

## 2026-05-28 — N2 NOVEL = quantization 품질-크기 trade-off (CODEX cycle-10 reorg Batch B · train/infer/serve stack)

- [x] ENERGY NOVEL N2 신규 추가 — QUANTIZATION (품질-크기 trade-off). N1 (sparse-MoE active-premium) 보존 · 건드리지 않음. 기존 per-layer energy decomposition stub (unbuilt `- [ ]`) → **N3 로 밀림** (구현 없는 placeholder · QUANTIZATION 에게 N2 슬롯 양보).
- [x] `ENERGY/bench/energy_n2_quantization_quality_size.hexa` — closed-form quality-size trade. 5 levels @7B {size_gb_x100, quality_pct_x100}: fp16 (1400·10000) · int8 (700·9950) · gguf_q8 (715·9950) · gguf_q4 (350·9700) · gguf_q2 (175·8500). Identity `quality_loss_pct_x100 = 10000 − quality_pct_x100` · `compression_ratio_x100 = fp16_size × 100 / level_size`. sentinel `__HEXA_CODEX_ENERGY_N2_QUANTIZATION__ DONE`.
- [x] `ENERGY/verify/numerics_energy_n2_quantization_quality_size.hexa` — 7 checks: (1) loss+compression identity (q4 → 300·400) (2) ranges (3) fp16 self (loss 0 · comp 100) (4) gguf_q2 fires (loss 1500 > 500) (5) fp16~gguf_q4 silent (≤ 500) (6) determinism (7) monotonicity (loss q2 ≥ q4 ≥ q8). env-driven `_root()`. verdict → `ENERGY/verdicts/n2_quantization_quality_size_verdict.txt`. ✅ **7/7 checks passed** · 🔵 STRUCTURAL + 🟡 BY-CITATION. sentinel `__HEXA_CODEX_NUMERICS_ENERGY_N2__ DONE`.
- [x] `ENERGY/verdicts/n2_quantization_quality_size_verdict.txt` written.
- [x] anti-overcompression: "이 양자화 레벨이 5% 초과 품질 손실 없이 압축한다" — gguf_q2 (2-bit · 8× 압축 · 85% quality) 에서 loss 15% > 5% → 🔴 FIRES (over-compression). fp16/int8/gguf_q8/gguf_q4 silent (≤ 5%) → bidirectional discrimination (NOT one-sided). 외부 published claim 반증 (strawman 아님 · [[feedback_negative_paper_external_claim]]).
- [x] 외부 anchors: Frantar 2023 GPTQ (arXiv:2210.17323) · Lin 2023 AWQ (arXiv:2306.00978) · Dettmers 2022 LLM.int8 (arXiv:2208.07339) · llama.cpp GGUF Q-levels (Q8_0/Q4_K_M/Q2_K) · Gemma 4 GGUF release.
- [x] ENERGY.md::축 N — N2 = quantization 추가 [x] · per-layer decomp stub → N3. SANDBOX substrate table N1/N2/N3 행 갱신. @goal perpetual 확인 (종료 조건 없음 · [[feedback_closure_is_physical_limit]]).
- [ ] 실측 per-level MMLU/GSM8K re-eval on local 7B GGUF mac M3 — **cost-bearing · DEFERRED to cycle-11+ T4** (`cx_lab_sandbox` · `cx_empirical_contact`). identity close ≠ measured close; 새 quant scheme (Q3_K · IQ-levels · per-channel) 등장 시 frontier 재오픈.
- [ ] ⚠ RACE-GUARD: `ENERGY/` 파일만 explicit stage · N1 (sparse-MoE) read-only 보존 · sibling agent (BATCH-COMPOSITION · HW-VARIANCE) 동시 작업 중.

## 2026-05-28 — N1 ⭐ NOVEL MAIN = sparse-MoE active-premium (FRONTIER F1 흡수 · CODEX cycle-10 reorg round-4)

- [x] FRONTIER 별도 meta-domain X · frontier 축 기존 도메인 N⭐ NOVEL MAIN 으로 분산 흡수 (사용자 결정). SPARSE-MOE (active-param efficiency) → ENERGY 의 sparse-activation 연산-절감 NOVEL.
- [x] `ENERGY/bench/energy_n1_sparse_moe_active_premium.hexa` — FRONTIER/F1 bench copy + 재명명 (헤더 "absorbed from FRONTIER/F1 (cycle-10 reorg)" · sentinel `__HEXA_CODEX_ENERGY_N1_SPARSE_MOE_ACTIVE_PREMIUM__ DONE`). active_premium_x1000 = perf(moe) × 1000 / perf(dense_same_active).
- [x] `ENERGY/verify/numerics_energy_n1_sparse_moe_active_premium.hexa` — 7 falsifier checks (identity 982 · range · zero-edge · Gemma 4 FIRES · synthetic silent · determinism · ledger sanity). verdict 출력 경로 `ENERGY/verdicts/n1_*`. ✅ **7/7 checks passed** · 🔵 STRUCTURAL + 🟡 BY-CITATION.
- [x] `ENERGY/verdicts/n1_sparse_moe_active_premium_verdict.txt` regenerated (`absorbed_from=FRONTIER/F1` 라인 추가).
- [x] anti-myth: "MoE > same-active-param dense by ≥ 1.2×" 신화 — Gemma 4 controlled (E4B 675 vs 26B/A4B 663 · arXiv:2604.07035) 에서 active_premium=982 < 1000 → 🔴 myth FALSIFIED in family. 외부 independent claim 반증 (strawman 아님 · [[feedback_negative_paper_external_claim]]). synthetic strong-MoE (800 vs 600 → 1333) silent → bidirectional discrimination.
- [x] ENERGY.md::축 N — N1 = MoE active-premium ⭐ MAIN priority lane; 기존 N1 (per-layer energy decomposition) → **N2 강등**. SANDBOX substrate table N1/N2 행 갱신.
- [x] @goal perpetual 확인 (종료 조건 없음 · [[feedback_closure_is_physical_limit]]).
- [ ] 실측 7-task weighted re-run on local Gemma 4 mac M3 GGUF — **cost-bearing · DEFERRED to cycle-11+ T4** (`cx_lab_sandbox` · `cx_empirical_contact`). identity close ≠ measured close; task-class · family · scale 마다 frontier 재오픈.
- [ ] ⚠ RACE-GUARD: FRONTIER/ 원본 read-only (안 건드림) · sibling agent 가 AGENT · ECONOMICS 동시 흡수 중 · `ENERGY/` 파일만 explicit stage.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-1)

- [x] `ENERGY/bench/energy_a1_tokens_per_joule.hexa` — closed-form tokens/J formula emission. tokens/J = N_tokens / E_total[J]; E_total = ∫P(t)dt ≈ Σ P_k·Δt_k ≈ mean_W·T. Placeholder worked example: 200 W · 60 s · 480 tok → 12 000 J → 0.040 tok/J. Riemann ↔ mean-power identity verified bit-identical (|Δ|=0 mJ).
- [x] `ENERGY/verify/numerics_energy_a1_tokens_per_joule.hexa` — 7 falsifier checks (identity · positivity · numerator linearity · denominator inverse · SOTA floor · Riemann↔mean-power · determinism). ✅ 7/7 PASS · 🔵 STRUCTURAL (6/7) + 🟡 BY-CITATION SOTA floor (1/7).
- [x] `ENERGY/verdicts/a1_tokens_per_joule_verdict.txt` written.
- [x] ENERGY.md::축 A A1 flipped [ ] → [x] with cycle-9 note (mirror ENGINE A1 style); anchors Patterson 2021 / Strubell 2019 / Schwartz 2020.
- [ ] real RAPL (Linux msr) + NVIDIA-smi sampler measurement on ubu-1 (RTX 5070 + 13900K) with per-task fixture — **cost-bearing · DEFERRED to a separate cycle**. On macOS Mx reuse `bench/bitnet_m6_energy_per_token.hexa` powermetrics recipe.
- [ ] A1 frontier OPEN (feedback_closure_is_physical_limit): instrumentation close ≠ measurement close; new HW (CPU/GPU/NPU) reopens the axis. One closed verdict ≠ axis termination.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
