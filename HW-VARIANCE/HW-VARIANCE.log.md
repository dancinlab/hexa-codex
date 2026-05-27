# HW-VARIANCE — log

Append-only history sister of `HW-VARIANCE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1' measured tier-2 elevation 🟡 → 🟢 (cycle-10 round-1 · CODEX bg)

- [x] `HW-VARIANCE/verify/numerics_hw_variance_a1_measured_spread.hexa` — measured Tier-2 🟢 SUPPORTED-NUMERICAL counterpart to round-8 closed-form A1. 7-check verifier embedding raw trial data + integer-ledger throughput recompute + identity recheck + bidirectional comparison against the 4 closed-form synthetic populations. Sentinel `__HEXA_CODEX_HW_VARIANCE_A1_MEASURED__ DONE`.
- [x] **Substrate** — LOCAL pool (`cx_lab_sandbox` qualifies; LOCAL hosts, no external paid API). 3-host sweep: mini (Apple M3 · arm64 · macOS 26.5) · ubu-2 (x86_64 · 12-core · RTX 5070 box · Ubuntu) · pi5-akida (Raspberry Pi 5 · aarch64 · Ubuntu). ubu-1 unreachable (`ssh: connect to host 10.142.0.1 port 22: Operation timed out`).
- [x] **Proxy choice (Step 3b fallback)** — none of the 3 ready hosts has a llama-server or GGUF model deployed today (mini: `llama-server not found`; ubu-2/pi5: empty). Fell back to deterministic CPU-bound `dd if=/dev/zero bs=1M count=512 | sha256sum`, 5 trials per host, median wall-clock time. Cleaner cross-host than `openssl speed` (LibreSSL vs OpenSSL syntax variance) — identical command runs on all 3 OSes. Proxy measures CPU throughput variance, not LLM tok/s — disclosed openly in verdict.
- [x] **Raw measurements** (5 trials × 3 hosts, seconds × 100 integer ledger):
  - mini: `[126, 123, 122, 123, 122]` → median 1.23 s → 512 MB / 1.23 s = **416 MB/s**
  - ubu-2: `[28, 27, 24, 27, 28]` → median 0.27 s → 512 MB / 0.27 s = **1896 MB/s**
  - pi5-akida: `[56, 55, 57, 56, 56]` → median 0.56 s → 512 MB / 0.56 s = **914 MB/s**
- [x] **Spread compute** — max=1896, min=416, sum=3226, mean=1075 → `spread_x1000 = (1896 − 416) × 1000 / 1075 = 1376` (= 137.6%, threshold=150 ⇒ fires hard, ≫ 15%). Measured spread > all 4 synthetic populations (tight=20 · nominal=100 · loose=180 · lottery=300) — cross-class variance dominates the synthetic lottery tail.
- [x] **`hexa run` verdict** — 🟢 SUPPORTED-NUMERICAL (measured cross-host throughput spread · 3 LOCAL pool hosts · 5 trials each · CPU proxy) — fires ≫ 15%. Verdict persisted at `HW-VARIANCE/verdicts/a1_measured_spread_verdict.txt`.
- [x] Snapshot A1' axis added below A1 with cycle-10 round-1 wire note + measured throughputs + verifier path + honest residuals (identical format to round-8 closed-form attribution).
- [ ] **Honest residual** — GPU-saturated LLM serving regime DEFERRED. CPU proxy captures cross-CLASS silicon variance (M3 vs Intel/AMD x86_64 vs Cortex-A76), not same-spec silicon-lottery. Llama-3 8B FP16 tok/s sweep awaits a llama-server / GGUF provisioning round (or vast.ai pod) — opens a future A2 axis (same-class GPU lottery) and N1 axis (cooling-controlled silicon-vs-thermal isolation).
- [ ] **Honest residual** — N=3 hosts is small. Future rounds should add same-spec replicates (≥ 3 same M3 minis · or ≥ 3 same RTX 5070 hosts) to isolate intra-class silicon-lottery from inter-class architectural variance. Frontier perpetually open ([[feedback_closure_is_physical_limit]]) — 🟢 elevation = one tier closed, NOT terminal. Axis B (thermal ladder) and Axis N⭐ (silicon-vs-cooling isolation) remain OPEN.

## 2026-05-28 — A1 closed-form per-chip throughput spread verifier wired (cycle-9 round-8 · CODEX bg)

- [x] `HW-VARIANCE/bench/hw_variance_a1_per_chip_cov.hexa` — closed-form `spread_x1000 = (max − min) × 1000 / mean` (× 1000 ledger of per-chip throughput spread · libm-free integer arithmetic via tok/s × 100 ledger). 4 placeholder populations × 5 chips: tight (10000,10100,10000,9900,10000)=20 · nominal (10000,10500,9500,10300,9700)=100 · loose (10000,10900,9100,10500,9500)=180 · lottery (10000,11500,8500,11000,9000)=300. All populations sum to 50000 → mean=10000 (mean-controlled comparison · spread is sole free variable).
- [x] `HW-VARIANCE/verify/numerics_hw_variance_a1_per_chip_cov.hexa` — 7-check verifier: (1) spread identity (2) tok/s ≥ 0 across all 20 chip slots (3) zero-spread synthetic (all 5 chips equal) → 0 (4) loose + lottery fire (> 150/1000) (5) tight + nominal silent (≤ 150/1000) — false-positive 회피 (6) determinism (7) monotone invariant max ≥ mean ≥ min for each population. Bidirectional discrimination across tight/nominal silent ↔ loose/lottery fire.
- [x] **Proxy choice rationale** — spread `(max − min) × 1000 / mean` chosen over libm-free integer sample-std (Newton-sqrt approximation ≤ 20 iter) because spread is (a) cheaper, (b) libm-free by construction (no integer sqrt loop), (c) still bidirectional (catches both 'one good chip' and 'one bad chip' silicon-lottery tails). Sample-std deferred to a future axis where Newton-sqrt iteration earns its keep.
- [x] `hexa run` verdict — 🔵 STRUCTURAL (spread identity + bidirectional discrimination + monotone invariant 7/7) + 🟡 BY-CITATION (15% spread threshold from Sinha 2022 not-all-gpus-are-equal · Hennessy & Patterson CAaQA silicon-lottery section · vLLM 2024 throughput variance report · Open Compute Project per-chip telemetry). Verdict persisted at `HW-VARIANCE/verdicts/a1_per_chip_cov_verdict.txt`.
- [x] Snapshot A1 milestone flipped `[ ]` → `[x]` with cycle-9 round-8 wire note + external anchors recorded.
- [ ] **Honest residual** — substrate fire DEFERRED. Identity-close ≠ measured-close ([[feedback_closure_is_physical_limit]]): cycle-10+ T4 measured contact via `/pool on ubu-1` + `/pool on mini` per-host Llama-3 8B FP16 throughput sweep (mac M3 / ubu-1 HF transformers / vast.ai pod cross-chip telemetry) required to bind placeholder per-chip tok/s to real silicon-lottery cohorts. Frontier perpetually open — 새 chip · cooling regime · workload 마다 A1 cell 재오픈 (per [[feedback_closure_is_physical_limit]]).
- [ ] **Honest residual** — A1 uses max−min spread proxy only. Sample-std (Newton-sqrt integer approximation) variance metric, per-batch (vs per-chip) variance, and chip-level temporal drift remain unverified — candidate axes A2 (sample-std variance) · A3 (per-batch vs per-chip variance decomposition) · A4 (temporal drift across burn-in) deferred to subsequent cycles.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
