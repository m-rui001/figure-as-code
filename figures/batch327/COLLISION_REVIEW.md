# Batch 327 visual collision review

Date: 2026-11-17. Scope: `dds-tsn-timing.typ` only (the one existing Typst figure in this batch).

Rendered the actual figure at 200 ppi and viewed its PNG. Link labels crossed the left dashed frame and the top Link 1 label crowded panel marker (a). Expanded the outer frame leftward and upward, moved (a) above the Link label, and expanded its right side for legend clearance. Final PNG viewed: link labels, panel markers and legends are clear of the frame.

PNG, SVG and PDF outputs are in `render/`. All three compiled with zero warnings.
`collision-validation.json` records single-page output, no bitmap embedding, text within
page bounds, source/render hashes and exact normalized PDF-text equality against the
repository HEAD version. All checks passed; label text and algorithm semantics were retained.

This is a visual collision review of the existing reconstruction, not a new comparison
against the original paper. Converging graph edges and intentional line/frame contacts
were not treated as text collisions. No figure or global manifest was added or changed.
