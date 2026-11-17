#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)

// Source: Sozanski, Electronics 2023, 12(15), 3235, doi:10.3390/electronics12153235.
#canvas({
  import draw: *
  let ink = 0.9pt + black
  let ar = (end: "stealth", fill: black, scale: 0.4)
  let wire(..points) = { draw.line(..points, stroke: ink, mark: ar) }
  let node(x, y, label) = {
    circle((x, y), radius: 0.38, fill: white, stroke: ink)
    content((x, y), text(size: 16pt)[#label])
  }
  let dot(x, y) = { circle((x, y), radius: 0.065, fill: black, stroke: none) }

  // The source labels each delay block T_s; preserve that label literally.
  let delay(x, y) = {
    rect((x - 0.62, y - 0.62), (x + 0.62, y + 0.62),
      fill: rgb("#fbdac8"), stroke: ink)
    content((x, y), text(size: 17pt)[$T_s$])
  }
  let lab(x, y, label) = { content((x, y), label) }
  node(1.60, 3.40, [+])
  lab(1.25, 2.80, text(size: 16pt)[-])
  wire((0.10, 3.40), (1.22, 3.40))
  lab(0.30, 3.82, [$x(n)$])
  wire((1.60, 1.90), (1.60, 3.02))
  lab(1.60, 1.60, [$y(n)$])
  wire((1.98, 3.40), (3.72, 3.40))
  lab(2.27, 3.93, [$e(n)$])
  dot(2.80, 3.40)
  node(4.10, 5.80, [X])
  node(4.10, 3.40, [X])
  node(6.25, 3.40, [X])
  node(4.10, 1.00, [X])
  node(5.45, 1.00, [X])
  wire((2.80, 3.40), (2.80, 5.80), (3.72, 5.80))
  wire((4.10, 6.90), (4.10, 6.18))
  lab(4.10, 7.18, [$k_c$])
  wire((4.10, 4.50), (4.10, 3.78))
  lab(4.10, 4.78, [$k_c$])
  wire((4.48, 3.40), (5.87, 3.40))
  wire((6.25, 4.50), (6.25, 3.78))
  lab(6.25, 4.80, [$T_d / T_s$])
  wire((2.80, 3.40), (2.80, 1.00), (3.72, 1.00))
  wire((4.10, 2.10), (4.10, 1.38))
  lab(4.10, 2.38, [$k_c$])
  wire((4.48, 1.00), (5.07, 1.00))
  wire((5.45, 2.10), (5.45, 1.38))
  lab(5.65, 2.38, [$T_s / (2 T_i)$])
  node(10.90, 4.45, [+])
  node(12.85, 4.45, [+])
  wire((4.48, 5.80), (12.85, 5.80), (12.85, 4.83))
  lab(12.30, 6.13, [$u_"P" (n)$])
  wire((6.63, 3.40), (8.03, 3.40))
  dot(7.20, 3.40)
  wire((7.20, 3.40), (7.20, 4.45), (10.52, 4.45))
  delay(8.65, 3.40)
  wire((9.27, 3.40), (10.20, 3.40), (10.63, 4.18))
  lab(10.17, 3.93, text(size: 16pt)[-])
  wire((11.28, 4.45), (12.47, 4.45))
  lab(11.84, 4.84, [$u_"d" (n)$])
  wire((13.23, 4.45), (14.15, 4.45))
  lab(13.80, 4.84, [$u(n)$])
  wire((5.83, 1.00), (8.77, 1.00))
  dot(6.12, 1.00)
  node(9.15, 1.00, [+])
  draw.line((9.53, 1.00), (12.85, 1.00), stroke: ink)
  dot(12.85, 1.00)
  wire((12.85, 1.00), (12.85, 4.07))
  lab(13.55, 1.00, [$u_"i" (n)$])
  delay(7.35, -0.90)
  wire((6.12, 1.00), (6.12, -0.90), (6.73, -0.90))
  wire((7.97, -0.90), (8.74, -0.90), (8.97, 0.67))
  delay(10.95, -0.90)
  wire((12.85, 1.00), (12.85, -0.90), (11.57, -0.90))
  wire((10.33, -0.90), (9.58, -0.90), (9.33, 0.67))
  lab(9.15, -1.40, [$u_"i" (n - 1)$])
  for x in (0.50, 13.90) {
    draw.line((x, 6.40), (x, 5.50), stroke: 0.9pt + red,
      mark: (end: "stealth", fill: red, scale: 0.4))
    content((x, 6.77), text(fill: red)[$f_s$])
  }
})
