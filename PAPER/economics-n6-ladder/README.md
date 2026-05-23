# economics-n6-ladder — n=6 lattice atlas atom recompute

> 검증 artefact — n=6 lattice 원자 4개를 `hexa verify --expr`로 재계산
> 하고 verdict를 verbatim 저장. `cx_claim_manifest → cx_claim_verify →
> cx_paper_gate` flow를 `project.tape`에 등록한 후의 첫 100% 🔵
> 통과 슬러그.

## Scope

이 artefact는 **n=6 격자의 atlas 원자 산술**만 검증함.
ECONOMICS 그룹의 verb (`train_cost · infer_cost · quality_scale`)가
이 원자들을 어떻게 사용하는지에 대한 **모델링 주장** (예 — α=1/6이
quality_scale의 진짜 지수다)은 **scope 밖** — 별도 slug에서 T4
empirical contact로 다룸.

## Source

| 파일 | 역할 |
|:--|:--|
| `main.tex` | arxiv-style LaTeX (article 11pt A4) |
| `references.bib` | Hoffmann 2022 · Kaplan 2020 · hexa-codex |
| `Makefile` | `make` = pdflatex × 3 + bibtex |

## Verdict surfaces (root of repo)

| 파일 | 역할 |
|:--|:--|
| `CLAIMS.tape` | 4 claim 인덱스 (atom × 4) |
| `.verdicts/economics-n6-ladder.tape` | tier 매트릭스 — 100% 🔵 |
| `.verdicts/economics-n6-ladder/<id>.txt` | `hexa verify --expr` raw stdout |

## Tier 분포 — 100% 🔵

| Tier | Count | 출처 |
|:--|--:|:--|
| 🔵 SUPPORTED-FORMAL | 4 | `hexa verify --expr` — σ(6) · φ(6) · τ(6) · σ₂(6) |
| 🟢/🟡/🟠/🔴/⚪ | 0 | — |
| **Gate (cx_paper_gate)** | **ALLOWED** | 4/4 🔵, 잔여 0 |

## Build

```bash
PAPER_ROOT=~/.claude/plugins/cache/sidecar/paper/0.4.1
hexa run "$PAPER_ROOT/bin/_paper.hexa" --root "$PAPER_ROOT" \
  compile PAPER/economics-n6-ladder
```

또는 `make` 단독 (sidecar canonical 경로 권장 — g23):

```bash
PATH="/Library/TeX/texbin:$PATH" make            # → main.pdf
```

## Reproducibility

`CLAIMS.tape`의 각 `cmd` 필드를 다시 실행하면 `.verdicts/economics-n6-ladder/<id>.txt`가 bit-for-bit 재생산. 변경 시 cmd 재실행 → raw stdout 갱신 → tier 확인 → 게이트 100% 🔵 유지 시에만 `main.tex` 갱신.
