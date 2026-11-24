#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#canvas(length: 1cm, {
  import draw: *
  let ink = black
  let edge = (paint: ink, thickness: 0.85pt)
  let fine = (paint: ink, thickness: 0.55pt)
  let k = 0.5523
  rect((0, 0), (16.5, 13.4), stroke: none)

  // 椭圆由四段贝塞尔四分之一圆构成，液滴与焊缝弧面均复用。
  let oval(cx, cy, rx, ry, fill: white, stroke: edge) = {
    line((cx + rx, cy), (cx + rx, cy + k * ry), (cx + k * rx, cy + ry), (cx, cy + ry),
      (cx - k * rx, cy + ry), (cx - rx, cy + k * ry), (cx - rx, cy),
      (cx - rx, cy - k * ry), (cx - k * rx, cy - ry), (cx, cy - ry),
      (cx + k * rx, cy - ry), (cx + rx, cy - k * ry), (cx + rx, cy),
      fill: fill, stroke: stroke)
  }
  let leader(..points) = line(..points, stroke: fine,
    mark: (end: "stealth", fill: ink, scale: 0.55))
  let label(position, body) = content(position, text(weight: "bold")[#body], anchor: "west")

  // 接地工件以浅灰填充，焊池处保留下凹轮廓。
  line((0.65, 2.35), (4.75, 2.35), (5.18, 2.30), (5.85, 2.06), (6.55, 2.00),
    (7.18, 2.30), (7.65, 2.35), (15.85, 2.35), (15.85, 0.65), (0.65, 0.65),
    close: true, fill: rgb("#e3e3e3"), stroke: edge)
  oval(6.55, 2.22, 0.62, 0.19, fill: rgb("#f4f4f4"), stroke: fine)

  // 焊道由连续鳞状弧面组成，活跃熔池位于电弧正下方。
  for cx in (4.28, 4.78, 5.28) {
    line((cx - 0.25, 2.35), (cx - 0.25, 2.35 + k * 0.15),
      (cx - k * 0.25, 2.50), (cx, 2.50), (cx + k * 0.25, 2.50),
      (cx + 0.25, 2.35 + k * 0.15), (cx + 0.25, 2.35), stroke: fine)
  }
  for cx in (7.58, 8.08) {
    line((cx - 0.25, 2.35), (cx - 0.25, 2.35 + k * 0.15),
      (cx - k * 0.25, 2.50), (cx, 2.50), (cx + k * 0.25, 2.50),
      (cx + 0.25, 2.35 + k * 0.15), (cx + 0.25, 2.35), stroke: fine)
  }

  // 焊枪、喷嘴与弯管组成连续斜向轮廓。
  line((6.10, 4.20), (6.92, 4.10), (7.50, 5.12), (8.22, 9.05),
    (7.25, 9.18), (6.55, 5.28), close: true, fill: white, stroke: edge)
  line((6.52, 5.25), (7.52, 5.15), stroke: edge)
  line((6.28, 4.47), (6.94, 4.39), stroke: fine)
  line((6.20, 4.28), (6.94, 4.18), stroke: fine)
  line((6.65, 5.34), (7.34, 9.10), stroke: fine)
  line((7.24, 9.08), (8.21, 8.96), (8.49, 9.90), (7.65, 9.88), close: true,
    fill: white, stroke: edge)
  line((7.24, 9.08), (8.21, 8.96), stroke: edge)

  // 电缆以两条平滑贝塞尔边界收束，顶端用斜切断面封口。
  bezier((7.65, 9.88), (10.45, 12.65), (8.00, 10.55), (9.55, 10.55), stroke: edge)
  bezier((8.49, 9.90), (11.05, 12.65), (8.85, 10.85), (10.65, 11.05), stroke: edge)
  line((10.45, 12.65), (11.05, 12.65), stroke: edge)
  bezier((7.78, 9.91), (8.15, 10.62), (9.82, 10.92), (10.55, 12.57), stroke: fine)

  // 气体流线从喷嘴出口向熔池两侧散开。
  for pts in (
    ((6.22, 4.28), (5.84, 4.00), (5.10, 3.18), (5.15, 2.46)),
    ((6.35, 4.22), (6.00, 3.70), (5.69, 3.03), (5.84, 2.45)),
    ((7.02, 4.15), (7.20, 3.62), (6.98, 2.91), (6.94, 2.42)),
    ((7.19, 4.20), (7.76, 3.72), (8.08, 2.94), (8.00, 2.43)),
    ((7.38, 4.36), (8.16, 4.02), (8.83, 3.13), (8.65, 2.43))) {
    bezier(..pts, stroke: fine)
  }

  // 实心丝极向下送进，液滴与锯齿电弧衔接至熔池。
  line((6.77, 5.55), (6.45, 4.42), (6.31, 3.56), stroke: (paint: ink, thickness: 1.6pt))
  line((6.87, 5.58), (6.55, 4.44), stroke: fine)
  oval(6.27, 3.32, 0.12, 0.18, fill: ink, stroke: none)
  oval(6.39, 2.94, 0.09, 0.14, fill: ink, stroke: none)
  line((6.49, 3.43), (6.25, 3.22), (6.65, 3.07), (6.32, 2.88),
    (6.68, 2.73), (6.41, 2.56), (6.58, 2.28), stroke: edge)

  // 接地符号置于工件下方，标签直接位于对应工件内部。
  line((12.60, 0.65), (12.60, 0.43), stroke: edge)
  line((11.95, 0.43), (13.25, 0.43), stroke: edge)
  line((12.14, 0.28), (13.06, 0.28), stroke: edge)
  line((12.34, 0.13), (12.86, 0.13), stroke: edge)
  content((12.60, 1.50), text(weight: "bold")[Grounded\ Workpiece], anchor: "center")

  // 引线只落在对应部件边缘，左侧标签按来源顺序纵向排列。
  label((0.80, 12.25), "Welding Gun")
  leader((3.95, 12.08), (7.40, 12.08), (9.50, 11.09))
  label((10.10, 8.05), "Nozzle")
  leader((9.90, 7.90), (7.96, 7.90))
  label((0.80, 6.85), "Solid Wire Electrode")
  leader((5.03, 6.65), (5.30, 4.66), (6.35, 4.37))
  label((10.30, 5.70), "Gas Shielding")
  leader((10.10, 5.55), (9.22, 4.95), (8.02, 3.94))
  label((0.80, 4.85), "Metal Droplets")
  leader((4.05, 4.68), (5.46, 3.86), (6.15, 3.36))
  label((10.30, 3.30), "Electric Arc")
  leader((10.10, 3.15), (9.30, 2.80), (6.58, 2.80))
  label((0.80, 3.00), "Weld Bead")
  leader((3.10, 2.88), (3.80, 2.55), (4.04, 2.40))
})
