#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Multiple UAVs simulation system based on PX4-ROS2 using Gazebo and NS-3
// 来源：Drones 2025, 9(8), 564, Figure 13；DOI 10.3390/drones9080564
// 结构：自上而下——Gazebo 仿真域、docker 容器（Commander/Node 1/Node 2/Node n）
//       、Bridge 总线、ns-3 无线网络云；右侧折线示意 UAV position 与 RSSI 衰减
// 配色：灰 #b0b0b0、红框 #d06060、青框 #5f9f8f、绿线 #8fbf6f、网络蓝 #4a90d9
// 虚线表示 Gazebo 内 1m 机间测距；右侧反馈箭头表示按 UAV position 计算 RSSI 衰减
// 容器配色区分指挥机（红）与成员机（青）；云内 ns-3 承担 802.11g 链路仿真
#let c-gray = rgb("#b0b0b0")
#let c-red = rgb("#d06060")
#let c-teal = rgb("#5f9f8f")
#let c-green = rgb("#8fbf6f")
#let c-blue = rgb("#4a90d9")
#let c-ink = rgb("#1a1a1a")
#canvas({
  import draw: *
  let uav(x, y) = {
    for (dx, dy) in ((-1.05, 0.5), (1.05, 0.5), (-1.05, -0.5), (1.05, -0.5)) {
      line((x, y), (x + dx, y + dy), stroke: 0.9pt + c-ink)
      line((x + dx - 0.42, y + dy), (x + dx + 0.42, y + dy),
        stroke: (thickness: 1.3pt, cap: "round", paint: c-ink))
      circle((x + dx, y + dy), radius: 0.06, fill: c-ink, stroke: none)
    }
    line((x - 0.46, y), (x + 0.46, y),
      stroke: (thickness: 2.4pt, cap: "round", paint: c-ink))
    circle((x, y), radius: 0.2, fill: c-ink, stroke: none)
    line((x - 0.18, y - 0.34), (x + 0.18, y - 0.34), stroke: 0.8pt + c-ink)
  }
  let docker(x, y) = {
    rect((x - 0.5, y - 0.15), (x + 0.36, y + 0.15), radius: 0.07,
      fill: c-blue, stroke: none)
    for i in range(3) {
      rect((x - 0.42 + i * 0.3, y + 0.2), (x - 0.24 + i * 0.3, y + 0.36),
        fill: c-blue, stroke: none)
    }
    line((x + 0.36, y + 0.08), (x + 0.54, y + 0.22), stroke: 1.6pt + c-blue)
    circle((x - 0.26, y + 0.01), radius: 0.035, fill: white, stroke: none)
  }
  let gazebo(x, y) = {
    line((x - 0.28, y), (x, y + 0.15), (x + 0.28, y), (x, y - 0.15), close: true,
      fill: rgb("#e79a3c"), stroke: 0.6pt + c-ink)
    line((x - 0.28, y), (x - 0.28, y - 0.26), (x, y - 0.4), (x, y - 0.15),
      stroke: 0.6pt + c-ink)
    line((x + 0.28, y), (x + 0.28, y - 0.26), (x, y - 0.4), stroke: 0.6pt + c-ink)
  }
  let docker-node(cx, l1, l2, edge) = {
    rect((cx - 2.42, 9.71), (cx + 2.42, 12.24), radius: 0.32, stroke: 2pt + edge)
    docker(cx - 1.86, 11.86)
    content((cx - 1.12, 11.86), anchor: "west", text(size: 7.5pt, fill: c-blue, "docker"))
    content((cx, 11.0), text(size: 10.5pt, weight: "bold", l1))
    content((cx, 10.38), text(size: 10.5pt, weight: "bold", l2))
  }
  rect((0.6, 13.84), (26.44, 18.71), radius: 0.75, stroke: 2pt)
  rect((1.03, 14.26), (7.35, 18.42), fill: c-gray, stroke: none)
  for i in range(9) {
    circle((1.55 + i * 0.63, 15.02 + i * 0.36), radius: 0.19, stroke: 1pt + white)
  }
  circle((2.78, 14.72), radius: 0.09, fill: c-ink, stroke: none)
  gazebo(15.85, 18.0)
  content((16.4, 17.86), anchor: "west", text(size: 11pt, tracking: 1.2pt, "GAZEBO"))
  uav(10.7, 16.15)
  uav(17.3, 16.15)
  uav(24.0, 16.15)
  line((12.3, 16.15), (15.7, 16.15), stroke: (thickness: 1.3pt, dash: "dotted", paint: c-ink))
  line((18.9, 16.15), (22.3, 16.15), stroke: (thickness: 1.3pt, dash: "dotted", paint: c-ink))
  content((14.0, 16.95), text(size: 12pt, "1m"))
  content((20.6, 16.95), text(size: 12pt, "1m"))
  content((10.7, 14.5), text(size: 11pt, "UAV1"))
  content((17.3, 14.5), text(size: 11pt, "UAV2"))
  content((24.0, 14.5), text(size: 11pt, [UAV#emph[n]]))
  for x in (3.75, 11.0, 17.54, 24.05) {
    line((x, 13.84), (x, 12.24), stroke: 2.6pt + c-green)
  }
  docker-node(3.75, [PX4-ROS2], [Commander], c-red)
  docker-node(11.0, [PX4-ROS2], [Node 1], c-teal)
  docker-node(17.54, [PX4-ROS2], [Node 2], c-teal)
  docker-node(24.05, [PX4-ROS2], [Node $n$], c-teal)
  content((20.8, 10.85), text(size: 14pt, weight: "bold", "..."))
  for x in (3.75, 11.0, 17.54, 24.05) {
    line((x, 9.71), (x, 8.24), stroke: 2.2pt)
  }
  rect((0.71, 6.83), (26.44, 8.24), radius: 0.2, stroke: 1.8pt)
  content((13.5, 7.53), text(size: 11.5pt, weight: "bold", "Bridge"))
  line((13.5, 6.83), (13.5, 5.55), stroke: 2.2pt)
  rect((9.0, 1.3), (19.0, 5.7), radius: 1.9, stroke: 1.5pt + c-blue)
  content((14.0, 4.55), text(size: 11pt, weight: "bold", fill: c-blue, "802.11g"))
  content((14.0, 3.8), text(size: 11pt, weight: "bold", fill: c-blue, "Wireless Network"))
  for (i, h) in (0.28, 0.44, 0.6, 0.78).enumerate() {
    rect((12.3 + i * 0.18, 2.5), (12.43 + i * 0.18, 2.5 + h), fill: c-green, stroke: none)
  }
  content((13.05, 2.86), anchor: "west",
    text(size: 14pt, weight: "bold", fill: c-ink, "ns-3"))
  content((13.05, 2.36), anchor: "west",
    text(size: 5.8pt, fill: rgb("#555555"), tracking: 0.4pt, "NETWORK SIMULATOR"))
  line((26.44, 16.5), (27.9, 16.5), (27.9, 3.4), (19.15, 3.4), stroke: 2.2pt,
    mark: (end: "stealth", fill: c-ink, scale: 0.45))
  content((24.2, 4.55), text(size: 11pt, "UAV position"))
  content((24.0, 2.3), text(size: 12pt,
    $R S S I prop frac(1, italic("distance"))$))
})
