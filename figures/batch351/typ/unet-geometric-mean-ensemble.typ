#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 10pt)

// Remote Sensing 2024, DOI 10.3390/rs16122077, Figure 5.
// Preserve the image's ConvFormer-M3 spelling rather than changing it to the prose.
#let vertical(t) = rotate(-90deg, t, reflow: true)
#canvas({
  import draw: *
  let blue = rgb("8ac5e8")
  let cyan = rgb("149fd0")
  let green = rgb("9cce8d")
  let purple = rgb("c397c4")
  let peach = rgb("f4ad91")
  let edge = 0.8pt
  let arrow(..pts, color: black) = line(..pts, stroke: edge + color, mark: (end: ">"))
  let cylinder(y, height, fill, color, t) = {
    circle((2, y), radius: (2, 0.4), fill: fill, stroke: edge + color)
    rect((0, y), (4, y + height), fill: fill, stroke: none)
    line((0, y), (0, y + height), stroke: edge + color)
    line((4, y), (4, y + height), stroke: edge + color)
    circle((2, y + height), radius: (2, 0.4), fill: fill.lighten(25%), stroke: edge + color)
    content((2, y + height / 2), t)
  }
  let dotted = (paint: black, thickness: 0.8pt, dash: "dashed")
  circle((2, 17.6), radius: (2.05, 0.45), stroke: dotted)
  line((-0.05, 2), (-0.05, 17.6), stroke: dotted)
  line((4.05, 2), (4.05, 17.6), stroke: dotted)
  content((2, 16.55), [Data set])
  cylinder(10, 5, blue, cyan, [Train split])
  cylinder(2, 4.2, green, rgb("4a9f34"), [Test split])

  for (x0, x1) in ((4.6, 11.15), (11.85, 17.15), (17.85, 23.15), (23.85, 33)) {
    line((x0, 9.4), (x1, 9.4), stroke: dotted)
  }
  content((6.1, 10.0), text(fill: gray)[Training stage])
  content((6.1, 8.8), text(fill: gray)[Testing stage])
  line((4, 12.5), (7, 12.5), (7, 17), (23.5, 17), stroke: edge + cyan)
  line((4, 4.1), (6.7, 4.1), (6.7, 7.8), (22.5, 7.8), stroke: edge + rgb("4a9f34"))

  for (x, name) in ((9, [MaxViT-S]), (15, [ConvFormer-M3]), (21, [EfficientNet-B7])) {
    rect((x, 12), (x + 5, 15), fill: rgb("98acba"), stroke: edge + rgb("206380"))
    content((x + 0.35, 14.5), [U-Net], anchor: "west")
    rect((x + 0.45, 12.45), (x + 4.55, 13.65), fill: blue, stroke: edge + cyan)
    content((x + 2.5, 13.05), name)
    arrow((x + 2.5, 17), (x + 2.5, 15), color: cyan)

    // Opaque training arrows cross the stage divider without a line through text.
    let cx = x + 2.5
    line((cx - 0.23, 11.5), (cx + 0.23, 11.5), (cx + 0.23, 7.55),
      (cx + 0.52, 7.55), (cx, 7.05), (cx - 0.52, 7.55), (cx - 0.23, 7.55),
      close: true, fill: purple, stroke: edge + rgb("9a268f"))
    content((cx, 9.55), vertical([Training]))
    arrow((x + 1.5, 7.8), (x + 1.5, 6.8), color: rgb("4a9f34"))
    rect((x, 3.8), (x + 5, 6.8), fill: purple, stroke: edge + rgb("9a268f"))
    content((x + 0.35, 6.3), [U-Net (trained)], anchor: "west")
    rect((x + 0.45, 4.25), (x + 4.55, 5.45), fill: peach, stroke: edge + rgb("ed7b42"))
    content((x + 2.5, 4.85), name)
  }
  rect((28.5, 0), (30.5, 7.1), fill: peach, stroke: edge + rgb("ed7b42"))
  content((29.5, 3.55), vertical([Geometric mean]))
  arrow((11.5, 3.8), (11.5, 0.65), (28.5, 0.65), color: rgb("ed7b42"))
  arrow((17.5, 3.8), (17.5, 2.75), (28.5, 2.75), color: rgb("ed7b42"))
  arrow((26, 5.2), (28.5, 5.2), color: rgb("ed7b42"))
  line((31, 2.9), (34.2, 2.9), (34.2, 2.2), (35.5, 3.6),
    (34.2, 5), (34.2, 4.3), (31, 4.3), close: true,
    fill: rgb("98b199"), stroke: edge + rgb("276733"))
  content((33.1, 3.6), [Prediction])
})
