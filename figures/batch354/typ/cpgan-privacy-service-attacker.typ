#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 13pt)

// Apostolou et al., Applied Sciences 2025, DOI 10.3390/app152011207, Figure 9.
// Retain S(X) exactly as printed in the source image.
#canvas({
  import draw: *
  let pink = rgb("ea95ea")
  let box(x0, y0, x1, y1, t, fill) = {
    rect((x0, y0), (x1, y1), radius: 0.5, fill: fill, stroke: none)
    content(((x0 + x1) / 2, (y0 + y1) / 2), align(center, t))
  }
  let arrow(..pts) = line(..pts, stroke: 1.4pt + black, mark: (end: ">"))
  box(0, 2.4, 3, 5.4, [X], pink)
  content((1.5, 1.45), align(center)[Original\ Data])
  box(4.7, 2.4, 11.3, 5.4, [G(X)\ Privatization], rgb("5bc9eb"))
  box(13, 2.4, 16, 5.4, [Z], pink)
  box(18.5, 4.8, 25.1, 7.8, [S(X)\ Service], rgb("85d36f"))
  box(18.5, 0, 25.1, 3, [A(Z)\ Attacker], rgb("ff8e88"))
  arrow((3, 3.9), (4.7, 3.9))
  arrow((11.3, 3.9), (13, 3.9))
  line((16, 3.9), (17.1, 3.9), stroke: 1.4pt + black)
  arrow((17.1, 3.9), (17.1, 6.3), (18.5, 6.3))
  arrow((17.1, 3.9), (17.1, 1.5), (18.5, 1.5))
  arrow((25.1, 6.3), (26.55, 6.3))
  arrow((25.1, 1.5), (26.55, 1.5))
  content((29.8, 6.3), [Utility Prediction Y])
  content((29.8, 1.5), [Reconstruction X′])
})
