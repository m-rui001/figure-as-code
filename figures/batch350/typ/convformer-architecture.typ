#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 11pt)

// Remote Sensing 2024, DOI 10.3390/rs16122077, Figure 3.
#let vertical(t) = rotate(-90deg, align(center, t), reflow: true)
#canvas({
  import draw: *
  let peach = rgb("f4ad91")
  let green = rgb("9cce8d")
  let blue = rgb("8ac5e8")
  let purple = rgb("c397c4")
  let arrow(..pts) = line(..pts, stroke: 0.8pt + black, mark: (end: ">"))
  for i in range(4) {
    let x = i * 8
    line((x, 10.3), (x, 16.1), (x + 1.5, 15.7), (x + 1.5, 10.7),
      close: true, fill: peach, stroke: 0.8pt + rgb("ed7b42"))
    content((x + 0.75, 13.2), vertical([Down sampling]))
    rect((x + 3, 11.7), (x + 7.3, 14.7), radius: 0.4,
      fill: green, stroke: 0.8pt + rgb("4a9f34"))
    content((x + 5.15, 13.2), align(center)[$L_#(i + 1) times$\ ConvFormer\ block])
    line((x + 1.5, 13.2), (x + 3, 13.2), stroke: 0.8pt + rgb("ed7b42"))
    if i < 3 {
      line((x + 7.3, 13.2), (x + 8, 13.2), stroke: 0.8pt + rgb("ed7b42"))
    } else { arrow((x + 7.3, 13.2), (x + 8.6, 13.2)) }
  }
  rect((5, 0), (26, 8), radius: 0.6, stroke: 0.8pt + black)
  line((13.15, 11.7), (15.3, 8), stroke: 0.7pt + black)
  let module(x0, x1, t, fill) = {
    rect((x0, 1.2), (x1, 6.2), radius: 0.2,
      fill: fill, stroke: 0.8pt + fill.darken(25%))
    content(((x0 + x1) / 2, 3.7), vertical(t))
  }
  let plus(x) = {
    circle((x, 3.7), radius: 0.45, stroke: 0.9pt + black)
    content((x, 3.7), text(size: 20pt, weight: "bold")[+])
  }
  module(6.4, 7.5, [Norm], purple)
  module(9.2, 11.9, [Separable\ Convolution], green)
  plus(14.2)
  module(16, 17.1, [Norm], purple)
  module(19, 21.7, [Channel-\ MLP], blue)
  plus(24.2)
  for (x0, x1) in ((5.7, 6.4), (7.5, 9.2), (11.9, 13.75),
    (14.65, 16), (17.1, 19), (21.7, 23.75)) {
    line((x0, 3.7), (x1, 3.7), stroke: 0.8pt + black)
  }
  arrow((24.65, 3.7), (25.3, 3.7))
  arrow((5.95, 3.7), (5.95, 7.2), (14.2, 7.2), (14.2, 4.15))
  arrow((15.15, 3.7), (15.15, 7.2), (24.2, 7.2), (24.2, 4.15))
})
