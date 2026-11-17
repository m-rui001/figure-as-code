# Batch 328 visual collision review

Date: 2026-11-17. Scope: `tsn-testbed-topology.typ` only (the one existing Typst figure in this batch).

Rendered the actual figure at 200 ppi and viewed its PNG. All four TSN Switch labels were centered on vertical green camera cables; Diagnostic Device also crossed its slanted cable. Moved switch labels right of their cables and Diagnostic Device above its icon. The first revision put SW4 near ZCU-LR, so moved SW4 lower. Viewed final PNG: all switch/device labels have visible clearance.

PNG, SVG and PDF outputs are in `render/`. All three compiled with zero warnings.
`collision-validation.json` records single-page output, no bitmap embedding, text within
page bounds, source/render hashes and exact normalized PDF-text equality against the
repository HEAD version. All checks passed; label text and algorithm semantics were retained.

This is a visual collision review of the existing reconstruction, not a new comparison
against the original paper. Converging graph edges and intentional line/frame contacts
were not treated as text collisions. No figure or global manifest was added or changed.
