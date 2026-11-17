# Batch 325 visual collision review

Date: 2026-11-17. Scope: `dds-discovery-simulation.typ` only (the one existing Typst figure in this batch).

Rendered the actual figure at 200 ppi and viewed its PNG. Subscriber node text crowded container borders, docker text overlapped its icon, and ns-3 text touched its bar chart. Reduced node labels locally from 9pt to 8pt and moved docker and ns-3 text away from icons. Final PNG viewed: all labels have visible separation.

PNG, SVG and PDF outputs are in `render/`. All three compiled with zero warnings.
`collision-validation.json` records single-page output, no bitmap embedding, text within
page bounds, source/render hashes and exact normalized PDF-text equality against the
repository HEAD version. All checks passed; label text and algorithm semantics were retained.

This is a visual collision review of the existing reconstruction, not a new comparison
against the original paper. Converging graph edges and intentional line/frame contacts
were not treated as text collisions. No figure or global manifest was added or changed.
