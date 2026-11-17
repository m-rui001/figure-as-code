# Batch 338 — Residual network building blocks

Source: Kaiming He, Xiangyu Zhang, Shaoqing Ren and Jian Sun,
*Deep Residual Learning for Image Recognition*, arXiv:1512.03385.

- Article: https://arxiv.org/abs/1512.03385
- PDF: https://arxiv.org/pdf/1512.03385 (downloaded 2026-11-17).
- Figure 2, PDF page 2: residual learning building block.
- Figure 5, PDF page 6: ResNet-34 basic block versus ResNet-50/101/152 bottleneck.
- Original PDF and cropped source figures are retained in `source/`.
- Source SHA-256 values and machine checks are in `verification.json`.
- Original illustration rights remain with the paper's authors.

## Validation

Both self-contained CeTZ files compile to PNG, SVG and PDF with zero warnings using
Typst 0.15.1 and CeTZ 0.4.2. Each PDF is one page with no embedded raster image.
Extracted labels verify both weight layers and both ReLUs in Figure 2, and all five
ReLUs plus channel labels in Figure 5. Both sources satisfy the 120-column limit.

The full source pages were inspected before conversion. Both renders were compared
visually with those source pages. Figure 2 preserves the downward residual path,
the curved identity bypass, addition before final ReLU, and the F(x), x and F(x)+x labels.
The first render's identity label touched the bypass; moving the label outward resolved it.
The final render shows no observed text overlap, line-through-label or clipping.

Figure 5 preserves the two 3x3/64 layers on the left and the 1x1/64, 3x3/64,
1x1/256 bottleneck on the right. The bypasses preserve the original input dimensions
64-d and 256-d and both meet the addition nodes before the final ReLUs.
The rendered shortcuts, intermediate arrows and labels are visually clear.

Font, spacing and shortcut curvature differ slightly from the source. Curves are sampled
into 80 vector segments; these are structural reconstructions rather than pixel-identical traces.
