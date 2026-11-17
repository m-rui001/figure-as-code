#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：优化流程示意图（Schematic flowchart of the optimization procedure）
// 来源：Energies 2025, 18, 2813, Figure 5，DOI: 10.3390/en18112813
// 结构：平行四边形输入 → 预处理矩形 → 约束菱形 → OpenFAST 矩形 → 频域矩形
// 左下为优化算法矩形；左上大闭环回馈输入，菱形左侧小闭环回馈预处理
// 线框蓝灰 #3f5f8f，白底无填充，文字黑色，箭头实心 stealth
// 主流程与两条反馈闭环均用折线连接，框内文字按语义分行

#canvas({
  import draw: *
  let blue = rgb("#3f5f8f")
  let st = (paint: blue, thickness: 0.9pt)
  let mk = (end: "stealth", fill: blue, scale: 0.45)
  let frame(x0, y0, w, h, body, size: 8.5pt) = {
    rect((x0, y0), (x0 + w, y0 + h), stroke: st)
    content((x0 + w / 2, y0 + h / 2), text(size: size, body), anchor: "center")
  }
  let down(x, y0, y1) = line((x, y0), (x, y1), stroke: st, mark: mk)
  let x0 = 5.8
  let x1 = 11.2
  let cx = 8.5

  line((5.8, 9.0), (11.2, 9.0), (11.6, 10.6), (6.2, 10.6), close: true, stroke: st)
  content((cx, 9.8), text(size: 7.4pt,
    "Inputs to the simulation\n(rotor and tower mass\nand geometry, platform\ngeometry etc.)"),
    anchor: "center")

  frame(x0, 6.7, x1 - x0, 1.6,
    "Geometry preprocessing\n(generate platform and\nmooring geometry)")
  frame(x0, 3.0, x1 - x0, 1.2, "OpenFAST simulations\n(calculate time responses)")
  frame(x0, 0.9, x1 - x0, 1.8,
    "Frequency domain\nanalysis (to estimate peaks\nand frequencies)")

  line((cx, 4.5), (x1, 5.4), (cx, 6.3), (x0, 5.4), close: true, stroke: st)
  content((cx, 5.4), text(size: 8.5pt, "Check\nconstraints"), anchor: "center")

  frame(0.9, 1.0, 4.2, 1.8,
    "Optimization algorithm\n(search for a configuration\nwith higher yaw response)")

  down(cx, 9.0, 8.3)
  down(cx, 6.7, 6.3)
  down(cx, 4.5, 4.2)
  down(cx, 3.0, 2.7)
  line((5.8, 1.8), (5.1, 1.8), stroke: st, mark: mk)

  line((x0, 5.4), (5.0, 5.4), (5.0, 7.5), (x0, 7.5), stroke: st, mark: mk)

  line((0.9, 1.8), (0.2, 1.8), (0.2, 10.95), (cx, 10.95), (cx, 10.6),
    stroke: st, mark: mk)
})
