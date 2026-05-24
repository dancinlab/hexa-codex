@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "rwkv-m1-accuracy-floor"
  source = "RWKV M1 Surface landing — RWKV-7 Goose World3 2.9B q5_k_m served on stock llama.cpp 9150, 20-task SANDBOX manifest"
  date   = "2026-05-25"
  flow   = "engine-native (no rwkv.cpp) -> jinja-broken gotcha -> empirical floor 15/20=75% -> honest positive (hits usable floor) -> flat RSS = M2 baseline -> M2 sweep + M1+ language-drift next-cycle seeds (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — how RWKV-7 2.9B was actually run, and what fell out
# ════════════════════════════════════════════════════════════════════
# Engine path (the load-bearing M1 unblock, and the surprise vs BitNet): RWKV-7 is
# ALREADY natively supported by stock brew llama.cpp 9150 — general.architecture =
# "rwkv7" (902 tensors, ctx_len 1048576, embd 2560, 32 blocks). NO rwkv.cpp build,
# NO conversion (contrast BitNet M1, which needed a bf16->TQ2_0 convert + 3 patches,
# and M2+ which needed a full bitnet.cpp build). GGUF = community mirror
# Mungert/RWKV7-Goose-World3-2.9B-HF-GGUF q5_k_m (2.13 GB); official source
# RWKV/RWKV7-Goose-World3-2.9B-HF (LF AI & Data, arxiv 2503.14456). The first repo
# tried (latestissue/rwkv7-goose-world3-2.9b-gguf) listed files in the HF API but
# the LFS blobs 404'd (EntryNotFound) -> Mungert mirror used instead.
#
# Engine gotchas (both verified before benching, both honest):
#   (1) the GGUF's built-in jinja chat_template = "rwkv-world" is BROKEN on this
#       engine: --jinja leaks the literal template name and decodes garbage
#       ("rwkv-world-cup-2022-qatar-tournament-tickets-on..."). So NO --jinja;
#       instead the model's native plain "User: <prompt>\n\nAssistant:" frame,
#       parsed assistant_prefix (strip up to LAST "Assistant:") + cut at the next
#       "User:" (the World model is base/continuation: keeps generating after the
#       answer). This is the RWKV analogue of BitNet's --jinja serving mode.
#   (2) llama-cli's -no-cnv is unsupported ("please use llama-completion instead");
#       llama-completion is the right tool (same one BitNet M1 used).
#
# FINDING (M1, honest POSITIVE): RWKV-7-Goose-World3-2.9B-q5_k_m scored 15/20 =
# 75.0% on the SAME 20-task canonical manifest where BitNet 2B4T = 6/20 = 30% and
# clean Qwen2.5-0.5B-Q4 = 16/20 = 80%. RWKV-7 2.9B HITS the usable floor (>=15/20),
# far above BitNet, just 1 task below the 4-bit 0.5B Qwen baseline. 5 misses: 2 are
# World/base-model language-drift to Chinese on number-only prompts (idx10 days-in-
# Feb, idx14 sort) — the World tokenizer is heavily multilingual; 1 is a harness
# PARSE_ERROR (idx17 tab-laden Fibonacci code broke the 6-field split, scored
# conservatively as WRONG, NOT a model failure); only idx7 (continents->"5") + idx8
# (boiling-point->off-topic prose) are genuine factual model errors.
#
# FINDING (M2 baseline, visible inside M1): peak RSS = 2249 MB on Metal/UMA, FLAT
# ~2353-2358 MB across all 20 tasks. RWKV is an RNN with NO KV-cache, so the per-
# task RSS column already shows constant memory at the single-prompt scale — the M2
# Constant-memory milestone's baseline. The context-length sweep (RWKV flat vs
# Transformer KV-cache O(n)) remains the substantive M2 work (M2 left [ ]).

@C d_rwkv_m1_engine_native := "RWKV-7 2.9B served on STOCK llama.cpp 9150 — arch rwkv7 natively supported, NO rwkv.cpp build, NO conversion (engine VERIFIED, M1 unblocked)" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "hf download Mungert/RWKV7-Goose-World3-2.9B-HF-GGUF q5_k_m; llama-completion -p 'User: <q>\\n\\nAssistant:' --temp 0 -st  (NO --jinja, Metal/UMA)"
  hyp     = "stock brew llama.cpp 9150 can serve RWKV-7 Goose 2.9B ($0 local) WITHOUT a separate rwkv.cpp build or any GGUF conversion"
  verdict = "TRUE — general.architecture=rwkv7 loads natively (902 tensors, ctx 1048576, embd 2560, 32 blocks), decodes coherently on Metal/UMA @ ~13 tok/s. Cheaper unblock than BitNet (which needed bf16->TQ2_0 convert + 3 patches, or a full bitnet.cpp build). .verdicts/rwkv/m1_accuracy_floor_summary.txt"

@C d_rwkv_m1_jinja_template_broken := "the GGUF's built-in jinja chat_template 'rwkv-world' is BROKEN on llama.cpp 9150 — --jinja leaks the template name + decodes garbage; plain User:/Assistant: frame is the fair serving mode" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "llama-completion --jinja -p 'What is 2+2?' -> 'rwkv-world-cup-2022-qatar-tournament-tickets-on...' (garbage); vs llama-completion -p 'User: What is 2+2?\\n\\nAssistant:' -> '4' (coherent)"
  hyp     = "the embedded rwkv-world jinja template is the correct serving path for this GGUF on this engine"
  verdict = "FALSIFIED — --jinja leaks the literal string 'rwkv-world' into the decode and produces garbage (same failure as llama-cli interactive mode). The native plain 'User: <prompt>\\n\\nAssistant:' frame + assistant_prefix parse (cut at next User:) decodes coherently. This is the RWKV analogue of BitNet's --jinja mode (opposite sign: BitNet NEEDED --jinja, RWKV must AVOID it)."

@C d_rwkv_m1_floor_positive := "RWKV-7 2.9B q5_k_m scores 15/20 = 75.0% — HITS the usable floor (>=15/20), far above BitNet 2B4T (30%), 1 task below Qwen-0.5B-Q4 (80%) on the same manifest" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "bench/rwkv_m1_accuracy_floor.hexa (20-task manifest + byte_exact_subset scorer VERBATIM from bitnet_m1 / sandbox_stage0_baseline.hexa; only engine call + prompt frame differ)"
  hyp     = "an attention-free RNN LLM (RWKV-7 Goose 2.9B) reaches the SANDBOX usable accuracy floor (>=15/20) at q5_k_m precision, $0 local"
  verdict = "TRUE — 15/20 = 75.0%, usable_floor_reached=true. Comparators on the IDENTICAL manifest+scorer: BitNet 2B4T 6/20=30% (FALSIFIED its floor), Qwen2.5-0.5B-Q4 16/20=80%. RWKV-7 2.9B is the FIRST non-Transformer model on this substrate to clear the floor. 5 misses honestly characterized: 2 Chinese language-drift (idx10/idx14), 1 harness parse-error (idx17, conservatively WRONG), 2 genuine factual errors (idx7/idx8). .verdicts/rwkv/m1_accuracy_floor.tsv"

@C d_rwkv_m2_constant_memory_baseline := "M2 baseline visible inside M1: peak RSS 2249 MB, FLAT ~2353-2358 MB across all 20 tasks — RNN constant memory, NO KV-cache growth" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "/usr/bin/time -l RSS capture per task during the M1 serving session (rss_bytes column of m1_accuracy_floor.tsv)"
  hyp     = "RWKV resident memory is flat at the single-prompt scale (no KV-cache), foreshadowing the M2 constant-memory law vs a Transformer's O(n) KV-cache"
  verdict = "TRUE at the single-prompt scale — per-task RSS holds within a ~5 MB band (2353-2358 MB) across 20 heterogeneous prompts; peak 2249 MB summary integer. This is the M2 Constant-memory BASELINE; the context-length SWEEP (flat vs Transformer O(n)) is the substantive M2 work, left open."

@C d_rwkv_m2_sweep_and_m1plus_language_drift := "next-cycle seeds — (M2) context-length RSS+latency sweep RWKV flat vs Transformer O(n) KV-cache; (M1+) strict-language prompt to recover the 2 Chinese-drift misses" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "M2: sweep ctx_len {1k,4k,16k,64k,256k} measuring RSS + per-token + prefill latency for RWKV-7 2.9B vs a Transformer (Qwen2.5-3B-Q4) on the SAME substrate. M1+: re-serve idx10/idx14 with a strict 'answer in English only' system prompt (re-serve, NOT silent re-score)."
  hyp     = "M2: RWKV RSS stays flat while the Transformer's KV-cache grows O(n) and prefill grows O(n^2) (falsifier: RWKV RSS/latency superlinear in ctx). M1+: the 2 Chinese-drift misses are language-routing, not knowledge gaps -> a language-pinned prompt lifts 75% toward ~85%."
  verdict = "OPEN — RWKV-7 ctx_len=1048576 makes the long-context sweep the natural M2/M3 probe; the q5_k_m GGUF (2.13 GB) + Qwen baselines are already on disk, so the sweep is $0 local. M1+ is a bounded 2-task re-serve; honesty note: do NOT re-score the saved completions, re-serve under the new prompt (g5/R6)."
