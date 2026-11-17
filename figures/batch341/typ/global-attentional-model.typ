#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 8pt)

// Source: Luong et al., Effective Approaches to Attention-based NMT, Figure 2.
// Solid source-state paths aggregate the context; dashed paths compute alignment weights.
#canvas({
  import draw: *
  let edge = 0.65pt + black
  let tip = (end: "stealth", fill: black, scale: 0.28)
  let wire(..points) = draw.line(..points, stroke: edge, mark: tip)
  let dashed = (paint: black, thickness: 0.55pt, dash: "dashed")
  let local = false
  let cx = if local { 2.50 } else { 2.80 }
  let ay = if local { 2.55 } else { 2.85 }
  draw.rect((cx - 0.70, 2.22), (7.33, 5.03), stroke: dashed)
  content((cx - 0.36, 5.35), text(style: "italic")[Attention Layer], anchor: "west")

  // Attention connections precede opaque state glyphs.
  for i in range(5) {
    let x = 0.40 + i * 1.10
    draw.line((x, 1.93), (cx + 1.35, ay), stroke: dashed)
    if not local or (i >= 1 and i <= 3) {
      wire((x, 1.93), (cx, 3.68))
    }
  }
  wire((7.00, 1.93), (cx + 1.35, ay))
  wire((cx + 1.35, ay), (cx + 1.35, 3.68), (cx + 0.20, 3.68))
  content((cx + 1.55, ay + 0.18), [$a_t$], anchor: "west")
  content((cx + 1.60, ay + 0.67), text(size: 6pt)[Global align weights], anchor: "west")
  if local {
    wire((7.00, 1.93), (6.25, 3.45))
    wire((6.02, 3.62), (cx + 0.20, 3.68))
    content((6.00, 3.62), [$p_t$], anchor: "west")
    content((4.18, 4.03), text(size: 6pt)[Aligned position], anchor: "west")
  }

  draw.rect((cx - 0.20, 3.68), (cx + 0.20, 4.78), fill: rgb("#008aff"), stroke: edge)
  content((cx - 0.30, 4.35), [$c_t$], anchor: "east")
  content((cx + 0.40, 4.48), text(size: 6pt)[Context vector], anchor: "west")
  wire((cx, 4.78), (7.00, 5.22))
  wire((7.00, 1.93), (7.00, 5.22))
  draw.rect((6.80, 5.22), (7.20, 6.32), fill: rgb("#c0c0c0"), stroke: edge)
  content((7.28, 6.50), [$tilde(h)_t$], anchor: "west")
  wire((7.00, 6.32), (7.00, 6.95))
  content((7.00, 7.20), [$y_t$])

  for i in range(7) {
    let x = 0.40 + i * 1.10
    draw.rect((x - 0.20, 0.83), (x + 0.20, 1.93),
      fill: if i < 5 { rgb("#008aff") } else { rgb("#a62c2b") }, stroke: edge)
    wire((x, 0.15), (x, 0.83))
    if i < 6 { wire((x + 0.20, 1.38), (x + 0.90, 1.38)) }
  }
  wire((7.20, 1.38), (7.90, 1.38))
  content((0.40, 2.30), [$overline(h)_s$])
  content((7.32, 2.08), [$h_t$], anchor: "west")
})
