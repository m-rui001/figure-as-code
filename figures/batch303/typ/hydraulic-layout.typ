#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：液压系统原理图（Hydraulic layout of the system）
// 来源：Technologies 2025, 13, 236, Figure 2；DOI: 10.3390/technologies13060236
// 结构：C 热负载 → RH1 可变节流 → Ssig 安全溢流阀 → 右 T 油箱；C 下方接左 T 油箱
// 中部支路：Tq 流量计 → DH 三位四通方向阀 → P 泵；Tp 压力传感器经支路接入
// 底部：M 电机经双线联轴器驱动 P 泵，泵出口与阀回油分别接入 T 油箱
#canvas(length: 1cm, {
  import draw: *
  let lw = 1.0pt
  let bw = 0.8pt
  let ln(..p) = line(..p, stroke: (paint: black, thickness: lw))
  let thin(..p) = line(..p, stroke: (paint: black, thickness: bw))
  let dsh(..p) = line(..p, stroke: (paint: black, thickness: bw, dash: "dashed"))
  let arw(a, b) = line(a, b, stroke: (paint: black, thickness: lw),
    mark: (end: "stealth", fill: black, scale: 0.45))
  let bxo(x1, y1, x2, y2) = line((x1, y1), (x2, y1), (x2, y2), (x1, y2),
    close: true, stroke: (paint: black, thickness: lw))
  let tank(x, yb, yt, w: 0.7) = line((x - w, yt), (x - w, yb), (x + w, yb),
    (x + w, yt), stroke: (paint: black, thickness: lw))

  // C 执行器/热负载与左侧 T 油箱
  ln((2.2, 16.85), (2.2, 15.0))
  tank(1.5, 13.8, 15.0)
  bxo(1.25, 16.85, 3.15, 18.75)
  content((2.2, 17.8), [C])
  content((3.5, 14.9), [T])

  // 顶部水平主线与右侧 T 油箱
  ln((3.15, 17.8), (13.1, 17.8))
  ln((14.9, 17.8), (18.9, 17.8), (18.9, 16.8))
  tank(18.2, 15.6, 16.8)
  content((19.55, 16.65), [T])

  // RH1 可变节流阀（交叉圆弧 + 斜向箭头）
  bezier((6.3, 18.5), (7.7, 17.1), (7.1, 18.3), (6.9, 17.3),
    stroke: (paint: black, thickness: bw))
  bezier((6.3, 17.1), (7.7, 18.5), (6.9, 17.3), (7.1, 18.3),
    stroke: (paint: black, thickness: bw))
  arw((6.45, 17.35), (7.55, 18.35))
  content((6.85, 19.1), [RH1])

  // Ssig 安全溢流阀（方框内箭头，虚线先导）
  bxo(13.1, 16.9, 14.9, 18.7)
  arw((13.35, 17.8), (14.65, 17.8))
  dsh((12.6, 17.8), (12.6, 16.2), (13.3, 16.2), (13.3, 16.9))
  content((14.0, 19.1), [Ssig])

  // Tq 流量计（圆形 + 两段月牙弧）
  ln((9.9, 17.8), (9.9, 15.8))
  circle((9.9, 15.2), radius: 0.6, stroke: (paint: black, thickness: lw))
  bezier((9.65, 15.65), (9.65, 14.75), (9.95, 15.4), (9.95, 15.0),
    stroke: (paint: black, thickness: bw))
  bezier((10.15, 15.65), (10.15, 14.75), (9.85, 15.4), (9.85, 15.0),
    stroke: (paint: black, thickness: bw))
  content((9.0, 15.95), [Tq])
  ln((9.9, 14.6), (9.9, 10.4))

  // Tp 压力传感器（斜线方框 + P）
  bxo(6.9, 10.9, 8.5, 12.5)
  thin((6.9, 12.5), (8.5, 10.9))
  thin((7.05, 12.15), (7.9, 12.15))
  content((8.05, 11.35), [P])
  content((7.6, 12.95), [Tp])
  ln((7.6, 10.9), (7.6, 10.4), (9.9, 10.4))
  circle((9.9, 10.4), radius: 0.07, fill: black, stroke: none)

  // DH 三位四通方向阀（两个并排方框）
  ln((9.9, 10.4), (9.9, 9.0))
  bxo(8.3, 7.4, 9.9, 9.0)
  bxo(9.9, 7.4, 11.5, 9.0)
  arw((8.85, 7.75), (8.85, 8.65))
  arw((9.45, 8.65), (9.45, 7.75))
  thin((10.55, 8.55), (10.55, 7.85))
  thin((10.95, 8.55), (10.95, 7.85))
  let sp = ((11.5, 8.2),)
  for i in range(1, 5) {
    sp.push((11.5 + i * 0.25, if calc.odd(i) { 8.42 } else { 7.98 }))
  }
  sp.push((12.5, 8.2))
  thin(..sp)
  content((7.7, 8.2), [DH])
  content((12.95, 8.2), [WW])

  // 阀回油至右侧底部 T 油箱
  ln((11.5, 8.2), (12.7, 8.2), (12.7, 2.4))
  ln((9.9, 7.4), (9.9, 5.35))

  // P 泵（圆内实心三角 + 旋向箭头）
  circle((9.9, 4.6), radius: 0.75, stroke: (paint: black, thickness: lw))
  line((9.9, 5.25), (9.55, 4.5), (10.25, 4.5), close: true, fill: black, stroke: none)
  content((9.9, 4.18), [P])
  bezier((10.6, 3.95), (10.95, 4.75), (11.05, 4.15), (11.1, 4.55),
    stroke: (paint: black, thickness: lw),
    mark: (end: "stealth", fill: black, scale: 0.45))
  ln((9.9, 3.85), (9.9, 2.4))

  // 底部 T 油箱
  tank(11.3, 1.2, 2.4, w: 1.4)
  content((13.75, 2.05), [T])

  // M 电机与双线联轴器
  circle((5.0, 4.6), radius: 0.75, stroke: (paint: black, thickness: lw))
  content((5.0, 4.6), [M])
  ln((5.75, 4.78), (9.15, 4.78))
  ln((5.75, 4.42), (9.15, 4.42))
  thin((6.85, 4.3), (6.85, 4.9))
  thin((8.05, 4.3), (8.05, 4.9))
})
