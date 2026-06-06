#!/usr/bin/env bash
# Re-run ONLY the smoke gate via vLLM (quant artifact already produced + intact), then
# upload to HF (PRIVATE) gated on PASS. HF_TOKEN read from env (never echoed).
set -uo pipefail
LOG=/workspace/awq-run2.log
exec > >(tee -a "$LOG") 2>&1
echo "=== run2 (vllm smoke) start $(date -u) ==="

export OUT=/workspace/awq-out
export RESULT=/workspace/smoke_result.json
REPO=dancinlab/qwen2.5-32b-uncensored-AWQ

echo "[run2] installing vllm (torch 2.4 compatible)"
pip install -q "vllm==0.6.3.post1" || { echo "__PIP_FAIL__"; exit 1; }
python3 -c "import torch,vllm;print('[run2] torch',torch.__version__,'vllm',vllm.__version__)"

echo "[run2] uncensored smoke gate (vLLM awq_marlin)"
python3 /workspace/smoke_awq_vllm.py || true   # verdict file is source of truth

VERDICT=$(python3 -c "import json;print(json.load(open('$RESULT'))['verdict'])" 2>/dev/null || echo "ERROR")
echo "[run2] smoke verdict: $VERDICT"

if [ "$VERDICT" = "PASS" ]; then
  cp /workspace/MODELCARD-AWQ.md "$OUT/README.md" 2>/dev/null || true
  python3 -c "
import os
from huggingface_hub import HfApi
api = HfApi(token=os.environ['HF_TOKEN'])
api.create_repo('$REPO', private=True, repo_type='model', exist_ok=True)
api.upload_folder(folder_path=os.environ['OUT'], repo_id='$REPO', repo_type='model')
print('[run2] uploaded ->', '$REPO')
" && echo "__UPLOAD_DONE__" || echo "__UPLOAD_FAIL__"
else
  echo "__SMOKE_GATE_BLOCKED_UPLOAD__ (verdict=$VERDICT) — AWQ NOT uploaded; inspect $RESULT"
fi
echo "=== run2 end $(date -u) ==="
echo "__RUN_COMPLETE__"
