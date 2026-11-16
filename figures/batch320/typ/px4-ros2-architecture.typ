#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：PX4-ROS2 System Architecture（PX4 与 ROS 2 系统架构）
// 来源：Drones 2025, 9(8), 564, Figure 1；DOI 10.3390/drones9080564
// 结构：左虚线容器为 PX4 飞控侧——Storage 圆柱、飞控模块、传感器驱动、uORB 发布订阅层、XRCE-DDS Client；
// 右虚线容器为 ROS 2 侧——Client Library 分两路到 Intra-process API 与 Abstract DDS Layer，
// 后者落到 DDS，再经 XRCE-DDS Agent 与左侧 Client 横向桥接。
// 配色沿用原图：浅蓝节点、深蓝描边、虚线容器边。

#canvas({
  import draw: *
  let st = 0.8pt + black
  let bt = 0.8pt + rgb("#5b7db1")
  let bg = rgb("#dae8fc")
  let ar = (end: "stealth", fill: black, scale: 0.45)
  let ar2 = (start: "stealth", end: "stealth", fill: black, scale: 0.45)
  let bx(x0, y0, x1, y1, t, s: 8.5pt) = {
    draw.rect((x0, y0), (x1, y1), fill: bg, stroke: bt)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: s, fill: black)[#t])
  }
  let dbox(x0, y0, x1, y1) = draw.rect((x0, y0), (x1, y1),
    stroke: (paint: black, thickness: 0.7pt, dash: "dashed"))
  let vl(x, y0, y1, m: ar) = draw.line((x, y0), (x, y1), stroke: st, mark: m)
  let hl(x0, x1, y, m: ar) = draw.line((x0, y), (x1, y), stroke: st, mark: m)

  // PX4 侧虚线容器
  dbox(1.30, 0.65, 8.60, 7.45)
  // Storage 圆柱：底弧、筒身、侧线、顶面双弧（用贝塞尔弧拼椭圆）
  draw.bezier((3.80, 6.20), (6.10, 6.20), (3.80, 5.97), (6.10, 5.97), fill: bg, stroke: bt)
  draw.rect((3.80, 6.20), (6.10, 6.90), fill: bg, stroke: none)
  draw.line((3.80, 6.20), (3.80, 6.90), stroke: bt)
  draw.line((6.10, 6.20), (6.10, 6.90), stroke: bt)
  draw.bezier((3.80, 6.90), (6.10, 6.90), (3.80, 6.77), (6.10, 6.77), fill: bg, stroke: bt)
  draw.bezier((3.80, 6.90), (6.10, 6.90), (3.80, 7.03), (6.10, 7.03), stroke: bt)
  content((4.95, 6.52), text(size: 8.5pt)[Storage])
  bx(1.60, 4.55, 4.70, 5.72, [Flight Control Module \ (EKF, Controller)])
  bx(5.20, 4.55, 8.35, 5.72, [Sensor Drivers \ (IMU, GPS)])
  bx(1.60, 3.23, 8.35, 3.82, [uORB (Pub/Sub)])
  bx(1.60, 1.96, 8.35, 2.55, [XRCE-DDS Client])

  // ROS 2 侧虚线容器
  dbox(10.05, 0.65, 17.35, 7.55)
  bx(10.45, 6.10, 13.65, 7.45, [Client Library])
  bx(10.45, 4.30, 13.65, 5.62, [Intra-process API])
  bx(14.20, 4.30, 17.15, 5.62, [Abstract DDS Layer])
  bx(10.45, 3.13, 17.15, 3.70, [DDS])
  bx(10.45, 1.90, 17.15, 2.55, [XRCE-DDS Agent])

  // PX4 侧连接：模块与 uORB 双向，模块与 uORB 汇入 Storage
  vl(3.15, 4.55, 3.82, m: ar2)
  vl(6.75, 4.55, 3.82, m: ar2)
  vl(4.30, 3.23, 2.55, m: ar2)
  draw.line((3.15, 5.72), (3.15, 6.35), (3.80, 6.35), stroke: st, mark: ar)
  draw.line((6.75, 5.72), (6.75, 6.35), (6.10, 6.35), stroke: st, mark: ar)
  vl(4.95, 3.82, 6.20)

  // ROS 2 侧连接
  vl(12.05, 6.10, 5.62)
  draw.line((13.65, 6.78), (15.675, 6.78), (15.675, 5.62), stroke: st, mark: ar)
  vl(15.675, 4.30, 3.70)
  vl(13.80, 3.13, 2.55, m: ar2)
  // XRCE 客户端与代理横向桥接
  hl(8.35, 10.45, 2.255, m: ar2)

  // 两侧标志：PX4 Autopilot 黑底白字，ROS2 点阵加词标
  draw.rect((6.55, 6.72), (8.45, 7.30), radius: 0.18, fill: black, stroke: none)
  content((7.50, 7.10), text(size: 7.5pt, fill: white, weight: "bold")[PX4])
  content((7.50, 6.88), text(size: 5pt, fill: white, style: "italic")[Autopilot])
  for i in range(4) {
    for j in range(3) {
      draw.circle((14.80 + i * 0.24, 7.08 + j * 0.16), radius: 0.045, fill: rgb("#1f3864"))
    }
  }
  content((16.30, 7.10), text(size: 13pt, fill: rgb("#1f3864"), weight: "bold")[ROS2])
})
