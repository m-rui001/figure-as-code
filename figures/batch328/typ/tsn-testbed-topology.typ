#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Network topology of the physical testbed（物理测试床网络拓扑）
// 来源：Future Internet 2026, 18, 297, Figure 9；DOI: 10.3390/fi18060297
// 结构：四台 TSN 交换机 SW1–SW4 组成方环；四角外接 ZCU 控制板，四端接 Camera 相机；
// 中心挂 VCP 控制器、Diagnostic Device 与 Host Computer。
// 图例：黑色 1000Base-T1、黄色 1000Base-Tx、绿色 100Base-T1。

#canvas({
  import draw: *
  let black = rgb("#222222")
  let green = rgb("#2f8a3c")
  let yellow = rgb("#d8a800")
  let swf = rgb("#3f74c8")
  let sw(cx, cy) = {
    draw.line((cx - 0.78, cy), (cx - 0.52, cy + 0.30), (cx + 0.78, cy + 0.30),
      (cx + 0.52, cy), close: true, fill: swf, stroke: 0.9pt + rgb("#1f3864"))
    for i in range(4) {
      draw.rect((cx - 0.44 + i * 0.26, cy - 0.13), (cx - 0.32 + i * 0.26, cy - 0.03),
        fill: rgb("#1f3864"), stroke: none)
    }
  }
  let cam(cx, cy) = {
    draw.circle((cx, cy), radius: 0.17, fill: black, stroke: none)
    draw.line((cx - 0.13, cy - 0.02), (cx + 0.13, cy - 0.02), stroke: 0.8pt + white)
    draw.line((cx, cy - 0.17), (cx, cy - 0.32), stroke: 1.2pt + black)
    draw.line((cx - 0.18, cy - 0.32), (cx + 0.18, cy - 0.32), stroke: 1.2pt + black)
  }
  let zcu(cx, cy) = {
    draw.rect((cx - 0.30, cy - 0.30), (cx + 0.30, cy + 0.30), radius: 0.06,
      fill: rgb("#1a1a1a"), stroke: none)
    content((cx, cy), text(size: 5.8pt, fill: white, weight: "bold")[ZCU])
  }
  let monitor(cx, cy, w, h) = {
    draw.rect((cx - w / 2, cy - h / 2), (cx + w / 2, cy + h / 2), radius: 0.06,
      fill: white, stroke: 1.4pt + black)
    draw.line((cx, cy - h / 2), (cx, cy - h / 2 - 0.18), stroke: 1.4pt + black)
    draw.line((cx - 0.22, cy - h / 2 - 0.18), (cx + 0.22, cy - h / 2 - 0.18),
      stroke: 1.4pt + black)
  }
  let lab(x, y, t) = content((x, y), text(size: 7.5pt)[#t])

  // 交换机
  sw(4.30, 6.50)
  sw(9.50, 6.50)
  sw(4.30, 3.70)
  sw(9.50, 3.70)
  content((4.55, 7.15), text(size: 7.5pt)[TSN Switch-SW2], anchor: "west")
  content((9.75, 7.15), text(size: 7.5pt)[TSN Switch-SW3], anchor: "west")
  content((4.55, 3.05), text(size: 7.5pt)[TSN Switch-SW1], anchor: "west")
  content((9.75, 2.78), text(size: 7.5pt)[TSN Switch-SW4], anchor: "west")

  // 外圈设备
  zcu(1.70, 6.50)
  zcu(12.10, 6.50)
  zcu(1.70, 3.70)
  zcu(12.10, 3.70)
  lab(1.70, 6.02, [ZCU-RF])
  lab(12.10, 6.02, [ZCU-RR])
  lab(1.70, 3.22, [ZCU-LF])
  lab(12.10, 3.22, [ZCU-LR])
  cam(4.30, 8.30)
  cam(9.50, 8.30)
  cam(4.30, 1.90)
  cam(9.50, 1.90)
  content((4.55, 8.30), text(size: 7.5pt)[Camera-RF], anchor: "west")
  content((9.75, 8.30), text(size: 7.5pt)[Camera-RR], anchor: "west")
  content((4.55, 1.90), text(size: 7.5pt)[Camera-LF], anchor: "west")
  content((9.75, 1.90), text(size: 7.5pt)[Camera-LR], anchor: "west")

  // 中心设备
  monitor(6.00, 5.15, 1.55, 1.05)
  draw.rect((5.45, 5.18), (6.15, 5.40), radius: 0.04, fill: white, stroke: 0.7pt + black)
  content((5.80, 5.29), text(size: 5pt)[TSN])
  draw.rect((5.45, 4.86), (6.15, 5.08), radius: 0.04, fill: white, stroke: 0.7pt + black)
  content((5.80, 4.97), text(size: 5pt)[CUC])
  lab(6.00, 4.22, [VCP])
  draw.rect((7.75, 5.15), (8.75, 5.70), radius: 0.05, fill: rgb("#c9c9c9"), stroke: 0.8pt + black)
  draw.rect((7.78, 5.18), (7.92, 5.67), fill: rgb("#b04a4a"), stroke: none)
  lab(7.95, 6.00, [Diagnostic Device])
  monitor(11.60, 5.10, 0.95, 0.75)
  draw.rect((12.18, 4.45), (12.48, 5.15), fill: white, stroke: 1.2pt + black)
  for i in range(3) {
    draw.line((12.23, 4.90 - i * 0.12), (12.43, 4.90 - i * 0.12), stroke: 0.7pt + black)
  }
  lab(11.85, 4.15, [Host Computer])

  // 链路
  draw.line((4.90, 6.50), (8.90, 6.50), stroke: 1.2pt + black)
  draw.line((4.90, 3.70), (8.90, 3.70), stroke: 1.2pt + black)
  draw.line((4.30, 6.10), (4.30, 4.10), stroke: 1.2pt + black)
  draw.line((9.50, 6.10), (9.50, 4.10), stroke: 1.2pt + black)
  draw.line((2.05, 6.50), (3.52, 6.50), stroke: 1.2pt + black)
  draw.line((10.28, 6.50), (11.75, 6.50), stroke: 1.2pt + black)
  draw.line((2.05, 3.70), (3.52, 3.70), stroke: 1.2pt + black)
  draw.line((10.28, 3.70), (11.75, 3.70), stroke: 1.2pt + black)
  draw.line((4.30, 7.98), (4.30, 6.80), stroke: 1.2pt + green)
  draw.line((9.50, 7.98), (9.50, 6.80), stroke: 1.2pt + green)
  draw.line((4.30, 2.22), (4.30, 3.40), stroke: 1.2pt + green)
  draw.line((9.50, 2.22), (9.50, 3.40), stroke: 1.2pt + green)
  draw.line((5.22, 4.90), (4.88, 3.98), stroke: 1.2pt + black)
  draw.line((6.78, 5.30), (7.75, 5.42), stroke: 1.2pt + black)
  draw.line((8.75, 5.32), (9.15, 3.98), stroke: 1.2pt + black)
  draw.line((11.12, 4.78), (9.92, 3.96), stroke: 1.2pt + yellow)

  // 线型图例
  draw.line((0.55, 5.55), (1.30, 5.55), stroke: 1.2pt + black)
  content((1.38, 5.55), text(size: 6.5pt)[1000Base-T1], anchor: "west")
  draw.line((0.55, 5.15), (1.30, 5.15), stroke: 1.2pt + yellow)
  content((1.38, 5.15), text(size: 6.5pt)[1000Base-Tx], anchor: "west")
  draw.line((0.55, 4.75), (1.30, 4.75), stroke: 1.2pt + green)
  content((1.38, 4.75), text(size: 6.5pt)[100Base-T1], anchor: "west")
})
