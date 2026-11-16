#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Schematic of the proposed system for the testing of rechargeable batteries
// 来源：Energies 2025, 18(9), 2304, Figure 4；DOI 10.3390/en18092304
// 结构：电池测试台架框图。Sorensen DLM 20-30 电源（含电压/电流传感器）经开关接锂电池支路，
// 电池下方为 Thermocouple K；SDAYC 控制单元经双向链路连电池、电源与 BK Precision 8614 负载。
// 左列为 HMI 与 Data register，顶部路由器以 Ethernet 连接，底部两条 USB 总线连 PC 与仪器。
// 虚线箭头为监测/控制信号：路由器→SDAYC、SDAYC→电源/负载、热电偶→NI USB-6281。

#canvas({
  import draw: *
  let st = 1pt + black
  let th = 0.7pt + black
  let box(x0, y0, x1, y1) = draw.rect((x0, y0), (x1, y1), stroke: st)
  let sig(a, b) = draw.line(a, b, stroke: (paint: black, thickness: 0.8pt, dash: "dashed"),
    mark: (end: "stealth", fill: black, scale: 0.3))
  let sw(x, y) = {
    draw.circle((x, y + 0.14), radius: 0.05, stroke: st)
    draw.circle((x, y - 0.14), radius: 0.05, stroke: st)
    draw.line((x, y + 0.14), (x + 0.24, y + 0.36), stroke: st)
  }
  let cyl(cx, cy, rx, ry, h) = {
    let el(cy) = range(25).map(k => {
      let a = k / 24 * 2 * calc.pi
      (cx + rx * calc.cos(a), cy + ry * calc.sin(a))
    })
    draw.line(..el(cy), close: true, stroke: st)
    draw.line((cx - rx, cy), (cx - rx, cy - h), stroke: st)
    draw.line((cx + rx, cy), (cx + rx, cy - h), stroke: st)
    draw.line(..el(cy - h).slice(13, 25), stroke: st)
  }

  // 电源与电池支路
  box(6.35, 6.75, 9.25, 8.12)
  content((7.8, 7.92), text(size: 8pt)[Sorensen DLM 20-30])
  box(6.65, 7.3, 8.95, 7.68)
  content((7.8, 7.49), text(size: 8.5pt)[Voltage sensor])
  box(6.65, 6.93, 8.95, 7.26)
  content((7.8, 7.1), text(size: 8.5pt)[Current sensor])
  draw.line((7.8, 6.75), (7.8, 5.95), stroke: st)
  sw(7.8, 5.75)
  draw.line((7.8, 5.52), (7.8, 5.3), stroke: st)
  draw.line((6.3, 5.3), (9.25, 5.3), stroke: st)
  draw.line((6.3, 5.3), (6.3, 3.0), stroke: st)
  draw.line((9.25, 5.3), (9.25, 3.0), stroke: st)
  draw.line((6.3, 3.0), (7.55, 3.0), stroke: st)
  draw.line((8.05, 3.0), (9.25, 3.0), stroke: st)
  sw(7.8, 2.78)
  draw.line((6.3, 4.55), (6.8, 4.55), stroke: st)
  draw.line((8.82, 4.55), (9.25, 4.55), stroke: st)
  draw.circle((6.3, 4.55), radius: 0.06, fill: black, stroke: none)
  draw.circle((9.25, 4.55), radius: 0.06, fill: black, stroke: none)
  draw.rect((6.8, 4.3), (8.82, 4.8), radius: 0.18, stroke: st)
  content((7.81, 4.55), text(size: 8.5pt)[Lithium battery])
  draw.rect((7.4, 4.14), (8.2, 4.27), stroke: st)
  content((7.81, 3.95), text(size: 8.5pt)[Thermocouple K])
  sig((8.25, 3.9), (9.7, 4.4))

  // SDAYC 与电池双向链路
  box(4.05, 4.33, 5.35, 4.78)
  content((4.7, 4.55), text(size: 8.5pt)[SDAYC])
  draw.line((5.4, 4.62), (6.25, 4.62), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  draw.line((6.25, 4.48), (5.4, 4.48), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  sig((4.7, 4.78), (6.5, 6.7))
  sig((4.7, 4.33), (7.1, 1.62))

  // 负载
  box(7.0, 0.42, 9.5, 1.62)
  content((8.25, 1.3), text(size: 8.5pt)[BK Precision 8614])
  box(7.15, 0.58, 9.35, 0.98)
  content((8.25, 0.78), text(size: 7pt)[Current sensor])
  draw.line((7.8, 2.5), (7.8, 1.62), stroke: st)

  // NI 数据采集
  box(9.7, 4.3, 11.9, 4.95)
  content((10.8, 4.62), text(size: 8.5pt)[NI USB-6281])

  // HMI、数据寄存器与工控机
  draw.rect((0.6, 4.45), (2.0, 5.35), stroke: st)
  content((1.3, 4.9), text(size: 10pt)[HMI])
  draw.line((1.3, 4.45), (1.3, 4.2), stroke: st)
  draw.line((1.05, 4.2), (1.55, 4.2), stroke: th)
  draw.line((1.2, 4.2), (1.2, 4.0), stroke: th)
  draw.line((1.4, 4.2), (1.4, 4.0), stroke: th)
  draw.line((1.3, 4.0), (1.3, 3.95), stroke: th,
    mark: (end: "stealth", fill: black, scale: 0.3))
  cyl(1.3, 3.85, 0.5, 0.12, 0.55)
  content((1.3, 2.92), text(size: 9pt)[Data register])
  draw.rect((2.1, 3.9), (2.6, 5.13), stroke: st)
  draw.line((2.15, 4.9), (2.55, 4.9), stroke: th)
  draw.line((2.15, 4.78), (2.55, 4.78), stroke: th)
  draw.line((2.6, 4.62), (4.05, 4.62), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  draw.line((4.05, 4.46), (2.6, 4.46), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))

  // 路由器与 Ethernet
  draw.rect((4.2, 7.25), (5.3, 7.6), radius: 0.15, stroke: st)
  for k in range(3) {
    draw.circle((4.45 + k * 0.3, 7.38), radius: 0.04, stroke: th)
  }
  draw.line((4.75, 7.6), (4.75, 7.85), stroke: th)
  draw.line((4.68, 7.85), (4.82, 7.85), stroke: th)
  draw.line((2.35, 7.42), (4.2, 7.42), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  draw.line((2.35, 7.42), (2.35, 5.13), stroke: st)
  draw.line((5.3, 7.42), (6.35, 7.42), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  content((3.2, 7.62), text(size: 9pt)[Ethernet])
  content((5.65, 7.80), text(size: 8.5pt)[Ethernet])
  sig((4.75, 7.25), (4.72, 4.78))

  // 底部 USB 总线
  draw.line((2.25, 3.9), (2.25, 1.35), (7.0, 1.35), stroke: st)
  draw.line((2.45, 3.9), (2.45, 0.7), (10.8, 0.7), (10.8, 4.3), stroke: st)
  content((4.4, 1.48), text(size: 9pt)[USB])
  content((5.5, 0.83), text(size: 9pt)[USB])
})
