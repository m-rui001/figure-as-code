#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 11pt)

// Remote Sensing 2024, DOI 10.3390/rs16122077, Figure 4.
#let vertical(t) = rotate(90deg, t, reflow: true)
#canvas({
  import draw: *
  let colors = (rgb("929292"), rgb("f4ad91"), rgb("8ac5e8"), rgb("88a58c"),
    rgb("8ac5e8"), rgb("889fac"), rgb("c397c4"))
  let bar(i, t, color, large: false) = {
    let x = 2.4 + i * 1.5
    let y0 = if large { -0.8 } else { 0 }
    let y1 = if large { 6.7 } else { 5.9 }
    rect((x, y0), (x + 0.95, y1), radius: 0.15,
      fill: color, stroke: 0.8pt + color.darken(25%))
    content((x + 0.475, (y0 + y1) / 2), vertical(t))
  }
  let groups = ((1, 1, [MBConv1, 3 × 3]), (2, 2, [MBConv6, 3 × 3]),
    (4, 2, [MBConv6, 5 × 5]), (6, 3, [MBConv6, 3 × 3]),
    (9, 3, [MBConv6, 5 × 5]), (12, 5, [MBConv6, 5 × 5]), (17, 1, [MBConv6, 3 × 3]))
  bar(0, [conv 3 × 3], rgb("9cce8d"))
  for (g, (start, count, t)) in groups.enumerate() {
    let c = colors.at(g)
    for i in range(start, start + count) { bar(i, t, c, large: g == 2 or g == 4 or g == 5) }
    let x0 = 2.4 + start * 1.5
    let x1 = 2.4 + (start + count - 1) * 1.5 + 0.95
    let mid = (x0 + x1) / 2
    line((x0, 7.35), (x0, 7.6), (mid - 0.1, 7.6), (mid, 7.78),
      (mid + 0.1, 7.6), (x1, 7.6), (x1, 7.35), stroke: 1pt + c.darken(35%))
    content((mid, 8.2), text(fill: c.darken(35%))[Block #(g + 1)])
  }
  content((0.6, 2.95), vertical([Input Image]))
  line((1.1, 2.95), (2.1, 2.95), stroke: 2pt + rgb("0c9dd1"), mark: (end: ">"))
  line((29.15, 2.95), (30.15, 2.95), stroke: 2pt + rgb("0c9dd1"), mark: (end: ">"))
  content((30.65, 2.95), vertical([Feature Map]))
})
