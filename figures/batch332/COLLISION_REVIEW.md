# Batch 332 visual collision review

Date: 2026-11-17. Scope: `tt-publishing-model.typ` only (the one existing Typst figure in this batch).

Rendered the actual figure at 200 ppi and viewed its PNG. External trigger crossed the TSN dashed boundary; moved it and its formula above the frame. The module-to-receiver arrow crossed DDS Subscriber; rerouted it through the right margin and into the receiver side. An intermediate route still crossed the header and was corrected. Final PNG viewed: trigger and header labels remain clear.

PNG, SVG and PDF outputs are in `render/`. All three compiled with zero warnings.
`collision-validation.json` records single-page output, no bitmap embedding, text within
page bounds, source/render hashes and exact normalized PDF-text equality against the
repository HEAD version. All checks passed; label text and algorithm semantics were retained.

This is a visual collision review of the existing reconstruction, not a new comparison
against the original paper. Converging graph edges and intentional line/frame contacts
were not treated as text collisions. No figure or global manifest was added or changed.
