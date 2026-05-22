# ECONOMICS.log.md — economics verb group history

> History sibling of [`ECONOMICS.md`](ECONOMICS.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-23 — quality_scale §3 verify ladder closed

`quality_scale` gains its full recipe §3 verification ladder — the
first non-falsifier ECONOMICS verb to reach §3 closure:

- T1 — `verify/calc_quality_scale.hexa` (8 algebraic checks)
- T2 — `verify/numerics_quality_scale.hexa` + `_solver.hexa` (10 + 10)
- T3 — `verify/numerics_quality_scale_parity.hexa` (10 checks)

The ladder fits the Chinchilla loss surface `loss = E + A·N^-α + B·D^-β`
with the n=6 lattice exponent `α = β = φ(6)/σ(6) = 1/6`. T2 verifies
loss-surface shape only (monotone decreasing, floored at the
irreducible loss E) — the Chinchilla A/B coefficients pair with a
measured ≈0.34 exponent, not the n=6 1/6, so absolute loss is
intentionally not asserted. T3 ties the 1/6 exponent to the geometric
mean of the Kaplan-2020 and Hoffmann-2022 published loss-scaling
exponents. Commits `89e810d` (T1), `80136fe` (T2/T3), `46b0971`
(verify-surface restoration).

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
