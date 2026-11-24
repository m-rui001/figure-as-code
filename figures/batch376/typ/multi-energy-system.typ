#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#canvas(length: 0.68cm, {
  import draw: *
  let ink = rgb("#15191f")
  let red = rgb("#d94141")
  let gold = rgb("#c9952e")
  let wire = (paint: ink, thickness: 1.2pt)

  // 来源：Energies 2025，DOI 10.3390/en18174489，Figure 1。
  let arrow(a, b, paint: ink, both: false) = {
    let marks = if both { (start: ">", end: "stealth") } else { (end: "stealth") }
    line(a, b, stroke: (paint: paint, thickness: 1.35pt), mark: (..marks, fill: paint, scale: 0.45))
  }
  let label(x, y, body, anchor: "center") = content((x, y), text(size: 10pt)[#body], anchor: anchor)
  let ellipse(cx, cy, rx, ry, fill: none, stroke: wire) = {
    let kx = 0.5523 * rx
    let ky = 0.5523 * ry
    bezier((cx - rx, cy), (cx, cy + ry), (cx - kx, cy + ry), (cx - rx, cy + ky),
      fill: fill, stroke: stroke, close: true)
    bezier((cx, cy + ry), (cx + rx, cy), (cx + rx, cy + ky), (cx + kx, cy + ry),
      fill: fill, stroke: stroke, close: true)
  }
  let node(x, y) = ellipse(x, y, 0.34, 0.34, fill: ink, stroke: ink)

  // Central energy bus and its five electrical/load branches.
  node(5.2, 8.0)
  arrow((5.2, 10.4), (5.2, 8.4))
  label(4.65, 10.0, $P_("PV")$, anchor: "east")
  arrow((2.0, 8.0), (4.82, 8.0))
  label(3.45, 8.35, $P_("grid, pos")$)
  arrow((4.88, 7.72), (0.75, 7.0))
  label(2.4, 6.45, $P_("grid, neg")$)
  arrow((5.55, 8.35), (8.0, 9.55))
  label(6.9, 10.05, $P_("HE")$)
  arrow((5.55, 7.95), (8.2, 6.75))
  label(6.9, 8.35, $P_("HP")$)
  line((5.2, 7.65), (5.2, 5.3), stroke: wire)
  label(4.65, 6.35, $P_("load")$, anchor: "east")

  // Photovoltaic and grid icons remain vector-only.
  line((3.6, 11.8), (6.8, 11.8), (6.3, 10.4), (4.1, 10.4), close: true,
    fill: rgb("#dbe9f5"), stroke: wire)
  for i in range(4) {
    line((4.0 + i * 0.7, 10.45), (4.4 + i * 0.7, 11.75), stroke: rgb("#6e8eaa") + 0.7pt)
  }
  line((4.2, 10.4), (6.5, 11.8), stroke: rgb("#6e8eaa") + 0.7pt)
  ellipse(5.2, 13.0, 0.42, 0.42, fill: gold, stroke: gold)
  for i in range(8) {
    let a = i * 45deg
    line((5.2 + 0.62 * calc.cos(a), 13.0 + 0.62 * calc.sin(a)),
      (5.2 + 0.9 * calc.cos(a), 13.0 + 0.9 * calc.sin(a)), stroke: gold + 1.2pt)
  }
  line((0.7, 7.0), (0.7, 10.2), (1.4, 10.2), (2.0, 9.0), stroke: ink + 2pt)
  line((0.7, 8.2), (1.7, 8.2), stroke: ink + 2pt)
  line((1.25, 7.0), (1.25, 9.0), stroke: ink + 1.2pt)

  // Heat pump has separate electrical, heat and COP ports.
  rect((8.0, 7.9), (10.5, 10.2), radius: 0.12, fill: rgb("#f5f5f5"), stroke: wire)
  line((8.65, 9.9), (9.35, 10.65), (9.75, 9.65), (10.25, 10.2),
    close: true, fill: none, stroke: ink + 1.2pt)
  rect((8.2, 5.0), (10.7, 7.25), radius: 0.28, fill: ink, stroke: none)
  ellipse(9.45, 6.8, 0.55, 0.25, fill: none, stroke: white + 1.2pt)
  label(9.45, 6.15, [COP])
  ellipse(9.2, 5.55, 0.09, 0.09, fill: white, stroke: white)
  ellipse(9.7, 5.55, 0.09, 0.09, fill: white, stroke: white)
  arrow((10.55, 9.55), (12.0, 9.55), paint: red)
  label(11.25, 9.9, $dot(Q)_("HE")$)
  arrow((10.75, 6.1), (12.0, 6.1), paint: red)
  label(11.4, 6.45, $dot(Q)_("HP")$)

  // Thermal store loses heat upward and serves three households.
  rect((12.0, 4.8), (15.5, 10.0), radius: 0.45, fill: ink, stroke: none)
  ellipse(13.75, 10.0, 1.75, 0.42, fill: ink, stroke: ink)
  label(13.75, 7.7, $T_("stor")$)
  label(13.75, 6.65, $E_("stor")$)
  line((13.75, 10.4), (13.75, 11.25), stroke: red + 1.2pt)
  line((13.75, 11.25), (13.55, 11.42), (13.95, 11.58), (13.75, 11.75),
    stroke: red + 1.2pt)
  arrow((13.75, 11.75), (13.75, 12.25), paint: red)
  label(14.8, 12.0, $T_(infinity)$)
  label(14.6, 11.1, $dot(Q)_("loss")$, anchor: "west")
  arrow((15.55, 7.6), (17.4, 7.6))
  label(16.45, 7.95, $dot(Q)_("out")$)
  arrow((17.4, 7.6), (19.7, 9.4))
  label(18.45, 10.4, $dot(Q)_("H1")$, anchor: "west")
  arrow((17.4, 7.6), (19.7, 6.8))
  label(18.45, 8.1, $dot(Q)_("H2")$, anchor: "west")
  arrow((17.4, 7.6), (19.7, 4.3))
  label(18.45, 4.35, $dot(Q)_("H3")$, anchor: "west")

  // House icons and the demand enclosure.
  rect((17.8, 3.9), (23.0, 11.0), radius: 0.35, stroke: (paint: ink, thickness: 1.2pt, dash: "dashed"))
  for (i, y) in ((0, 9.4), (1, 6.8), (2, 4.3)) {
    let x = 20.7
    line((x - 1.0, y), (x, y + 0.75), (x + 1.0, y), close: true, fill: ink, stroke: none)
    rect((x - 0.75, y - 1.05), (x + 0.75, y), fill: ink, stroke: none)
    rect((x - 0.16, y - 0.65), (x + 0.16, y), fill: white, stroke: none)
  }

  // Geothermal probe and bottom return complete the heat-pump circuit.
  line((9.2, 5.55), (9.2, 0.65), stroke: gold + 3pt)
  line((9.7, 5.55), (9.7, 0.65), stroke: gold + 3pt)
  line((9.2, 0.65), (9.7, 0.65), stroke: gold + 3pt)
  for i in range(6) {
    let y = 0.75 + i * 0.25
    line((8.55, y), (8.7, y + 0.14), (8.85, y), (9.0, y + 0.14), (9.15, y),
      (9.3, y + 0.14), (9.45, y), (9.6, y + 0.14), (9.75, y), (9.9, y + 0.14),
      (10.05, y), stroke: gold + 1.2pt)
  }
  label(10.55, 1.65, $T_("GP")$, anchor: "west")
  line((5.2, 5.3), (5.2, 0.25), (22.5, 0.25), (22.5, 3.9), stroke: wire)
  arrow((22.5, 3.9), (22.5, 4.35))
})
