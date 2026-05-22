@V := "tape" :: spec [active]
  version = "1.2"

@I := "hexa-codex" :: identity [active]
  kind   = "AI knowledge substrate (17-verb spec library · `lm_foundry/` hexa-lang code-LLM 94.29% Mk.I)"
  brief  = "Safety · economics · ops · substrate verbs + 3-vendor orchestration runtime."
  parent = "dancinlab"
  ssot   = "github.com/dancinlab/hexa-codex (`hx install hexa-codex`)"

@D cx_hf_complete := "HF registration — complete, no missing artifacts" :: governance [required active]
  do   = "register every model / dataset / ckpt to HF Hub COMPLETE — all artifacts present · manifest = local"
  dont = "partial HF upload · model card referencing un-uploaded files · HF repo out of sync with local"
