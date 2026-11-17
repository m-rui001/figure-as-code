#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 12pt, weight: "bold")

// Apostolou et al., DOI 10.3390/app152011207, Figure 6.
// Schematic animal icons stand for the source photographs and their crops.
#canvas({
  import draw: *
  let green = rgb("b0d997")
  let pink = rgb("ef92c5")
  let lilac = rgb("a3a9da")
  let yellow = rgb("f1c573")
  let edge = 0.8pt + black
  let arrow(..pts) = line(..pts, stroke: 1.25pt + black, mark: (end: ">"))
  let title(x, y, w, t, h: 0.9) = {
    rect((x - w / 2, y - h / 2), (x + w / 2, y + h / 2),
      fill: rgb("dddddd"), radius: 0.12, stroke: none)
    content((x, y), align(center, t))
  }
  let portrait(x, y, color, cat: true, close-up: false) = {
    rect((x - 1.8, y - 1.8), (x + 1.8, y + 1.8), fill: rgb("f6f3ed"), stroke: 3pt + color)
    let s = if close-up { 1.25 } else { 0.85 }
    let fur = if cat { rgb("e9b987") } else { rgb("ad7358") }
    let point(u, v) = (x + s * u, y + s * v)
    if cat {
      line(point(-0.7, 0.25), point(-0.69, 1.05), point(-0.18, 0.56),
        close: true, fill: fur, stroke: edge)
      line(point(0.7, 0.25), point(0.69, 1.05), point(0.18, 0.56),
        close: true, fill: fur, stroke: edge)
    } else {
      circle(point(-0.64, 0.08), radius: (0.24 * s, 0.51 * s), fill: fur.darken(23%), stroke: edge)
      circle(point(0.64, 0.08), radius: (0.24 * s, 0.51 * s), fill: fur.darken(23%), stroke: edge)
    }
    circle(point(0, 0), radius: (0.66 * s, 0.57 * s), fill: fur, stroke: edge)
    circle(point(0, -0.21), radius: (0.3 * s, 0.22 * s), fill: fur.lighten(42%), stroke: none)
    for u in (-0.24, 0.24) { circle(point(u, 0.13), radius: 0.048, fill: black, stroke: none) }
    circle(point(0, -0.13), radius: 0.065, fill: black, stroke: none)
  }
  title(3, 9, 3.7, [Image space])
  portrait(0.9, 6.3, green)
  portrait(5.1, 6.3, pink, close-up: true)
  portrait(0.9, 2.1, lilac, cat: false)
  portrait(5.1, 2.1, yellow, cat: false, close-up: true)
  arrow((7.25, 4.2), (8.7, 4.2))
  title(11.45, 7.9, 4.2, [Manifold space])
  line((8.9, 5.1), (14, 5.1), stroke: edge)
  line((8.9, 3.3), (14, 3.3), stroke: edge)
  for x in (10.4, 12.65) {
    circle((x, 4.2), radius: 0.56, stroke: 0.45pt + gray)
  }
  for (x, color) in ((10, green), (10.8, pink), (12.28, lilac), (13.02, yellow)) {
    circle((x, 4.2), radius: 0.22, fill: color, stroke: none)
  }
  arrow((14.35, 4.5), (15.55, 5.15))
  arrow((14.35, 3.9), (15.55, 3.25))
  let feature-axis(y, positions) = {
    line((16, y), (20.25, y), stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
    for x in (16, 20.25) { line((x, y - 0.1), (x, y + 0.1), stroke: edge) }
    for (x, color) in positions.zip((green, pink, lilac, yellow)) {
      circle((x, y), radius: 0.22, fill: color, stroke: none)
    }
  }
  feature-axis(5.85, (16.55, 18.5, 19.7, 17.9))
  feature-axis(2.55, (16.55, 17.16, 19.7, 19.08))
  title(18.125, 7.65, 3.2, [Before\ consistency], h: 1.45)
  title(18.125, 0.65, 3.2, [After\ consistency], h: 1.45)
  title(23.3, 4.2, 5.7, [Semantic feature space])
})
