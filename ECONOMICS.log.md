# ECONOMICS.log.md — economics verb group history

> History sibling of [`ECONOMICS.md`](ECONOMICS.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-23 — domain doc opened

`ECONOMICS.md` / `ECONOMICS.log.md` created in the per-domain root-SSOT
restructure (alongside `SAFETY` / `OPS` / `SUBSTRATE`). The economics
group itself is unchanged — 3 verbs, spec-first, since v1.0.0.

## 2026-05-06 — v1.0.0 seed (Cycle 0)

3 economics verbs extracted unchanged from
`canon@c0f1f570:domains/cognitive/`: `train_cost` · `infer_cost` ·
`quality_scale`. Part of the 17-verb / 4-group seed. Commit `63e8283`.

## v1.0.0 — F-CODEX-1 / F-CODEX-2 arithmetic floors PASS

`training_cost ∝ N^24` (F-CODEX-1) and `inference_cost ∝ context^4`
(F-CODEX-2) closed-form floors verified by `verify/falsifier_check.py` —
the algebraic identity `σ·φ = n·τ = J₂ = 24` is self-proving. Empirical
curve fits PENDING — F-CODEX-1 → v1.2.0, F-CODEX-2 → v1.3.0.

---

_Next: v1.2.0 (2026-10, PLANNED) — wire the economics verbs, ship the
training/inference cost scaling fit, land F-CODEX-1 empirical. Append
round entries here as the group progresses._
