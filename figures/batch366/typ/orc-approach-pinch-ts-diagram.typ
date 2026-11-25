#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#let rotated(body) = rotate(-90deg, origin: center, body)

#canvas(length: 1cm, {
  import draw: *
  let ink = rgb("#343434")
  let gray = rgb("#a8a8a8")
  let wire = (paint: ink, thickness: 0.9pt)
  let pale = (paint: gray, thickness: 1.15pt)
  let arrow = (start: "stealth", end: "stealth", fill: ink, scale: 0.45)
  let dashed = (paint: ink, thickness: 1.0pt, dash: "dashed")
  let double-arrow(x, y1, y2) = {
    line((x, y1), (x, y2), stroke: (paint: ink, thickness: 0.8pt), mark: arrow)
  }
  // 左图保留泵、冷凝器、蒸发器与膨胀机的闭环连接及六个状态点
  let k = 0.5523 * 1.05
  bezier((3.0, 6.65), (4.05, 7.7), (3.0 + k, 6.65), (4.05, 7.7 - k), stroke: wire)
  bezier((4.05, 7.7), (3.909, 8.225), (4.05, 7.7 + k), (4.009, 8.142), stroke: wire)
  line((3.909, 8.225), (3.90, 8.30), (3.90, 9.8), stroke: wire)
  bezier((3.525, 8.609), (3.0, 8.75), (3.431, 8.75), (3.0, 8.75), stroke: wire)
  bezier((3.0, 8.75), (1.95, 7.7), (3.0 - k, 8.75), (1.95, 7.7 + k), stroke: wire)
  bezier((1.95, 7.7), (3.0, 6.65), (1.95, 7.7 - k), (3.0 - k, 6.65), stroke: wire)
  bezier((3.525, 8.609), (3.90, 8.30), (3.60, 8.53), (3.90, 8.30), stroke: wire)
  line((3.90, 9.8), (5.4, 9.8), stroke: wire)
  line((3.0, 8.75), (3.0, 9.8), stroke: wire)
  line((3.0, 6.65), (3.0, 2.0), stroke: wire)
  line((3.0, 2.0), (5.4, 2.0), stroke: wire)
  rect((5.4, 1.4), (13.5, 2.6), fill: white, stroke: wire, radius: 0.20)
  content((9.45, 2.0), text(size: 11pt)[Condenser])
  rect((5.4, 9.35), (13.5, 10.45), fill: white, stroke: wire, radius: 0.24)
  content((9.45, 9.90), text(size: 11pt)[Heat Exchanger])
  line((13.5, 2.0), (15.2, 2.0), stroke: wire)
  line((15.2, 2.0), (15.2, 6.4), stroke: wire)
  line((14.2, 8.6), (16.2, 8.6), (15.5, 6.4), (14.9, 6.4), stroke: wire)
  line((14.9, 6.4), (15.5, 6.4), stroke: wire)
  line((15.4, 9.8), (15.4, 8.6), stroke: wire)
  line((13.5, 9.8), (15.4, 9.8), stroke: wire)
  line((5.4, 10.9), (16.3, 10.9), stroke: dashed)
  double-arrow(7.4, 10.78, 9.36)
  double-arrow(15.7, 10.78, 9.55)
  content((7.4, 11.15), $T_("pp")$, anchor: "south")
  content((15.7, 11.15), $T_1$, anchor: "south")
  content((16.0, 10.35), $T_("ap")$, anchor: "west")
  for (x, y, label) in ((4.3, 10.15, $t_2$), (4.1, 2.65, $t_1$),
      (14.25, 10.15, $t_5$), (14.2, 2.65, $t_6$)) {
    content((x, y), label)
  }
  // 右图以原图坐标范围重建 R134a 穹顶、循环折线和 HT Fluid 虚线
  let x(s) = 21.0 + (s - 0.9) * 13.0
  let y(t) = 0.8 + (t - 260.0) * 0.09
  line((x(0.9), y(260)), (x(1.9), y(260)), stroke: pale)
  line((x(0.9), y(260)), (x(0.9), y(380)), stroke: pale)
  for t in (260, 280, 300, 320, 340, 360, 380) {
    line((20.82, y(t)), (21.0, y(t)), stroke: pale)
    content((20.62, y(t)), text(size: 8.5pt)[#t], anchor: "east")
  }
  for (s, label) in ((0.9, "0.9"), (1.4, "1.4"), (1.9, "1.9")) {
    line((x(s), y(260) - 0.12), (x(s), y(260)), stroke: pale)
    content((x(s), 0.43), text(size: 8.5pt)[#label], anchor: "north")
  }
  content((27.5, -0.15), text(size: 10pt)[Entropy (kJ/kg)], anchor: "north")
  content((19.0, 6.2), rotated(text(size: 10pt)[Temperature (K)]))
  line((21.35, 12.35), (22.45, 12.35), stroke: pale)
  content((22.7, 12.35), text(size: 9.5pt)[R134a], anchor: "west")
  line((27.0, 12.35), (28.1, 12.35), stroke: dashed)
  content((28.35, 12.35), text(size: 9.5pt)[HT Fluid], anchor: "west")
  bezier((x(0.9), y(260)), (x(1.40), y(370)),
    (x(1.05), y(260)), (x(1.20), y(370)), stroke: pale)
  bezier((x(1.40), y(370)), (x(1.76), y(260)),
    (x(1.58), y(370)), (x(1.70), y(260)), stroke: pale)
  line((x(0.9), y(260)), (x(1.20), y(280)), (x(1.64), y(280)),
    (x(1.84), y(350)), (x(1.64), y(320)), (x(1.64), y(280)), stroke: pale)
  line((x(1.04), y(324)), (x(1.82), y(362)), stroke: dashed)
})
