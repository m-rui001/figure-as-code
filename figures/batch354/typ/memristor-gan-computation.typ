#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 14pt)

// Apostolou et al., Applied Sciences 2025, DOI 10.3390/app152011207, Figure 7.
#canvas({
  import draw: *
  let blue = rgb("73b8ea")
  let orange = rgb("ff7b32")
  let yellow = rgb("ffdf36")
  let box(x0, y0, x1, y1, t, fill) = {
    rect((x0, y0), (x1, y1), radius: 0.45, fill: fill, stroke: none)
    content(((x0 + x1) / 2, (y0 + y1) / 2), t)
  }
  let arrow(..pts) = line(..pts, stroke: 1.5pt + black, mark: (end: ">"))
  box(5, 1, 15, 3.3, [Discriminator], orange)
  box(18, 1, 28, 3.3, [Generator], yellow)
  box(11, 6, 21, 8.3, [Diff-Block], blue)
  box(29, 8.4, 33.5, 9.5, [Control Unit], rgb("d9d9d9"))
  for (i, fill) in (orange, yellow, blue).enumerate() {
    rect((0.4 + i * 0.3, 0.6 + i * 0.3), (2.4 + i * 0.3, 2.6 + i * 0.3),
      radius: 0.25, fill: fill, stroke: none)
  }
  content((1.7, -0.1), [Real Data])
  arrow((3, 2.15), (5, 2.15))
  content((4, 2.85), [a])
  arrow((18, 2.15), (15, 2.15))
  content((16.5, 1.45), [c])
  arrow((12.2, 6), (12.2, 3.3))
  content((11.45, 4.65), [e])
  arrow((13.4, 3.3), (13.4, 6))
  content((14.15, 4.65), [d])
  arrow((19.5, 6), (19.5, 3.3))
  content((20.25, 4.65), [f])

  // Overlapping vector ellipses form the original unlabelled noise cloud.
  for (p, r) in (((31.3, 2.2), (1.8, 0.85)), ((30.7, 2.7), (0.9, 0.7)),
    ((31.8, 2.9), (0.95, 0.7)), ((32.5, 2.45), (0.8, 0.7)),
    ((32.3, 1.8), (0.9, 0.7)), ((31.1, 1.65), (1.1, 0.65))) {
    circle(p, radius: r, fill: rgb("bbbbbb"), stroke: none)
  }
  arrow((29.4, 2.15), (28, 2.15))
  content((28.7, 2.85), [b])
  content((31.5, -0.1), [Noise])
})
