#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Hydraulic layout of the system（试验台液压系统原理图）
// 来源：Technologies 2025, 13(6), 236, Figure 2；DOI 10.3390/technologies13060236
// 结构：左下 M 电机经联轴节驱动 P 液压泵；泵出口向上，经 DH 三位四通阀旁通回油箱 T，
// 主管经 Tq 流量计与 Tp 压力传感器汇入顶部横管；横管左端为热负载 C 与可调节流阀 RH1，
// 右端为压力开关 Ssig 与油箱 T；底部为泵吸油油箱。
// 所有字母标签逐字保留：C、RH1、Ssig、Tq、Tp、P、DH、M、P、T。

#canvas({
  import draw: *
  let st = 1pt + black
  let th = 0.7pt + black

  let tank(x, y, w, d) = {
    draw.line((x, y), (x, y - d), (x + w, y - d), (x + w, y), stroke: st)
  }

  let arcp(c, r, a0, a1, n: 20) = range(n + 1).map(k => {
    let a = (a0 + (a1 - a0) * k / n) * calc.pi / 180
    (c.at(0) + r * calc.cos(a), c.at(1) + r * calc.sin(a))
  })

  // 顶部横管与左右油箱
  draw.line((1.85, 11.15), (10.45, 11.15), stroke: st)
  draw.line((10.2, 11.15), (10.2, 10.0), stroke: st)
  tank(1.45, 9.35, 1.25, 0.62)
  draw.line((1.28, 10.6), (1.28, 9.35), stroke: st)
  content((2.85, 9.45), [T])
  tank(8.95, 10.0, 1.25, 0.62)
  content((10.35, 10.12), [T])

  // C 热负载
  draw.rect((0.55, 10.55), (1.85, 11.7), stroke: st)
  content((1.2, 11.12), [C])
  draw.line((1.28, 10.55), (1.28, 9.35), stroke: th)

  // RH1 可调节流阀（标签避让斜箭头）
  draw.line(..arcp((3.0, 11.15), 0.28, 100, 260), stroke: st)
  draw.line(..arcp((3.55, 11.15), 0.28, -80, 80), stroke: st)
  draw.line((2.75, 11.55), (3.85, 12.05), stroke: th,
    mark: (end: "stealth", fill: black, scale: 0.32))
  content((2.55, 12.05), [RH1])

  // Ssig 压力开关
  draw.rect((7.25, 10.82), (8.6, 11.5), stroke: st)
  draw.line((7.4, 11.12), (8.35, 11.12), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  draw.line((7.1, 10.65), (7.9, 10.5), (8.4, 10.78), (7.6, 10.93), close: true,
    stroke: (paint: black, thickness: 0.7pt, dash: "dashed"))
  content((7.95, 11.82), [Ssig])

  // 主管竖段与 Tq/Tp
  draw.line((5.6, 11.15), (5.6, 2.55), stroke: st)
  draw.circle((5.6, 9.55), radius: 0.55, stroke: st)
  draw.line(..arcp((5.6, 9.62), 0.26, 0, 180), stroke: st)
  draw.line(..arcp((5.6, 9.48), 0.26, 180, 360), stroke: st)
  content((4.5, 9.95), [Tq])
  draw.rect((3.45, 7.35), (4.75, 8.55), stroke: st)
  draw.line((3.45, 8.55), (4.75, 7.35), stroke: th)
  content((4.3, 7.6), [P])
  draw.line((4.75, 8.15), (5.6, 8.15), stroke: st)
  content((3.55, 8.78), [Tp])

  // DH 三位四通阀
  draw.rect((4.35, 5.35), (6.45, 6.05), stroke: st)
  draw.line((4.9, 5.35), (4.9, 6.05), stroke: st)
  draw.line((5.65, 5.35), (5.65, 6.05), stroke: st)
  draw.line((4.55, 5.5), (4.55, 5.9), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  draw.line((4.78, 5.9), (4.78, 5.5), stroke: st,
    mark: (end: "stealth", fill: black, scale: 0.3))
  draw.line((5.75, 5.55), (5.75, 5.9), (6.0, 5.9), stroke: th)
  draw.line((5.95, 5.4), (5.95, 5.7), (6.2, 5.7), stroke: th)
  draw.line((3.5, 5.55), (4.35, 5.78), stroke: st)
  draw.line((3.5, 5.55), (3.5, 5.35), stroke: st)
  content((3.12, 5.7), [DH])
  draw.line((6.45, 5.7), (6.55, 5.5), (6.68, 5.9), (6.81, 5.5), (6.94, 5.9),
    (7.07, 5.5), (7.15, 5.7), stroke: th)

  // 泵与旁通
  draw.circle((5.6, 2.0), radius: 0.55, stroke: st)
  draw.line((5.6, 2.38), (5.33, 1.92), (5.87, 1.92), close: true, fill: black, stroke: none)
  content((5.6, 1.72), [P])
  draw.line(..arcp((5.6, 2.0), 0.72, -80, 35), stroke: th,
    mark: (end: "stealth", fill: black, scale: 0.3))
  draw.line((5.6, 4.5), (7.05, 4.5), (7.05, 1.25), stroke: st)
  draw.line((5.6, 1.45), (5.6, 1.15), stroke: st)
  tank(5.0, 1.25, 2.4, 0.55)
  content((7.9, 1.45), [T])

  // M 电机与联轴节
  draw.circle((1.55, 2.0), radius: 0.55, stroke: st)
  content((1.55, 2.0), [M])
  draw.line((2.1, 2.0), (3.05, 2.0), stroke: th)
  draw.line((2.55, 1.78), (2.55, 2.22), stroke: 2.2pt + black)
  draw.line((2.9, 1.78), (2.9, 2.22), stroke: 2.2pt + black)
  draw.line((3.05, 2.0), (5.05, 2.0), stroke: st)
})
