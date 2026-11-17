"""Compile a batch and check its declared labels, source hashes and PDF bounds.

Usage: python tools/verify_batch.py figures/batch339
This provides reproducible structural checks, not visual-fidelity certification.
Requires PyMuPDF and Typst on PATH.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

import pymupdf


ROOT = Path(__file__).resolve().parents[1]


def normalize(text):
    return " ".join(text.split())


def verify(batch):
    spec = json.loads((batch / "audit-spec.json").read_text(encoding="utf-8"))
    output = ROOT / "_build" / batch.name
    output.mkdir(parents=True, exist_ok=True)
    rows = []
    for figure in spec["figures"]:
        source = batch / figure["source"]
        typ = batch / figure["typ"]
        pdf = output / (typ.stem + ".pdf")
        result = subprocess.run(
            ["typst", "compile", str(typ), str(pdf)], capture_output=True, text=True,
            encoding="utf-8", errors="replace",
        )
        checks = {
            "compile": result.returncode == 0,
            "no_warnings": "warning:" not in result.stderr,
            "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest() == figure["sha256"],
            "max_120_columns": max(map(len, typ.read_text(encoding="utf-8").splitlines())) <= 120,
        }
        row = {
            "typ": figure["typ"], "typ_sha256": hashlib.sha256(typ.read_bytes()).hexdigest(),
            "checks": checks, "compiler_stderr": result.stderr,
        }
        if result.returncode == 0:
            with pymupdf.open(pdf) as document:
                text = normalize(" ".join(page.get_text() for page in document))
                checks["single_page"] = len(document) == 1
                checks["no_embedded_raster"] = all(not page.get_images() for page in document)
                checks["text_within_page"] = all(
                    page.rect.contains(pymupdf.Rect(span["bbox"]))
                    for page in document for block in page.get_text("dict")["blocks"]
                    for line in block.get("lines", []) for span in line["spans"]
                )
                row["label_counts"] = {
                    label: text.count(normalize(label)) for label in figure.get("labels", {})
                }
                checks["declared_labels"] = all(
                    row["label_counts"][label] == count for label, count in figure.get("labels", {}).items()
                )
                checks["literal_code_lines"] = all(
                    normalize(line) in text for line in figure.get("code_lines", [])
                )
        rows.append(row)
    coverage = {figure["typ"] for figure in spec["figures"]} == {
        path.relative_to(batch).as_posix() for path in (batch / "typ").glob("*.typ")
    }
    report = {"batch": batch.name, "all_typ_files_covered": coverage, "figures": rows,
              "passed": bool(rows) and coverage and all(all(row["checks"].values()) for row in rows)}
    (batch / "validation.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8",
    )
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("batch", type=Path)
    args = parser.parse_args()
    report = verify(args.batch.resolve())
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
