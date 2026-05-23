# ECONOMICS.log.md — economics verb group history

> History sibling of [`ECONOMICS.md`](ECONOMICS.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-23 — ECONOMICS Pareto envelope added

Third ECONOMICS-specific cross-cutter — closed-form (N, D) ↔
(loss, train_cost) trade-off geometry. `verify/numerics_economics_pareto.hexa`
(10 checks, all PASS):

| # | Check                                                                  |
|--:|:-----------------------------------------------------------------------|
| 1 | iso-loss contour monotone — D drops as N rises at fixed L*             |
| 2 | Lagrangian optimum — `(N/D)^α = A/B`, for n=6 collapses to N/D ≈ 0.94 |
| 3 | equal-reducible identity at optimum — `A·N^-α = B·D^-α`               |
| 4 | asymptotic E floor — `loss(N → 1e50, D → 1e50) → E_LOSS` (rel < 1e-5) |
| 5 | pole at `N → 0` — loss diverges (> 1e3 at N = 1e-6)                   |
| 6 | pole at `D → 0` — loss diverges (> 1e3 at D = 1e-6)                   |
| 7 | `∂L/∂N < 0` — loss strictly decreases in N                             |
| 8 | `∂L/∂D < 0` — loss strictly decreases in D                             |
| 9 | iso-cost hyperbola — fixed `train_cost` ratio ⇒ fixed `N·D`           |
|10 | n6-vs-Chinchilla allocation gap — `|D/N_n6 − D/N_chin| ≈ 18.9 > 15`   |

Check 10 is the headline n=6 prediction: with α = β = 1/6 the
optimal allocation is nearly symmetric (D/N ≈ 1.07), in contrast
to Chinchilla's published optimum D/N ≈ 20. The two scaling-law
fits live in different corners of the (N, D) plane.

Wired into `verify/run_all.hexa` (41 → 42 subjects),
`verify/lint_numerics.hexa` (green core 19 → 20),
`tests/test_all.hexa` (32 → 33 cases), and the X-ECON row of
`verify/report_economics_ladder.hexa` (2/2 → 3/3).

## 2026-05-23 — ECONOMICS group ladder report added

A sister of `verify/falsifier_check.hexa` (which only covers the four
F-CODEX falsifiers), now ECONOMICS-focused — surfaces the recipe §3
ladder across all three ECONOMICS verbs including non-falsifier
`quality_scale`. `verify/report_economics_ladder.hexa` (10 checks,
all PASS) verifies and emits the per-verb closure table:

| verb            | T1  | T2  | T2-solver | T3  | T4-stub | closure |
|:----------------|:---:|:---:|:---------:|:---:|:-------:|:-------:|
| train_cost      | ✓   | ✓   | ✓         | ✓   | ✓       | 100%    |
| infer_cost      | ✓   | ✓   | ✓         | ✓   | ✓       | 100%    |
| quality_scale   | ✓   | ✓   | ✓         | ✓   | ✓       | 100%    |

The 10 checks gate on: per-verb T1+T2+T3 closure (3 checks), X-ECON
cross-cutter row 2/2, T4-stub row 3/3, all-verbs-100% simultaneously,
inventory ≥ 17 files, group SSOT (ECONOMICS.md + log) present, verb
spec dirs present, and the rendered ladder table (always-pass render
check). Wired into `verify/run_all.hexa` (40 → 41 subjects) and
`tests/test_all.hexa` (31 → 32 cases). Not wired into lint_numerics
(it is a meta report, not a `numerics_*` script).

## 2026-05-23 — ECONOMICS scaling-laws sweep added

A companion of the 3-pillar cross-cutter, restricted to closed-form
ratio identities — `verify/numerics_economics_scaling_laws.hexa`
(10 checks, all PASS). Sweeps the full scaling-law surface of the
three ECONOMICS verbs and the cost-vs-quality competition ratio
emerging from their distinct n=6 exponents:

| # | Check                                                                |
|--:|:---------------------------------------------------------------------|
| 1 | q-side N halving — `red_term(A,2N,α)/red_term(A,N,α) = 2^-α`         |
| 2 | q-side D halving — `red_term(B,2D,α)/red_term(B,D,α) = 2^-α`         |
| 3 | q-side N 4× — `red_term(A,4N,α)/red_term(A,N,α) = 4^-α`              |
| 4 | q-side D 4× — `red_term(B,4D,α)/red_term(B,D,α) = 4^-α`              |
| 5 | train N doubling — `train(2N,D)/train(N,D) = 2^N6_EXP`                |
| 6 | train D doubling — `train(N,2D)/train(N,D) = 2^N6_EXP`                |
| 7 | train ND 4× — `train(2N,2D)/train(N,D) = 4^N6_EXP`                   |
| 8 | infer ctx doubling — `infer(2c)/infer(c) = 2^τ = 16`                 |
| 9 | infer ctx 4× — `infer(4c)/infer(c) = 4^τ = 256`                      |
|10 | cost/quality ratio — `N6_EXP / α = (24/25)/(1/6) = 144/25 = 5.76`    |

The check 10 ratio is the ECONOMICS surface's "diminishing returns"
signature: per log doubling the training cost rises ~5.76× as fast
as the quality reducible-loss term shrinks.

Wired into `verify/run_all.hexa` (39 → 40 subjects),
`verify/lint_numerics.hexa` (green core 18 → 19), and
`tests/test_all.hexa` (30 → 31 cases).

## 2026-05-23 — ECONOMICS 3-pillar cross-cutter added

A new `verify/numerics_economics_cross_pillar.hexa` (10 checks, all
PASS) ties the three ECONOMICS verbs to one n=6 lattice — sister of
the general `verify/numerics_cross_pillar.hexa` (which only covers the
four F-CODEX falsifiers). The 10 checks:

| # | Check                                                                  |
|--:|:-----------------------------------------------------------------------|
| 1 | lattice closure σ·φ = n·τ = J₂ = 24 (shared by all 3 verbs)            |
| 2 | train_cost exponent recovery — `N6_EXP·(J₂+1) = J₂` (24/25 · 25 = 24) |
| 3 | infer_cost exponent recovery — `τ·n = J₂` (4 · 6 = 24)                |
| 4 | quality_scale exponent recovery — `α·σ = φ = 2` AND `α = β`            |
| 5 | exponent triad ordering — 0 < α (1/6) < N6_EXP (24/25) < 1 < τ (4)     |
| 6 | 3-pillar composite at Chinchilla 70B / 1.4T / 8k — all 3 finite > 0    |
| 7 | quality⟂infer orthogonality — quality free of ctx, infer free of (N,D) |
| 8 | quality halving rule — `red_term(A,2N,α) / red_term(A,N,α) = 2^-α`    |
| 9 | train doubling rule — `train_cost(N,2D) / train_cost(N,D) = 2^N6_EXP` |
|10 | n6-vs-measured triple gap — quality·train·infer all distinct from emp. |

Wired into `verify/run_all.hexa` (38 → 39 subject scripts),
`verify/lint_numerics.hexa` (green core 17 → 18), and
`tests/test_all.hexa` (29 → 30 cases).

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
