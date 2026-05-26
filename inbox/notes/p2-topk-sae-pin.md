# P2 Top-K SAE library pin — cycle-25 FIRE preflight resolution

> **상태:** OPEN · cycle-24 lane A4 작성 (2026-05-26) — 다음 cycle-25 P2 FIRE 의
> 외부 SAE library pin + ubu-1 venv 설치 + dispatch 명령어 확정 runbook
> **대상 호스트:** ubu-1 (aiden-B650M-K · Linux · RTX 5070 12GB · cycle-20 substrate)
> **막힌 FIRE:** `bench/sandbox_p2_topk_sae_lever.hexa` 의 `dispatch_plan()` 내
> `TBD_PIN_SAE_LIB` + `TODO_PIN_REFERENCE_REPO_COMMIT` 마커 (cycle-22 commit, PR #68)

## 컨텍스트 — 무엇을 해결하는가

cycle-22 의 SAE-lever-isolation skeleton (`bench/sandbox_p2_topk_sae_lever.hexa`)
은 SAE-train 본체를 외부 library 에 dispatch 하도록 설계됐다 (Hexa stdlib 에
autodiff/SAE 학습 primitive 없음 — `feedback_hexa_only_authoring` 준수). cycle-25
P2 FIRE 가 zero infra decision 으로 진입하려면:

1. 어느 library 의, 어느 commit SHA 를 쓸 것인가?
2. ubu-1 의 cycle-20 `~/sandbox_probe/venv` 와 호환되는 install 절차는?
3. `dispatch_plan()` 의 `TODO_PIN_SAE_LIB` 줄이 정확히 어떤 명령어가 되는가?

이 runbook 이 그 세 가지를 결론까지 박는다.

## 후보 library 3개 — 실측 SHA + 차이점

GitHub API (`curl https://api.github.com/repos/<owner>/<repo>/...`) 로 직접
조회한 결과 (cite-URL 포함, fetch 일자 2026-05-26):

| 후보 | 최신 tag | commit SHA (40-char) | license | size 추정 | 3-family coverage |
|------|----------|----------------------|---------|----------|-------------------|
| `openai/sparse_autoencoder` | (no releases) — HEAD only | `4965b941e9eb590b00b253a2c406db1e1b193942` (2024-06-30) | MIT | ~50KB python (sparse_autoencoder/ dir, 14 commits total) | Top-K **only** (Gao-Goh-Heimersheim 참조 구현; JumpReLU/BatchTopK 없음) |
| `jbloomAus/SAELens` (= `decoderesearch/SAELens`) | v6.44.0 (2026-05-20) | `3b3f4cacf992645f1f7c08525ed6c122a9cd30a1` | MIT | PyPI `sae-lens` ~수 MB + transformer-lens 의존 ~수십 MB | **3-family 모두** (`sae_lens/saes/topk_sae.py` + `jumprelu_sae.py` + `batchtopk_sae.py` 확인) |
| `EleutherAI/sparsify` (renamed from `EleutherAI/sae`) | v1.3.0 (2025-11-17) | `b2dee7c6d38a0d78fdc50754164e23e51fd14f68` | MIT | PyPI `eai-sparsify` 중간 size | Top-K + JumpReLU (단일 `sparse_coder.py` 의 config flag; BatchTopK 별도 클래스 없음) |

### Fetch URL provenance (검증용)

- `https://api.github.com/repos/openai/sparse_autoencoder/commits/main` → `sha=4965b941...193942` (Leo Gao, 2024-06-30 09:08:02Z, "Update README.md")
- `https://api.github.com/repos/openai/sparse_autoencoder/tags` → `[]` (empty — no releases)
- `https://api.github.com/repos/jbloomAus/SAELens/releases/latest` → `tag_name=v6.44.0` (annotated tag obj SHA `a1ac50bf...0f1d` → dereference → commit SHA `3b3f4cac...30a1`, semantic-release 2026-05-20)
- `https://api.github.com/repos/jbloomAus/SAELens/contents/sae_lens/saes` → 파일 목록 안에 `topk_sae.py` · `jumprelu_sae.py` · `batchtopk_sae.py` 모두 존재
- `https://api.github.com/repos/EleutherAI/sparsify/releases/latest` → `tag_name=v1.3.0` (annotated tag obj SHA `1a119ab8...0038` → dereference → commit SHA `b2dee7c6...4f68`, semantic-release 2025-11-17)
- `https://api.github.com/repos/EleutherAI/sparsify/contents/sparsify` → `sparse_coder.py` 단일 (config-flag 기반 family switch)
- `https://raw.githubusercontent.com/openai/sparse_autoencoder/main/pyproject.toml` → `torch == 2.1.0` (hard pin, **cycle-20 의 torch 2.12+cu130 venv 와 충돌**)
- `https://raw.githubusercontent.com/jbloomAus/SAELens/main/pyproject.toml` → `transformers >=4.38.1,<6.0.0` (cycle-20 의 4.51.3 와 양립)
- `https://raw.githubusercontent.com/EleutherAI/sparsify/main/pyproject.toml` → name=`eai-sparsify`, `requires-python = ">=3.10"`

## 추천 — **SAELens** (`v6.44.0` @ `3b3f4cacf992645f1f7c08525ed6c122a9cd30a1`)

### 근거 (cycle-22 의 default candidate 추측을 실측으로 추인)

1. **3-family single-config coverage 가 직접 확인됐다** — `sae_lens/saes/` 디렉토리에
   `topk_sae.py` · `jumprelu_sae.py` · `batchtopk_sae.py` 세 파일이 별도 존재.
   cycle-22 harness 가 요구하는 (Top-K K∈{8,16,32} + JumpReLU + BatchTopK) 5개 row
   를 **한 venv · 한 import 경로** 로 모두 dispatch 가능. EleutherAI/sparsify 는
   Top-K + JumpReLU 까지만 (BatchTopK 별도 클래스 없음); openai/sparse_autoencoder
   는 Top-K 단일.

2. **cycle-20 venv pin 과 호환** — SAELens 의 `transformers >=4.38.1,<6.0.0` 는
   cycle-20 의 `transformers==4.51.3` (per `reference_activation_capture_env`) 를
   직접 수용. 대조: **openai/sparse_autoencoder 는 `torch==2.1.0` 하드 핀** 이라
   cycle-20 의 `torch 2.12+cu130` venv 를 깨뜨림 — 별도 venv 또 만들어야 함
   (overhead +1 venv).

3. **최신 + 활발한 릴리스** — SAELens v6.44.0 은 2026-05-20 (이번 달!),
   semantic-release 자동 태깅. openai/sparse_autoencoder 는 2024-06-30 이후
   commit 없음 (사실상 freeze). EleutherAI/sparsify v1.3.0 은 2025-11-17.

4. **install + dispatch surface 최소** — PyPI `pip install sae-lens==6.44.0`
   한 줄. 3 후보 모두 git clone 없이 PyPI 로 가능하지만 (openai 도 git+
   install 가능), SAELens 만이 5개 row 를 **한 library** 로 처리.

### Honest residual — 추천에 매달린 위험

- SAELens 는 `transformer-lens` 를 강제 의존 (`>=2.16.1`). `transformer-lens`
  는 Qwen2.5 지원 (확인됨, v2.x 부터) 인데, cycle-22 가 활용하는 cycle-20
  의 acts cache (HF transformers hook 으로 캡처된 `l19_acts_cache.pt`) 와
  shape/dtype 호환만 맞으면 transformer-lens 의 hook surface 는 우회 가능
  (SAELens 의 `SAETrainingRunner` 는 외부에서 미리 모은 activations 도 학습
  가능 — `ActivationsStore.from_iterable_of_dicts` 패턴). cycle-25 의 첫 step
  은 이 import shape 를 smoke 로 확인하는 것.
- SAELens BatchTopK `batchtopk_sae.py` 의 API 가 cycle-22 harness 의
  "AUTO_TUNED_TO_MEAN_L0~16" 자동 튜닝 요구를 지원하는지는 코드 inspection
  필요 — 미지원이면 binary search wrapper 가 cycle-25 의 추가 작업이 됨
  (skeleton 의 manifest 는 정확하나 dispatch 의 K-tune step 이 1줄 추가).

## ubu-1 venv 설치 — 정확한 명령어

cycle-20 의 `~/sandbox_probe/venv` 를 **재사용하지 않는다** (cycle-20 venv 는
HF transformers hook 캡처용 — pin 이 fragile · SAELens 의 transformer-lens
의존이 이 venv 의 transformers pin 과 부딪칠 수 있음). 별도 venv 신설:

```bash
# ubu-1 위에서 (또는 mini 에서 `pool on ubu-1 '...'` 로):
cd $HOME/sandbox_probe   # cycle-20 의 작업 디렉토리 (acts cache 가 여기 있음)
python3.11 -m venv venv_sae           # SAELens 전용 분리 venv
source venv_sae/bin/activate
pip install --upgrade pip
# SAELens v6.44.0 정확히 — semantic-release 태그 = PyPI 버전 일치
pip install "sae-lens==6.44.0"
# cycle-20 acts cache 로딩에 필요한 torch (transformer-lens 가 끌어옴, 자동)
# acts cache 가 fp32 이므로 numpy 도 자동 설치되지만, cycle-20 의 NumPy 1.x
# 제약 (transformers 4.51.3 의 알려진 numpy<2 의존, per
# reference_activation_capture_env) 을 동일 venv 에서 유지:
pip install "numpy<2"   # NumPy 1.26.4 가 SAELens 와도 양립
# smoke
python -c "import sae_lens; print(sae_lens.__version__)"   # 6.44.0 출력 기대
python -c "from sae_lens.saes.topk_sae import TopKSAE; print('OK topk')"
python -c "from sae_lens.saes.jumprelu_sae import JumpReLUSAE; print('OK jumprelu')"
python -c "from sae_lens.saes.batchtopk_sae import BatchTopKSAE; print('OK batchtopk')"
```

(class 이름은 cycle-25 가 진입 시점에 SAELens 의 `__init__.py` 로 최종 확인 —
import path 가 `sae_lens.saes.<family>_sae` 인 것까지는 `contents/` API 로 검증함.
정확한 클래스 시그니처는 cycle-25 의 첫 smoke 가 결정.)

추정 디스크 size ≈ SAELens 본체 ~수 MB + `transformer-lens` ~수십 MB +
torch (이미 cycle-20 venv 에 있으나 venv_sae 신설이므로 재설치) ~2GB +
nvidia-cuda runtime ~3-4GB. ubu-1 의 free space 사전 확인 권장 (`df -h ~`).

## dispatch 명령어 — `pool on ubu-1` 형태 (base64 ship-to-scratch pattern)

cycle-22 의 `dispatch_plan()` 본문에 박힌 TODO 줄을 다음으로 치환:

```hexa
// fn dispatch_plan() 안의 TODO 블록 → 다음으로 갈음 (각 family 1 row 씩 5회 fire):
//
//   # SAELens v6.44.0 @ 3b3f4cacf992645f1f7c08525ed6c122a9cd30a1 (PyPI sae-lens==6.44.0)
//   # ubu-1 venv: ~/sandbox_probe/venv_sae (SAELens 전용, transformers 4.51.3 호환)
//   # acts cache: ~/sandbox_probe/l19_acts_cache.pt (cycle-20 의 59795×1536 fp32)
//   #
//   # 5 fire rows (per cycle-22 families() manifest):
//   #   (1) topk K=8
//   #   (2) topk K=16
//   #   (3) topk K=32
//   #   (4) jumprelu  theta = auto-tune to mean_L0 ≈ 16
//   #   (5) batchtopk batchK = auto-tune to mean_L0 ≈ 16
//
//   # 각 row 는 다음 패턴으로 dispatch (per feedback_pod_quoting,
//   # inline ssh 인용 지옥 대신 script 를 scp 로 ship 후 실행):
//   #
//   #   1) host 에서 scratch script 작성 (이 inbox-note 의 §부록 A 참고)
//   #   2) scp $SCRIPT ubu-1:/tmp/p2_sae_train_<family>.py
//   #   3) pool on ubu-1 'cd ~/sandbox_probe && \
//   #        venv_sae/bin/python /tmp/p2_sae_train_<family>.py \
//   #          --acts l19_acts_cache.pt \
//   #          --width 6144 --epochs 40 --lr 4e-4 --batch 4096 \
//   #          --family <topk|jumprelu|batchtopk> \
//   #          --k <8|16|32> \  # topk only
//   #          --theta-target-L0 16 \  # jumprelu only
//   #          --batchK-target-L0 16 \  # batchtopk only
//   #          --r-vector-source pr60_matched_pool \
//   #          --emit-tsv-row /tmp/p2_row_<family>_<setting>.tsv'
//   #   4) pool on ubu-1 'cat /tmp/p2_row_<family>_<setting>.tsv' >> .verdicts/sandbox/p2_topk_sae_lever.tsv
//   #
//   # (cycle-22 의 baseline_relu_l1_row() 가 TSV 의 첫 row, 그 아래 5개 fire row 가 concat)
```

**핵심:** `pool on ubu-1 '<long python invocation>'` 의 single-quote inline
지옥을 피하기 위해 **scratch python script 를 mini→ubu-1 으로 scp 후 실행**
하는 패턴 (`feedback_pod_quoting` 의 "rm-disaster rule" 준수). script 자체는
`.hexa` repo 에 commit 되지 않음 (per `feedback_hexa_only_authoring`) — `/tmp/`
scratch 에서만 살고 cycle-25 round 종료 시 cleanup. inline base64 ship 대안은
script 가 짧을 경우 (<2KB) `base64 -w0 | ssh ubu-1 'base64 -d > /tmp/x.py'`.

## 5-step cycle-25 P2 FIRE runbook

1. **venv smoke** — `pool on ubu-1 'cd ~/sandbox_probe && python3.11 -m venv venv_sae && source venv_sae/bin/activate && pip install "sae-lens==6.44.0" "numpy<2" && python -c "import sae_lens; print(sae_lens.__version__)"'` — `6.44.0` 출력 확인 (PyPI 가용성 + ubu-1 디스크 free 확인). 실패 시 stop · venv 신설 issue 를 inbox 에 등록.
2. **acts cache resolve** — cycle-20 의 `~/sandbox_probe/l19_acts_cache.pt` 가 stale 인지 확인 (`pool on ubu-1 'ls -la ~/sandbox_probe/l19_acts_cache.pt'` 의 mtime). stale 이면 cycle-20 의 STEP 1 path (`bench/sandbox_m5_safety_sae_decomposition.hexa` 의 capture 단계, 1550 NEUTRAL prompts × L19 token-acts) 를 재실행. 정상이면 skip — `torch.load()` 로 `(59795, 1536)` fp32 tensor 인지 smoke.
3. **SAE training launch (5 row × dispatch)** — `families()` manifest 의 5개 (Top-K K=8/16/32 + JumpReLU + BatchTopK) row 를 각각 §dispatch 패턴으로 fire. JumpReLU + BatchTopK 의 sparsity hyper 는 mean_L0 ≈ 16 (cycle-20 baseline 3.6 ~ Top-K K=32 envelope 의 중간) 으로 binary-search auto-tune. 각 row 의 `r̂` 는 PR #60 의 20+20 matched pool 로 in-process 재계산 (acts cache 와 별개 — `cx_hf_safety_private`, adv 문자열은 wire 통과 X).
4. **TSV harvest** — 각 fire 의 `/tmp/p2_row_*.tsv` 를 `pool on ubu-1 'cat <path>'` 로 stdout 회수 후, cycle-22 의 `tsv_header()` + `baseline_relu_l1_row()` 다음에 concat 해서 `.verdicts/sandbox/p2_topk_sae_lever.tsv` 로 commit. **NUMBERS ONLY** — adv text / generation / per-prompt label 절대 TSV 진입 금지 (`cx_hf_safety_private`).
5. **bench TSV emit + fold** — `bench/sandbox_p2_topk_sae_lever.hexa` 의 `main()` 을 fire-mode 로 수정 (현재는 SKELETON · 콘솔 print only). harness 가 §dispatch 의 5 row 결과를 읽어 `tsv_path()` 에 write. verifier (`verify/numerics_safety_sae_alignment.hexa` — cycle-25 가 cycle-20 의 동명 verifier 를 재사용 또는 변형) 가 lever-attribution 판정: max|cos| 가 어느 family 에서 ≥0.25 로 점프하면 cycle-20 negative → 🟡 reopen candidate (cx_paper_significance — STRONGER POSITIVE), 모두 ≤0.10 이면 cycle-20 negative HARDEN (corpus-scale lever 로 escalate → `d_p2_corpus_dictionary_scaleup` seed 활성화).

## 부록 A — scratch script 의 최소 시그니처 (cycle-25 가 작성, 이 runbook 의 참고)

```python
# /tmp/p2_sae_train_<family>.py — cycle-25 fire 가 작성 · ship · 실행
# (이 inbox-note 는 .md 만 commit, 이 python script 자체는 repo 에 안 들어감)
#
# 입력: --acts <pt path> --family <topk|jumprelu|batchtopk> + family hyper
# 출력: --emit-tsv-row <out tsv> 에 cycle-22 의 TSV row schema 1줄 (\t-separated)
#
# 의존: sae-lens==6.44.0 (이미 venv_sae 에 설치), torch, numpy<2
#
# 책임:
#   (a) acts cache 로딩 → (X, d_model) fp32 tensor
#   (b) PR #60 의 20+20 matched pool 을 in-process 로 다시 fetch → r̂ 재계산
#       (model: Qwen2.5-1.5B-Instruct fp32; L19; 동일 marker-scan 24 phrase)
#       NOTE: model 로딩은 SAELens 가 아니라 HF transformers 직접 사용 (별도 import)
#   (c) SAELens 의 family-별 trainer 호출:
#       - topk: TopKSAE(d_in=1536, d_sae=6144, k=<K>).fit(X, lr=4e-4, epochs=40, batch=4096)
#       - jumprelu: JumpReLUSAE(...) + threshold auto-tune loop until mean_L0 ≈ 16
#       - batchtopk: BatchTopKSAE(...) + batchK auto-tune loop until mean_L0 ≈ 16
#   (d) 학습 끝나면 decoder W_dec (shape (d_sae, d_in)) 의 각 행과 r̂ 의 cos 계산
#   (e) TSV row 출력 (cycle-22 의 tsv_header 컬럼 순서 일치):
#       family\tsparsity_setting\tmean_L0\talive_features\tdead_features\tfvu\t
#       max_abs_cos\ttop1_energy\ttop5_energy\ttop10_energy\t
#       ablate_top10_ref\tablate_random10\tablate_full_r\tbaseline_ref
#   (f) ablation refusal (top-10 / random-10 / full-r / baseline) 은
#       cycle-20 의 ablation 코드와 동일 패턴 (h ← h − (h·r̂)r̂) — PR #60 reproducer
```

이 script 의 본체는 cycle-25 가 작성. 이 runbook 은 **scaffold 의 signature 만**
박는다 (어떤 인자, 어떤 출력 schema, 어떤 책임 분할).

## 비용 추정

- venv 신설 + SAELens install ≈ **5분, $0** (ubu-1 sudo 불필요)
- acts cache 재사용 (cycle-20 산출물 그대로) ≈ **0분, $0**
- SAE 학습 5 row × 40 epochs × ~60k token-acts × 6144-wide ≈ row 당 5-15분 on RTX 5070 → **합계 ~1시간, $0** (cycle-20 ReLU-L1 학습이 동일 host 에서 ~10분이었음)
- 총합: **약 1시간, $0** (ubu-1 local)

cycle-20 의 ReLU-L1 baseline 과 동등 compute 의 lever-swap. 이 cheap probe 가
끝나야 더 비싼 `d_p2_corpus_dictionary_scaleup` (5M token-acts × A100 80GB
$0.5-$2) 의 SAE family 선택 정보가 생긴다 — 그래서 cycle-22 design 이 이걸
선행으로 박은 것.

## 다음 cycle 진입 조건

1. (이 runbook commit) cycle-25 의 reader 가 zero infra decision 으로 §5-step runbook 을 그대로 실행 가능
2. 첫 step 의 venv smoke 가 PASS — SAELens v6.44.0 의 3 family class import 성공
3. cycle-22 harness `bench/sandbox_p2_topk_sae_lever.hexa` 의 `dispatch_plan()` 의 `TBD_PIN_SAE_LIB` 문자열을 `sae_lens==6.44.0 @ 3b3f4cacf992645f1f7c08525ed6c122a9cd30a1` 으로 치환 (cycle-25 의 첫 hexa-edit)
4. §dispatch 패턴을 실제 fire 로 wire — 5 row TSV concat → `.verdicts/sandbox/p2_topk_sae_lever.tsv` 첫 emit

## Honest residual — 이 runbook 이 cycle-25 에 남긴 것

- **SAELens 의 정확한 학습 API signature (class name · `.fit()` vs `.train()` · constructor args)** 는 PyPI 패키지가 ubu-1 에 실제로 설치되고 import 되는 시점에 확인 — `contents/` API 로 파일명만 봤지 source 본문을 line-by-line 으로 검수하지 않았음. cycle-25 의 step 1 smoke 가 이를 결정.
- **JumpReLU + BatchTopK 의 auto-tune loop (mean_L0 ≈ 16 으로 sparsity 맞추기)** 가 SAELens 안에 builtin 으로 있는지, 아니면 outer binary-search wrapper 가 필요한지 — 미지수. 후자라면 §부록 A 의 scratch script 가 ~30 lines 추가됨 (사소).
- **transformer-lens 의 Qwen2.5 model loading path** 가 cycle-22 가 가정한 HF transformers 직접 로딩 (Qwen2.5-1.5B-Instruct fp32 + L19 hook) 과 호환되는지 — SAELens 는 transformer-lens 를 강제 의존하지만, 외부 acts 로 학습할 때는 transformer-lens 의 model loading 자체는 안 거치므로 무해할 가능성 큼. cycle-25 가 step 1 smoke 에서 `from transformer_lens import HookedTransformer` 가 cycle-20 의 HF transformers 와 import-conflict 안 내는지 같이 확인.
- **EleutherAI/sparsify 의 v1.3.0 commit `b2dee7c6...4f68` 은 fallback** — 만약 cycle-25 의 SAELens smoke 가 어떤 이유로 실패하면, eai-sparsify 로 Top-K + JumpReLU 의 4 row (K=8/16/32 + jumprelu) 까지는 동등하게 fire 가능. BatchTopK row 1개는 별도 library (BatchTopK 의 reference 가 `aypanthropic/batchtopk` GitHub 에 있지만 PyPI 미배포 — git+ install 필요) 또는 SAELens 의 부분 사용으로 갈음. 이 분기는 발생 시점에 결정.
- **openai/sparse_autoencoder 는 cycle-25 의 적극 선택지가 아니다** — torch 2.1.0 하드 핀 + Top-K 단일 family + 1.5년간 stagnant. 만약 cycle-25 가 "오로지 Top-K K=8/16/32 3 row 만 가장 reference 충실하게" 라는 요구로 좁아진다면 SHA `4965b941...193942` 로 별도 venv 신설은 가능 (PyPI 미배포 → `pip install git+https://github.com/openai/sparse_autoencoder@4965b941e9eb590b00b253a2c406db1e1b193942`).

## 관련 링크

- harness skeleton: `bench/sandbox_p2_topk_sae_lever.hexa` (cycle-22, 293 lines, parse PASS, PR #68)
- discovery seed: `.discoveries/sandbox-p2-prod-sae.tape :: d_p2_top_k_sae_family`
- 인접 infra seed: `.discoveries/sandbox-p2-prod-sae.tape :: d_p2_runpod_compute_tier_runbook` (더 큰 scaleup `d_p2_corpus_dictionary_scaleup` 의 별도 runbook, 이 runbook 의 자매)
- cycle-20 baseline (대조 surface): `.verdicts/sandbox/m5_safety_sae_decomposition.txt` (ReLU-L1 frozen baseline row)
- runbook 패턴 모범: `inbox/notes/p3-ubu1-llama-cpp-install.md` (cycle-23 의 ubu-1 install runbook — 본 runbook 의 헤더/구조 미러)
- venv pin 제약 SoT: `[[reference_activation_capture_env]]` (transformers 4.51.3 + numpy<2 clean venv)
- inline-ssh 회피 패턴: `[[feedback_pod_quoting]]` (ship-script-via-scp, never inline-quote-hell)
- hexa-only 작성 제약: `[[feedback_hexa_only_authoring]]` (이 inbox-note 는 .md 라 OK; scratch python 은 /tmp scratch 만, repo commit 안 함)
