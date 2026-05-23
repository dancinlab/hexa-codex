# STATUS — economics-n6-ladder

> **DRAFT — gate BLOCKED.** This paper directory holds source only; the
> PDF will not be built until `cx_paper_gate` (100% formal-blue) opens.

## 현재 게이트

| 항목 | 값 |
|:--|:--|
| 게이트 | **BLOCKED** (`cx_paper_gate`) |
| 임계값 | 100% 🔵 SUPPORTED-FORMAL |
| 현재 | 4 🔵 + 4 🟠 DEFERRED → blue_pct = 50% |
| 차단 사유 | 4개 T4 empirical claim 미실행 |

## 차단된 T4 empirical claim

| id | 내용 | 필요 자원 |
|:--|:--|:--|
| `ec_t4_quality` | quality_scale 손실곡선 vs (N,D) 측정 → α=1/6 적합도 | GPU pod (lm_foundry train + hexa-eval) |
| `ec_t4_train` | train_cost FLOPs vs (N,D) 측정 → N6_EXP=24/25 적합도 | GPU pod (lm_foundry SFT sweep) |
| `ec_t4_infer` | infer_cost prefill latency vs ctx 측정 → τ=4 적합도 | GPU pod (hexa-eval 1k..128k ctx) |
| `ec_t4_serve` | serving throughput vs ctx 측정 → infer-cost-derived 예측 적합도 | GPU pod (vLLM serve bench) |

## 게이트 해제 절차

```
1. GPU pod dispatch (g8: hexa cloud · 또는 lm_foundry runner)
2. T4 sweep 4종 실행 → .verdicts/economics-n6-ladder/ec_t4_*.txt 갱신
3. 결과가 closed-form 공식과 within tolerance → tier=BLUE 승격
4. 모든 8 claim BLUE 시 cx_paper_gate ALLOWED
5. /paper compile → main.pdf 빌드
```

## 왜 DRAFT인가

이전 사이클(2026-05-23)에서 3개 ⚪ SPECULATION-FENCED claim을
explicit fence로 허용한 약한 게이트 하에 main.pdf가 빌드됨.
새 사이클은 `cx_paper_gate`를 엄격화 — ⚪ 잔여 금지, T4 empirical
포함 — 따라서 본 paper는 T4 결과 도착까지 DRAFT 상태로 동결.

소스(main.tex · references.bib · README.md)는 그대로 유지 —
T4 결과를 §verified 표에 채워 넣고 다시 빌드.
