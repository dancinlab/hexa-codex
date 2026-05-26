# P3 ubu-1 llama.cpp install — cycle-23 FIRE blocker resolution

> **상태:** OPEN · cycle-23 P3 preflight 에서 측정 confirmed (2026-05-26)
> **대상 호스트:** ubu-1 (aiden-B650M-K · Linux · RTX 5070 12GB · load 6.05)
> **막힌 FIRE:** `bench/sandbox_p3_multinode_2host.hexa` 의 ubu-1 replica boot

## 측정된 실태

cycle-23 P3 preflight (cheapest first) 가 ubu-1 환경을 probe 한 결과 — 모든
설치 경로 부재:

| probe | 결과 |
|-------|------|
| `which llama-server` | ❌ MISSING |
| `which brew` | ❌ no Homebrew (linuxbrew 도 없음) |
| `apt list --installed \| grep llama` | ❌ no apt package |
| `snap list \| grep llama` | ❌ no snap |
| `$HOME/llama.cpp/build/bin/llama-server` | ❌ no source build |
| `which cmake gcc` | ✅ `/usr/local/bin/cmake` + `/usr/bin/gcc` |
| `which nvcc` | ❌ no CUDA toolkit (RTX 5070 sm_120 GPU 가속 build 불가) |
| `$HOME/Models/gguf/` | ❌ no GGUF inventory (Qwen2.5-0.5B 도 부재) |

## 가능한 install 경로 (cheapest→heaviest)

### Option A — pre-built binary (cheapest, CPU-only OK)

GitHub Releases 에 `llama-bXXXX-bin-ubuntu-x64.zip` 같은 pre-built 가 있다.
~5MB · CPU-only · 0.5B Q4_K_M throughput 충분 (M3 mini 9 qps 와 비교, x86
CPU 도 비슷). RTX 5070 활용 안 하니 GPU 가속 포기 — P3 의 Erlang-C
측정에는 OK (load·throughput 만 봄).

```bash
# ubu-1 에서:
cd $HOME && mkdir -p llama-cpp && cd llama-cpp
LATEST=$(curl -s https://api.github.com/repos/ggml-org/llama.cpp/releases/latest | jq -r '.tag_name')
curl -L "https://github.com/ggml-org/llama.cpp/releases/download/${LATEST}/llama-${LATEST}-bin-ubuntu-x64.zip" -o llama.zip
unzip llama.zip
./build/bin/llama-server --version    # smoke
# PATH 등록 (둘 중 택1):
ln -sf $HOME/llama-cpp/build/bin/llama-server $HOME/.local/bin/llama-server
# 또는 ~/.bashrc 에 export PATH=$HOME/llama-cpp/build/bin:$PATH
```

소요 ≈ 1–2분.

### Option B — source build (CPU-only, 호환성↑)

```bash
cd $HOME && git clone https://github.com/ggml-org/llama.cpp && cd llama.cpp
cmake -B build -DGGML_CUDA=OFF -DLLAMA_CURL=OFF
cmake --build build --target llama-server -j 8
```

소요 ≈ 10–15분 (load 6.05 호스트라 더 길 수도). Option A 가 실패할 때만.

### Option C — CUDA build (GPU 활용)

RTX 5070 sm_120 활용. CUDA 12.5+ 필요. ubu-1 에 nvcc 부재 → toolkit 설치
선행 (~15분 추가). P3 Erlang-C 측정에는 over-kill — Option A/B 권장.

## GGUF 전송 (install 후)

```bash
# mini 에서:
scp $HOME/Models/gguf/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf ubu-1:Models/gguf/
# 또는 ubu-1 에서 직접:
pool on ubu-1 'mkdir -p $HOME/Models/gguf && cd $HOME/Models/gguf && hf download Qwen/Qwen2.5-0.5B-Instruct-GGUF qwen2.5-0.5B-instruct-q4_k_m.gguf --local-dir .'
```

`hf` 가 ubu-1 에 있는지도 별도 확인 필요 (cycle-23 preflight 에서 안 봤음).
없으면 mini→ubu-1 `scp` 가 가장 simple.

## 추정 비용

- Option A (binary DL) + GGUF transfer ≈ **5분, $0**
- Option B (source build) + GGUF transfer ≈ **15분, $0**
- 둘 다 ubu-1 sudo 불필요 ($HOME 안에 설치)

## 다음 cycle 진입 조건

1. Option A 또는 B 실행 (사용자 결정)
2. `pool on ubu-1 'llama-server --version'` PASS 확인
3. `bench/sandbox_p3_multinode_2host.hexa` FIRE 진입 (cycle-22 commit 의
   다른 4 TODO 도 동시 wire — round-robin curl dispatcher 등)

## 관련 링크

- skeleton: `bench/sandbox_p3_multinode_2host.hexa` (cycle-22, 472 lines, parse PASS)
- discovery seed: `.discoveries/sandbox-p3-multinode.tape :: d_p3_2host_homogeneous_pilot`
- verifier: `verify/numerics_ops_mmc_knee.hexa` (c=2 invariant 확장 필요)
- 베이스라인: `.verdicts/sandbox/m3_ops_full_slo_grid_summary.txt` (cycle-16 single-host 18-cell grid)
