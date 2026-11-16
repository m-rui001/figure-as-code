#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Finger design of the pneumatic soft bending actuator（气动软体弯曲执行器手指设计）
// 来源：Actuators 2025, 14(2), 252, Figure 2；DOI 10.3390/act14020252
// 结构：五个面板 (a)–(e)，白底黑线机械尺寸图。(a) 软体指节轴测图与 Mold Star 30 正视图，
// 含 20/10/16/5/3、R0.50/R2.00、23/30/46、Φ7.00/Φ13.00 及 Cotton bandage 引线；
// (b) 关节爆炸轴测图：Fixing frame、Support wall、Middle phalanx、Distal phalanx、Grub screw；
// (c) 关节纵剖面（斜线剖面）；(d) 110° 弯曲示意与 7.00 尺寸；(e) 装配侧视图，
// 尺寸 40.00/46.00/56.00，Finger fixture 引线。
#let rtxt(t, a) = rotate(a, t, reflow: true)
#canvas({
  import draw: *
  let (st, th) = (0.9pt + black, 0.6pt + black)
  let mk = (start: "stealth", end: "stealth", fill: black, scale: 0.32)
  let lead(a, b) = draw.line(a, b, stroke: th, mark: (end: "stealth", fill: black, scale: 0.28))
  let dimh(x0, x1, y, t, dy: 0.2) = {
    draw.line((x0, y), (x1, y), stroke: th, mark: mk)
    draw.line((x0, y - 0.08), (x0, y + 0.08), stroke: th)
    draw.line((x1, y - 0.08), (x1, y + 0.08), stroke: th)
    content(((x0 + x1) / 2, y + dy), text(size: 8.5pt)[#t])
  }
  let dimv(x, y0, y1, t, dx: -0.25) = {
    draw.line((x, y0), (x, y1), stroke: th, mark: mk)
    draw.line((x - 0.08, y0), (x + 0.08, y0), stroke: th)
    draw.line((x - 0.08, y1), (x + 0.08, y1), stroke: th)
    content((x + dx, (y0 + y1) / 2), rtxt(text(size: 8.5pt)[#t], -90deg))
  }
  let arcp(c, r, a0, a1, n: 24) = range(n + 1).map(k => {
    let a = (a0 + (a1 - a0) * k / n) * calc.pi / 180
    (c.at(0) + r * calc.cos(a), c.at(1) + r * calc.sin(a))
  })
  let hatch(x0, y0, x1, y1, s) = {
    for k in range(int((x1 - x0) / s) + 2) {
      let xa = calc.max(x0 + k * s, x0)
      let xb = calc.min(x0 + k * s + y1 - y0, x1)
      if xb - xa > 0.02 { draw.line((xa, y0 + xa - x0 - k * s), (xb, y0 + xb - x0 - k * s), stroke: th) }
    }
  }
  let slot(x, y, w, h) = draw.rect((x, y), (x + w, y + h), radius: w / 2, stroke: st)
  let dv = (0.5, 0.38)
  let blk(p, w, h, o: dv) = {
    let (x, y) = p
    draw.line((x, y), (x + w, y), (x + w, y + h), (x, y + h), close: true, stroke: st)
    draw.line((x + o.at(0), y + o.at(1)), (x + w + o.at(0), y + o.at(1)), (x + w + o.at(0), y + h + o.at(1)),
      (x + o.at(0), y + h + o.at(1)), close: true, stroke: st)
    for c in ((x, y), (x + w, y), (x + w, y + h), (x, y + h)) {
      draw.line(c, (c.at(0) + o.at(0), c.at(1) + o.at(1)), stroke: st)
    }
  }
  content((1.5, 12.9), text(size: 12pt)[(a)])
  for (p, w, h, sx, sy, sw, sh) in (((1.75, 9.55), 1.6, 1.5, 2.05, 9.95, 0.2, 0.75),
      ((4.05, 9.35), 1.7, 1.5, 4.35, 9.7, 0.22, 0.8)) {
    blk(p, w, h)
    slot(sx, sy, sw, sh)
  }
  draw.line(..arcp((1.75, 10.3), 0.5, 90, 270, n: 20), stroke: st)
  draw.line((5.82, 9.75), (5.82, 10.45), (6.18, 10.45), (6.18, 9.75), stroke: st)
  draw.line(..arcp((6.0, 10.45), 0.18, 0, 180, n: 14), stroke: st)
  draw.line((5.9, 9.75), (5.9, 10.35), (6.1, 10.35), (6.1, 9.75), stroke: st)
  draw.line((6.25, 10.55), (6.6, 10.55), (6.6, 9.95), (6.25, 9.95), stroke: st)
  draw.line((6.25, 10.7), (6.75, 10.7), (6.75, 9.8), (6.25, 9.8), stroke: st)
  hatch(2.9, 9.3, 4.7, 9.48, 0.1)
  draw.line((2.9, 9.3), (4.7, 9.3), (4.7, 9.48), (2.9, 9.48), close: true, stroke: th)
  content((4.55, 8.9), anchor: "west", text(size: 10.5pt)[Cotton bandage])
  lead((4.5, 8.8), (3.95, 9.35))
  draw.line((1.4, 11.7), (2.6, 12.22), stroke: th, mark: mk)
  content((1.95, 12.2), rtxt(text(size: 8.5pt)[20.00], -16deg))
  dimh(2.55, 3.6, 12.0, [10.00])
  dimv(6.95, 9.5, 11.0, [16.00], dx: 0.22)
  dimv(2.95, 8.95, 9.4, [5.00], dx: -0.2)
  dimv(1.2, 9.2, 9.65, [3.00], dx: -0.2)
  for (y, t, q) in ((12.4, "R0.50", (5.6, 11.3)), (12.05, "R2.00", (5.72, 10.85))) {
    content((5.95, y), anchor: "west", text(size: 8.5pt)[#t])
    lead((5.9, y - 0.05), q)
  }
  content((8.95, 12.9), anchor: "west", text(size: 11.5pt)[Mold Star 30])
  lead((9.95, 12.7), (9.95, 12.6))
  let (bx, by, bw, bh) = (9.35, 9.95, 3.5, 2.7)
  draw.rect((bx, by), (bx + bw, by + bh), radius: 0.16, stroke: st)
  for ox in (0.7, 2.56) { slot(bx + ox, by + 0.55, 0.24, 1.6) }
  for yy in (11.05, 11.55) {
    draw.line((8.35, yy), (bx, yy), stroke: st)
    draw.line((bx + bw, yy), (13.85, yy), stroke: st)
  }
  for x0 in (8.15, 13.85) { draw.rect((x0, 10.82), (x0 + 0.2, 11.78), stroke: st) }
  dimv(7.95, by, by + bh, [23.00], dx: -0.28)
  dimh(bx, bx + bw, 9.5, [30.00])
  dimh(8.15, 14.05, 9.1, [46.00])
  dimv(14.12, 11.05, 11.55, [Φ7.00], dx: 0.26)
  dimv(14.66, 10.82, 11.78, [Φ13.00], dx: 0.26)
  content((1.15, 8.55), text(size: 12pt)[(b)])
  let plate(x, y, w, h, s) = {
    draw.line((x, y), (x + w, y), (x + w + s, y + h), (x + s, y + h), close: true, stroke: st)
    draw.circle((x + w / 2 + s * 0.3, y + h * 0.25), radius: 0.05, stroke: th)
    draw.circle((x + w / 2 + s * 0.7, y + h * 0.55), radius: 0.05, stroke: th)
  }
  for (x, y, w, h, s) in ((1.85, 7.3, 0.62, 1.1, 0.28), (2.65, 7.42, 0.58, 1.18, 0.28),
      (3.6, 7.52, 0.55, 1.22, 0.28), (4.35, 6.72, 0.7, 0.85, 0.22), (5.12, 6.5, 0.65, 0.8, 0.22)) {
    plate(x, y, w, h, s)
  }
  blk((3.55, 5.6), 1.5, 1.0, o: (0.32, 0.24))
  slot(3.75, 5.82, 0.18, 0.55)
  slot(4.35, 5.82, 0.18, 0.55)
  draw.circle((3.55, 6.0), radius: 0.18, stroke: st)
  draw.circle((3.55, 6.0), radius: 0.06, stroke: th)
  draw.line((2.3, 4.68), (5.3, 5.18), stroke: 7pt + black)
  draw.line((3.0, 4.4), (5.35, 4.83), stroke: 4pt + black)
  for (p, r) in (((2.3, 4.68), 0.13), ((5.3, 5.18), 0.13), ((3.0, 4.4), 0.1), ((5.35, 4.83), 0.1)) {
    draw.circle(p, radius: r, fill: white, stroke: st)
  }
  for (p, a) in (((2.85, 4.56), 0.5), ((3.6, 4.72), 1.9), ((4.6, 4.95), 0.9), ((5.0, 4.55), 2.4),
      ((4.15, 4.31), 1.2)) {
    draw.circle(p, radius: 0.07, stroke: th)
    draw.line((p.at(0) - 0.09 * calc.cos(a), p.at(1) - 0.09 * calc.sin(a)),
      (p.at(0) + 0.09 * calc.cos(a), p.at(1) + 0.09 * calc.sin(a)), stroke: th)
  }
  content((4.7, 8.35), anchor: "west", [Fixing frame])
  lead((4.65, 8.25), (3.95, 7.95))
  content((5.9, 7.1), anchor: "west", [Support wall])
  lead((5.85, 7.02), (5.5, 6.85))
  content((1.55, 6.2), [Middle phalanx])
  lead((2.4, 6.15), (3.5, 5.98))
  content((5.55, 4.7), anchor: "west", [Distal phalanx])
  lead((5.62, 4.86), (5.32, 5.06))
  content((4.55, 3.95), [Grub screw])
  lead((4.45, 4.14), (4.2, 4.29))
  content((8.1, 8.45), text(size: 12pt)[(c)])
  draw.rect((8.55, 7.3), (12.55, 7.55), stroke: th)
  hatch(8.55, 7.3, 12.55, 7.55, 0.1)
  draw.line((8.55, 7.55), (8.55, 8.65), (12.55, 8.65), (12.55, 7.55), stroke: st)
  draw.line((8.8, 7.55), (8.8, 8.45), (12.3, 8.45), (12.3, 7.55), stroke: st)
  for (x0, y0, x1, y1) in ((8.55, 7.55, 8.8, 8.65), (12.3, 7.55, 12.55, 8.65), (8.55, 8.45, 12.55, 8.65)) {
    hatch(x0, y0, x1, y1, 0.09)
  }
  for (u0, u1) in ((8.95, 9.65), (9.8, 10.5), (10.65, 11.35)) {
    draw.line((u0, 7.55), (u0, 8.15), (u1, 8.15), (u1, 7.55), stroke: st)
  }
  draw.circle((11.7, 7.42), radius: 0.08, stroke: st)
  lead((8.4, 8.4), (8.95, 8.2))
  content((8.1, 6.7), text(size: 12pt)[(d)])
  let pv = (10.75, 6.0)
  draw.rect((9.35, 5.95), (pv.at(0), 6.15), stroke: st)
  draw.circle((9.55, 6.05), radius: 0.07, stroke: th)
  draw.circle(pv, radius: 0.17, stroke: st)
  draw.circle(pv, radius: 0.06, stroke: th)
  let pe = (11.65, 5.55)
  let dn = (0.447, 0.894)
  draw.line((pv.at(0) + 0.09 * dn.at(0), pv.at(1) + 0.09 * dn.at(1)),
    (pe.at(0) + 0.09 * dn.at(0), pe.at(1) + 0.09 * dn.at(1)),
    (pe.at(0) - 0.09 * dn.at(0), pe.at(1) - 0.09 * dn.at(1)), (pv.at(0) - 0.09 * dn.at(0), pv.at(1) - 0.09 * dn.at(1)),
    close: true, stroke: st)
  draw.circle(pe, radius: 0.14, fill: white, stroke: st)
  draw.circle(pe, radius: 0.06, stroke: th)
  draw.line(pv, (13.05, 6.0), stroke: (paint: black, thickness: 0.6pt, dash: "dashed"))
  draw.line(..arcp(pv, 1.35, -110, -2, n: 40), (pv.at(0) + 1.35, pv.at(1)), stroke: th,
    mark: (end: "stealth", fill: black, scale: 0.3))
  content((11.25, 5.15), rtxt(text(size: 9pt)[110°], -52deg))
  dimv(9.1, 5.55, 6.05, [7.00], dx: -0.22)
  draw.line((9.1, 6.05), (9.35, 6.05), stroke: th)
  content((1.5, 3.85), text(size: 12pt)[(e)])
  draw.rect((1.75, 1.25), (10.4, 1.6), stroke: st)
  for k in range(9) { draw.circle((2.15 + k * 1.0, 1.42), radius: 0.05, stroke: th) }
  for (x, w, h) in ((2.0, 2.2, 1.6), (4.35, 2.53, 1.75), (7.03, 3.08, 1.65)) {
    draw.rect((x, 1.6), (x + w, 1.6 + h), stroke: st)
  }
  for (x, y, h) in ((2.35, 2.0, 0.85), (4.85, 2.05, 0.9), (5.85, 2.05, 0.9), (8.45, 2.05, 0.85)) {
    slot(x, y, 0.2, h)
  }
  for x in (4.25, 6.93) { draw.circle((x, 1.85), radius: 0.09, stroke: st) }
  draw.circle((2.2, 1.75), radius: 0.06, stroke: th)
  for (a, b, t) in ((2.0, 4.2, "40.00"), (4.35, 6.88, "46.00"), (7.03, 10.11, "56.00")) { dimh(a, b, 0.9, t) }
  content((11.15, 1.95), text(size: 10pt)[Finger fixture])
  lead((11.05, 1.9), (10.45, 1.55))
})
