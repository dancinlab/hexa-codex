#!/usr/bin/env bash
# Pod orchestrator: deps -> verify model -> AWQ quant -> uncensored smoke gate -> HF upload (gated on PASS).
# HF_TOKEN is read from the environment (never echoed). Run with nohup; tail awq-run.log.
set -uo pipefail
LOG=/workspace/awq-run.log
exec > >(tee -a "$LOG") 2>&1
echo "=== run start $(date -u) ==="

export SRC=/workspace/model
export OUT=/workspace/awq-out
export RESULT=/workspace/smoke_result.json
REPO=dancinlab/qwen2.5-32b-uncensored-AWQ

# 1. deps — PIN transformers to an autoawq-0.2.9 + torch-2.4.1 compatible line.
# (autoawq is archived/deprecated; transformers 5.x needs torch>=2.7's float8_e8m0fnu
#  and breaks PreTrainedModel import on this image — pin down, do NOT touch torch.)
echo "[run] installing deps"
# transformers 4.51.3 is autoawq 0.2.9's OFFICIAL last-tested version (its own deprecation
# notice says so). 4.48 lacks qwen3 (autoawq imports it); 4.52+ adds the `attention_type`
# attr that breaks autoawq's Catcher calibration proxy; 5.x needs torch>=2.7. 4.51.3 is the
# one blessed window — has qwen3, no attention_type, runs on torch 2.4.1.
pip install -q autoawq "transformers==4.51.3" "tokenizers<0.22" accelerate huggingface_hub \
  || { echo "__PIP_FAIL__"; exit 1; }
python3 -c "import transformers,torch;print('[run] transformers',transformers.__version__,'torch',torch.__version__)"

# 2. verify model present on the prebaked volume; fall back to HF download
if [ ! -f "$SRC/config.json" ]; then
  echo "[run] model not on volume — downloading dancinlab/qwen2.5-32b-uncensored"
  python3 -c "import os;from huggingface_hub import snapshot_download;snapshot_download('dancinlab/qwen2.5-32b-uncensored',local_dir=os.environ['SRC'],token=os.environ['HF_TOKEN'])" \
    || { echo "__DL_FAIL__"; exit 1; }
else
  echo "[run] model present on volume: $SRC"
fi

# 3. quantize
echo "[run] AWQ 4bit quantization"
python3 /workspace/quant_awq.py || { echo "__QUANT_FAIL__"; exit 1; }

# 4. uncensored smoke gate (base vs AWQ)
echo "[run] uncensored smoke gate"
python3 /workspace/smoke_uncensored.py || true   # verdict file is the source of truth

VERDICT=$(python3 -c "import json;print(json.load(open('$RESULT'))['verdict'])" 2>/dev/null || echo "ERROR")
echo "[run] smoke verdict: $VERDICT"

# 5. upload to HF (PRIVATE) only if the refusal-removal survived quantization
if [ "$VERDICT" = "PASS" ]; then
  cp /workspace/MODELCARD-AWQ.md "$OUT/README.md" 2>/dev/null || true
  python3 -c "
import os
from huggingface_hub import HfApi
api = HfApi(token=os.environ['HF_TOKEN'])
api.create_repo('$REPO', private=True, repo_type='model', exist_ok=True)
api.upload_folder(folder_path=os.environ['OUT'], repo_id='$REPO', repo_type='model')
print('[run] uploaded ->', '$REPO')
" && echo "__UPLOAD_DONE__" || echo "__UPLOAD_FAIL__"
else
  echo "__SMOKE_GATE_BLOCKED_UPLOAD__ (verdict=$VERDICT) — AWQ NOT uploaded; inspect $RESULT"
fi

echo "=== run end $(date -u) ==="
echo "__RUN_COMPLETE__"
