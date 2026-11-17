#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 12pt)

// Chen and Guo, Mathematics 2023, DOI 10.3390/math11081777, Figure 7.
// Reserve independent heading widths and keep all connectors outside text boxes.
#canvas({
  import draw: *
  let blue = rgb("365b91")
  let orange = rgb("ef7800")
  let green = rgb("00b951")
  let box(x0, y0, x1, y1, t, color) = {
    rect((x0, y0), (x1, y1), radius: 0.3, stroke: 1pt + color)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(fill: color, t))
  }
  let wire(..pts) = line(..pts, stroke: 1.3pt + black)
  let down(y0, y1) = line((10.25, y0), (10.25, y1),
    stroke: 2pt + blue, mark: (end: ">"))
  let stage(y, t) = content((1.5, y), text(fill: rgb("3c82ad"), style: "italic", weight: "bold", t))
  stage(16.9, [Input layer])
  stage(10.65, [Model layer])
  stage(1, [Output layer])
  box(4, 16, 7.8, 17.8, [User feedback\ data], blue)
  box(8.3, 16, 12.1, 17.8, [User or item\ information], blue)
  box(12.6, 16, 16.4, 17.8, [Auxiliary\ information], blue)
  wire((5.9, 16), (5.9, 15.45), (14.5, 15.45), (14.5, 16))
  down(16, 14.75)

  rect((4.2, 6.9), (16.3, 14.7), stroke: 1pt + orange)
  content((7.35, 13.95), text(fill: orange, weight: "bold")[Integration Model])
  content((13.25, 13.95), text(fill: orange, weight: "bold")[Non-integration Model])
  box(4.9, 10.65, 9.8, 13.05, [Integrated AE\ with traditional\ RS method], orange)
  box(4.9, 7.65, 9.8, 10.05, [Integrated AE\ with other DL\ methods], orange)
  box(10.8, 9.55, 15.65, 12.05, [Relying only\ on AE methods], orange)
  down(6.9, 5.85)

  wire((7.1, 5.4), (7.1, 5.85), (13.4, 5.85), (13.4, 5.4))
  box(4.65, 3.3, 9.55, 5.4, [The latent\ representation\ of user], green)
  box(10.95, 3.3, 15.85, 5.4, [The latent\ representation\ of item], green)
  wire((7.1, 3.3), (7.1, 2.7), (13.4, 2.7), (13.4, 3.3))
  down(2.7, 1.85)
  box(7.35, 0, 13.15, 1.85, [Recommendation\ list], blue)
})
