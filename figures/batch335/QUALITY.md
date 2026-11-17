# Batch 335 quality review

Source: Vaswani et al., *Attention Is All You Need*, Figure 2, arXiv:1706.03762.
The paper explicitly permits reproducing figures with attribution on PDF page 1.
Source crop and retrieval metadata are under `source/`.

Converted artifact: `typ/attention-mechanisms.typ`; preview:
`render/attention-mechanisms.png` (180 ppi).

## Verification (2026-11-17)

- Typst 0.15.1 / CeTZ 0.4.2: PNG and PDF compile successfully, with no warnings.
- The PDF contains one page and zero raster image objects.
- PDF text extraction checks: MatMul x2, Linear x4, SoftMax x1,
  Mask (opt.) x1, Concat x1. Source lines are at most 82 characters.
- Both source crop and final render were visually inspected side by side.
  Q/K inputs enter the first MatMul; V bypasses Scale/Mask/SoftMax and
  enters the upper MatMul. Right panel preserves input order V/K/Q,
  parallel projection outlines, stacked attention heads, Concat and Linear.
- The first render collapsed the two-line attention label and showed back-head
  arrows through the front panel. The final version uses an explicit text line
  break and draws head panels after input arrows. The final preview was inspected
  again: labels fit their boxes, arrows stop at boundaries, and neither panel is clipped.

## Fidelity limits

This is a structural redraw rather than a pixel match. Fonts, panel spacing,
rounded corners and stroke widths differ slightly. The original soft shadows are
omitted; the h multiplicity cue uses a straight grouping stroke instead of the
original curved brace. These differences do not change blocks or data flow.
