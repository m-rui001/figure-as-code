# Batch 336 — Transformer architecture

- Source: Vaswani et al., *Attention Is All You Need*, Figure 1, PDF page 3.
- Article: https://arxiv.org/abs/1706.03762
- Download: https://arxiv.org/pdf/1706.03762 (retrieved 2026-11-17).
- The downloaded PDF and a cropped reference are retained under `source/`.
- Original figure rights remain with the paper's authors; this is a manually reconstructed diagram.

## Verification

`typst compile` with Typst 0.15.1 / CeTZ 0.4.2 produced PNG, SVG and PDF with no warnings.
The PDF contains one page and no embedded bitmap images. Extracted labels confirm five
Add & Norm blocks, two Feed Forward blocks, three attention blocks (one masked), and two
Positional Encoding labels. Machine results and source SHA-256 are in `verification.json`.

The source crop and the 180-ppi render were visually compared. Both stack outlines, their
N-times labels, five residual bypasses, three input branches to each self-attention module,
the encoder-to-decoder keys/values path, and the decoder query path are preserved.
The first render exposed overflowing text in the masked attention block; increasing its height
and reducing its label size resolved the overlap. The final render has no observed label overlap,
line-through-text, clipped labels or hollow arrowheads.

The reconstruction changes spacing, font, corner curvature and the positional encoding waveform.
Its geometry is an explicit structural reconstruction, not pixel-identical tracing.
