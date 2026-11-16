#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Comparison of discovery structures between Simple and Preloading
// 来源：Drones 2025, 9(8), 564, Figure 7；DOI: 10.3390/drones9080564
// 结构：两组 P1/P2 时序对照。Simple：PDP 先广播/应答，再在 EDP 里逐条交换 Pub Info、Sub Info、User Data；
// Preloading：EDP 元数据在运行前以 Batch EDP 文件预置到两端，运行时仍走 PDP 与三类数据交换，但不再逐对协商。
// 竖线 P1/P2 为两条生命线，蓝带为 PDP 阶段、黄带为 EDP 阶段，箭头成对表示请求/应答。
// 右侧面板两侧的文档图标即预置的 EDP 元数据，箭头指向对应生命线。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.32)
  let st = 0.8pt + black
  let life(x, t) = {
    draw.line((x, 5.55), (x, 1.10), stroke: 0.9pt + black)
    content((x, 5.72), text(size: 8pt, weight: "bold")[#t])
  }
  let doc(cx, cy) = {
    draw.line((cx - 0.28, cy - 0.32), (cx + 0.16, cy - 0.32), (cx + 0.28, cy - 0.20),
      (cx + 0.28, cy + 0.32), (cx - 0.28, cy + 0.32), close: true, fill: white, stroke: st)
    draw.line((cx + 0.16, cy - 0.32), (cx + 0.16, cy - 0.20), (cx + 0.28, cy - 0.20), stroke: st)
    content((cx, cy + 0.08), text(size: 5pt)[Batch])
    content((cx, cy - 0.10), text(size: 5pt)[EDP])
  }
  let panel(x0, x1, p1, p2, pre: false) = {
    let xm = (x0 + x1) / 2
    life(p1, [P1])
    life(p2, [P2])
    draw.rect((x0, 4.35), (x1, 5.35), fill: rgb("#dbe6f5"), stroke: st)
    content((xm, 5.24), text(size: 7.5pt, weight: "bold")[PDP])
    draw.line((p1, 4.90), (p2, 4.90), stroke: 0.7pt + black, mark: ar)
    content((xm, 5.02), text(size: 6pt)[PDP Broadcast])
    draw.line((p2, 4.54), (p1, 4.54), stroke: 0.7pt + black, mark: ar)
    content((xm, 4.70), text(size: 6pt)[PDP Response])
    draw.rect((x0, 1.35), (x1, 4.35), fill: rgb("#fbefc9"), stroke: st)
    content((xm, 4.22), text(size: 7.5pt, weight: "bold")[EDP])
    let rows = ((3.73, [Pub Info]), (3.03, [Sub Info]), (2.33, [User Data]))
    for (y, t) in rows {
      draw.line((p1, y + 0.07), (p2, y + 0.07), stroke: 0.7pt + black, mark: ar)
      draw.line((p2, y - 0.07), (p1, y - 0.07), stroke: 0.7pt + black, mark: ar)
      content((xm, y + 0.20), text(size: 6pt)[#t])
    }
    if pre {
      doc(x0 - 0.55, 3.10)
      draw.line((x0 - 0.27, 3.00), (p1 - 0.05, 3.00), stroke: 0.7pt + black, mark: ar)
      doc(x1 + 0.55, 2.83)
      draw.line((x1 + 0.27, 2.93), (p2 + 0.05, 2.93), stroke: 0.7pt + black, mark: ar)
    }
    content((xm, 0.85), text(size: 8pt, weight: "bold")[#(if pre { "Preloading" } else { "Simple" })])
  }

  panel(0.90, 4.30, 1.75, 3.45)
  panel(5.55, 8.95, 6.40, 8.10, pre: true)
})
