# hexa-codex Constitution

## Core Principles

### I. Spec-First — Codex Reads, Does Not Run (NON-NEGOTIABLE)
Each of the 17 verbs ships as a single closed-form `.md` spec plus a preregistered falsifier under its group directory. Consumers READ the codex; the codex does NOT execute the verbs. Write-side sandbox wiring is per-verb future work (release ladder). Treating a verb spec as a validated capability claim is an over-claim and is rejected.

### II. 17 Verbs · 4 Groups — Group-Orthogonal (NON-NEGOTIABLE)
The substrate is split into four orthogonal concerns: SAFETY (6) · ECONOMICS (3) · OPS (4) · SUBSTRATE (4) = 17. Each group carries a different falsifier class (interp probes / cost-curve fits / SLO checks / capability evals). Adding a 5th group, collapsing a group, or expanding past 17 verbs is a MAJOR constitution change — not a documentation tweak.

### III. Falsifier Preregister — Arithmetic Floor → Empirical Floor
Every verb has a preregistered falsifier (F-CODEX-1..4 are the four currently named). Each carries two floors:
- **Arithmetic floor** — closed-form identity, checked at v1.0.0 by `verify/falsifier_check.py`. PASS is a precondition for the spec to ship.
- **Empirical floor** — lands per the release ladder (F-CODEX-3 at v1.1.0 · F-CODEX-1/2 at v1.2.0 · F-CODEX-4 at v2.0.0).

Shipping arithmetic-only as if empirical were also closed is a Principle I violation.

### IV. Release Ladder — Strict Monotone (NON-NEGOTIABLE)
Versions advance strict-monotone in (verbs-wired, eval-pipelines): v1.0.0 (0,0) RELEASED → v1.1.0 (2,1) safety → v1.2.0 (5,2) economics → v1.3.0 (9,3) ops → v2.0.0 (17,4) substrate. A version that decreases either count, or skips a rung, is rejected. `verify/release_ladder.py` (7/7 PASS) is the gate.

### V. n=6 Master Identity Anchors the Cost Surface
`σ(6) = 12` · `τ(6) = 4` · `φ(6) = 2` · `J₂(6) = 24` · `σ−φ = 10` anchor four of the catalogued cost laws — training_cost ∝ N^24, inference_cost ∝ context^4, alignment_score over 12 axes, interpret motifs = σ−φ = 10. The lattice is an organizing tool; `dancinlab/echoes` `LATTICE_POLICY.md` is the cross-project authority on what's tool vs constraint, including the "no-external-lattice-fitting" rule (raw#10 C3).

### VI. lm_foundry — Separate Concern (Trained Models + Runtime)
Where the 17 verbs are *spec library*, `lm_foundry/` is *trained models + orchestration runtime* — the code-LLM at 94.29% Mk.I strict (r39 GA, frozen) plus the v0.5.x orchestration runtime (pre-7B classifier routing · 3-vendor SDKs · persistent cache · multi-turn memory · SQLite WAL multi-process safety). Spec-side PRs and runtime PRs do not mix in the same change; the boundary is structural, not stylistic.

### VII. Provenance — Extracted from canon@c0f1f570
The 17 verb specs were extracted from `canon/domains/cognitive/` at commit `c0f1f570` on 2026-05-06. The provenance pointer is part of each spec's identity. Modifications that diverge from the canon source require either (a) a canon-side change first (then re-extract) or (b) an explicit "standalone divergence" note in the spec file with the divergence's rationale.

## Repository Layout

```
hexa-codex/
├── alignment/                    # SAFETY verbs (.md specs)
├── safety/
├── welfare/
├── adversarial/
├── consciousness/
├── interpret/
├── … (economics · ops · substrate dirs)
├── verify/                       # arithmetic-floor checkers + ladder audit
├── formal/                       # Lean4 proof (σ(6)=12 PROVEN)
├── lm_foundry/                   # domain-LLM pipeline + orchestration runtime
├── docs/                         # design + reference annexes
├── LATTICE_POLICY.md             # mirror of cross-project authority (echoes-authored)
├── LIMIT_BREAKTHROUGH.md         # per-verb real-limits audit (HARD/SOFT/BREAKABLE/UNCLEAR)
├── IMPORTED_FROM_CANON.md        # provenance ledger
├── hexa.toml                     # hx package manifest
├── install.hexa                  # hx install entry
└── .specify/                     # Spec Kit pipeline artifacts (this constitution lives here)
```

## Development Workflow

1. **Verb add / amend.** PR adds or modifies one `.md` spec under the matching group dir; arithmetic-floor falsifier check (`verify/falsifier_check.py`) MUST pass before merge. Empirical floor lands per release ladder.
2. **Group integrity.** No verb crosses groups. If a verb fits two groups, the orthogonality is broken — that's a Principle II flag.
3. **Release rung.** Each release PR updates the ladder table, advances (verbs-wired, eval-pipelines) strict-monotone, and runs `verify/release_ladder.py` (7/7 PASS) before tag.
4. **lm_foundry change.** Lives entirely under `lm_foundry/`. Spec directories MUST NOT be touched in the same PR.
5. **Canon sync.** Periodic re-extraction from canon updates `IMPORTED_FROM_CANON.md`; standalone divergences flagged in-spec.

## Governance

- This constitution governs hexa-codex repo-local concerns (spec-first discipline, 17-verb / 4-group invariants, falsifier-floor gating, release ladder, lm_foundry / spec separation).
- On lattice / n=6 / real-limits subjects, `dancinlab/echoes` `LATTICE_POLICY.md` is the authority. The local `LATTICE_POLICY.md` mirrors that source.
- Amendments land via PR that updates this file and bumps semver (MAJOR = principle removal/redefinition · MINOR = new principle / section · PATCH = wording).
- Complexity must be justified. Default = simpler. Codex framing (read-only spec library) trumps runtime convenience.

**Version**: 1.0.0 | **Ratified**: 2026-05-21 | **Last Amended**: 2026-05-21
