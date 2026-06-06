# FRONTEND/sample — offline mirrors of source originals (각각 서브폴더 · 오프라인 미러)

Each source project page is stored as a **self-contained offline mirror in its own subfolder**:
the page HTML (verbatim) plus **all internal images** downloaded alongside it, so every `<img>`
resolves from local disk with no network. This folder seeds the [`../FRONTEND.md`](../FRONTEND.md)
domain (read-only provenance archive).

```
FRONTEND/sample/
├─ SkillOpt/
│  ├─ index.html                 (verbatim · img src="skillopt-assets/…" → local)
│  └─ skillopt-assets/           6 files (5 png + 1 svg)
└─ SkillLens/
   ├─ index.html                 (verbatim · img src="static/images/…" → local)
   └─ static/images/             10 png
```

| subfolder | title | source URL | paper | code | org |
|---|---|---|---|---|---|
| `SkillOpt/` | SkillOpt — Executive Strategy for Self-Evolving Agent Skills | https://microsoft.github.io/SkillOpt/ | arXiv:2605.23904 | github.com/microsoft/SkillOpt | Microsoft Research |
| `SkillLens/` | SkillLens — A Systematic Study of Model-Generated Agent Skills | https://microsoft.github.io/SkillLens/ | arXiv:2605.23899 | github.com/microsoft/SkillLens | Fudan · Microsoft Research · SJTU |

- **Fetched:** 2026-06-07 · all assets HTTP 200, validated as real PNG/SVG (`file` check, not 404 HTML).
- **Internal images saved:** SkillOpt 6 (`teaser-1`, `pipeline-1`, `epoch-trends-1`, `openai`, `qwen-color`, `arxiv-logomark-small.svg`) · SkillLens 10 (`overview`, `consumption_transfer`, `experience_ratio`, `pairwise_accuracy`, `meta_skill_slope`, `fudan`, `microsoft`, `openai`, `gemini-color`, `qwen-color`).
- **Image URLs:** the originals already use **relative** paths (`skillopt-assets/…`, `static/images/…`); preserving the directory layout makes every image resolve locally — verified 0 absolute image URLs leak to network. No HTML rewrite was needed, so the page bodies stay byte-faithful to the originals.

## Not localized (intentional — external, not internal images)

- **Google Fonts CDN** (`fonts.googleapis.com`) — cosmetic webfonts; degrade gracefully to
  system fonts offline. Layout CSS itself is **inline** in each `index.html` (no external `.css`).
- **YouTube embed** (`youtube.com/embed/…`, SkillOpt only) — streamed video, cannot be a static file.
- **Navigation links** — arXiv / GitHub / the sibling project page stay as live URLs.

## Why these two are the seed (one-line each)

- **SkillOpt** — text-space optimizer that trains reusable natural-language *skill documents*
  for a frozen agent via rollout → reflect → edit (bounded "learning rate") → held-out gate.
- **SkillLens** — systematic study of the experience → skill-extraction → skill-consumption
  lifecycle; skills help ~75% / hurt ~25% (negative transfer), and extraction is a distinct
  capability from execution.

> ⚠ Topic note: both papers are about **self-evolving agent skills in general**, not frontend
> design specifically. They are kept here as the **methodology seed** for [`../FRONTEND.md`](../FRONTEND.md)
> axis N (self-evolving skill utility) — not as frontend-design benchmarks themselves.
