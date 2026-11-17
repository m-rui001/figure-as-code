#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 9pt)

// Source: He et al., Deep Residual Learning for Image Recognition, Figure 2.
// Identity bypass joins the learned residual before the final ReLU.
#canvas({
  import draw: *
  let stroke = 0.7pt + black
  let arrow = (end: "stealth", fill: black, scale: 0.35)
  let wire(..points) = draw.line(..points, stroke: stroke, mark: arrow)
  let layer(y) = {
    draw.rect((-1.15, y), (1.15, y + 0.55), fill: white, stroke: stroke)
    content((0, y + 0.275), [weight layer])
  }
  layer(2.50)
  layer(1.25)
  wire((0, 3.68), (0, 3.05))
  wire((0, 2.50), (0, 1.80))
  wire((0, 1.25), (0, 0.62))
  content((-0.30, 3.58), [$x$], anchor: "east")
  content((0.22, 2.15), [relu], anchor: "west")
  content((-1.55, 2.16), [$cal(F)(x)$], anchor: "east")
  draw.circle((0, 0.45), radius: 0.17, fill: white, stroke: stroke)
  draw.line((-0.10, 0.45), (0.10, 0.45), stroke: stroke)
  draw.line((0, 0.35), (0, 0.55), stroke: stroke)
  // Sample a cubic curve to preserve the curved identity shortcut.
  let points = ()
  for i in range(81) {
    let t = i / 80
    let u = 1 - t
    points.push((3 * u * u * t * 2.65 + 3 * u * t * t * 2.65 + t * t * t * 0.17,
      u * u * u * 3.48 + 3 * u * u * t * 3.48 + 3 * u * t * t * 0.45 + t * t * t * 0.45))
  }
  draw.line(..points, stroke: stroke, mark: arrow)
  content((2.36, 2.13), [$x$])
  content((2.18, 1.65), [identity], anchor: "west")
  content((-0.48, 0.45), [$cal(F)(x) + x$], anchor: "east")
  wire((0, 0.28), (0, -0.18))
  content((0.22, 0.06), [relu], anchor: "west")
})
