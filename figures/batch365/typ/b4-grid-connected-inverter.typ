#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：B4 并网逆变器主电路；来源：Electronics 2024, 13, 1755，Figure 1，DOI 10.3390/electronics13091755。
// a 相出自左桥臂上中点，b 相出自右桥臂中点，c 相出自左桥臂下中点；a/c 跨右桥臂时用桥弧。
// 两只 C 串联跨接直流母线，中点接 b 相节点；每相三组 r/L 串联，阻尼为三组 Rd–Cf。

#canvas(length: 1cm, {
  import draw: *
  let ink = black
  let wire = (paint: ink, thickness: 0.8pt)
  let node(p) = circle(p, radius: 0.07, fill: ink, stroke: none)
  let bridge(x, y, r: 0.30) = bezier((x - r, y), (x + r, y),
    (x - r, y + 0.5523 * r), (x + r, y + 0.5523 * r), stroke: wire)
  let transistor(x, top, bottom, dir: 1) = {
    let m = (top + bottom) / 2
    line((x, top), (x, bottom), stroke: wire)
    line((x, top), (x + 0.38, top), stroke: wire)
    line((x, bottom), (x + 0.38, bottom), stroke: wire)
    line((x - 0.42, m + 0.20), (x - 0.42, m - 0.20), stroke: wire)
    line((x - 0.72, m), (x - 0.42, m), stroke: wire)
    line((x + 0.38, top), (x + 0.38, bottom), stroke: wire)
    line((x + 0.38, m + 0.22 * dir), (x + 0.20, m - 0.22 * dir), stroke: wire)
    line((x + 0.38, m - 0.22 * dir), (x + 0.20, m + 0.22 * dir), stroke: wire)
    line((x + 0.20, m - 0.22 * dir), (x + 0.20, m + 0.22 * dir), stroke: wire)
    line((x + 0.15, m - 0.30), (x + 0.15, m + 0.30), stroke: wire)
  }
  let capacitor(x, y) = {
    line((x, y + 0.48), (x, y + 0.16), stroke: wire)
    line((x - 0.34, y + 0.16), (x + 0.34, y + 0.16), stroke: wire)
    line((x - 0.34, y), (x + 0.34, y), stroke: wire)
    line((x, y), (x, y - 0.48), stroke: wire)
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
      bezier((a, y), (a + 0.32, y), (a, y + 0.34), (a + 0.32, y + 0.34), stroke: wire)
    }
    line((x + 0.64, y), (x + 0.82, y), stroke: wire)
  }
  let current(x, y, label) = {
    circle((x, y), radius: 0.27, fill: white, stroke: wire)
    content((x, y), label)
  }
  let arrow(x, y) = line((x - 0.45, y), (x + 0.25, y), stroke: wire,
    mark: (end: "stealth", fill: black, scale: 0.45))
  let source(x, y, label) = {
    circle((x, y), radius: 0.48, fill: white, stroke: wire)
    bezier((x - 0.20, y), (x + 0.20, y), (x - 0.18, y + 0.34), (x + 0.18, y + 0.34), stroke: wire)
    bezier((x + 0.20, y), (x - 0.20, y), (x + 0.18, y - 0.34), (x - 0.18, y - 0.34), stroke: wire)
    content((x, y + 0.72), label, anchor: "south")
  }
  let damping(x, y, bus, label_r: false) = {
    line((x, y), (x, 1.65), stroke: wire)
    line((x, 1.65), (x - 0.15, 1.47), (x + 0.15, 1.29),
      (x - 0.15, 1.11), (x + 0.15, 0.93), (x - 0.15, 0.75), (x, 0.52), stroke: wire)
    if label_r { content((x + 0.28, 1.08), $R_d$, anchor: "west") }
    line((x, 0.52), (x, 0.23), stroke: wire)
    capacitor(x, -0.25)
    line((x, -0.73), (x, bus), stroke: wire)
  }
  let phase(y, idx, first, second, third, i1, i2, ig) = {
    let x1 = 1.25 + idx * 2.15; let l1 = x1 + 1.65; let n1 = l1 + 1.27
    let x2 = 6.35 + idx * 2.35; let l2 = x2 + 1.65
    let x3 = 15.15; let l3 = 16.80
    line((-0.75, y), (-0.22, y), stroke: wire); line((0.32, y), (x1 - 0.70, y), stroke: wire)
    current(0.05, y, i1)
    resistor(x1, y); line((x1 + 0.70, y), (l1 - 0.82, y), stroke: wire)
    inductor(l1, y); line((l1 + 0.82, y), (n1, y), stroke: wire); node((n1, y))
    line((n1, y), (x2 - 0.70, y), stroke: wire)
    resistor(x2, y); line((x2 + 0.70, y), (l2 - 0.82, y), stroke: wire)
    inductor(l2, y); line((l2 + 0.82, y), (x3 - 0.70, y), stroke: wire)
    resistor(x3, y); line((x3 + 0.70, y), (l3 - 0.82, y), stroke: wire)
    inductor(l3, y); line((l3 + 0.82, y), (19.05, y), stroke: wire)
    content((x1 + 0.15, y + 0.55), first, anchor: "south")
    content((x2 + 0.78, y + 0.55), second, anchor: "south")
    content((x3 + 0.63, y + 0.55), third, anchor: "south")
    arrow(x2 + 3.00, y); content((x2 + 3.00, y + 0.48), i2, anchor: "south")
    arrow(18.25, y); content((18.25, y + 0.48), ig, anchor: "south")
    damping(n1, y, -1.35, label_r: idx == 0)
  }

  content((-17.1, 6.3), $V_("dc")$, anchor: "east")
  line((-14.8, 10.4), (-14.8, 6.65), stroke: wire)
  line((-15.2, 6.65), (-14.4, 6.65), stroke: wire)
  line((-15.0, 5.95), (-14.6, 5.95), stroke: wire)
  line((-14.8, 5.95), (-14.8, 0.6), stroke: wire)
  content((-15.35, 6.85), $+$, anchor: "east"); content((-15.35, 5.75), $-$, anchor: "east")
  line((-14.8, 10.4), (-0.80, 10.4), stroke: wire)
  line((-14.8, 0.6), (-0.80, 0.6), stroke: wire)

  transistor(-7.0, 10.4, 8.2); transistor(-7.0, 8.2, 0.6, dir: -1)
  transistor(-3.0, 10.4, 6.0); transistor(-3.0, 6.0, 0.6, dir: -1)
  line((-1.20, 10.4), (-1.20, 9.73), stroke: wire); capacitor(-1.20, 9.25)
  line((-1.20, 8.77), (-1.20, 6.0), stroke: wire)
  line((-1.20, 6.0), (-1.20, 2.23), stroke: wire); capacitor(-1.20, 1.75)
  line((-1.20, 1.27), (-1.20, 0.6), stroke: wire)
  content((-0.55, 9.25), $C$, anchor: "west"); content((-0.72, 1.75), $C$, anchor: "west")
  for p in ((-14.8, 10.4), (-14.8, 0.6), (-7.0, 10.4), (-7.0, 0.6),
      (-3.0, 10.4), (-3.0, 0.6), (-7.0, 8.2), (-7.0, 4.4), (-3.0, 6.0),
      (-1.20, 10.4), (-1.20, 6.0), (-1.20, 0.6)) { node(p) }

  line((-7.0, 8.2), (-3.30, 8.2), stroke: wire); bridge(-3.0, 8.2)
  line((-2.70, 8.2), (-1.50, 8.2), stroke: wire); bridge(-1.20, 8.2)
  line((-0.90, 8.2), (-0.75, 8.2), stroke: wire)
  line((-3.0, 6.0), (-0.75, 6.0), stroke: wire)
  line((-7.0, 4.4), (-3.30, 4.4), stroke: wire); bridge(-3.0, 4.4)
  line((-2.70, 4.4), (-1.50, 4.4), stroke: wire); bridge(-1.20, 4.4)
  line((-0.90, 4.4), (-0.75, 4.4), stroke: wire)

  phase(8.2, 0, $r_a, L_a$, $r_b, L_b$, $r_c, L_c$, $i_("a1")$, $i_("a2")$, $i_("ga")$)
  phase(6.0, 1, $r_b, L_b$, $r_c, L_c$, $r_a, L_a$, $i_("b1")$, $i_("b2")$, $i_("gb")$)
  phase(4.4, 2, $r_c, L_c$, $r_a, L_a$, $r_b, L_b$, $i_("c1")$, $i_("c2")$, $i_("gc")$)
  line((4.17, -1.35), (8.47, -1.35), stroke: wire)
  content((6.32, -1.58), $C_f$, anchor: "north")
  for (y, label) in ((8.2, $V_("ga")$), (6.0, $V_("gb")$), (4.4, $V_("gc")$)) {
    line((19.05, y), (20.52, y), stroke: wire); source(21.0, y, label)
    line((21.48, y), (23.0, y), stroke: wire)
  }
  line((23.0, 8.2), (23.0, 4.4), stroke: wire)
  node((23.0, 6.0)); content((23.25, 6.0), $v_N$, anchor: "west")
})
