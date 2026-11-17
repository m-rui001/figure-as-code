#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 12pt)

// Chen and Guo, Mathematics 2023, DOI 10.3390/math11081777, Figure 6.
// Expand branch spacing while preserving all labels and category relationships.
#canvas({
  import draw: *
  let blue = rgb("548ed3")
  let purple = rgb("b0a0c6")
  let peach = rgb("fbd2b2")
  let link = rgb("0071bc")
  let box(x0, x1, y, t, fill) = {
    rect((x0, y - 0.55), (x1, y + 0.55), fill: fill, stroke: none)
    content(((x0 + x1) / 2, y), t)
  }
  let arrow(x0, x1, y, color: link) = line((x0, y), (x1, y),
    stroke: 1.6pt + color, mark: (end: ">"))
  let branch(x0, trunk, x1, parent, children, color: link) = {
    line((x0, parent), (trunk, parent), stroke: 1.6pt + color)
    line((trunk, children.first()), (trunk, children.last()), stroke: 1.6pt + color)
    for y in children { arrow(trunk, x1, y, color: color) }
  }
  rect((0, 7.5), (3.5, 8.9), stroke: 0.9pt + black)
  content((1.75, 8.2), [Application\ Domains])
  branch(3.5, 4.2, 5, 8.2, (19, 13.6, 8.2, 4.1, 0))
  box(5, 11.5, 19, [Computer Vision], blue)
  box(5, 11.5, 13.6, [Recommender System], rgb("fac296"))
  box(5, 11.5, 8.2, [Pattern Recognition], purple)
  box(5, 11.5, 4.1, [Data Generation], rgb("c2d69b"))
  box(5, 11.5, 0, [Other Applications], peach)

  branch(11.5, 12.1, 12.8, 19, (21, 19, 17))
  box(12.8, 19, 21, [Image Processing], blue)
  box(12.8, 19, 19, [3D Models field], blue)
  box(12.8, 19, 17, [Video Processing], blue)
  branch(19, 19.65, 20.3, 21, (22.5, 21, 19.5))
  for (y, t) in ((22.5, [Saliency Detection]), (21, [Image Restoration]), (19.5, [Image Retrieval])) {
    box(20.3, 27.3, y, t, blue)
  }
  branch(19, 19.65, 20.3, 17, (18, 16.5, 15, 13.5, 12))
  for (y, t) in ((18, [Video Classification]), (16.5, [Object Tracking]), (15, [Event Detection]),
    (13.5, [Forgery Detection]), (12, [Abnormal Detection])) {
    box(20.3, 27.3, y, t, blue)
  }
  branch(11.5, 12.1, 12.8, 8.2, (9.8, 8.2, 6.6), color: rgb("8063a5"))
  for (y, t) in ((9.8, [Face Recognition]), (8.2, [Facial Emotion Recognition]),
    (6.6, [Speech Emotion Recognition])) {
    box(12.8, 22, y, t, purple)
  }
  branch(11.5, 12.1, 12.8, 0, (4.8, 3.2, 1.6, 0, -1.6), color: rgb("ffc095"))
  for (y, t) in ((4.8, [Observing Phase Transitions]), (3.2, [Page Segmentation]),
    (1.6, [Text Classification]), (0, [Modeling Graphs])) {
    box(12.8, 22, y, t, peach)
  }
  content((17.4, -1.6), text(size: 20pt)[$dots.h dots.h$])
})
