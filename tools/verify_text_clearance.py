"""Check batch PDF text against straight stroked paths and other text spans.

Run verify_batch.py first. Curved paths and filled shapes still need visual review.
Usage: python tools/verify_text_clearance.py figures/batch348
"""
import argparse
import hashlib
import json
from pathlib import Path

import pymupdf


ROOT = Path(__file__).resolve().parents[1]


def intersects(rect, a, b):
    """Clip a finite segment against an inset text rectangle."""
    low, high = 0.0, 1.0
    for start, delta, lower, upper in (
        (a.x, b.x - a.x, rect.x0, rect.x1),
        (a.y, b.y - a.y, rect.y0, rect.y1),
    ):
        if abs(delta) < 1e-9:
            if not lower < start < upper:
                return False
        else:
            first, last = sorted(((lower - start) / delta, (upper - start) / delta))
            low, high = max(low, first), min(high, last)
            if low >= high:
                return False
    return True


def verify(batch):
    spec = json.loads((batch / "audit-spec.json").read_text(encoding="utf-8"))
    validation = json.loads((batch / "validation.json").read_text(encoding="utf-8"))
    recorded = {row["typ"]: row for row in validation["figures"]}
    rows = []
    for figure in spec["figures"]:
        typ = batch / figure["typ"]
        digest = hashlib.sha256(typ.read_bytes()).hexdigest()
        prior = recorded[figure["typ"]]
        if digest != prior["typ_sha256"] or not all(prior["checks"].values()):
            raise ValueError(f"Run verify_batch.py on current source first: {typ}")
        collisions, overlaps = [], []
        with pymupdf.open(ROOT / "_build" / batch.name / (typ.stem + ".pdf")) as doc:
            for page in doc:
                spans = [s for block in page.get_text("dict")["blocks"]
                         for line in block.get("lines", []) for s in line["spans"] if s["text"].strip()]
                segments = []
                for drawing in page.get_drawings():
                    if drawing["fill"] is not None:
                        continue
                    for item in drawing["items"]:
                        if item[0] == "l":
                            segments.append((item[1], item[2]))
                        elif item[0] == "re":
                            r = item[1]
                            segments.extend(((r.tl, r.tr), (r.tr, r.br), (r.br, r.bl), (r.bl, r.tl)))
                for i, span in enumerate(spans):
                    r = pymupdf.Rect(span["bbox"]) + (1, 1, -1, -1)
                    if r.is_empty:
                        continue
                    for a, b in segments:
                        if intersects(r, a, b):
                            collisions.append({"text": span["text"], "line": [list(a), list(b)]})
                    for other in spans[i + 1:]:
                        overlap = r & pymupdf.Rect(other["bbox"])
                        if overlap.width > 0.5 and overlap.height > 0.5:
                            overlaps.append([span["text"], other["text"]])
        rows.append({"typ": figure["typ"], "typ_sha256": digest,
                     "text_line_intersections": collisions, "text_span_overlaps": overlaps,
                     "passed": not collisions and not overlaps})
    result = {"figures": rows, "passed": all(r["passed"] for r in rows),
              "limitation": "1pt inset text bounds; straight unfilled paths only; visual review required."}
    (batch / "text-clearance-validation.json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("batch", type=Path)
    result = verify(parser.parse_args().batch.resolve())
    print(json.dumps(result, indent=2))
    raise SystemExit(0 if result["passed"] else 1)
