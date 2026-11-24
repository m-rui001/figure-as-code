#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#canvas(length: 1cm, {
  import draw: *
  let ink = black
  let wire = (paint: ink, thickness: 0.8pt)
  let node(p) = circle(p, radius: 0.07, fill: ink, stroke: none)
  // 四开关由两个桥臂组成，反并联二极管跨接开关节点
  let transistor(x, top, bottom) = {
    line((x, top), (x, top - 0.30), stroke: wire)
    line((x, top - 0.30), (x - 0.42, top - 0.30), stroke: wire)
    line((x, top - 0.30), (x, bottom + 0.61), stroke: wire)
    line((x - 0.42, top - 0.18), (x - 0.42, top - 0.82), stroke: wire)
    line((x - 0.58, top - 0.30), (x - 0.84, top - 0.30), stroke: wire)
    line((x - 0.28, bottom + 0.62), (x - 0.84, bottom + 0.62), stroke: wire)
    line((x - 0.42, bottom + 0.30), (x - 0.42, bottom + 1.02), stroke: wire)
    line((x - 0.58, bottom + 0.66), (x - 0.84, bottom + 0.66), stroke: wire)
    line((x - 0.30, bottom + 0.75), (x - 0.09, bottom + 0.43), stroke: wire)
    line((x - 0.30, bottom + 0.47), (x - 0.09, bottom + 0.79), stroke: wire)
    line((x - 0.09, bottom + 0.43), (x - 0.09, bottom + 0.79), stroke: wire)
    line((x + 0.38, bottom + 0.61), (x + 0.38, top - 0.40), stroke: wire)
    line((x + 0.38, bottom + 0.61), (x, bottom + 0.61), stroke: wire)
    line((x + 0.38, top - 0.40), (x, top - 0.40), stroke: wire)
    line((x + 0.38, bottom + 1.04), (x + 0.20, bottom + 1.39), stroke: wire)
    line((x + 0.56, bottom + 1.04), (x + 0.20, bottom + 1.39), stroke: wire)
    line((x + 0.20, bottom + 1.39), (x + 0.20, bottom + 0.98), stroke: wire)
    line((x, bottom + 0.61), (x, bottom), stroke: wire)
    line((x + 0.08, bottom + 0.83), (x + 0.38, bottom + 1.02), stroke: wire)
    line((x + 0.08, bottom + 0.57), (x + 0.38, bottom + 0.38), stroke: wire)
  }
  // 直流侧两个等值电容跨接正负母线
  let capacitor(x, y) = {
    line((x, y + 0.52), (x, y + 0.18), stroke: wire)
    line((x - 0.38, y + 0.18), (x + 0.38, y + 0.18), stroke: wire)
    line((x - 0.38, y), (x + 0.38, y), stroke: wire)
    line((x, y), (x, y - 0.52), stroke: wire)
  }
  // 阻尼支路采用三个并联电容
  let filter-capacitor(x, bottom) = {
    line((x, bottom), (x, bottom + 0.34), stroke: wire)
    line((x - 0.27, bottom + 0.34), (x + 0.27, bottom + 0.34), stroke: wire)
    line((x - 0.27, bottom + 0.48), (x + 0.27, bottom + 0.48), stroke: wire)
    line((x - 0.27, bottom + 0.64), (x + 0.27, bottom + 0.64), stroke: wire)
    line((x, bottom + 0.64), (x, bottom + 0.98), stroke: wire)
  }
  let damping-resistor(x, top, bottom) = {
    line((x, top), (x, top - 0.35), stroke: wire)
    line((x, top - 0.35), (x - 0.17, top - 0.52),
      (x + 0.17, top - 0.69), (x - 0.17, top - 0.86),
      (x + 0.17, top - 1.03), (x, top - 1.20), stroke: wire)
    line((x, top - 1.20), (x, bottom), stroke: wire)
  }
  let resistor(x, y) = {
    let pts = ((x - 0.70, y), (x - 0.52, y), (x - 0.40, y + 0.17),
      (x - 0.20, y - 0.17), (x, y + 0.17), (x + 0.20, y - 0.17),
      (x + 0.40, y + 0.17), (x + 0.52, y), (x + 0.70, y))
    line(..pts, stroke: wire)
  }
  let inductor(x, y) = {
    line((x - 0.82, y), (x - 0.64, y), stroke: wire)
    for k in range(4) {
      let a = x - 0.64 + k * 0.32
      bezier((a, y), (a + 0.32, y), (a, y + 0.34), (a + 0.32, y + 0.34))
    }
    line((x + 0.64, y), (x + 0.82, y), stroke: wire)
  }
  let sensor(x, y, label) = {
    circle((x, y), radius: 0.22, fill: white, stroke: wire)
    content((x, y), label)
    line((x, y - 0.22), (x, y - 0.50), stroke: wire)
  }
  let source(x, y, label) = {
    circle((x, y), radius: 0.48, fill: white, stroke: wire)
    line((x - 0.22, y), (x + 0.22, y), stroke: (paint: ink, thickness: 0.5pt))
    bezier((x - 0.19, y + 0.05), (x + 0.19, y + 0.05),
      (x - 0.19, y - 0.38), (x + 0.19, y - 0.38))
    content((x, y + 0.95), label, anchor: "south")
  }
  // 交流输出依次经过逆变器侧、电网侧电抗器与电流方向标记
  let branch(y, current, first, second) = {
    line((-2.10, y), (18.75, y), stroke: wire)
    resistor(0.2, y)
    inductor(1.45, y)
    content((1.45, y + 0.72), first, anchor: "south")
    resistor(7.2, y)
    inductor(8.45, y)
    content((7.95, y + 0.72), second, anchor: "south")
    resistor(14.6, y)
    inductor(15.85, y)
    content((14.6, y + 0.72), $r_c, L_c$, anchor: "south")
    content((15.85, y + 0.72), current, anchor: "south")
    line((11.05, y), (11.72, y), stroke: wire,
      mark: (end: "stealth", fill: black, scale: 0.45))
    line((18.1, y), (18.75, y), stroke: wire,
      mark: (end: "stealth", fill: black, scale: 0.45))
  }
  let leg(x) = {
    line((x, 10.4), (x, 9.35), stroke: wire)
    transistor(x, 9.35, 6.95)
    line((x, 6.95), (x, 6.0), stroke: wire)
    node((x, 6.0))
    transistor(x, 6.0, 3.60)
    line((x, 3.60), (x, 0.6), stroke: wire)
  }
  line((-16.8, 6.3), (-14.8, 6.3), stroke: wire)
  line((-11.0, 10.4), (-11.0, 0.6), stroke: wire)
  line((-11.0, 10.4), (-3.0, 10.4), stroke: wire)
  line((-11.0, 0.6), (-3.0, 0.6), stroke: wire)
  capacitor(-9.6, 9.1)
  capacitor(-9.6, 1.9)
  content((-9.6, 9.85), [$C$], anchor: "south")
  content((-9.6, 1.15), [$C$], anchor: "north")
  leg(-7.0)
  leg(-3.0)
  for p in ((-7.0, 10.4), (-3.0, 10.4), (-7.0, 0.6), (-3.0, 0.6)) { node(p) }
  line((-11.0, 6.3), (-11.0, 0.6), stroke: wire)
  line((-14.8, 5.95), (-14.8, 6.65), stroke: wire)
  line((-14.55, 6.12), (-14.55, 6.48), stroke: wire)
  line((-14.55, 6.3), (-11.0, 6.3), stroke: wire)
  content((-17.1, 6.3), $V_("dc")$, anchor: "east")
  content((-14.45, 6.85), $+$, anchor: "east")
  content((-14.45, 5.75), $-$, anchor: "east")
  // 桥臂中点经电容交接跨线引出，避免导线误接
  for (x, y) in ((-7.0, 8.2), (-3.0, 6.0), (-7.0, 3.8)) {
    line((x, y), (x + 0.40, y), stroke: wire)
    bezier((x + 0.40, y), (x + 0.80, y), (x + 0.40, y + 0.58), (x + 0.80, y + 0.58))
    line((x + 0.80, y + 0.58), (-2.10, y + 0.58), stroke: wire)
  }
  node((-7.0, 8.2))
  node((-3.0, 6.0))
  node((-7.0, 3.8))
  branch(8.78, $i_("a2")$, $r_a, L_a$, $r_b, L_b$)
  branch(6.58, $i_("b2")$, $r_b, L_b$, $r_c, L_c$)
  branch(4.38, $i_("c2")$, $r_c, L_c$, $r_a, L_a$)
  sensor(-2.25, 8.20, $i_("a1")$)
  sensor(-2.25, 6.00, $i_("b1")$)
  sensor(-2.25, 3.80, $i_("c1")$)
  line((-2.10, 8.78), (-2.25, 8.42), stroke: wire)
  line((-2.10, 6.58), (-2.25, 6.22), stroke: wire)
  line((-2.10, 4.38), (-2.25, 4.02), stroke: wire)
  node((5.35, 8.78))
  node((5.35, 6.58))
  node((5.35, 4.38))
  line((5.35, 8.78), (5.35, -0.45), stroke: wire)
  line((8.25, 6.58), (8.25, -0.45), stroke: wire)
  line((8.25, 6.58), (8.25, 4.38), stroke: wire)
  line((11.1, 6.58), (11.1, 4.38), stroke: wire)
  line((5.35, -0.45), (11.1, -0.45), stroke: wire)
  for x in (5.95, 8.25, 10.55) {
    filter-capacitor(x, -2.0)
    line((x, -0.45), (x, -1.02), stroke: wire)
    content((x, -2.3), $C_f$, anchor: "north")
  }
  damping-resistor(7.10, -0.45, -2.0)
  content((7.55, -1.25), $R_d$, anchor: "west")
  // 三相电流方向与公共星形点保留原始拓扑
  content((12.0, 7.52), $i_("ga")$, anchor: "south")
  content((12.0, 5.32), $i_("gb")$, anchor: "south")
  content((12.0, 3.12), $i_("gc")$, anchor: "south")
  content((18.85, 6.85), $i_("ga")$, anchor: "south")
  content((18.85, 4.65), $i_("gb")$, anchor: "south")
  content((18.85, 2.45), $i_("gc")$, anchor: "south")
  source(20.9, 8.78, $V_("ga")$)
  source(20.9, 6.58, $V_("gb")$)
  source(20.9, 4.38, $V_("gc")$)
  line((19.98, 8.78), (20.9, 8.78), stroke: wire)
  line((19.98, 6.58), (20.9, 6.58), stroke: wire)
  line((19.98, 4.38), (20.9, 4.38), stroke: wire)
  for y in (8.78, 6.58, 4.38) { line((21.38, y), (22.0, y), stroke: wire) }
  line((22.0, 8.78), (22.0, 4.38), stroke: wire)
  node((22.0, 6.58))
  content((22.25, 6.58), $v_N$, anchor: "west")
})
