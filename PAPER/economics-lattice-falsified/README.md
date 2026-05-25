# When the Lattice Over-Predicts — n=6 스케일링 지수의 닫힌 반증 (closed-negative)

> hexa-codex ECONOMICS-group canonical paper · **CLOSED-NEGATIVE (🔴 FALSIFIED)**.
> 프로젝트 규칙이 닫힌-부정(closed-negative) 논문 게재를 허용하도록 넓혀진 뒤
> 나온 첫 반증 논문. 11페이지 · fal.ai figure 1개 (commons g51 ✓).

## 핵심 발견 (F-CODEX-1 + F-CODEX-2)

n=6 격자(number-theoretic lattice)는 LLM 비용에 대해 두 개의 스케일링 지수를
**예측**한다 — 두 지수 모두 self-hosted SANDBOX substrate에서 측정되어
**결정적으로 반증**됨.

- **F-CODEX-2 (추론 지연 지수 τ — load-bearing, 결정적):**
  격자는 `wall_ms ∝ context^τ`, τ=4 를 예측. substrate 자신의 4-rung
  context-scaling bench(Qwen2.5-1.5B-Instruct-Q4_K_M, mac-mini-m3 Metal/UMA,
  -np 1 -cb, port 8091, 20 tasks × 4 rung, $0 local) 측정:

  | context | mean_wall_ms | acc | tok/s |
  |--------:|-------------:|:---:|------:|
  | 1024 | 569 | 17/20 | 22.80 |
  | 2048 | 670 | 17/20 | 17.60 |
  | 4096 | 1005 | 17/20 | 11.98 |
  | 8192 | 1668 | 17/20 | 7.31 |

  log-log OLS slope → **측정 τ̂ = 0.524 (R²≈0.956)** — 깨끗한 멱법칙이지만
  **sub-linear**. 잔차 `|τ̂ − τ| = 3.476 ≫ ε=0.10` → 🔴 FALSIFIED.
  τ=4 는 8k 지연을 **~1400× 과대예측**. 정확도는 모든 rung에서 17/20 **flat**
  (long-context 붕괴 없음 → accuracy-floor caveat 불필요).
  메커니즘: 지연이 8× context 스윕에서 ~2.9× 만 상승 — 고정 64-token decode
  (memory-bandwidth wall) + cached-prefix paged-attention prefill 지배,
  quartic 아님.

- **F-CODEX-1 (훈련 지수 σφ — supporting, disclosure-grade):**
  격자 예측 σφ≈0.96, 외부 Qwen2.5 scale ladder 측정 slope=0.172, 잔차 0.788.
  외부 entity(Qwen2.5)에 격자 숫자를 주장한 것 → substrate-internal이 아니므로
  disclosure-grade. F-CODEX-2가 load-bearing, F-CODEX-1은 보강 맥락.

- **반증 자체의 tier:** 🟢 SUPPORTED-NUMERICAL (real bench + closed-form
  recompute). 닫힌 부정(closed negative) — INSUFFICIENT/DEFERRED 아님.
  잘못된 스케일링 prior를 폐기하고, substrate의 참 지수 τ̂≈0.52를 기록으로 남김.

## Section → verdict 매트릭스 (cx_paper_sections)

| Section       | Verdict glyph        | Path |
|---------------|----------------------|------|
| §Formula      | 🔴 FALSIFIED (at ε-gate) · 🟢 SUPPORTED-NUMERICAL (recompute) | `.verdicts/sandbox/m3_econ_fcodex2_latency_fit.txt` · `.verdicts/sandbox/f_codex_1_falsified_4rung.txt` |
| §Method       | 🟢 SUPPORTED-NUMERICAL | `verify/numerics_economics_empirical_landing.hexa` (checks 9+10, 10/10 structural) |
| §Benchmark    | 🟢 SUPPORTED-NUMERICAL | `.verdicts/sandbox/stage4_context_scaling.tsv` (4-rung 실측) |
| §Refutation   | 🔴 FALSIFIED | `.verdicts/sandbox/m3_econ_fcodex2_latency_fit.txt` (τ̂=0.524 vs τ=4, residual 3.476, ~1400× over-prediction) |

> 닫힌-부정 노트: 모든 section claim이 자기 verdict 파일을 inline으로 링크.
> §Formula는 ε-gate에서 🔴 FALSIFIED이고, 반증을 만드는 recompute 자체는
> 🟢 SUPPORTED-NUMERICAL — closed negative이지 INSUFFICIENT가 아님.

## Source

- `main.tex` — single-column arxiv-style LaTeX (article 11pt A4). UTF-8 verdict
  glyph은 `newunicodechar` 매핑으로 verbatim 블록에서 그대로 식자.
- `references.bib` — 모든 entry가 arXiv id/DOI/URL, arXiv id는 live API로 확인
  (Kaplan 2001.08361 · Chinchilla 2203.15556 · Pope 2211.05102 ·
  PagedAttention 2309.06180 · Attention 1706.03762 · Qwen2.5 2412.15115).
- `figures/fig01_predicted_vs_measured.png` — fal.ai (gpt-image-2) log-log
  schematic; prompt in `figures/_prompts/predicted_vs_measured.txt`.

## Build

```bash
make            # → main.pdf (pdflatex × 3 + bibtex)
# or: /paper compile .
```

## Honest stance

- 모든 section이 자기 verdict path를 inline 링크 — 어떤 숫자도 저자 판단만으로
  서지 않음. recompute(`verify/numerics_economics_empirical_landing.hexa`)가
  source of truth이고, 그 verbatim 10/10 + 🔴 FALSIFIED stdout이 Appendix B에 재현.
- single model(1.5B) · single host · 4 rung(≤8k) · F-CODEX-1 external-data
  caveat은 §Limitations에 헤징 없이 명시.
- n=6 number theory(τ(6)=4 등)는 산술적으로 옳음 — 반증 대상은 그 숫자를
  observable latency에 묶는 **modeling claim**이지 격자 산술 자체가 아님.
