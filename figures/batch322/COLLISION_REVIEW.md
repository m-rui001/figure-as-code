# Batch 322 visual collision review

Date: 2026-11-17. Scope: `tt-strategy-workflow.typ` only (the one existing Typst figure in this batch).

Rendered the actual figure at 200 ppi and viewed its PNG. The outgoing initialization arrow began at y=4.59 inside the closing-time block and crossed the t_gdb formula. Moved its start to the bottom edge y=4.40. Moved the TSQ and Blocking No labels away from return-path verticals. Re-viewed the final PNG: formula and branch labels are clear.

PNG, SVG and PDF outputs are in `render/`. All three compiled with zero warnings.
`collision-validation.json` records single-page output, no bitmap embedding, text within
page bounds, source/render hashes and exact normalized PDF-text equality against the
repository HEAD version. All checks passed; label text and algorithm semantics were retained.

This is a visual collision review of the existing reconstruction, not a new comparison
against the original paper. Converging graph edges and intentional line/frame contacts
were not treated as text collisions. No figure or global manifest was added or changed.
