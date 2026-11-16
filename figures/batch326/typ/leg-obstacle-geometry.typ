#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Obstacle negotiation analysis in leg mode（腿模式越障几何分析）
// 来源：Electronics 2026, 15, 3747, Figure 7；DOI: 10.3390/electronics15163747
// 结构：驱动轮圆在台阶左侧，红标注 h 为台阶高度；右侧点线圆为障碍轮廓，
// 上方实线三角与点线虚影为腿部连杆的两个位姿，$phi$ 为摆角；黑色曲线为足端行走轨迹，
// 红色 H_max 为轨迹峰顶高出障碍顶面的高度，h = H_max 为最大越障高度判据。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.45)
  let tar = (start: "stealth", end: "stealth", fill: black, scale: 0.4)
  let red = rgb("#d03030")
  let tdash = (paint: black, thickness: 1.1pt, dash: "densely-dotted")
  let thin = 1pt + black

  // 地面与台阶
  draw.rect((0.35, 0.55), (8.15, 0.78), fill: rgb("#9a9a9a"), stroke: none)
  draw.line((0.35, 0.78), (8.15, 0.78), stroke: thin)
  draw.line((2.86, 0.78), (2.86, 2.06), stroke: thin)
  draw.line((2.12, 2.06), (2.86, 2.06), stroke: 0.7pt + red)
  draw.line((2.12, 0.78), (2.86, 0.78), stroke: 0.7pt + red)
  draw.line((2.12, 0.86), (2.12, 1.98), stroke: 0.8pt + red, mark: tar)
  content((1.80, 1.42), text(size: 11pt)[$h$])

  // 驱动轮与轮心
  draw.circle((2.72, 1.78), radius: 1.00, stroke: 1.4pt + black)
  draw.circle((2.72, 1.78), radius: 0.045, fill: black, stroke: none)

  // 障碍轮廓（点线圆）
  draw.circle((4.15, 1.95), radius: 1.17, stroke: tdash)

  // 行走轨迹
  draw.bezier((0.38, 2.60), (4.60, 3.95), (1.80, 3.40), (3.30, 3.95), stroke: 1.2pt + black)
  draw.bezier((4.60, 3.95), (8.05, 2.30), (5.90, 3.95), (7.10, 3.05), stroke: 1.2pt + black)
  content((6.75, 4.55), text(size: 8.5pt, weight: "bold")[walking trajectory])
  draw.line((6.55, 4.42), (6.30, 3.60), stroke: 0.9pt + red, mark: (end: "stealth", fill: red, scale: 0.4))

  // H_max 标注
  draw.line((4.15, 3.12), (5.75, 3.12), stroke: 0.7pt + red)
  draw.line((4.60, 3.95), (5.75, 3.95), stroke: 0.7pt + red)
  draw.line((5.55, 3.12), (5.55, 3.95), stroke: 0.8pt + red, mark: tar)
  content((4.88, 3.50), text(size: 10pt)[$H_("max")$])

  // 腿部连杆：实体三角与点线虚影
  draw.line((2.85, 5.95), (5.15, 5.80), (4.05, 4.75), close: true, stroke: thin)
  draw.line((2.72, 1.78), (4.05, 4.75), stroke: thin)
  draw.circle((4.05, 4.75), radius: 0.045, fill: black, stroke: none)
  draw.line((3.05, 5.45), (4.35, 5.10), (4.05, 4.75), close: true,
    stroke: (paint: black, thickness: 0.9pt, dash: "dotted"))
  draw.circle((3.05, 5.45), radius: 0.04, fill: white, stroke: black)
  content((4.28, 4.88), text(size: 10pt)[$phi$])
})
