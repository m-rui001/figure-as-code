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

  let blue = rgb("#2828ff")
  let green = rgb("#e1ecb4")
  let lab(x, y, label) = { content((x, y), text(fill: blue)[#label]) }
  let pair(x, y, time, laplace) = {
    lab(x, y + 0.42, time)
    content((x, y - 0.43), laplace)
  }
  let block(x, y, label) = {
    rect((x - 0.95, y - 0.64), (x + 0.95, y + 0.64), fill: green, stroke: ink)
    lab(x, y, label)
  }
  rect((2.65, 0.10), (11.55, 5.85),
    stroke: (paint: blue, thickness: 0.9pt, dash: "dotted"))
  lab(7.10, 6.18, [$italic("PID") quad G(s)$])
  node(1.60, 3.25, [+])
  content((1.26, 2.64), text(size: 16pt)[-])
  node(3.50, 3.25, [X])
  node(5.70, 3.25, [X])
  node(5.70, 1.10, [X])
  node(10.50, 3.25, [+])
  wire((0.25, 3.25), (1.22, 3.25))
  wire((1.98, 3.25), (3.12, 3.25))
  wire((3.50, 4.30), (3.50, 3.63))
  lab(3.50, 4.57, [$k_c$])
  wire((3.88, 3.25), (5.32, 3.25))
  dot(4.20, 3.25)
  wire((4.20, 3.25), (4.20, 5.00), (10.50, 5.00), (10.50, 3.63))
  pair(9.75, 5.00, [$u_"p" (t)$], [$U_"p" (s)$])
  wire((5.70, 4.27), (5.70, 3.63))
  lab(5.70, 4.55, [$T_d$])
  block(8.05, 3.25, [$upright("d") e(t) "/" upright("d") t$])
  wire((6.08, 3.25), (7.10, 3.25))
  wire((9.00, 3.25), (10.12, 3.25))
  pair(9.58, 3.25, [$u_"d" (t)$], [$U_"d" (s)$])
  wire((4.20, 3.25), (4.20, 1.10), (5.32, 1.10))
  wire((5.70, 2.16), (5.70, 1.48))
  lab(5.70, 2.42, [$1 / T_i$])
  block(8.05, 1.10, [$integral e(t) "d" t$])
  wire((6.08, 1.10), (7.10, 1.10))
  wire((9.00, 1.10), (10.50, 1.10), (10.50, 2.87))
  pair(9.70, 1.10, [$u_"i" (t)$], [$U_"i" (s)$])
  block(13.00, 3.25, [Plant\ $H(s)$])
  wire((10.88, 3.25), (12.05, 3.25))
  pair(11.22, 3.25, [$u(t)$], [$U(s)$])
  draw.line((13.95, 3.25), (14.45, 3.25), (14.45, -0.30), (1.60, -0.30),
    stroke: 0.9pt + rgb("#7030a0"))
  wire((1.60, -0.30), (1.60, 2.87))
  pair(0.46, 3.25, [$x(t)$], [$X(s)$])
  pair(2.34, 3.25, [$e(t)$], [$E(s)$])
  pair(14.85, 2.88, [$y(t)$], [$Y(s)$])
  pair(1.00, 1.95, [$y(t)$], [$Y(s)$])
})
