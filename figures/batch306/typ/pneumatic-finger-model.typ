#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Mechanical model of the developed pneumatic finger（气动手指三连杆摆机械模型）
// 来源：Actuators 2025, 14(2), 252, Figure 12；DOI: 10.3390/act14020252
// 结构：右上固定端 O 与剖面线墙面，三连杆向左下悬垂，灰色软体轮廓包覆粗黑杆；
//       零位虚线、夹角 α1–α3、力矩 M1–M3、关节阻尼 b/ct、杆参数 m/l/J；
//       右下为单连杆局部坐标图（S_i、j r_Si、β_i、红色 xj/yj 轴）。
#let norm(a) = if a < 180deg { a + 360deg } else { a }
#let blob(js, ws, n) = {
  let left = ()
  let right = ()
  let seg = js.len() - 1
  for i in range(seg) {
    let a = js.at(i)
    let b = js.at(i + 1)
    let w = ws.at(i)
    let dx = b.at(0) - a.at(0)
    let dy = b.at(1) - a.at(1)
    let l = calc.sqrt(dx * dx + dy * dy)
    let nx = -dy / l
    let ny = dx / l
    for k in range(n) {
      let t = float(k) / float(n)
      let g = float(i + t) / float(seg)
      let w1 = w + 0.14 * calc.sin(5 * g * 360deg) + 0.07 * calc.sin(9 * g * 360deg + 90deg)
      let w2 = w + 0.13 * calc.sin(6 * g * 360deg + 40deg) + 0.06 * calc.sin(11 * g * 360deg)
      left.push((a.at(0) + dx * t + nx * w1, a.at(1) + dy * t + ny * w1))
      right.push((a.at(0) + dx * t - nx * w2, a.at(1) + dy * t - ny * w2))
    }
  }
  left + right.rev()
}
#let softbody(pts) = {
  draw.line(..pts, close: true, stroke: 4pt + luma(235))
  draw.line(..pts, close: true, stroke: 0.8pt + black)
}
#let arc-at(c, r, a1, a2) = draw.arc(
  (c.at(0) + r * calc.cos(a1), c.at(1) + r * calc.sin(a1)),
  start: a1, stop: a2, radius: r, stroke: 1pt,
  mark: (end: "stealth", fill: black, scale: 0.45),
)
#let joint(c, r) = {
  draw.circle(c, radius: (r, r), fill: white, stroke: 1.2pt + black)
  draw.circle(c, radius: (0.09, 0.09), fill: black, stroke: none)
}
#canvas({
  import draw: *
  let O = (13.9, 8.65)
  let J2 = (10.3, 7.14)
  let J3 = (7.9, 4.11)
  let TIP = (7.0, 0.39)
  let js = (O, J2, J3, TIP)
  let a1 = norm(calc.atan2(J2.at(0) - O.at(0), J2.at(1) - O.at(1)))
  let a2 = norm(calc.atan2(J3.at(0) - J2.at(0), J3.at(1) - J2.at(1)))
  let a3 = norm(calc.atan2(TIP.at(0) - J3.at(0), TIP.at(1) - J3.at(1)))
  let dash = (paint: black, thickness: 1pt, dash: "dashed")
  let mk = (end: "stealth", fill: black, scale: 0.45)
  // 零位虚线与墙面
  draw.line((1.5, 8.65), (14.2, 8.65), stroke: dash)
  content((2.9, 8.85), [zero level], anchor: "south")
  draw.line((14.45, 7.7), (14.45, 9.7), stroke: 1.2pt)
  for i in range(8) {
    let y = 7.8 + 0.25 * i
    draw.line((14.45, y), (14.75, y + 0.28), stroke: 0.8pt)
  }
  // 软体轮廓与三连杆
  softbody(blob(js, (0.55, 0.5, 0.42), 14))
  draw.line(..js, stroke: 2.5pt + black)
  joint(O, 0.3)
  joint(J2, 0.3)
  joint(J3, 0.3)
  draw.circle(TIP, radius: (0.16, 0.16), fill: white, stroke: 1.2pt + black)
  // 夹角弧（自零位虚线指向各杆）
  arc-at(O, 1.35, 180deg, a1)
  arc-at(J2, 1.55, 180deg, a2)
  arc-at(J3, 1.55, 180deg, a3)
  content((10.75, 8.45), $alpha_1$, anchor: "north")
  content((8.35, 6.45), $alpha_2$, anchor: "north")
  content((6.2, 3.15), $alpha_3$, anchor: "north")
  // 力矩弧箭头
  arc-at(O, 1.05, 100deg, 195deg)
  arc-at(J2, 0.95, 95deg, 190deg)
  arc-at(J3, 0.95, 95deg, 190deg)
  content((13.0, 9.75), $arrow(M)_1$)
  content((9.05, 8.0), $arrow(M)_2$)
  content((6.55, 4.85), $arrow(M)_3$)
  // 阻尼/弹簧参数符号
  draw.line((13.9, 8.35), (13.65, 8.1), stroke: 1pt)
  draw.rect((13.45, 7.75), (13.95, 8.1), stroke: 1pt)
  draw.line(J2, (9.8, 6.8), stroke: 1pt)
  draw.rect((9.55, 6.45), (10.05, 6.8), stroke: 1pt)
  draw.line(J3, (7.7, 3.8), stroke: 1pt)
  draw.rect((7.45, 3.45), (7.95, 3.8), stroke: 1pt)
  content((15.55, 8.05), $b_1, c_t med 1$)
  content((11.35, 6.1), $b_2, c_t med 2$)
  content((9.05, 3.2), $b_3, c_t med 3$)
  content((12.8, 7.0), $m_1, l_1, J_1$)
  content((10.45, 5.0), $m_2, l_2, J_2$)
  content((8.9, 1.9), $m_3, l_3, J_3$)
  // 重力与右上局部坐标
  draw.line((15.6, 6.7), (15.6, 5.15), mark: mk, stroke: 1.2pt)
  content((16.1, 5.9), $arrow(g)$)
  draw.line((16.1, 9.95), (15.15, 9.95), mark: mk, stroke: 1.2pt)
  draw.line((16.1, 9.95), (16.1, 9.0), mark: mk, stroke: 1.2pt)
  content((15.55, 10.25), $x$)
  content((16.65, 10.2), $O$)
  content((16.5, 9.35), $y$)
  // 右下：单连杆局部坐标图
  let P = (11.7, 1.91)
  let Q = (17.3, 3.95)
  let Si = (12.7, 2.89)
  draw.line((10.4, 3.93), (17.35, 3.93), stroke: dash)
  softbody(blob((P, Q), (0.55,), 24))
  draw.line(P, Q, stroke: 2.5pt + black)
  draw.circle(P, radius: (0.2, 0.2), fill: white, stroke: 1.2pt + black)
  draw.circle(Q, radius: (0.13, 0.13), fill: white, stroke: 1.2pt + black)
  draw.line(Q, Si, stroke: 0.9pt)
  draw.circle(Si, radius: (0.06, 0.06), fill: black, stroke: none)
  content((12.15, 3.3), $S_i$)
  content((14.95, 4.42), $arrow(r)_(S i)$)
  content((14.25, 4.55), $j$)
  arc-at(P, 1.5, calc.atan2(Q.at(0) - P.at(0), Q.at(1) - P.at(1)), calc.atan2(Si.at(0) - P.at(0), Si.at(1) - P.at(1)))
  content((13.4, 1.7), $beta_i$)
  let mkr = (end: "stealth", fill: red, scale: 0.45)
  draw.line(Q, (17.05, 4.65), mark: mkr, stroke: 1.2pt + red)
  draw.line(Q, (16.45, 3.72), mark: mkr, stroke: 1.2pt + red)
  content((17.65, 4.5), $y_j$)
  content((17.45, 3.35), $x_j$)
})
