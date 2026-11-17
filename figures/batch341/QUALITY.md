# Batch 341 — Global and local recurrent attention

Source: Minh-Thang Luong, Hieu Pham and Christopher D. Manning,
*Effective Approaches to Attention-based Neural Machine Translation*,
arXiv:1508.04025v5, 2015.

- Article: https://arxiv.org/abs/1508.04025
- Download: https://arxiv.org/pdf/1508.04025 (retrieved 2026-11-17).
- Figure 2, PDF page 3: global attentional model.
- Figure 3, PDF page 4: local attention model.
- The downloaded PDF, full source pages and cropped original figures are in `source/`.
- `source/provenance.json` records SHA-256 hashes of the PDF and all reference images.
- Original figure rights remain with the paper's authors.

## Checks and visual review

Both self-contained CeTZ files compile to PNG, SVG and PDF with zero warnings under
Typst 0.15.1 and CeTZ 0.4.2. Run `python tools/verify_batch.py figures/batch341` to
reproduce the structural checks. `audit-spec.json` covers both files and all visible
text labels; `validation.json` records passing source hashes, single-page output,
zero embedded raster images, text within page bounds, label counts and 120 columns.

The full source pages were viewed before conversion. Both final renders were viewed
and compared against the source. All seven recurrent state glyphs, five blue encoder
states, two red decoder states, recurrent arrows, bottom inputs and the dashed
attention-layer enclosure are preserved. The global diagram aggregates all five
encoder states into context; the local diagram aggregates only the middle three.
The local diagram also preserves its aligned-position path from the target state.
Both context and current target state feed the attentional hidden state and output.

The first render placed the alignment-weight labels on vertical paths. Their labels
were moved to the right; the final renders show no observed text-line intersections,
text overlaps or clipped labels. Crossings among the converging source-state paths
are intentional and follow the source diagrams. Arrowheads are solid.

Font, spacing and exact line angles differ from the originals. This is a structural
redrawing, not a pixel-identical trace. Machine checks do not certify visual fidelity.

Follow-up visual audit: the horizontal aligned-position connector touched the p_t label. Its endpoint was moved left from x=6.02 to x=5.80, leaving a visible gap. PNG/SVG were regenerated and the batch verifier passed. The prior visual review missed this contact.
