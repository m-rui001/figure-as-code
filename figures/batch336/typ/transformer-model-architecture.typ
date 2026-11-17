#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 8pt)

// Source: Vaswani et al., Attention Is All You Need, arXiv:1706.03762, Figure 1.
// Encoder output supplies keys and values to decoder cross-attention; query comes from below.
#canvas({
  import draw: *
  let edge = 0.75pt + black
  let tip = (end: "stealth", fill: black, scale: 0.35)
  let wire(..points) = draw.line(..points, stroke: edge, mark: tip)
  let box(x, y, h, label, color) = {
    draw.rect((x - 0.95, y), (x + 0.95, y + h), radius: 0.06, stroke: edge, fill: rgb(color))
    content((x, y + h / 2), label)
  }
  let norm(x, y) = box(x, y, 0.35, [Add & Norm], "#ffffc6")
  let attention(x, y, label) = box(x, y, 0.78, label, "#ffe3be")
  let feed(x, y) = box(x, y, 0.72, [Feed\ Forward], "#c5e8f1")
  let residual(x, y0, y1, left: false) = {
    let side = if left { x - 1.47 } else { x + 1.40 }
    let target = if left { x - 0.95 } else { x + 0.95 }
    wire((x, y0), (side, y0), (side, y1 + 0.175), (target, y1 + 0.175))
  }
  let sum(x) = {
    draw.circle((x, 1.72), radius: 0.13, stroke: edge, fill: white)
    draw.line((x - 0.08, 1.72), (x + 0.08, 1.72), stroke: edge)
    draw.line((x, 1.64), (x, 1.80), stroke: edge)
  }
  let positional(x, left: false) = {
    let px = if left { x - 0.72 } else { x + 0.72 }
    draw.circle((px, 1.72), radius: 0.29, stroke: edge)
    let wave = ()
    for i in range(41) {
      let dx = -0.27 + i * 0.54 / 40
      wave.push((px + dx, 1.72 + 0.13 * calc.sin(i * 360deg / 40)))
    }
    draw.line(..wave, stroke: 0.55pt + black)
    if left {
      wire((px + 0.29, 1.72), (x - 0.13, 1.72))
      content((px - 0.43, 1.72), [Positional\ Encoding], anchor: "east")
    } else {
      wire((px - 0.29, 1.72), (x + 0.13, 1.72))
      content((px + 0.43, 1.72), [Positional\ Encoding], anchor: "west")
    }
  }

  // Stack outlines are drawn first so no opaque fill covers a connection.
  draw.rect((1.38, 2.28), (4.20, 6.45), radius: 0.20, fill: rgb("#f3f3f3"), stroke: edge)
  draw.rect((5.30, 2.28), (8.12, 8.20), radius: 0.20, fill: rgb("#f3f3f3"), stroke: edge)
  content((1.12, 4.35), [$N times$], anchor: "east")
  content((8.38, 5.22), [$N times$], anchor: "west")

  box(3, 0.48, 0.70, [Input\ Embedding], "#fce1e3")
  box(6.5, 0.48, 0.70, [Output\ Embedding], "#fce1e3")
  wire((3, -0.05), (3, 0.48))
  wire((6.5, -0.05), (6.5, 0.48))
  content((3, -0.30), [Inputs])
  content((6.5, -0.43), [Outputs\ (shifted right)])
  wire((3, 1.18), (3, 1.59))
  wire((6.5, 1.18), (6.5, 1.59))
  sum(3)
  sum(6.5)
  positional(3, left: true)
  positional(6.5)

  attention(3, 2.70, [Multi-Head\ Attention])
  norm(3, 3.66)
  feed(3, 4.69)
  norm(3, 5.62)
  wire((3, 1.85), (3, 2.70))
  wire((3, 3.48), (3, 3.66))
  wire((3, 4.01), (3, 4.69))
  wire((3, 5.41), (3, 5.62))
  residual(3, 2.42, 3.66, left: true)
  residual(3, 4.18, 5.62, left: true)
  for dx in (-0.72, 0.72) {
    wire((3, 2.42), (3 + dx, 2.42), (3 + dx, 2.70))
  }

  box(6.5, 2.50, 0.98, text(size: 7pt)[Masked\ Multi-Head\ Attention], "#ffe3be")
  norm(6.5, 3.66)
  attention(6.5, 4.69, [Multi-Head\ Attention])
  norm(6.5, 5.65)
  feed(6.5, 6.67)
  norm(6.5, 7.61)
  wire((6.5, 1.85), (6.5, 2.50))
  wire((6.5, 3.48), (6.5, 3.66))
  wire((6.5, 4.01), (6.5, 4.28), (7.22, 4.28), (7.22, 4.69))
  wire((6.5, 5.47), (6.5, 5.65))
  wire((6.5, 6.00), (6.5, 6.67))
  wire((6.5, 7.39), (6.5, 7.61))
  residual(6.5, 2.42, 3.66)
  residual(6.5, 4.20, 5.65)
  residual(6.5, 6.18, 7.61)
  for dx in (-0.72, 0.72) {
    wire((6.5, 2.42), (6.5 + dx, 2.42), (6.5 + dx, 2.50))
  }
  // Route the encoder output above its frame, then descend through the inter-stack gap.
  draw.line((3, 5.97), (3, 6.72), (4.55, 6.72), (4.55, 4.43), (6.50, 4.43), stroke: edge)
  wire((5.78, 4.43), (5.78, 4.69))
  wire((6.50, 4.43), (6.50, 4.69))

  box(6.5, 8.62, 0.35, [Linear], "#dedfee")
  box(6.5, 9.34, 0.35, [Softmax], "#d0ead2")
  wire((6.5, 7.96), (6.5, 8.62))
  wire((6.5, 8.97), (6.5, 9.34))
  wire((6.5, 9.69), (6.5, 10.08))
  content((6.5, 10.42), [Output\ Probabilities])
})
