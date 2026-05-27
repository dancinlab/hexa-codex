# RELIABILITY — log

Append-only history sister of `RELIABILITY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-10 reorg: N⭐ NOVEL MAIN = checkpoint-integrity (train/infer/serve stack · 🔵+🟡 · 7/7)

- [x] reorg: 기존 N⭐ (silent-vs-loud failure ratio) → **N2 강등**. 새 N1 = checkpoint(ckpt) 무결성이 NOVEL MAIN ⭐ lane 점유. A1 (단일 process 결정론) 의 자연스러운 깊이 — checkpoint 저장↔로드↔포맷변환 전체 무결성.
- [x] N1 closed-form bench: `RELIABILITY/bench/reliability_n1_checkpoint_integrity.hexa` — 5 ckpt roundtrip 시나리오 × {mismatch_ppm, format_loss_pct_x100}. identity `integrity_pass = (mismatch_ppm == 0) AND (format_loss_pct_x100 < 500)`. dual falsifier: (a) mismatch_ppm > 0 → resume 깨짐 · (b) loss_x100 > 500 (5%) → 변환 손실 과다. sentinel `__HEXA_CODEX_RELIABILITY_N1_CHECKPOINT_INTEGRITY__ DONE`.
- [x] 시나리오: safetensors_roundtrip (0ppm/0% silent) · pytorch_pickle (0ppm/0% silent) · gguf_q8 (0ppm/0.5% silent) · gguf_q4 (0ppm/3.2% borderline silent) · corrupted_shard (50000ppm fires). bidirectional fire: corrupted_shard (mismatch) + synthetic gguf_q2 (loss 8%).
- [x] N1 7-check verifier: `RELIABILITY/verify/numerics_reliability_n1_checkpoint_integrity.hexa` — (1) integrity identity (2) ranges valid (3) zero-loss bit-exact synthetic → pass (4) corrupted-shard mismatch fires (5) clean roundtrips silent (6) determinism (7) sanity mismatch≥0 ∧ loss≥0. env-driven `_root()`. sentinel `__HEXA_CODEX_NUMERICS_RELIABILITY_N1__ DONE`.
- [x] `hexa run` → **7/7 checks passed** · 🔵 STRUCTURAL + 🟡 BY-CITATION · verdict `RELIABILITY/verdicts/n1_checkpoint_integrity_verdict.txt`.
- [x] external anchors: safetensors spec (HuggingFace) · PyTorch torch.save/load · llama.cpp GGUF quant (Q8/Q4/Q2) · Gemma 4 GGUF conversion · ZeRO checkpoint (Rajbhandari 2020 · arXiv:1910.02054).
- [x] RELIABILITY.md::축 N — header → checkpoint-integrity NOVEL MAIN · N1 [x] wire note · 기존 silent-vs-loud → N2 [ ] 강등. SANDBOX substrate 표 N1/N2 row 갱신. @goal perpetual 유지 (종료 조건 없음 · 진행바 100% 미도달 = 설계).
- [ ] honest residual: 실측 (T4 substrate fire) DEFERRED → cycle-10+ — real ckpt save→load roundtrip (torch.save/load · safetensors) + llama.cpp quantize fidelity diff (mac M3 · vast.ai pod). closed-form identity close ≠ measured close. N⭐ perpetual MAIN — 새 ckpt format · quant scheme · sharding 마다 frontier 재오픈 ([[feedback_closure_is_physical_limit]]).

## 2026-05-28 — cycle-10 round-1: A1' MEASURED determinism elevation 🟡→🟢 (🟢 SUPPORTED-NUMERICAL · 7/7)

- [x] substrate choice: mac M3 host CPU SHA-256 (idle · single-process). llama-server present at `/opt/homebrew/bin/llama-server` but no large gguf locally (`~/.cache/llama-models/` empty); ubu-1 unreachable (ssh timeout to 10.142.0.1); ubu-2 has no llama-server; mini has no llama-server. CPU SHA-256 = available real determinism probe — `cx_lab_sandbox` 만족 (local pool · single-host).
- [x] determinism probe N=5 each, bidirectional:
    - det: `shasum -a 256 CODEX/CODEX.md` ×5 → all 5 hashes = `09ea07…f665` → 10/10 identical pairs → rate_x100=**10000** → silent ✓
    - nondet: `dd if=/dev/urandom bs=1M count=1 | shasum -a 256` ×5 → 5 distinct hashes (a1ec…61, d531…5b, 191d…64, 50af…c7, 2aa5…75) → 0/10 identical pairs → rate_x100=**0** → fires ✓ (well below threshold 9990 = 99.9%)
- [x] hexa verifier: `RELIABILITY/verify/numerics_reliability_a1_measured_repro.hexa` — 7-check mirror of round-6 closed-form ((1) rate identity (2) range [0,10000] (3) perfect=10000 (4) measured nondet fires (5) measured det silent (6) formula determinism (7) failure complement). × 100 ledger (libm-free integer math for 99.9% precision). N_pairs = N_runs*(N_runs-1)/2 = 10. sentinel `__HEXA_CODEX_RELIABILITY_A1_MEASURED__ DONE`.
- [x] `hexa run` → 7/7 PASS · 🟢 SUPPORTED-NUMERICAL · verdict `RELIABILITY/verdicts/a1_measured_repro_verdict.txt`.
- [x] RELIABILITY.md::축 A — A1' axis appended below A1 with CYCLE-10 round-1 wire note (tier 🟢, both verifier + verdict paths, bidirectional measured numbers).
- [ ] honest residual: full LLM serving stack determinism under load · GPU non-determinism · multi-host fan-out · ECC bit-flip injection DEFERRED (cycle-10+ T4 · vast.ai A100/H100 pod · llama-server with real model weights). 본 elevation 은 single-host single-process idle scope. frontier perpetual ([[feedback_closure_is_physical_limit]]) — 새 HW · model · serving stack 마다 재오픈.

## 2026-05-28 — cycle-9 round-6: A1 determinism reproduction-rate (🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7)

- [x] A1 first-probe closed-form bench: `RELIABILITY/bench/reliability_a1_determinism.hexa` — `reproduction_rate = N_match / N_total × 1000` (× 1000 ledger for 99.9% precision · libm-free integer math) · 4 placeholder setups (det-seed=1000 · fp32-quirk=999 · bit-flip=995 · nondet-kernel=850) · falsifier threshold rate < 999.
- [x] A1 7-check verifier: `RELIABILITY/verify/numerics_reliability_a1_determinism.hexa` — (1) rate identity (2) range [0,1000] (3) perfect=1000 (4) rate<999 fires (5) rate≥999 silent (6) formula determinism (7) failure-complement sanity. 7/7 PASS.
- [x] `hexa run` → 🔵 STRUCTURAL + 🟡 BY-CITATION · verdict `RELIABILITY/verdicts/a1_determinism_verdict.txt`.
- [x] external anchors: Dixit 2021 silent data corruption (arXiv:2102.11245) · Hochschild 2021 fail-silent (HotOS) · NVIDIA bit-flip (ECC SBE/DBE).
- [x] RELIABILITY.md::축 A 의 A1 [ ] → [x] (CYCLE-9 round-6 wire note).
- [ ] honest residual: 실측 (T4 substrate fire) DEFERRED → cycle-10+ — llama-server (mac M3) · HF transformers (ubu-1) · vast.ai pod ECC injection. closed-form identity close ≠ measured close ([[feedback_closure_is_physical_limit]]). frontier perpetual — 새 HW·model·serving stack 마다 재오픈.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
