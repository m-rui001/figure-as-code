#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 12pt, style: "italic", weight: "bold")

// Chen and Guo, Mathematics 2023, DOI 10.3390/math11081777, Figure 5.
// Keep stack counts, receptive-field fans and the two dense output stages.
#canvas({
  import draw: *
  let teal = rgb("3c8e92")
  let pale = rgb("cece9d")
  let edge = 0.75pt + black
  let stack(x, y, size, count, step) = {
    for i in range(count) {
      rect((x + i * step, y - i * step), (x + i * step + size, y - i * step + size),
        fill: if calc.even(i) { teal } else { pale }, stroke: edge)
    }
  }
  let fan(x, y, size, tx, ty) = {
    rect((x, y), (x + size, y + size), stroke: edge)
    line((x, y + size), (tx, ty), stroke: 0.55pt + black)
    line((x + size, y + size), (tx, ty), stroke: 0.55pt + black)
    line((x + size, y), (tx, ty), stroke: 0.55pt + black)
  }
  let caption(x, y, t) = content((x, y), t)
  rect((0, 3.3), (1.6, 4.9), fill: pale, stroke: edge)
  stack(2.8, 4.5, 1.5, 8, 0.25)
  stack(7, 4.3, 1.3, 8, 0.25)
  stack(9.5, 6.8, 1.15, 16, 0.25)
  stack(13.3, 7, 0.98, 16, 0.25)
  fan(0.17, 4.28, 0.45, 4.88, 3.05)
  fan(5.35, 3.83, 0.43, 8.92, 3.14)
  fan(9.56, 3.15, 0.30, 13.5, 3.38)
  fan(13.93, 3.22, 0.30, 17.18, 3.45)

  line((14.28, 7.98), (16.5, 6.9), stroke: 0.55pt + black)
  line((18.03, 3.25), (18.4, 3.9), stroke: 0.55pt + black)
  line((16.5, 6.9), (17.0, 6.9), (18.9, 3.9), (18.4, 3.9),
    close: true, fill: teal, stroke: none)
  line((17.0, 6.9), (19.4, 6.45), stroke: 0.55pt + black)
  line((18.9, 3.9), (20.6, 4.82), stroke: 0.55pt + black)
  line((19.4, 6.45), (19.75, 6.45), (20.95, 4.82), (20.6, 4.82),
    close: true, fill: teal, stroke: none)

  caption((0.8), 5.55, [input image])
  caption(4.35, 6.7, [feature map])
  for (x, top, bottom, t) in (
    (3.0, 3.1, 1.9, [convolution]),
    (7.5, 2.9, 1.55, [pooling]),
    (12.1, 2.5, 1.2, [convolution]),
    (16.1, 2.25, 0.65, [pooling]),
  ) {
    line((x, top), (x, bottom + 0.45), stroke: edge)
    caption(x, bottom, t)
  }
  line((20.62, 4.35), (20.62, 3.25), stroke: edge)
  caption(20.62, 2.62, align(center)[fully connected\ layers])
  caption(21.55, 6.05, [output layer])
})
