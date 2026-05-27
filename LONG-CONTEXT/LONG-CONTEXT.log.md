# LONG-CONTEXT — log

Append-only history sister of `LONG-CONTEXT.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — N2 KV-cache efficiency build (cycle-10 reorg Batch C · 마지막 7번째 축)

- [x] N2 — KV-cache 메모리 효율 closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/long_context_n2_kv_cache_efficiency.hexa` · `verify/numerics_long_context_n2_kv_cache_efficiency.hexa` · `verdicts/n2_kv_cache_efficiency_verdict.txt`.
- [x] identity: `utilization = used_blocks / allocated_blocks` (× 10000) · `waste = 100 − util` · falsifier `util < 50% (5000)` → 메모리 절반 이상 over-allocation fragmentation 낭비.
- [x] worked example 5 cache 전략 (used=100 고정): paged_vllm alloc105=95.2% silent · paged_conservative alloc115=86.9% silent · dynamic_good alloc110=90.9% silent · contiguous_padded alloc220=45.4% fires · static_maxlen alloc250=40.0% fires (max_len 통째 예약).
- [x] bidirectional discrimination (3 silent ≥50% · 2 fire <50%) + over-allocation sanity (allocated ≥ used → util ≤ 100% · under-allocation 불가).
- [x] external anchors: Kwon 2023 vLLM PagedAttention (arXiv:2309.06180) · Sheng 2023 FlexGen (arXiv:2303.06865) · Hooper 2024 KVQuant (arXiv:2401.18079) · Pope 2022 efficiently scaling transformer inference (arXiv:2211.05102).
- **honest residual**: 실측 미수행 — cycle-10+ T4 deferred (vLLM gpu_memory_utilization vs KV-cache block stats on serving stack). frontier OPEN ([[feedback_closure_is_physical_limit]]).
- **note**: A1 (NIAH) · N⭐ N1 (position×content coupling) 보존 — N2 신규 추가만.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-5, /cycle-fg inline)

- [x] A1 — NIAH drop ratio closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `verify/numerics_long_context_a1_niah_drop.hexa` · `verdicts/a1_niah_drop_verdict.txt`.
- [x] identity: `drop_ratio = acc_64k / acc_4k` (× 1000) + monotone non-increase sanity (16k ≤ 4k AND 64k ≤ 16k).
- [x] worked example 4 models × {4k/16k/64k} ladder: solid 88/95 silent · ok 65/92 silent · degrades 38/88 fires · breaks 20/90 fires.
- [x] external anchors: Liu 2023 lost-in-the-middle (arXiv:2307.03172) · Kamradt 2023 NIAH · Bai 2023 LongBench · An 2023 L-Eval.
- **honest residual**: 실측 NIAH 미수행 — cycle-10+ T4 deferred (mac M3 llama-server · Qwen2.5/Llama-3.x scale ladder).
- [ ] 축 B (multi-needle recall at varying depth · 거리별 attention 강도 fit) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (position-vs-content coupling · 위치 × 난이도 cross-product) — measured-tier 필요.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
