#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 12pt)

// Chen and Guo, Mathematics 2023, DOI 10.3390/math11081777, Figure 3.
// Draw example digits and the Gaussian surface as vectors, without raster assets.
#canvas({
  import draw: *
  let blue = rgb("006fbd")
  let red = rgb("d40000")
  let arrow(..pts) = line(..pts, stroke: 1pt + black, mark: (end: ">"))
  let layer(x, y0, y1, fill: white) = rect((x, y0), (x + 0.8, y1),
    fill: fill, stroke: 2pt + black)
  let digit(x, y) = {
    rect((x, y), (x + 2.5, y + 2.3), stroke: 0.6pt + gray)
    line((x + 0.86, y + 0.35), (x + 0.91, y + 0.68), (x + 1.14, y + 1.1),
      (x + 1.39, y + 1.55), (x + 1.65, y + 1.94), stroke: 5pt + black)
  }
  let brace(x0, x1, y, title) = {
    let mid = (x0 + x1) / 2
    line((x0, y - 0.1), (x0 + 0.2, y), (mid - 0.2, y), (mid, y + 0.1),
      (mid + 0.2, y), (x1 - 0.2, y), (x1, y - 0.1), stroke: 0.8pt + black)
    content((mid, y + 0.65), text(fill: blue, size: 20pt, weight: "bold", title))
  }

  rect((0, 8), (18, 14.1), stroke: 1.2pt + red)
  brace(0, 8.8, 14.65, [Encoder])
  brace(9.1, 17.7, 14.65, [Decoder])
  digit(0.5, 9.7)
  content((1.75, 12.85), text(size: 18pt)[$bold(x)$])
  layer(4.1, 8.5, 13.2)
  layer(5.8, 8.5, 13.2)
  content((5.35, 13.65), [$q(bold(z) | bold(x))$])
  layer(8.2, 9.3, 12.2, fill: rgb("c9c9c9"))
  content((8.6, 12.75), [$bold(z) tilde.op q(bold(z))$])
  layer(11.2, 8.5, 13.2)
  layer(12.9, 8.5, 13.2)
  digit(15.1, 9.7)
  for (x0, x1) in ((3, 4.1), (4.9, 5.8), (6.6, 8.2), (9, 11.2), (12, 12.9), (13.7, 15.1)) {
    arrow((x0, 10.85), (x1, 10.85))
  }
  content((20.35, 10.85), text(fill: blue, size: 16pt, weight: "bold")[Input\ reconstruction])

  rect((0, 0), (22.8, 7.7), stroke: 1.2pt + rgb("365b91"))
  rect((0.65, 0.75), (6.0, 6.9), stroke: 2pt + black)
  content((3.32, 6.05), text(fill: red, size: 17pt)[Draw samples\ from $p(z)$])

  // Project a small analytic Gaussian mesh onto the sample panel.
  let project(u, v) = {
    let z = calc.exp(-2.7 * (u * u + v * v))
    (3.3 + 1.75 * u + 0.65 * v, 2.2 - 0.48 * u + 0.8 * v + 2.15 * z)
  }
  let heat(u, v) = {
    let z = calc.exp(-2.7 * (u * u + v * v))
    if z < 0.25 { rgb(0%, z * 400%, 100%) }
    else if z < 0.65 { rgb((z - 0.25) * 250%, 100%, (1 - (z - 0.25) * 2.5) * 100%) }
    else { rgb(100%, (1 - z) / 0.35 * 100%, 0%) }
  }
  for j in range(20) {
    for i in range(20) {
      let u = -1 + i / 10
      let v = 1 - j / 10
      line(project(u, v), project(u + 0.1, v), project(u + 0.1, v - 0.1), project(u, v - 0.1),
        close: true, fill: heat(u + 0.05, v - 0.05), stroke: none)
    }
  }

  rect((7.7, 3.1), (9.5, 4.25), stroke: 1.2pt + black)
  content((8.6, 3.68), text(fill: red, size: 18pt)[Input])
  arrow((8.6, 9.3), (8.6, 4.25))
  content((8.04, 6.8), text(size: 20pt)[−])
  arrow((6, 3.68), (7.7, 3.68))
  content((6.65, 4.2), text(size: 20pt)[+])
  layer(11.2, 0.6, 7.05)
  layer(12.9, 0.6, 7.05)
  arrow((9.5, 3.68), (11.2, 3.68))
  arrow((12, 3.68), (12.9, 3.68))
  arrow((13.7, 3.68), (14.65, 3.68))
  circle((15.5, 3.68), radius: 0.85, stroke: 0.9pt + black)
  line((14.94, 3.25), (16.05, 3.25), stroke: 0.65pt + black)
  line((15.5, 3.14), (15.5, 4.18), stroke: 0.65pt + black)
  let curve = ()
  for i in range(31) {
    let x = -0.55 + i * 1.1 / 30
    curve.push((15.5 + x, 3.25 + 0.78 / (1 + calc.exp(-9 * x))))
  }
  line(..curve, stroke: 1pt + black)
  content((19.3, 1.4), text(fill: red, size: 14pt)[
    Adversarial cost for\
    distinguishing positive samples\
    $p(z)$ from negative samples $q(z)$
  ])
})
