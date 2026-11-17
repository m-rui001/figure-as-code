# Batch 333 visual collision review

Date: 2026-11-17. Scope: `simple-vs-preloading-sequence.typ` only (the one existing Typst figure in this batch).

Rendered the actual figure at 200 ppi and viewed its PNG. The right preloaded metadata arrow crossed the Batch text inside its document glyph. Moved it below both Batch and EDP labels, retaining its endpoint near the P2 lifeline. Final PNG viewed: no document-label intersection; protocol labels remain separated from message arrows.

PNG, SVG and PDF outputs are in `render/`. All three compiled with zero warnings.
`collision-validation.json` records single-page output, no bitmap embedding, text within
page bounds, source/render hashes and exact normalized PDF-text equality against the
repository HEAD version. All checks passed; label text and algorithm semantics were retained.

This is a visual collision review of the existing reconstruction, not a new comparison
against the original paper. Converging graph edges and intentional line/frame contacts
were not treated as text collisions. No figure or global manifest was added or changed.
