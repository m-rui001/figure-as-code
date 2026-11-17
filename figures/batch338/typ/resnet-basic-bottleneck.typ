#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 8pt)

// Source: He et al., Deep Residual Learning for Image Recognition, Figure 5.
// The right block compresses 256 channels to 64, processes them, then restores 256.
#canvas({
  import draw: *
  let stroke = 0.65pt + black
  let arrow = (end: "stealth", fill: black, scale: 0.32)
  let wire(..points) = draw.line(..points, stroke: stroke, mark: arrow)
  let layer(x, y, label) = {
    draw.rect((x - 1.05, y), (x + 1.05, y + 0.42), stroke: stroke, fill: white)
    content((x, y + 0.21), label)
  }
  let addition(x) = {
    draw.circle((x, 0.43), radius: 0.15, stroke: stroke, fill: white)
    draw.line((x - 0.09, 0.43), (x + 0.09, 0.43), stroke: stroke)
    draw.line((x, 0.34), (x, 0.52), stroke: stroke)
    wire((x, 0.28), (x, -0.12))
    content((x + 0.18, 0.07), [relu], anchor: "west")
  }
  let shortcut(x) = {
    let points = ()
    for i in range(81) {
      let t = i / 80
      let u = 1 - t
      points.push((x + 3 * u * u * t * 2.70 + 3 * u * t * t * 2.70 + t * t * t * 0.15,
        u * u * u * 3.55 + 3 * u * u * t * 3.55 + 3 * u * t * t * 0.43 + t * t * t * 0.43))
    }
    draw.line(..points, stroke: stroke, mark: arrow)
  }

  layer(0, 2.60, [$3 times 3$, 64])
  layer(0, 1.40, [$3 times 3$, 64])
  wire((0, 3.78), (0, 3.02))
  wire((0, 2.60), (0, 1.82))
  wire((0, 1.40), (0, 0.58))
  content((0.20, 3.73), [64-d], anchor: "west")
  content((0.18, 2.18), [relu], anchor: "west")
  addition(0)
  shortcut(0)

  layer(5.35, 2.85, [$1 times 1$, 64])
  layer(5.35, 2.02, [$3 times 3$, 64])
  layer(5.35, 1.19, [$1 times 1$, 256])
  wire((5.35, 3.78), (5.35, 3.27))
  wire((5.35, 2.85), (5.35, 2.44))
  wire((5.35, 2.02), (5.35, 1.61))
  wire((5.35, 1.19), (5.35, 0.58))
  content((5.55, 3.73), [256-d], anchor: "west")
  content((5.53, 2.65), [relu], anchor: "west")
  content((5.53, 1.82), [relu], anchor: "west")
  addition(5.35)
  shortcut(5.35)
})
