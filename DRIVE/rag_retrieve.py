#!/usr/bin/env python3
"""DRIVE RAG retriever — HYBRID retrieval over the fix-recipe KB.

Two-stage, precision-first (this beats embedding-only on this KB — the curated
keys are bilingual and queries quote them verbatim, so an exact substring hit is
100% correct, whereas MiniLM cosine mis-ranks short technical Korean phrases):

  STAGE 1 — keyword:  scan the instruction for any key on a recipe line; if any
            line's keys substring-match, emit those recipes (exact, high precision).
  STAGE 2 — embedding (only when STAGE 1 is empty — the paraphrase long-tail):
            embed the query + every recipe KEY via fastembed (in-process, ONNX/CPU,
            ~120MB MiniLM), cosine-rank, emit top-k above a CONSERVATIVE threshold
            (≥0.55 — high, because embedding mis-fires here and a wrong recipe
            actively misleads the small model). Recipe-key vectors are cached to
            fix_recipes.emb.json keyed by an MD5 of the KB so the cache
            auto-invalidates when recipes change (no manual rebuild).

Embedding backend (first that works wins):
  - in-process fastembed   (default — no network, no daemon, most robust)
  - HTTP server            (only if DRIVE_EMBED_URL is set — e.g. a pool host)

Usage:  rag_retrieve.py "<instruction>"   -> prints "- <recipe>" lines
Exit 0 with empty stdout when neither stage clears (caller then proceeds with no
grounding). NEVER raises to the caller — every failure degrades to "".
"""
import sys, os, json, hashlib

_HERE  = os.path.dirname(os.path.abspath(__file__))   # this script's dir = pkg root
KB     = os.path.join(_HERE, "fix_recipes.txt")       # KB ships beside this script
CACHE  = os.path.join(_HERE, "fix_recipes.emb.json")  # embedding cache (regenerable)
MODEL  = os.environ.get("DRIVE_EMBED_MODEL", "intfloat/multilingual-e5-large")
EMBURL = os.environ.get("DRIVE_EMBED_URL", "").strip()   # optional HTTP fallback
TOPK   = int(os.environ.get("DRIVE_RAG_TOPK", "3"))
THRESH = float(os.environ.get("DRIVE_RAG_THRESH", "0.80"))   # e5 sims cluster high; reject weak
# e5 REQUIRES instruction prefixes — "query: " for the query, "passage: " for docs
QPREF  = os.environ.get("DRIVE_EMBED_QPREFIX", "query: ")
DPREF  = os.environ.get("DRIVE_EMBED_DPREFIX", "passage: ")

_MODEL = None   # lazy fastembed handle (loaded once per process)


def _embed_local(texts):
    global _MODEL
    from fastembed import TextEmbedding
    if _MODEL is None:
        _MODEL = TextEmbedding(model_name=MODEL)
    return [v.tolist() for v in _MODEL.embed(list(texts))]


def _embed_http(texts):
    import urllib.request
    out = []
    for t in texts:
        body = json.dumps({"input": t, "model": "e"}).encode()
        req = urllib.request.Request(EMBURL, data=body,
                                     headers={"Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=30) as r:
            out.append(json.load(r)["data"][0]["embedding"])
    return out


def embed(texts):
    """Embed a list of strings -> list of vectors. Prefer in-process fastembed;
    fall back to an HTTP server only when DRIVE_EMBED_URL is set and local fails."""
    try:
        return _embed_local(texts)
    except Exception:
        if EMBURL:
            return _embed_http(texts)
        raise


def load_recipes():
    rows = []
    with open(KB, encoding="utf-8") as f:
        for ln in f:
            ln = ln.strip()
            if not ln or ln.startswith("#") or "::" not in ln:
                continue
            keys, recipe = ln.split("::", 1)
            rows.append((keys.strip(), recipe.strip()))
    return rows


def keyword_hits(q, rows):
    """STAGE 1 — exact substring match on a recipe line's keys (high precision)."""
    out = []
    for keys, recipe in rows:
        for key in keys.split():
            if key and key in q:
                out.append("- " + recipe)
                break
    return out


def embedding_hits(q, rows):
    """STAGE 2 — cosine top-k over recipe KEYS (paraphrase long-tail fallback)."""
    import numpy as np
    kbhash = hashlib.md5(open(KB, "rb").read()).hexdigest()
    cache = {}
    if os.path.exists(CACHE):
        try:
            cache = json.load(open(CACHE))
        except Exception:
            cache = {}
    if cache.get("hash") != kbhash or len(cache.get("vecs", [])) != len(rows) \
            or cache.get("model") != MODEL:
        vecs = embed([DPREF + k for k, _ in rows])   # embed KEYS only (queries quote keys)
        cache = {"hash": kbhash, "model": MODEL, "vecs": vecs}
        try:
            json.dump(cache, open(CACHE, "w"))
        except Exception:
            pass
    V = np.asarray(cache["vecs"], dtype=np.float32)
    qv = np.asarray(embed([QPREF + q])[0], dtype=np.float32)
    qn = qv / (np.linalg.norm(qv) + 1e-9)
    Vn = V / (np.linalg.norm(V, axis=1, keepdims=True) + 1e-9)
    sims = Vn @ qn
    out = []
    for i in np.argsort(-sims)[:TOPK]:
        if float(sims[i]) >= THRESH:
            out.append("- " + rows[int(i)][1])
    return out


def main():
    q = sys.argv[1] if len(sys.argv) > 1 else ""
    if not q.strip() or not os.path.exists(KB):
        return
    rows = load_recipes()
    if not rows:
        return
    out = keyword_hits(q, rows)        # precision-first
    if not out:
        out = embedding_hits(q, rows)  # paraphrase fallback (may raise -> caught)
    if out:
        sys.stdout.write("\n".join(out) + "\n")


if __name__ == "__main__":
    try:
        main()
    except Exception:
        pass   # graceful: any failure -> empty output -> caller uses keyword fallback
