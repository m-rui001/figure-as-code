#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Comparison of discovery structures between Simple and Preloading
// 来源：Drones 2025, 9(8), 564, Figure 7；DOI: 10.3390/drones9080564
// 结构：左右等宽时序图，两条竖直生命线；上部为 PDP 浅蓝带，下部为 EDP 浅黄带。
// 左栏 P1/P2 间三条双向数据流；右栏在两侧增加 Batch EDP 文档图标与短箭头。
// 视觉元素：蓝带 #cfe0f5、黄带 #ffe9b8，细实线箭头配实心 stealth 箭头。
// Batch EDP 为折角文档图标，预加载时 Pub/Sub 元数据在两侧预置，不再逐跳协商。
#let ink = rgb("#1a1a1a")
#let blue = rgb("#cfe0f5")
#let yellow = rgb("#ffe9b8")
#let arrow-stroke = (paint: ink, thickness: 0.65pt)
#let one-way(a, b) = draw.line(a, b, stroke: arrow-stroke,
  mark: (end: "stealth", fill: ink, scale: 0.45))
#let two-way(a, b) = draw.line(a, b, stroke: arrow-stroke,
  mark: (start: "stealth", end: "stealth", fill: ink, scale: 0.45))
#let tag(x, y, body, size: 10pt, weight: "regular") = {
  draw.content((x, y), text(body, size: size, weight: weight, fill: ink), anchor: "center")
}
#let bands(x0, x1) = {
  draw.rect((x0, 7.8), (x1, 11.9), fill: blue, stroke: none)
  draw.rect((x0, 3.9), (x1, 7.8), fill: yellow, stroke: none)
}
#let lifelines(p1, p2) = {
  for x in (p1, p2) {
    draw.line((x, 11.9), (x, 1.55), stroke: (paint: ink, thickness: 1.25pt))
  }
  tag(p1, 12.2, [P1], size: 9.5pt, weight: "bold")
  tag(p2, 12.2, [P2], size: 9.5pt, weight: "bold")
}
#let pdp(p1, p2) = {
  tag((p1 + p2) / 2, 11.5, [PDP], weight: "bold")
  one-way((p1, 11.15), (p2, 10.0))
  tag((p1 + p2) / 2, 10.25, [PDP Broadcast])
  one-way((p2, 8.55), (p1, 9.35))
  tag((p1 + p2) / 2, 8.2, [PDP Response])
}
#let batch-doc(x, y) = {
  let w = 1.2
  let h = 1.8
  let f = 0.28
  draw.line((x, y), (x, y + h), (x + w - f, y + h), (x + w, y + h - f),
    (x + w, y), close: true, fill: white, stroke: (paint: ink, thickness: 0.8pt))
  draw.line((x + w - f, y + h), (x + w - f, y + h - f), (x + w, y + h - f),
    stroke: (paint: ink, thickness: 0.65pt))
  draw.content((x + w / 2, y + h / 2),
    text([Batch #linebreak() EDP], size: 9pt, fill: ink), anchor: "center")
}
#let simple-panel(p1, p2, x0, x1, title) = {
  bands(x0, x1)
  lifelines(p1, p2)
  pdp(p1, p2)
  tag((p1 + p2) / 2, 7.45, [EDP], weight: "bold")
  let lanes = ((6.35, 6.02, [Pub Info]), (5.45, 5.12, [Sub Info]),
    (4.45, 4.12, [User Data]))
  for (y, ty, txt) in lanes {
    two-way((p1, y), (p2, y))
    tag((p1 + p2) / 2, ty, txt)
  }
  tag((p1 + p2) / 2, 0.75, title, size: 12pt, weight: "bold")
}
#let preloading-panel(p1, p2, x0, x1, title) = {
  bands(x0, x1)
  lifelines(p1, p2)
  pdp(p1, p2)
  tag((p1 + p2) / 2, 7.45, [EDP], weight: "bold")
  two-way((p1, 4.45), (p2, 4.45))
  tag((p1 + p2) / 2, 4.12, [User Data])
  batch-doc(p1 - 2.4, 4.7)
  batch-doc(p2 + 1.2, 4.7)
  for (xa, xb, tx) in ((p1 - 1.2, p1, p1 - 0.65), (p2, p2 + 1.2, p2 + 0.65)) {
    for (y, ty, txt) in ((6.1, 6.35, [Pub Info]), (5.1, 4.85, [Sub Info])) {
      two-way((xa, y), (xb, y))
      tag(tx, ty, txt, size: 7.5pt)
    }
  }
  tag((p1 + p2) / 2, 0.75, title, size: 12pt, weight: "bold")
}
#canvas({
  import draw: *
  simple-panel(2.2, 7.8, 1.4, 8.6, [Simple])
  preloading-panel(12.4, 17.4, 11.2, 18.4, [Preloading])
})
