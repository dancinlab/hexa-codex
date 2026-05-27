# ENERGY — log

Append-only history sister of `ENERGY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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
