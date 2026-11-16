#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Simulation System for DDS Discovery Performance Test（DDS 发现性能测试仿真系统）
// 来源：Drones 2025, 9(8), 564, Figure 9；DOI 10.3390/drones9080564
// 结构：上方一个 Publisher 容器与 N 个 Subscriber 容器（均为 docker 内的 ROS2 节点），
// 全部接入中间 Bridge；Bridge 与下方 Adhoc 802.11g Wireless Network 云（ns-3 网络模拟器）双向相连。
// 箭头方向：发布者下行写入 Bridge，Bridge 上行分发给各订阅者。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.5)
  let ar2 = (start: "stealth", end: "stealth", fill: black, scale: 0.45)
  let node(x0, y0, x1, y1, t, col) = {
    draw.rect((x0, y0), (x1, y1), radius: 0.18, fill: white, stroke: 1.6pt + col)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: 9pt, weight: "bold")[#t])
    // docker 小标志
    draw.rect((x0 + 0.12, y0 + 0.78), (x0 + 0.52, y0 + 0.94), radius: 0.04,
      fill: rgb("#1d63b8"), stroke: none)
    for i in range(3) {
      draw.rect((x0 + 0.16 + i * 0.11, y0 + 0.86), (x0 + 0.23 + i * 0.11, y0 + 0.92),
        fill: rgb("#7fb3e8"), stroke: none)
    }
    content((x0 + 0.78, y0 + 0.86), text(size: 5.5pt, fill: rgb("#1d63b8"))[docker])
  }
  let ty = rgb("#2a9d8f")
  let rd = rgb("#d64545")
  content((2.90, 7.98), text(size: 10pt, weight: "bold", fill: ty)[Publisher (1)])
  content((11.70, 8.06), text(size: 10pt, weight: "bold", fill: rd)[Subscribers (N)])
  // 订阅者括线
  draw.line((7.40, 7.55), (7.40, 7.78), (16.80, 7.78), (16.80, 7.55), stroke: 0.9pt + black)
  draw.line((12.10, 7.78), (12.10, 7.90), stroke: 0.9pt + black)

  node(1.25, 6.35, 4.55, 7.45, [ROS2 Node], ty)
  node(7.40, 6.35, 9.50, 7.45, [ROS2 Node1], rd)
  node(10.70, 6.35, 12.80, 7.45, [ROS2 Node2], rd)
  node(14.70, 6.35, 16.80, 7.45, [ROS2 Node N], rd)
  content((13.55, 6.90), text(size: 13pt, weight: "bold")[...])

  // Bridge 总线
  draw.rect((1.55, 4.95), (17.20, 5.55), radius: 0.15, fill: white, stroke: 2pt + black)
  content((9.40, 5.25), text(size: 10pt, weight: "bold")[Bridge])
  draw.line((2.90, 6.35), (2.90, 5.55), stroke: 1.1pt + black, mark: ar)
  for x in (8.45, 11.75, 15.75) {
    draw.line((x, 5.55), (x, 6.35), stroke: 1.1pt + black, mark: ar)
  }

  // ns-3 云
  let cx = 9.40
  let cy = 2.72
  let pts = range(120).map(i => {
    let a = i * 3deg
    let f = 1 + 0.06 * calc.sin(11 * a)
    (cx + 3.10 * f * calc.cos(a), cy + 1.25 * f * calc.sin(a))
  })
  draw.line(..pts, close: true, fill: white, stroke: 1.4pt + rgb("#2a7fd4"))
  draw.line((9.40, 4.95), (9.40, 4.10), stroke: 1.4pt + black, mark: ar2)
  content((9.40, 3.52), text(size: 12pt, weight: "bold", fill: rgb("#2079d0"))[Adhoc])
  content((9.40, 3.10), text(size: 12pt, weight: "bold", fill: rgb("#2079d0"))[802.11g])
  content((9.40, 2.68), text(size: 12pt, weight: "bold", fill: rgb("#2079d0"))[Wireless Network])
  for i in range(4) {
    draw.rect((8.62 + i * 0.16, 2.08), (8.74 + i * 0.16, 2.08 + 0.08 * (i + 1)),
      fill: rgb("#63aa2e"), stroke: none)
  }
  content((9.55, 2.16), text(size: 11pt, weight: "bold", fill: rgb("#3d7a12"))[ns-3])
  content((9.40, 1.86), text(size: 5pt, fill: rgb("#666666"))[NETWORK SIMULATOR])
})
