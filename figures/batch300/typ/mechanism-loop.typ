#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：腿轮机器人单环闭链腿机构运动简图（Mechanism loop）
// 来源：Electronics 2026, 15, 3747, Figure 2；DOI: 10.3390/electronics15163747
// 结构：铰点 A/B/C/D/P，六杆 A-C、A-B、C-D、B-D、C-P、D-P
// 红虚线闭链环 Loop1（A-B-D-C-A）；D 处 X-Y 坐标系；P 为轮心
// 角度：theta_1(D)、theta_2(C)、theta_3(A)、theta_4(B)、theta_5(P)
// 轮圈、红色虚线 Loop1 与红色运动箭头为主要视觉元素

#canvas({
  import draw: *
  let red = rgb("#e60000")
  let A = (4.30, 11.30)
  let B = (8.65, 10.00)
  let C = (4.95, 6.70)
  let D = (6.70, 6.55)
  let P = (3.35, 2.30)
  let polar(c, r, a) = (c.at(0) + r * calc.cos(a * 1deg), c.at(1) + r * calc.sin(a * 1deg))
  let arcpts(c, r, a1, a2) = {
    let n = 18
    let pts = ()
    for i in range(n + 1) { pts.push(polar(c, r, a1 + (a2 - a1) * i / n)) }
    pts
  }
  let aarc(c, r, a1, a2) = line(..arcpts(c, r, a1, a2),
    stroke: (paint: black, thickness: 0.7pt),
    mark: (end: "stealth", fill: black, scale: 0.45))
  let lab(pos, body, anc: "center") = content(pos, body, anchor: anc)

  circle(P, radius: 2.90, stroke: 1.2pt + black)

  let cen = (6.15, 8.64)
  let inset(p) = {
    let v = (cen.at(0) - p.at(0), cen.at(1) - p.at(1))
    let n = calc.sqrt(v.at(0) * v.at(0) + v.at(1) * v.at(1))
    (p.at(0) + 0.12 * v.at(0) / n, p.at(1) + 0.12 * v.at(1) / n)
  }
  line(inset(A), inset(B), inset(D), inset(C), close: true,
    stroke: (paint: red, thickness: 0.9pt, dash: "dashed"))

  for (p, q) in ((A, C), (A, B), (C, D), (B, D), (C, P), (D, P)) {
    line(p, q, stroke: 1.1pt + black)
  }
  for (p, rad) in ((A, 0.24), (B, 0.22), (C, 0.13), (D, 0.16), (P, 0.13)) {
    circle(p, radius: rad, stroke: 1pt + black, fill: white)
  }
  circle(D, radius: 0.055, fill: black)
  circle(P, radius: 0.055, fill: black)

  line(A, (4.30, 11.80), stroke: 0.7pt + black)
  line(B, (9.75, 10.10), stroke: 0.7pt + black)
  line(P, (4.55, 2.30), stroke: 0.7pt + black)
  line(D, (7.95, 6.55), stroke: 0.9pt + black, mark: (end: "stealth", fill: black, scale: 0.45))
  line(D, (6.70, 7.85), stroke: 0.9pt + black, mark: (end: "stealth", fill: black, scale: 0.45))

  aarc(D, 1.00, 360, 183.4)
  aarc(C, 0.90, 356.6, 101.9)
  aarc(A, 0.62, -16.6, 90)
  aarc(B, 0.95, 160.5, 240.5)
  aarc(P, 1.05, 0, 68)

  line((5.95, 3.95), (9.90, 3.95), stroke: (paint: red, thickness: 2pt),
    mark: (end: "stealth", fill: red, scale: 0.5))

  lab((3.70, 11.15), [$A$], anc: "east")
  lab((3.55, 11.90), [$theta_3$], anc: "east")
  lab((4.00, 8.90), [$r_2$], anc: "east")
  lab((4.50, 6.55), [$C$], anc: "east")
  lab((5.48, 5.55), [$r_1$])
  lab((5.75, 7.55), [$theta_2$])
  lab((8.90, 9.55), [$B$], anc: "north")
  lab((9.15, 10.55), [$theta_4$])
  lab((6.40, 11.10), [$r_3$])
  lab((8.15, 8.15), [$r_4$], anc: "west")
  lab((6.48, 5.85), [$D$])
  lab((7.85, 6.10), [$theta_1$])
  lab((8.30, 6.55), [$X$], anc: "west")
  lab((6.70, 7.95), [$Y$], anc: "south")
  lab((3.55, 4.55), [$r_5$], anc: "east")
  lab((5.95, 4.35), [$r_6$])
  lab((2.55, 2.30), [$P$], anc: "east")
  lab((4.70, 2.40), [$theta_5$])
  content((5.95, 8.85), text(fill: red, size: 11pt, "Loop1"), anchor: "center", angle: -75deg)
})
