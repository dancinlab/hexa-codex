@V := "tape" :: spec [active]
  version = "1.2"

@I := "hexa-codex" :: identity [active]
  kind   = "AI knowledge substrate (17-verb spec library · `lm_foundry/` hexa-lang code-LLM 94.29% Mk.I)"
  brief  = "Safety · economics · ops · substrate verbs + 3-vendor orchestration runtime."
  parent = "dancinlab"
  ssot   = "github.com/dancinlab/hexa-codex (`hx install hexa-codex`)"

@D cx_hf_complete := "HF registration — complete, no missing artifacts" :: governance [required active]
  do   = "register every shipped model / dataset / checkpoint to HuggingFace Hub COMPLETELY — weights · config · tokenizer · model card · eval results all present; verify the HF repo file manifest matches local before declaring done"
  dont = "partial HF upload (missing weights / config / tokenizer / eval) · model card referencing files not actually uploaded · leave the HF repo out of sync with local artifacts"
