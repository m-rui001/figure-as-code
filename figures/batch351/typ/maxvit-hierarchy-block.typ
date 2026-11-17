#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 10pt)

// Remote Sensing 2024, DOI 10.3390/rs16122077, Figure 2.
#let vertical(t) = rotate(90deg, align(center, t), reflow: true)
#canvas({
  import draw: *
  let blue = rgb("8ac5e8")
  let green = rgb("9cce8d")
  let peach = rgb("f4ad91")
  let purple = rgb("c397c4")
  let grayblue = rgb("889fac")
  let dashed = (paint: gray, thickness: 0.7pt, dash: "dashed")
  let arrow(..pts) = line(..pts, stroke: 0.8pt + black, mark: (end: ">"))
  let block(x0, x1, y0, y1, t, fill, turn: true) = {
    rect((x0, y0), (x1, y1), radius: 0.2, fill: fill, stroke: 0.8pt + fill.darken(25%))
    content(((x0 + x1) / 2, (y0 + y1) / 2), if turn { vertical(t) } else { align(center, t) })
  }
  block(0, 0.7, 11, 15, [Input], gray)
  content((-0.6, 13), vertical([224 × 224]))
  block(2, 3.4, 11, 15, [Conv 3 × 3\ (S=2)], green)
  block(4.2, 5.3, 11, 15, [Conv 3 × 3], green)
  rect((1.6, 10.7), (5.8, 15.3), radius: 0.4, stroke: dashed)
  content((3.7, 16.1), align(center)[S0: Stem\ (112 × 112)])
  for i in range(4) {
    let x = 7 + 5 * i
    block(x, x + 3.8, 11, 15, [MaxViT\ Block], blue, turn: false)
    rect((x - 0.3, 10.7), (x + 4.1, 15.3), radius: 0.4, stroke: dashed)
    let size = (56, 28, 14, 7).at(i)
    content((x + 1.9, 16.1), align(center)[S#(i + 1): repeat × $L_#(i + 1)$\ (#size × #size)])
  }
  block(27.3, 28.3, 11, 15, [Pool], purple)
  block(29.3, 30.3, 11, 15, [FC], purple)
  block(31.7, 32.4, 11, 15, [Output], gray)
  content((28.8, 16.1), align(center)[Head\ (1 × 1)])
  for (x0, x1) in ((0.7, 2), (3.4, 4.2), (5.3, 7), (10.8, 12), (15.8, 17),
    (20.8, 22), (25.8, 27.3), (28.3, 29.3), (30.3, 31.7)) {
    arrow((x0, 13), (x1, 13))
  }
  line((8.9, 10.7), (12.5, 7), stroke: dashed)

  rect((0, 0), (28, 7), radius: 0.5, stroke: dashed)
  for (x0, x1, t) in ((0.9, 9.1, [MBConv]), (9.5, 18, [Block Attention]), (18.5, 27.2, [Grid Attention])) {
    rect((x0, 0.5), (x1, 5.8), radius: 0.4, stroke: dashed)
    content(((x0 + x1) / 2, 6.35), t)
  }
  for (x, t, fill) in ((1.8, [Conv 1 × 1], peach), (3.3, [Depthwise\ Conv 3 × 3], peach),
    (4.8, [SE], rgb("88a58c")), (6.3, [Conv 1 × 1], peach),
    (10.5, [Block-SA], blue), (14.2, [FFN], grayblue),
    (19.5, [Grid-SA], blue), (23.2, [FFN], grayblue)) {
    block(x, x + 1, 1.1, 4.7, t, fill)
  }
  for x in (8.2, 12.7, 16.5, 21.7, 25.5) {
    circle((x, 2.9), radius: 0.43, stroke: 0.8pt + black)
    content((x, 2.9), text(size: 19pt, weight: "bold")[+])
  }
  for (x0, x1) in ((0.6, 1.8), (2.8, 3.3), (4.3, 4.8), (5.8, 6.3), (7.3, 7.77),
    (8.63, 10.5), (11.5, 12.27), (13.13, 14.2), (15.2, 16.07),
    (16.93, 19.5), (20.5, 21.27), (22.13, 23.2), (24.2, 25.07)) {
    line((x0, 2.9), (x1, 2.9), stroke: 0.8pt + black)
  }
  for (x0, x1) in ((1.3, 8.2), (9.9, 12.7), (13.7, 16.5), (18.9, 21.7), (22.7, 25.5)) {
    arrow((x0, 2.9), (x0, 5.2), (x1, 5.2), (x1, 3.33))
  }
  arrow((25.93, 2.9), (27.6, 2.9))
})
