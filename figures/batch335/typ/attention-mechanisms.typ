#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: ("Arial", "Segoe UI"), size: 9pt)

// Source: Vaswani et al., Attention Is All You Need, arXiv:1706.03762, Figure 2.
// Q and K enter the lower MatMul; V bypasses the normalization path.
// Stacked outlines preserve the parallel heads and their three input projections.
#canvas({
  import draw: *
  let ink = 0.8pt + black
  let arrow = (end: "stealth", fill: black, scale: 0.32)
  let purple = rgb("#ccc5e3")
  let green = rgb("#d7e8dd")
  let yellow = rgb("#fff6bd")
  let pink = rgb("#f3d1e1")
  let box(x, y, w, h, label, tint) = {
    rect((x - w / 2, y - h / 2), (x + w / 2, y + h / 2),
      radius: 0.06, fill: tint, stroke: ink)
    content((x, y), text(size: 8pt)[#label])
  }
  let link(a, b) = { draw.line(a, b, stroke: ink, mark: arrow) }
  content((2.0, 6.50), [Scaled Dot-Product Attention])
  box(1.70, 1.40, 1.55, 0.45, [MatMul], purple)
  box(1.70, 2.18, 1.05, 0.45, [Scale], yellow)
  box(1.70, 2.96, 1.70, 0.45, [Mask (opt.)], pink)
  box(1.70, 3.74, 1.55, 0.45, [SoftMax], green)
  box(2.35, 4.52, 1.70, 0.45, [MatMul], purple)
  link((1.70, 1.625), (1.70, 1.955))
  link((1.70, 2.405), (1.70, 2.735))
  link((1.70, 3.185), (1.70, 3.515))
  link((1.70, 3.965), (1.70, 4.295))
  link((2.35, 4.745), (2.35, 5.12))
  link((1.25, 0.67), (1.25, 1.175))
  link((2.15, 0.67), (2.15, 1.175))
  link((2.95, 0.67), (2.95, 4.295))
  content((1.25, 0.42), [Q])
  content((2.15, 0.42), [K])
  content((2.95, 0.42), [V])

  content((8.10, 6.50), [Multi-Head Attention])
  for x in (6.90, 8.10, 9.30) {
    for d in (0.28, 0.14, 0.0) {
      rect((x - 0.46 + d, 1.18 + d), (x + 0.46 + d, 1.67 + d),
        radius: 0.05, fill: green, stroke: ink)
    }
    content((x, 1.425), text(size: 8pt)[Linear])
    link((x, 0.20), (x, 1.18))
    link((x, 1.67), (x, 2.30))
    link((x + 0.14, 1.81), (x + 0.14, 2.44))
    link((x + 0.28, 1.95), (x + 0.28, 2.58))
  }
  // Back heads first, then front head, so overlapping outlines remain visible.
  for d in (0.28, 0.14, 0.0) {
    rect((6.40 + d, 2.30 + d), (9.80 + d, 3.12 + d),
      radius: 0.06, fill: purple, stroke: ink)
  }
  content((8.10, 2.71), text(size: 8pt)[Scaled Dot-Product\ Attention])
  for (x, label) in ((6.90, [V]), (8.10, [K]), (9.30, [Q])) {
    content((x, -0.05), label)
  }
  box(8.10, 4.20, 1.15, 0.48, [Concat], yellow)
  for d in (0.0, 0.14, 0.28) {
    link((8.10 + d, 3.12 + d), (8.10 + d, 3.96))
  }
  box(8.10, 5.10, 0.98, 0.48, [Linear], green)
  link((8.10, 4.44), (8.10, 4.86))
  link((8.10, 5.34), (8.10, 5.68))
  draw.line((9.68, 2.45), (10.18, 2.98), stroke: ink)
  content((10.38, 2.72), text(size: 8pt)[h])
})
