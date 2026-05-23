# economics-n6-ladder — hexa-codex ECONOMICS verification artefact

> Verification artefact for the hexa-codex ECONOMICS group's `n=6` ladder
> — 11 claims, all run through `hexa verify`, raw verdicts persisted to
> `.verdicts/economics-n6-ladder/`. Generated via the `cx_claim_manifest →
> cx_claim_verify → cx_paper_gate → cx_paper_sections` flow registered in
> `project.tape`.

## Source

- `main.tex` — single-column arxiv-style LaTeX (article class, 11pt A4)
- `references.bib` — BibTeX (Chinchilla · Kaplan · hexa-codex)
- `Makefile` — `make` builds `main.pdf` (pdflatex × 3 + bibtex)

## Verdict surfaces (root of repo)

| 파일 | 역할 |
|:--|:--|
| `CLAIMS.tape` | 11 claim 인덱스 (id · text · method) |
| `.verdicts/economics-n6-ladder.tape` | tier 매트릭스 (id · tier · raw-path) |
| `.verdicts/economics-n6-ladder/<id>.txt` | `hexa verify` raw stdout verbatim |

## Tier 분포

| Tier | Count | 출처 |
|:--|--:|:--|
| 🔵 SUPPORTED-FORMAL (atom) | 4 | `hexa verify --expr` — σ·φ·τ·σ₂(6) |
| 🟢 PASS (closed-form sentinel) | 4 | `hexa run verify/*.hexa` — cross_pillar · scaling_laws · pareto · ladder_report |
| ⚪ SPECULATION-FENCED | 3 | `hexa verify --fence` — α=1/6 · N6_EXP=24/25 · Pareto D/N≈1.07 |
| 🔴 FALSIFIED | 0 | — |
| **Gate (cx_paper_gate)** | **ALLOWED** | 0🔴 + 8 (🔵+🟢) ≥ 1 + 3⚪ explicit |

## Build

```bash
make            # → main.pdf
make clean      # remove .aux/.log/.bbl (keep PDF)
```

## Reproducibility

`CLAIMS.tape`의 `cmd` 필드를 그대로 다시 실행하면 verdict 매트릭스가
bit-for-bit 재생산됨. 변경 시: claim 수정 → cmd 재실행 → raw stdout 갱신
→ tier 확인 → 게이트 통과 시에만 `main.tex` 갱신 (cx_paper_sections 따라
tier별 섹션 분리 유지).
