#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 13pt)

// Chen and Guo, Mathematics 2023, DOI 10.3390/math11081777, Figure 4.
// Keep the eleven visible connections, including the omitted first-to-last edge.
#canvas({
  import draw: *
  let hidden = ((5, 4.4), (8.1, 4.4), (12.5, 4.4))
  let visible = ((2.2, 0), (5.5, 0), (8.6, 0), (14.4, 0))
  for (i, a) in hidden.enumerate() {
    for (j, b) in visible.enumerate() {
      if not (i == 0 and j == 3) {
        line((a.at(0), a.at(1) - 1.05), (b.at(0), b.at(1) + 1.05), stroke: 0.7pt + black)
      }
    }
  }
  for (p, t) in hidden.zip(($h_1$, $h_2$, $h_m$)) {
    circle(p, radius: 1.05, fill: rgb("f6cbaa"), stroke: none)
    content(p, text(size: 23pt, t))
  }
  for (p, t) in visible.zip(($v_1$, $v_2$, $v_3$, $v_n$)) {
    circle(p, radius: 1.05, fill: rgb("91a8d5"), stroke: none)
    content(p, text(size: 23pt, t))
  }
  content((1.3, 4.4), text(style: "italic", weight: "bold")[hidden layer])
  content((-0.5, 0), text(style: "italic", weight: "bold")[input layer])
  content((10.3, 4.4), text(size: 24pt)[$dots.h$])
  content((11.5, 0), text(size: 24pt)[$dots.h$])
})
