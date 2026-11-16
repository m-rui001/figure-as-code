#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Transmission timing of DDS messages in TSN（TSN 中 DDS 消息的发送时序）
// 来源：Future Internet 2026, 18, 297, Figure 3；DOI: 10.3390/fi18060297
// 结构：上下两幅——(a) 正常时序，两条链路上按周期交替发出蓝色消息块 1.1–1.4；
// (b) 消息超时时序，Link 1 先划出 GCL 传输窗（斜线阴影），消息被推迟，红色虚弧表示逐条回补，
// 红色标注为 jitter 造成的附加时延。底部图例给出消息块、传输窗、到达箭头与抖动时延的记号。

#canvas({
  import draw: *
  let blue = rgb("#29abe2")
  let red = rgb("#d03030")
  let ar = (end: "stealth", fill: black, scale: 0.35)
  let bar = (end: "stealth", fill: blue, scale: 0.35)
  let rar = (end: "stealth", fill: red, scale: 0.35)
  let rar2 = (start: "stealth", end: "stealth", fill: red, scale: 0.32)
  let arr_up(x, y) = draw.line((x, y), (x, y + 0.45), stroke: 0.9pt + blue, mark: bar)
  let msg(cx, cy, t) = {
    draw.rect((cx - 0.40, cy - 0.23), (cx + 0.40, cy + 0.23), fill: blue, stroke: none)
    content((cx, cy), text(size: 7.5pt, fill: white, weight: "bold")[#t])
  }
  let win(x0, y) = {
    draw.rect((x0, y), (x0 + 0.70, y + 0.45), fill: white, stroke: 0.8pt + blue)
    for i in range(4) {
      draw.line((x0 + 0.10 + i * 0.16, y + 0.03), (x0 + 0.03 + i * 0.16, y + 0.42),
        stroke: 0.7pt + blue)
    }
  }
  let axis(y) = draw.line((0.95, y), (10.75, y), stroke: 0.9pt + black, mark: ar)
  let lab(x, y, t) = content((x, y), text(size: 8pt, style: "italic")[#t])

  // 外框与分区
  draw.rect((0.30, 0.55), (10.95, 9.05), stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
  draw.line((0.30, 5.15), (10.95, 5.15), stroke: (paint: black, thickness: 0.6pt, dash: "dashed"))
  content((0.52, 8.78), text(size: 8.5pt, weight: "bold")[(a)])
  content((0.52, 4.92), text(size: 8.5pt, weight: "bold")[(b)])
  for x in (1.25, 3.95, 6.65, 9.35) {
    draw.line((x, 1.60), (x, 8.90), stroke: (paint: black, thickness: 0.5pt, dash: "dashed"))
  }

  // (a) 正常时序
  axis(8.30)
  axis(6.70)
  lab(0.62, 8.55, [Link 1])
  lab(0.62, 6.95, [Link 2])
  for x in (1.25, 3.95, 6.65, 9.35) {
    arr_up(x, 8.30)
    arr_up(x, 6.70)
  }
  for (c, t) in ((1.90, [1.1]), (4.60, [1.2]), (7.30, [1.3]), (9.90, [1.4])) {
    msg(c, 8.30, t)
  }
  for (c, t) in ((2.95, [1.1]), (5.65, [1.2]), (8.35, [1.3])) {
    msg(c, 6.70, t)
  }

  // (b) 超时时序
  axis(4.05)
  axis(2.45)
  lab(0.62, 4.30, [Link 1])
  lab(0.62, 2.70, [Link 2])
  for x in (1.25, 3.95, 6.65, 9.35) {
    arr_up(x, 4.05)
    arr_up(x, 2.45)
  }
  win(1.35, 4.05)
  win(2.40, 2.45)
  win(5.10, 2.45)
  for (c, t) in ((2.55, [1.1]), (5.25, [1.2]), (7.95, [1.3])) {
    msg(c, 4.05, t)
    draw.circle((c - 0.40, 4.28), radius: 0.045, fill: red, stroke: none)
  }
  msg(5.55, 2.45, [1.1])
  msg(8.25, 2.45, [1.2])
  // 逐条回补的红色虚弧
  draw.bezier((2.15, 4.28), (4.85, 4.28), (3.10, 4.95), (3.85, 4.95),
    stroke: (paint: red, thickness: 0.8pt, dash: "dashed"), mark: rar)
  draw.bezier((4.85, 4.28), (7.55, 4.28), (5.85, 4.95), (6.60, 4.95),
    stroke: (paint: red, thickness: 0.8pt, dash: "dashed"), mark: rar)
  // 抖动时延标注
  draw.line((1.35, 3.55), (2.05, 3.55), stroke: 0.8pt + red, mark: rar2)
  draw.line((2.05, 3.55), (1.42, 2.92), stroke: 0.8pt + red, mark: rar)
  draw.line((1.35, 3.55), (1.35, 4.02), stroke: 0.8pt + red, mark: rar)

  // 图例
  draw.line((0.45, 1.25), (0.70, 1.25), (0.70, 1.08), stroke: 0.9pt + red, mark: rar)
  content((0.80, 1.22), text(size: 5.8pt)[Latency caused], anchor: "west")
  content((0.80, 1.04), text(size: 5.8pt)[by jitter], anchor: "west")
  draw.rect((2.35, 0.88), (2.92, 1.36), fill: blue, stroke: none)
  content((2.63, 1.12), text(size: 5.8pt, fill: white)[$i - j$])
  content((3.10, 1.22), text(size: 5.8pt)[The $j$-th message in], anchor: "west")
  content((3.10, 1.04), text(size: 5.8pt)[the DDS stream $i$], anchor: "west")
  win(5.20, 0.90)
  content((6.00, 1.24), text(size: 5.8pt)[The transmission window assigned], anchor: "west")
  content((6.00, 1.06), text(size: 5.8pt)[to the DDS message $i$-$j$ in GCL], anchor: "west")
  draw.line((9.35, 0.90), (9.35, 1.34), stroke: 0.9pt + blue, mark: bar)
  content((9.50, 1.22), text(size: 5.8pt)[Arrival time of], anchor: "west")
  content((9.50, 1.04), text(size: 5.8pt)[DDS messages], anchor: "west")
})
