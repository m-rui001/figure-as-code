#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#let rtxt(t) = rotate(90deg, t, reflow: true)

// 图名：The DDS over TSN architecture based on centralized network management
// 来源：Future Internet 2026, 18, 297, Figure 2；DOI: 10.3390/fi18060297
// 结构：三层——Application Plane 是 DDS 应用与主题云，Control Plane 是 TSN Controller（CUC 经 UNI 接 CNC），
// Data Plane 是五台 TSN 交换机组成的网状拓扑。绿色竖线传送 DDS Messages，黄线为 DDS Centralized Discovery，
// CNC 用 NETCONF 协议（红虚线）配置各交换机。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.45)
  let ar2 = (start: "stealth", end: "stealth", fill: black, scale: 0.45)
  let garg = (end: "stealth", fill: rgb("#1f8a45"), scale: 0.45)
  let garg2 = (start: "stealth", end: "stealth", fill: rgb("#1f8a45"), scale: 0.45)
  let yarg2 = (start: "stealth", end: "stealth", fill: rgb("#c99a12"), scale: 0.45)
  let rarg = (end: "stealth", fill: rgb("#d03030"), scale: 0.4)
  let st = 1.4pt + black
  let cloud(cx, cy, rx, ry, fill, sc) = {
    let pts = range(90).map(i => {
      let a = i * 4deg
      let f = 1 + 0.09 * calc.sin(9 * a)
      (cx + rx * f * calc.cos(a), cy + ry * f * calc.sin(a))
    })
    draw.line(..pts, close: true, fill: fill, stroke: 1.2pt + sc)
  }
  let sw(cx, cy) = {
    draw.rect((cx - 0.58, cy - 0.47), (cx + 0.58, cy + 0.47), radius: 0.12,
      fill: white, stroke: 1.3pt + black)
    draw.line((cx - 0.30, cy + 0.22), (cx + 0.18, cy - 0.16), stroke: 0.9pt + black,
      mark: (end: "stealth", fill: black, scale: 0.3))
    draw.line((cx + 0.30, cy + 0.22), (cx - 0.18, cy - 0.16), stroke: 0.9pt + black,
      mark: (end: "stealth", fill: black, scale: 0.3))
    for i in range(5) {
      draw.rect((cx - 0.36 + i * 0.15, cy - 0.36), (cx - 0.28 + i * 0.15, cy - 0.28),
        fill: black, stroke: none)
    }
  }

  // Application Plane
  draw.rect((0.60, 11.55), (12.75, 15.40), radius: 0.55, stroke: st)
  draw.line((1.40, 11.55), (1.40, 15.40), stroke: 0.9pt + black)
  content((0.88, 13.45), rtxt(text(size: 8.5pt, weight: "bold")[Application]))
  content((1.20, 13.45), rtxt(text(size: 8.5pt, weight: "bold")[Plane]))
  for k in (0.34, 0.17) {
    draw.rect((5.30 + k, 13.78 + k), (9.00 + k, 14.72 + k), radius: 0.18,
      fill: rgb("#f2a0a0"), stroke: 1.1pt + rgb("#a94442"))
  }
  draw.rect((5.30, 13.78), (9.00, 14.72), radius: 0.18,
    fill: rgb("#f2a0a0"), stroke: 1.1pt + rgb("#a94442"))
  content((7.15, 14.25), text(size: 9pt, weight: "bold")[DDS Applications])
  cloud(3.00, 12.70, 1.40, 0.50, rgb("#d9f2e6"), rgb("#1f8a45"))
  content((3.00, 12.82), text(size: 8pt, weight: "bold")[DDS user-defined])
  content((3.00, 12.50), text(size: 8pt, weight: "bold")[topics])
  cloud(7.05, 12.82, 1.45, 0.44, rgb("#fbe7bf"), rgb("#c99a12"))
  content((7.05, 12.94), text(size: 8pt, weight: "bold")[DDS built-in])
  content((7.05, 12.62), text(size: 8pt, weight: "bold")[topics])
  cloud(10.35, 12.70, 1.55, 0.50, rgb("#d9f2e6"), rgb("#1f8a45"))
  content((10.35, 12.82), text(size: 8pt, weight: "bold")[DDS user-defined])
  content((10.35, 12.50), text(size: 8pt, weight: "bold")[topics])
  draw.line((5.55, 13.80), (3.95, 13.22), stroke: 1.1pt + rgb("#1f8a45"), mark: garg2)
  draw.line((8.75, 13.80), (9.35, 13.22), stroke: 1.1pt + rgb("#1f8a45"), mark: garg2)
  draw.line((7.10, 13.80), (7.05, 13.28), stroke: 1.1pt + rgb("#c99a12"), mark: yarg2)

  // Control Plane
  draw.rect((3.65, 8.05), (8.85, 11.05), radius: 0.50, stroke: st)
  draw.line((4.45, 8.05), (4.45, 11.05), stroke: 0.9pt + black)
  content((4.05, 9.55), rtxt(text(size: 9pt, weight: "bold")[Control Plane]))
  content((5.25, 9.78), text(size: 8.5pt, weight: "bold")[TSN])
  content((5.25, 9.44), text(size: 8.5pt, weight: "bold")[Controller])
  draw.rect((5.95, 9.90), (7.15, 10.70), radius: 0.10, fill: white, stroke: 1.1pt + black)
  draw.circle((6.32, 10.42), radius: 0.10, stroke: 0.8pt + black)
  draw.circle((6.58, 10.18), radius: 0.10, stroke: 0.8pt + black)
  draw.line((6.40, 10.34), (6.50, 10.26), stroke: 1.1pt + black)
  draw.line((6.10, 10.02), (7.00, 10.02), stroke: 1.2pt + black)
  content((7.65, 10.30), text(size: 8.5pt, weight: "bold")[CUC])
  draw.rect((6.30, 8.35), (7.45, 9.20), radius: 0.10, fill: white, stroke: 1.1pt + black)
  for i in range(3) {
    draw.rect((6.42, 8.90 - i * 0.16), (7.02, 8.98 - i * 0.16), radius: 0.03,
      stroke: 0.7pt + black)
  }
  draw.circle((6.95, 8.62), radius: 0.13, stroke: 1pt + black)
  for i in range(8) {
    let a = i * 45deg
    draw.line((6.95 + 0.16 * calc.cos(a), 8.62 + 0.16 * calc.sin(a)),
      (6.95 + 0.23 * calc.cos(a), 8.62 + 0.23 * calc.sin(a)), stroke: 0.8pt + black)
  }
  content((7.95, 8.75), text(size: 8.5pt, weight: "bold")[CNC])
  draw.line((6.70, 9.20), (6.70, 9.90), stroke: 1pt + black, mark: ar2)
  content((6.92, 9.55), text(size: 8pt)[UNI])

  // Data Plane
  draw.rect((0.60, 0.55), (12.75, 6.85), radius: 0.50, stroke: st)
  draw.line((1.45, 0.55), (1.45, 6.85), stroke: 0.9pt + black)
  content((1.03, 3.70), rtxt(text(size: 9pt, weight: "bold")[Data Plane]))
  content((2.55, 1.00), text(size: 8.5pt, weight: "bold")[TSN Switches])
  let s1 = (2.95, 5.65)
  let s2 = (6.70, 5.30)
  let s3 = (5.20, 2.50)
  let s4 = (8.30, 2.50)
  let s5 = (10.40, 5.45)
  for (a, b) in ((s1, s2), (s2, s5), (s1, s3), (s3, s4), (s4, s5), (s2, s3)) {
    draw.line(a, b, stroke: 0.7pt + black)
  }
  for c in (s1, s2, s3, s4, s5) { sw(c.at(0), c.at(1)) }

  // 跨层连线：DDS 消息、集中发现、NETCONF
  draw.line((2.75, 12.18), (2.95, 6.12), stroke: 1.1pt + rgb("#1f8a45"), mark: garg)
  draw.line((10.35, 12.18), (10.40, 5.92), stroke: 1.1pt + rgb("#1f8a45"), mark: garg)
  content((2.30, 8.90), rtxt(text(size: 8.5pt, weight: "bold")[DDS Messages]))
  content((11.30, 8.60), rtxt(text(size: 8.5pt, weight: "bold")[DDS Messages]))
  draw.line((7.05, 12.36), (7.05, 10.70), stroke: 1.1pt + rgb("#c99a12"), mark: ar)
  content((7.45, 11.30), text(size: 6pt, weight: "bold")[DDS Centralized Discovery], anchor: "west")
  for c in (s1, s2, s3, s4, s5) {
    draw.line((6.42, 8.35), (c.at(0), c.at(1) + 0.47),
      stroke: (paint: rgb("#d03030"), thickness: 0.9pt, dash: "dashed"), mark: rarg)
  }
  content((9.30, 7.55), text(size: 8.5pt, weight: "bold")[NETCONF])
  content((9.30, 7.22), text(size: 8.5pt, weight: "bold")[Protocol])
})
