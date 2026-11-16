#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：DDS discovery process（DDS 发现过程）
// 来源：Drones 2025, 9(8), 564, Figure 2；DOI: 10.3390/drones9080564
// 结构：顶部 Node 1..N 汇入 Discovery Process 方框；框内先走 PDP（参与者也发现，两段交互），
// 再走 EDP（端点发现，三段交互）。右侧三个虚线框依次说明：通告域、通告所需数据、连接所需节点。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.35)
  let ar2 = (start: "stealth", end: "stealth", fill: black, scale: 0.32)
  let st = 0.9pt + black
  let ell(cx, cy, rx, ry, t, s: 7pt) = {
    let k = 0.5523
    draw.bezier((cx - rx, cy), (cx + rx, cy), (cx - rx, cy + k * ry), (cx + rx, cy + k * ry),
      fill: white, stroke: st)
    draw.bezier((cx + rx, cy), (cx - rx, cy), (cx + rx, cy - k * ry), (cx - rx, cy - k * ry),
      fill: white, stroke: st)
    content((cx, cy), text(size: s)[#t])
  }
  let cloud(cx, cy, rx, ry) = {
    let pts = range(80).map(i => {
      let a = i * 4.5deg
      let f = 1 + 0.07 * calc.sin(9 * a)
      (cx + rx * f * calc.cos(a), cy + ry * f * calc.sin(a))
    })
    draw.line(..pts, close: true, fill: white, stroke: st)
    content((cx, cy), text(size: 7.5pt)[DDS])
  }
  let dashed(x0, y0, x1, y1) = draw.rect((x0, y0), (x1, y1), radius: 0.18,
    stroke: (paint: black, thickness: 0.7pt, dash: "dashed"))

  // 顶部节点
  content((4.05, 8.62), text(size: 11pt, weight: "bold")[Data Distribution Service])
  ell(1.75, 7.75, 0.95, 0.50, [Node 1])
  ell(3.35, 7.75, 0.95, 0.50, [2])
  content((4.35, 7.72), text(size: 11pt)[...])
  ell(5.85, 7.75, 0.95, 0.50, [Node N])

  // Discovery Process 主框
  draw.rect((1.05, 3.55), (7.05, 7.25), stroke: 1.1pt + black)
  content((4.05, 6.98), text(size: 9pt, weight: "bold")[Discovery Process])
  draw.rect((1.35, 5.60), (6.75, 6.72), fill: rgb("#dbe6f5"), stroke: 0.8pt + rgb("#5b7db1"))
  content((4.05, 6.52), text(size: 7.5pt, weight: "bold")[PDP : Participant Discovery Protocol])
  draw.line((1.70, 6.04), (4.00, 6.04), stroke: st, mark: ar)
  content((2.85, 6.25), text(size: 6.8pt)[(1) Participant Info Broadcast])
  draw.line((4.10, 5.66), (1.70, 5.66), stroke: st, mark: ar)
  content((2.85, 5.89), text(size: 6.8pt)[(2) Participant Info Response])
  draw.line((4.05, 5.60), (4.05, 5.36), stroke: st, mark: ar)
  draw.rect((1.35, 3.68), (6.75, 5.36), fill: rgb("#fbefc9"), stroke: 0.8pt + rgb("#c8a84a"))
  content((4.05, 5.24), text(size: 7.5pt, weight: "bold")[EDP : Endpoint Discovery Protocol])
  draw.line((1.70, 4.80), (4.00, 4.80), stroke: st, mark: ar)
  content((2.85, 4.93), text(size: 6.8pt)[(3) Publication Info])
  draw.line((4.10, 4.46), (1.70, 4.46), stroke: st, mark: ar)
  content((2.85, 4.59), text(size: 6.8pt)[(4) Subscriber Info])
  draw.line((1.70, 4.12), (4.00, 4.12), stroke: st, mark: ar)
  content((2.85, 4.25), text(size: 6.8pt)[(5) User Data])
  // 节点汇入
  for x in (1.75, 2.55, 5.85) {
    draw.line((x, 7.25), (x, 6.72), stroke: st, mark: ar)
  }

  // 右侧三个虚线说明框
  dashed(7.75, 6.55, 12.85, 8.70)
  ell(8.95, 8.24, 0.52, 0.30, [?])
  ell(10.25, 8.28, 0.52, 0.30, [?])
  ell(8.75, 7.42, 0.60, 0.32, [Node N])
  cloud(10.35, 7.55, 0.80, 0.42)
  ell(11.85, 7.08, 0.52, 0.30, [?])
  content((10.30, 6.78), text(size: 7.5pt, weight: "bold")[Notify the domain])

  dashed(7.75, 4.40, 12.85, 6.42)
  ell(9.30, 6.10, 0.60, 0.31, [Node 1])
  ell(11.05, 6.10, 0.60, 0.31, [Node 2])
  draw.rect((7.95, 5.62), (8.35, 5.94), fill: rgb("#dbe6f5"), stroke: 0.7pt + black)
  content((8.15, 5.78), text(size: 6.5pt)[A])
  ell(8.75, 5.28, 0.60, 0.31, [Node N])
  cloud(10.35, 5.32, 0.80, 0.42)
  ell(11.65, 4.95, 0.60, 0.31, [Node 3])
  content((10.30, 4.60), text(size: 7.5pt, weight: "bold")[Notify required data])

  dashed(7.75, 1.78, 12.85, 4.22)
  draw.rect((9.45, 3.96), (9.85, 4.26), fill: rgb("#d9f2e6"), stroke: 0.7pt + black)
  content((9.65, 4.11), text(size: 6.5pt)[B])
  draw.rect((10.70, 3.96), (11.10, 4.26), fill: rgb("#d9f2e6"), stroke: 0.7pt + black)
  content((10.90, 4.11), text(size: 6.5pt)[B])
  ell(10.10, 3.66, 0.60, 0.31, [Node 1])
  ell(11.55, 3.58, 0.60, 0.31, [Node 2])
  draw.rect((7.95, 3.32), (8.35, 3.62), fill: rgb("#dbe6f5"), stroke: 0.7pt + black)
  content((8.15, 3.47), text(size: 6.5pt)[A])
  ell(8.75, 3.02, 0.60, 0.31, [Node N])
  cloud(10.10, 3.02, 0.80, 0.40)
  draw.rect((11.55, 2.76), (11.95, 3.06), fill: rgb("#dbe6f5"), stroke: 0.7pt + black)
  content((11.75, 2.91), text(size: 6.5pt)[A])
  ell(11.55, 2.42, 0.60, 0.31, [Node 3])
  content((8.95, 2.24), text(size: 6.5pt)[Topic Data])
  draw.line((9.55, 2.30), (10.30, 2.62), stroke: 0.7pt + black, mark: ar)
  draw.line((10.50, 2.28), (11.30, 2.40), stroke: 0.7pt + black, mark: ar)
  content((9.75, 2.02), text(size: 7.5pt, weight: "bold")[Connect required nodes])

  // 虚线引线
  draw.line((7.05, 6.55), (7.75, 7.30), stroke: (paint: black, thickness: 0.6pt, dash: "dashed"))
  draw.line((7.05, 5.20), (7.75, 5.50), stroke: (paint: black, thickness: 0.6pt, dash: "dashed"))
  draw.line((7.05, 3.90), (7.75, 3.20), stroke: (paint: black, thickness: 0.6pt, dash: "dashed"))
})
