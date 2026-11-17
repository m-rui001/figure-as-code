#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 11pt)

// Dimitrovski et al., Remote Sensing 2024, DOI 10.3390/rs16122077, Figure 1.
// Keep five scales and the source layer counts; move the legend outside the frame.
#canvas({
  import draw: *
  let conv = rgb("f4ad91")
  let pool = rgb("9cce8d")
  let up = rgb("8ac5e8")
  let io = rgb("929292")
  let bar(x, y, fill) = rect((x, y - 1.2), (x + 0.48, y + 1.2),
    radius: 0.08, fill: fill, stroke: 0.8pt + fill.darken(25%))
  let arrow(..pts) = line(..pts, stroke: 0.8pt + black, mark: (end: ">"))
  let stage(x, y, colors) = {
    for (i, fill) in colors.enumerate() { bar(x + 0.62 * i, y, fill) }
  }
  rect((1.5, 0), (15.3, 18), stroke: (paint: red, thickness: 0.7pt, dash: "dashed"))
  rect((16, 0), (30.4, 18), stroke: (paint: purple, thickness: 0.7pt, dash: "dashed"))
  content((3.5, 0.55), text(size: 15pt)[Encoder])
  content((28.1, 0.55), text(size: 15pt)[Decoder])
  let enc = ((2, 16), (4.3, 12.5), (7, 9), (10, 5.5), (13.4, 2))
  let dec = ((27.4, 16), (24.5, 12.5), (21.8, 9), (19, 5.5), (17, 2))
  for (i, p) in enc.enumerate() {
    stage(..p, if i == 0 { (conv, conv, conv) }
      else if i == 4 { (pool, conv) } else { (pool, conv, conv, conv) })
  }
  for (i, p) in dec.enumerate() {
    stage(..p, if i == 0 { (conv, conv, conv) }
      else if i == 4 { (conv, up) } else { (conv, conv, conv, up) })
  }
  bar(0.1, 16, io)
  bar(31.5, 16, io)
  arrow((0.75, 16), (1.9, 16))
  arrow((29.35, 16), (31.3, 16))
  for i in range(4) {
    let a = enc.at(i)
    let b = enc.at(i + 1)
    let c = dec.at(i)
    let d = dec.at(i + 1)
    arrow((a.at(0) + 0.75, a.at(1) - 1.4),
      (a.at(0) + 0.75, b.at(1)), (b.at(0) - 0.2, b.at(1)))
    let end = a.at(0) + if i == 0 { 1.9 } else { 2.5 }
    arrow((end, a.at(1)), (c.at(0) - 0.25, c.at(1)))
    let start = d.at(0) + if i == 3 { 1.45 } else { 2.55 }
    arrow((start, d.at(1)), (c.at(0) + 0.3, d.at(1)), (c.at(0) + 0.3, c.at(1) - 1.4))
  }
  arrow((14.85, 2), (16.75, 2))

  for (y, t, fill) in ((10, [Convolution Layer], conv), (8.4, [Pooling Layer], pool),
    (6.8, [Up-convolution Layer], up), (5.2, [Input/Output Layer], io)) {
    rect((32.7, y - 0.55), (39, y + 0.55), radius: 0.14,
      fill: fill, stroke: 0.8pt + fill.darken(25%))
    content((35.85, y), t)
  }
  content((35.85, 3.6), [Concatenate])
  arrow((32.8, 2.9), (38.9, 2.9))
})
