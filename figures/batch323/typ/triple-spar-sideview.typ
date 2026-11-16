#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#let rtxt(t, a) = rotate(a * 1deg, t, reflow: true)

// 图名：Side-view sketch of the DTU 10 MW mounted on the Triple Spar（DTU 10 MW 三浮筒平台侧视）
// 来源：Energies 2025, 18, 2813, Figure 2；DOI: 10.3390/en18112813
// 结构：塔架与机舱立在中心线上，三根立柱悬挂在甲板下；SWL 为静水面，X/Z 轴定参考系。
// 标注：D 为水深，z_F 为导缆点高出 SWL 的高度，x_F、x_S、x_A 为水平偏距，Δx_F-A 为导缆点到锚点水平距，
// l_moor 为系泊线长；图中只画两条系泊线（左灰一、右灰蓝二），锚点落在海床上。

#canvas({
  import draw: *
  let st = 0.8pt + black
  let thin = 0.6pt + black
  let bthin = 0.6pt + rgb("#4a4ae0")
  let blue = rgb("#4a4ae0")
  let mdash = (paint: rgb("#333333"), thickness: 0.5pt, dash: "densely-dotted")
  let ar = (end: "stealth", fill: black, scale: 0.4)
  let arb = (end: "stealth", fill: blue, scale: 0.4)
  let tar = (start: "stealth", end: "stealth", fill: black, scale: 0.38)
  let tarb = (start: "stealth", end: "stealth", fill: blue, scale: 0.38)

  // 水体与海床
  draw.rect((0.78, 0.77), (9.50, 3.70), fill: rgb("#e8f1fb"), stroke: none)
  draw.rect((0.78, 0.55), (9.50, 0.77), fill: rgb("#a9837a"), stroke: none)
  draw.line((0.78, 0.77), (9.50, 0.77), stroke: thin)
  // 静水面与坐标轴
  draw.line((0.78, 3.70), (9.75, 3.70), stroke: st, mark: ar)
  draw.line((5.30, 0.25), (5.30, 7.60), stroke: st, mark: ar)
  content((1.12, 3.92), text(size: 9pt)[SWL])
  content((9.45, 3.92), text(size: 9pt)[X])
  content((5.46, 7.38), text(size: 9pt)[Z])

  // 塔架、机舱、轮毂与叶片
  draw.line((5.22, 5.30), (5.22, 3.00), stroke: st)
  draw.line((5.38, 5.30), (5.38, 3.00), stroke: st)
  draw.line((5.18, 5.30), (5.42, 5.30), stroke: st)
  draw.circle((5.30, 5.42), radius: 0.10, fill: white, stroke: st)
  draw.line((5.30, 5.52), (5.30, 7.30), stroke: thin)
  draw.line((5.30, 5.42), (4.28, 4.55), stroke: thin)
  draw.line((5.30, 5.42), (5.82, 4.42), stroke: thin)
  // 甲板与三根立柱
  draw.line((4.30, 3.97), (6.80, 3.97), stroke: st)
  draw.line((4.52, 3.86), (6.20, 3.86), stroke: thin)
  draw.rect((4.62, 2.75), (4.84, 3.86), stroke: st)
  draw.rect((5.20, 2.95), (5.42, 3.86), stroke: st)
  draw.rect((5.96, 2.75), (6.18, 3.86), stroke: st)
  draw.line((4.62, 3.86), (4.48, 3.32), stroke: thin)
  draw.line((6.18, 3.86), (6.32, 3.32), stroke: thin)

  // 导缆点与系泊线
  draw.circle((4.30, 3.97), radius: 0.05, fill: black, stroke: none)
  draw.circle((6.80, 3.97), radius: 0.05, fill: black, stroke: none)
  draw.bezier((4.30, 3.97), (2.15, 0.82), (4.02, 3.05), (2.62, 0.88), stroke: thin)
  draw.bezier((6.80, 3.97), (9.20, 0.82), (7.22, 3.00), (8.32, 0.86), stroke: thin)
  draw.bezier((6.86, 3.98), (9.16, 0.84), (7.42, 3.02), (8.42, 0.88),
    stroke: 1pt + blue)
  draw.circle((2.15, 0.80), radius: 0.05, fill: black, stroke: none)
  draw.circle((9.20, 0.80), radius: 0.05, fill: black, stroke: none)

  // 尺寸线：D、z_F、x_F、x_A、x_S、Δx_F-A
  draw.line((2.90, 3.70), (2.90, 0.77), stroke: thin, mark: tar)
  draw.line((2.82, 3.70), (2.98, 3.70), stroke: thin)
  draw.line((2.82, 0.77), (2.98, 0.77), stroke: thin)
  content((2.62, 2.20), text(size: 9pt)[$D$])
  draw.line((7.05, 3.70), (7.05, 3.97), stroke: thin, mark: tar)
  draw.line((6.97, 3.97), (7.35, 3.97), stroke: mdash)
  content((7.28, 4.14), text(size: 9pt)[$z_F$])
  draw.line((5.30, 4.78), (6.80, 4.78), stroke: thin, mark: tar)
  draw.line((6.80, 4.78), (6.80, 3.97), stroke: mdash)
  content((6.00, 4.94), text(size: 9pt)[$x_F$])
  draw.line((5.30, 5.32), (9.20, 5.32), stroke: bthin, mark: tarb)
  draw.line((9.20, 5.32), (9.20, 0.77), stroke: mdash)
  content((7.28, 5.48), text(size: 9pt, fill: blue)[$x_A$])
  draw.line((5.30, 2.62), (6.18, 2.62), stroke: bthin, mark: tarb)
  draw.line((6.18, 2.62), (6.18, 2.75), stroke: mdash)
  content((5.58, 2.84), text(size: 9pt, fill: blue)[$x_S$])
  draw.line((6.80, 1.96), (9.20, 1.96), stroke: thin, mark: tar)
  draw.line((6.80, 1.96), (6.80, 3.80), stroke: mdash)
  content((7.55, 1.72), text(size: 9pt)[$Delta x_(F - A)$])
  content((8.32, 1.02), rtxt(text(size: 9pt, fill: blue)[$l_("moor")$], 18))
})
