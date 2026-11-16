#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Structural differences between Preloading discovery and Simple discovery
// 来源：Drones 2025, 9(8), 564, Figure 6；DOI: 10.3390/drones9080564
// 结构：两幅四节点拓扑。(a) Simple 发现：PDP（蓝虚线）与 EDP（红虚线）交织，逐对协商；
// (b) Preloading 发现：EDP 提前批量嵌入各节点（Batch EDP 红点线标签框），运行时只走 PDP，链路统一为实线。
// 图例：蓝虚线 PDP、红虚线 EDP；批量预置框用红点线，仅挂在节点外侧、不参与链路。
// 两幅拓扑的节点位置一致，差别只在链路线型与 EDP 的承载方式。

#canvas({
  import draw: *
  let blue = rgb("#3f6fd8")
  let red = rgb("#d03030")
  let link = rgb("#8aa6d8")
  let pdp = (paint: blue, thickness: 0.9pt, dash: "dashed")
  let edp = (paint: red, thickness: 0.9pt, dash: "dashed")
  let st = 0.9pt + black
  let node(cx, cy, t) = {
    let k = 0.5523
    let rx = 0.95
    let ry = 0.60
    draw.bezier((cx - rx, cy), (cx + rx, cy), (cx - rx, cy + k * ry), (cx + rx, cy + k * ry),
      fill: rgb("#fbe3c8"), stroke: st)
    draw.bezier((cx + rx, cy), (cx - rx, cy), (cx + rx, cy - k * ry), (cx - rx, cy - k * ry),
      fill: rgb("#fbe3c8"), stroke: st)
    content((cx, cy), text(size: 7.5pt)[#t])
  }
  let leg(x, y, t, s) = {
    draw.line((x, y), (x + 0.55, y), stroke: s)
    content((x + 0.95, y), text(size: 6.5pt)[#t])
  }

  // (a) Simple discovery
  draw.line((2.55, 5.60), (3.85, 5.60), stroke: pdp)
  draw.line((2.00, 5.00), (2.00, 4.00), stroke: edp)
  draw.line((4.40, 5.00), (4.40, 4.00), stroke: edp)
  draw.line((2.55, 3.40), (3.85, 3.40), stroke: pdp)
  draw.line((2.55, 5.35), (3.85, 3.65), stroke: pdp)
  draw.line((3.85, 5.35), (2.55, 3.65), stroke: edp)
  node(2.00, 5.60, [Node 1])
  node(4.40, 5.60, [Node 2])
  node(2.00, 3.40, [Node 3])
  node(4.40, 3.40, [Node 4])
  leg(1.10, 1.95, [PDP], pdp)
  leg(2.55, 1.95, [EDP], edp)
  content((3.20, 1.25), text(size: 8pt)[(a)])

  // (b) Preloading discovery
  let ls = 1pt + link
  draw.line((8.45, 5.60), (9.75, 5.60), stroke: ls)
  draw.line((7.90, 5.00), (7.90, 4.00), stroke: ls)
  draw.line((10.30, 5.00), (10.30, 4.00), stroke: ls)
  draw.line((8.45, 3.40), (9.75, 3.40), stroke: ls)
  draw.line((8.45, 5.35), (9.75, 3.65), stroke: ls)
  draw.line((9.75, 5.35), (8.45, 3.65), stroke: ls)
  node(7.90, 5.60, [Node 1])
  node(10.30, 5.60, [Node 2])
  node(7.90, 3.40, [Node 3])
  node(10.30, 3.40, [Node 4])
  let batch(x0, y0) = {
    draw.rect((x0, y0), (x0 + 0.70, y0 + 0.40), radius: 0.05, fill: white,
      stroke: (paint: red, thickness: 0.7pt, dash: "dotted"))
    content((x0 + 0.35, y0 + 0.29), text(size: 5.5pt, weight: "bold")[Batch])
    content((x0 + 0.35, y0 + 0.11), text(size: 5.5pt, weight: "bold")[EDP])
  }
  batch(7.55, 6.35)
  batch(10.15, 6.35)
  batch(7.55, 2.25)
  batch(10.15, 2.25)
  draw.line((8.25, 6.35), (8.05, 6.20), stroke: (paint: red, thickness: 0.6pt, dash: "dotted"))
  draw.line((10.15, 6.50), (9.95, 6.20), stroke: (paint: red, thickness: 0.6pt, dash: "dotted"))
  draw.line((7.55, 2.60), (7.75, 2.80), stroke: (paint: red, thickness: 0.6pt, dash: "dotted"))
  draw.line((10.85, 2.60), (10.65, 2.80), stroke: (paint: red, thickness: 0.6pt, dash: "dotted"))
  leg(6.95, 1.95, [PDP], ls)
  leg(8.40, 1.95, [EDP], ls)
  content((9.10, 1.25), text(size: 8pt)[(b)])
})
