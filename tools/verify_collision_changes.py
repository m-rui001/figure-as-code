"""Check changed tracked figures against HEAD and refresh their previews.

Run: python -X utf8 tools/verify_collision_changes.py
Character counts protect labels; they do not verify topology or visual clearance.
"""
import collections
import hashlib
import json
from pathlib import Path
import subprocess

import pymupdf

ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / "_build" / "collision-validation"


def run(args):
    return subprocess.run(args, cwd=ROOT, capture_output=True, check=True)


def main():
    BUILD.mkdir(parents=True, exist_ok=True)
    paths = run(["git", "diff", "--name-only", "HEAD", "--", "figures"]).stdout.decode().splitlines()
    rows = []
    for rel in paths:
        path = ROOT / rel
        if path.suffix != ".typ" or not path.is_file():
            continue
        original = run(["git", "show", "HEAD:" + rel]).stdout
        old = BUILD / (path.parent.parent.name + "-old-" + path.name)
        old.write_bytes(original)
        counters = []
        checks = {}
        for label, source in (("old", old), ("new", path)):
            pdf = BUILD / (path.parent.parent.name + "-" + label + "-" + path.stem + ".pdf")
            result = run(["typst", "compile", "--root", str(ROOT), str(source), str(pdf)])
            with pymupdf.open(pdf) as document:
                counters.append(collections.Counter("".join(
                    "".join(page.get_text().split()) for page in document
                )))
                if label == "new":
                    checks = {
                        "single_page": len(document) == 1,
                        "no_warnings": b"warning:" not in result.stderr,
                        "text_within_page": all(
                            page.rect.contains(pymupdf.Rect(span["bbox"]))
                            for page in document for block in page.get_text("dict")["blocks"]
                            for line in block.get("lines", []) for span in line["spans"]
                        ),
                    }
        checks["character_counts_preserved"] = counters[0] == counters[1]
        render = path.parent.parent / "render" / (path.stem + ".png")
        render.parent.mkdir(exist_ok=True)
        run(["typst", "compile", str(path), str(render), "--ppi", "200"])
        rows.append({"path": rel, "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
                     "preview": render.relative_to(ROOT).as_posix(),
                     "preview_sha256": hashlib.sha256(render.read_bytes()).hexdigest(), "checks": checks})
    report = {"baseline": run(["git", "rev-parse", "HEAD"]).stdout.decode().strip(),
              "scope": "changed tracked figure sources", "figures": rows,
              "passed": bool(rows) and all(all(row["checks"].values()) for row in rows)}
    (ROOT / "COLLISION_CHANGES_VALIDATION.json").write_text(
        json.dumps(report, indent=2) + "\n", encoding="utf-8",
    )
    print(json.dumps({"figures": len(rows), "passed": report["passed"],
                      "failed": [row for row in rows if not all(row["checks"].values())]}))
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
