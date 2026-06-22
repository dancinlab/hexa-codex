#!/usr/bin/env python3
"""n2 SUBSTRATE counting eval — synthetic dot-image generator.

Seed-pinned colored dots on a white canvas via PIL. Three ranges:
  SUBITIZING  N in {1,2,3,4}   (human-flat regime)
  COUNTING    N in {5,6,7,8,9} (the dip regime observed in-hand)
  DENSE       N in {10,12,15}  (universal-collapse control)

>=3 seed-pinned layouts per N (LAYOUTS_PER_N), non-overlapping random placement
with a fixed RNG seed derived from (N, layout_idx) so every run is byte-identical.

Output: ~/n2_counting/imgs/count_<N>_s<idx>.png  +  manifest.tsv (img, n_expected, layout_idx)
"""
import os, math, random, csv
from PIL import Image, ImageDraw

OUT = os.path.expanduser("~/n2_counting")
IMGDIR = os.path.join(OUT, "imgs")
os.makedirs(IMGDIR, exist_ok=True)

CANVAS = 448            # square white canvas
RADIUS = 16            # dot radius (px)
MARGIN = 24            # keep dots away from edges
MIN_GAP = 8           # min gap between dot edges (so they never touch/merge)
LAYOUTS_PER_N = 4      # >=3 seed-pinned layouts per N
DOT_COLOR = (20, 20, 200)   # solid blue dots, high contrast on white

COUNTS = [1, 2, 3, 4,  5, 6, 7, 8, 9,  10, 12, 15]

def place(n, seed):
    """Return n non-overlapping (cx,cy) centers using a fixed seed; rejection sample."""
    rng = random.Random(seed)
    pts = []
    tries = 0
    need = (2 * RADIUS + MIN_GAP)
    while len(pts) < n and tries < 200000:
        tries += 1
        cx = rng.randint(MARGIN + RADIUS, CANVAS - MARGIN - RADIUS)
        cy = rng.randint(MARGIN + RADIUS, CANVAS - MARGIN - RADIUS)
        ok = True
        for (px, py) in pts:
            if math.hypot(cx - px, cy - py) < need:
                ok = False
                break
        if ok:
            pts.append((cx, cy))
    if len(pts) < n:
        raise RuntimeError(f"could not place {n} dots (seed {seed})")
    return pts

def main():
    rows = []
    for n in COUNTS:
        for li in range(LAYOUTS_PER_N):
            seed = 1000 * n + li          # deterministic per (N, layout)
            pts = place(n, seed)
            img = Image.new("RGB", (CANVAS, CANVAS), (255, 255, 255))
            d = ImageDraw.Draw(img)
            for (cx, cy) in pts:
                d.ellipse([cx - RADIUS, cy - RADIUS, cx + RADIUS, cy + RADIUS],
                          fill=DOT_COLOR)
            name = f"count_{n}_s{li}"
            img.save(os.path.join(IMGDIR, name + ".png"))
            rng = "subitizing" if n <= 4 else ("counting" if n <= 9 else "dense")
            rows.append((name, n, li, rng))
    with open(os.path.join(OUT, "manifest.tsv"), "w", newline="") as f:
        w = csv.writer(f, delimiter="\t")
        w.writerow(["img", "n_expected", "layout_idx", "range"])
        w.writerows(rows)
    print(f"wrote {len(rows)} images to {IMGDIR}")
    print(f"manifest: {os.path.join(OUT, 'manifest.tsv')}")
    # range histogram
    from collections import Counter
    c = Counter(r[3] for r in rows)
    print("range counts:", dict(c))

if __name__ == "__main__":
    main()
