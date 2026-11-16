#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图 5  外骨骼八杆机构侧视运动简图（Figure 5）
// 来源：Technologies 2025, 13, 463，DOI: 10.3390/technologies13100463
// 结构：固定铰 O_2 与 O_4=D 支撑整机；杆 2、3 位于左侧，杆 4 与杆 6 在中部交错成 X，
//       杆 5 连 O_4 到 E，杆 7 自 C 竖直向下到 F，杆 8 由 F 收束到踝点 G。
// 几何：C-O_4-E 与 E-F-G 两处三角区域浅灰填充；G 下方红色虚线是闭合踝关节轨迹。

#canvas(length: 0.55pt, {
  import draw: *

  // 源图坐标 x 向右、y 向下；P 翻转到画布坐标，ps 把像素线宽换成描边点值
  let P(x, y) = (x, -y)
  let ps(k) = k * 0.55pt

  let c-edge  = rgb("#2B2B2B")
  let c-fill  = rgb("#D9D9D9")
  let c-shade = rgb("#E7E7E7")
  let c-thin  = rgb("#3A3A3A")
  let c-red   = rgb("#FF0000")

  // 各铰点的源图像素坐标
  let O2 = (125, 175)
  let A  = (195, 190)
  let B  = (217, 437)
  let O4 = (350, 88)
  let C  = (488, 47)
  let E  = (464, 472)
  let F  = (508, 490)
  let G  = (326, 780)

  // 浅灰圆角连杆：深灰粗底叠浅灰内芯，形成双线加粗轮廓
  let bar(a, b, w: 16) = {
    line(P(a.at(0), a.at(1)), P(b.at(0), b.at(1)),
      stroke: (paint: c-edge, thickness: ps(w + 2.4), cap: "round"))
    line(P(a.at(0), a.at(1)), P(b.at(0), b.at(1)),
      stroke: (paint: c-fill, thickness: ps(w), cap: "round"))
  }

  // 细连线与浅灰填充三角
  let thin(a, b) = line(P(a.at(0), a.at(1)), P(b.at(0), b.at(1)),
    stroke: (paint: c-thin, thickness: ps(1.5)))
  let tri(a, b, c) = line(
    P(a.at(0), a.at(1)), P(b.at(0), b.at(1)), P(c.at(0), c.at(1)),
    close: true, fill: c-shade,
    stroke: (paint: c-thin, thickness: ps(1.6)))

  // 关节：白色小圆 + 深灰描边
  let pin(p) = circle(P(p.at(0), p.at(1)), radius: 7,
    fill: white, stroke: (paint: c-edge, thickness: ps(1.9)))

  // 固定铰支座：小三角 + 底座横线 + 斜线剖面
  let ground(p) = {
    let x = p.at(0)
    let y = p.at(1) + 6
    line(P(x, y), P(x - 13, y + 18), stroke: (paint: c-edge, thickness: ps(1.7)))
    line(P(x, y), P(x + 13, y + 18), stroke: (paint: c-edge, thickness: ps(1.7)))
    line(P(x - 20, y + 18), P(x + 20, y + 18),
      stroke: (paint: c-edge, thickness: ps(1.9)))
    for k in range(-3, 4) {
      line(P(x + k * 6 - 4, y + 18), P(x + k * 6 - 10, y + 27),
        stroke: (paint: c-edge, thickness: ps(1.2)))
    }
  }

  // 标签：默认加粗深灰，可指定锚点与字号
  let label(p, body, a: "center", sz: 10pt, w: "bold") = content(
    P(p.at(0), p.at(1)), anchor: a,
    text(size: sz, weight: w, fill: c-edge, body))

  // 浅灰填充三角区域（杆 4 与杆 8 的板体）
  tri(O4, C, E)
  tri(E, F, G)

  // 红色虚线闭合踝关节轨迹：采样点经 hobby 平滑成环
  let traj = ((332, 779), (395, 795), (450, 804), (472, 811),
              (450, 826), (385, 835), (305, 834), (225, 824),
              (145, 803), (80, 778), (40, 750), (38, 725),
              (55, 700), (90, 685), (140, 690), (205, 710), (265, 745))
  hobby(..traj.map(p => P(p.at(0), p.at(1))), close: true,
    stroke: (paint: c-red, thickness: ps(2.2), dash: "dashed"))

  // 八根连杆，中部编号 2-8
  bar(O2, A, w: 15)
  bar(A, B, w: 14)
  bar(B, O4, w: 18)
  bar(O4, E, w: 17)
  bar(A, E, w: 19)
  bar(C, F, w: 12)
  bar(F, G, w: 13)
  thin(O4, C)
  thin(C, E)

  // 固定铰支座画在杆体之上，三角与斜线才不被连杆遮盖
  ground(O2)
  ground(O4)

  // 关节白圆置于杆体之上
  for p in (O2, A, B, O4, C, E, F, G) { pin(p) }

  // 点名
  label((108, 166), $O_2$, a: "east")
  label((195, 170), [A], a: "south")
  label((200, 440), [B], a: "east")
  label((348, 64), $O_4 = D$, a: "south")
  label((492, 33), [C], a: "south")
  label((478, 465), [E], a: "west")
  label((522, 490), [F], a: "west")
  label((296, 735), [G], a: "east")

  // 连杆编号置于杆侧空白处
  label((168, 163), [2])
  label((192, 312), [3])
  label((316, 222), [4])
  label((432, 268), [5])
  label((365, 400), [6])
  label((522, 252), [7])
  label((452, 548), [8])
})
