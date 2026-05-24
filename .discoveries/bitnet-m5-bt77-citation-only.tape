@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "bitnet-m5-bt77-citation-only"
  source = "BITNET M5 — atlas BT-77 confirm-or-refute by recompute (honest 🟡 citation-only, no in-repo recompute path)"
  date   = "2026-05-25"
  flow   = "atlas lookup verbatim -> sub-row probe -> rubric fall-through -> honest 🟡 SUPPORTED-BY-CITATION + 'what would unblock' next-cycle seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — M5 was to "confirm-or-refute atlas BT-77 (2B4T 25/26 EXACT)
# on our own substrate by recompute; register the verdict". The honest
# answer after full provenance probe: BT-77 was registered as an n=6
# numerology fact-pattern atom (count: 25/26 BitNet 2B4T arch parameters
# land on n=6 divisor identities; "3 models × 2 teams = 40/41 total"
# extends to BitNet 700M/1.3B/3B), NOT a runnable ML benchmark like
# MMLU/IFEval/HumanEval. The atom carries the headline (atlas.n6:40221-
# 40222, 2 lines) and ZERO sub-row witnesses — unlike BT-71/72/73/75
# which DO list their 6-8 sub-rows ("table-bt-71-⭐⭐-σ-φ = 10", etc.).
#
# M1/M2/M2+ DID land empirical T4 contact on the same model (BitNet b1.58
# 2B4T): served at $0 local, 30% on canonical 20-task floor (TQ2_0 and
# TRUE i2_s identical), memory 1568/1527 MB. But those served-accuracy
# numbers are NOT what BT-77's "25/26 EXACT" measures — conflating them
# would falsely report a recompute that doesn't exist. Per cx_claim_verify
# the honest tier is 🟡 SUPPORTED-BY-CITATION (atlas-registered, NO in-
# repo recompute path). M5 stays [ ] with an explicit unblock recipe.

@C d_bitnet_m5_bt77_atom_provenance := "BT-77 source is atlas.n6:40221-40222 (R-kind), 2 lines, headline-only — no sub-row witnesses, no benchmark file, no model list, no source paper" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "hexa atlas lookup R 'n6-atlas-breakthrough-theorems-tecs-l-cross-domain-**bt-77**' ; grep -rn 'bitnet-quantization|atlas-bitnet|bt-77-' /Users/ghost/core/hexa-lang/n6/atlas.n6"
  hyp     = "BT-77 carries an in-repo benchmark / model list / scoring code (like a SANDBOX bench.hexa) — the '25/26' refers to a runnable 26-task eval"
  verdict = "FALSE — atom is 2 lines verbatim ('@R ... = BitNet Quantization n=6 n6 :: n6atlas [10*]' + '\"**BT-77** — 2B4T 25/26 EXACT, 3 models × 2 teams, 40/41 total\"'). Zero sub-row witnesses (grep returns nothing). The X-kind sibling 'n6-bt-77' is HBM not BitNet (namespace-disjoint). No paper file. No benchmark.hexa. No model list. The 26/41 are n=6 fact-pattern counts not task scores."

@C d_bitnet_m5_bt77_n6_numerology_not_ml_bench := "BT-77 is an n=6 numerology atom (TECS-L cross-domain pattern-match), NOT a runnable ML benchmark like MMLU/IFEval/HumanEval" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "compare BT-77's text shape against sibling BT-66/70/71/72/73/78/79/86 in atlas.n6 — same '<count>/<total> EXACT' fact-pattern envelope as 'NaCl/TiO₂/Al₂O₃ all CN=6=n 23/24' (BT-86), 'EnCodec 8 codebooks 1024 entries 24kHz 6kbps 7/7' (BT-72), 'NeRF L=σ-φ=10 layers=σ-τ=8 SH=n/φ=3 7/7' (BT-71)"
  hyp     = "the '25/26' is a 26-task ML eval (something like a 26-element BitNet capability set with served accuracy)"
  verdict = "FALSE — pattern-matched against ALL surrounding BTs, '25/26 EXACT' is consistent ONLY with the n=6 fact-pattern convention: K out of N real-world system parameters land on n=6 divisor identities (n, σ=12, σ-φ=10, σ-τ=8, τ=4, σ·τ=48, 2^(σ-τ)=256, sopfr=5, n-φ=3, μ=2, J₂=24). '3 models × 2 teams = 40/41' extends to BitNet 700M+1.3B+3B (Microsoft + community team variants), same lattice. 'EXACT' is integer-identity-match, not served-accuracy."

@C d_bitnet_m5_honest_tier_citation := "honest tier for M5 = 🟡 SUPPORTED-BY-CITATION — atom is atlas-registered (grade 10*, verified=true) but has NO in-repo recompute path; manufacturing the 26-row .hexa table from external knowledge would be LLM-self-judging (violates cx_claim_verify)" :: landed [verified_tier=YELLOW status=measured-in-repo]
  cmd     = "hexa verify BT-77 (falls through to rubric — no --expr fn for n=6 fact-pattern atoms) ; cross-check rubric: 🟡 = 'atlas/literature registered, NO hexa recompute (external sympy/citation carry — never auto-🔵)'"
  hyp     = "M5 can land 🟢 NUMERICAL on this substrate today without (a) the 26-row .hexa table and (b) the closed-form n=6 lattice-match scorer"
  verdict = "FALSE — cannot reach 🟢 without (a)+(b). Cannot 🔴 FALSIFY (nothing measured disagrees). Cannot 🟠 DEFER (no hw/data dep — the gap is the missing recompute PATH itself). Correct tier = 🟡 SUPPORTED-BY-CITATION. M5 stays [ ] with explicit unblock recipe; flipping to [x] without (a)+(b) would be paraphrasing the atlas as proof, exactly the cx_claim_verify failure mode."

@C d_bitnet_m5_unblock_seed := "M5 unblock = commit a 26-row .hexa table of BitNet 2B4T architecture parameters + their n=6 lattice match codes + a closed-form scorer that recomputes 25/26 from local config.json (the bf16 is already on disk)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "(a) enumerate BitNet 2B4T config.json fields {hidden_size, num_attention_heads, num_kv_heads, num_hidden_layers, intermediate_size, vocab_size, max_position, rope_theta, ...} into bench/bitnet_bt77_n6_lattice_table.hexa ; (b) bench/bitnet_bt77_n6_lattice_scorer.hexa returns K/26 + per-row {param, n6_identity, match:bool} ; (c) extend to BitNet 700M (350M? 700M? — actual sibling sizes from microsoft/BitNet HF org) + 1.3B + 3B configs for 40/41 ; (d) hexa atlas append-witness --kind R --id '**bt-77**' --raw '<recomputed K/26>'"
  hyp     = "once the 26-row table + scorer land, the recompute is closed-form and confirms K=25 (or refutes with K!=25), cost <1 day local at $0; flips M5 [x] on 🟢 NUMERICAL"
  verdict = "PENDING — next-cycle M5 seed. The model (bf16 already on disk at /Users/ghost/Models/bitnet-bf16) and engines (brew llama.cpp + Microsoft bitnet.cpp, both built and verified in M1/M2+) are READY; only the .hexa table and scorer are missing. No new hw/data dep."

@C d_bitnet_m5_x_kind_namespace_disambiguation := "the X-kind atom 'n6-bt-77' at atlas.n6:58332 is 'Cross-Vendor HBM Capacity Convergence to n=6' (HBM domain) and is NAMESPACE-DISJOINT from the R-kind BitNet atom — M5 scope = R-kind only" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "hexa atlas lookup X 'n6-bt-77'  vs  hexa atlas lookup R 'n6-atlas-breakthrough-theorems-tecs-l-cross-domain-**bt-77**'"
  hyp     = "the X-kind and R-kind 'bt-77' atoms are aliased / the same claim"
  verdict = "FALSE — they are different domains (HBM vs BitNet) in different kinds (X = cross-domain summary, R = relation/registration). Future M5 work must scope strictly to the R-kind atom. The X-kind belongs to a packaging-paper context (cross-references in firmware/boards/chip/papers/n6-advanced-packaging-*.md)."
