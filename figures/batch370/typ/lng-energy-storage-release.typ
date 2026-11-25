#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  let ink = black; let blue = rgb("#0071c4")
  let green = rgb("#009033"); let cyan = rgb("#00a6d6")
  let orange = rgb("#ff7100"); let gold = rgb("#d5a600")
  let pink = rgb("#f3a6a6"); let aqua = rgb("#55d7f2")
  let wire=(paint:ink,thickness:0.9pt);let edge=(paint:rgb("#c48a00"),thickness:1pt,dash:"dashed")
  let label(body,at,c:ink,sz:10,anchor:"center")=content(at,anchor:anchor,align(center,text(fill:c,size:sz*1pt,body)))
  let num(n, at, c, anchor: "center") = label(str(n), at, c: c, sz: 9, anchor: anchor)
  let pipe(pts, c, arrow: true) = line(..pts, stroke: (paint: c, thickness: 1.05pt),
    mark: if arrow { (end: "stealth", fill: c, scale: 0.46) } else { none })
  let panel(a, b, fill) = rect(a, b, fill: fill, stroke: none)
  let coil(x, y, w, c) = {
    let pts = ()
    for i in range(9) { pts.push((x - w / 2 + (i + 0.5) * w / 8, y + if calc.odd(i) { 0.09 } else { -0.09 })) }
    line((x - w / 2, y), ..pts, (x + w / 2, y), stroke: (paint: c, thickness: 1.15pt)) }
  let hx(x, y, s, w: 2.3, h: 1.25, ys: (0.32, 0, -0.32), cs: (green, red, blue)) = {
    rect((x - w / 2, y - h / 2), (x + w / 2, y + h / 2), fill: white, stroke: wire)
    for (dy, c) in ys.zip(cs) { coil(x, y + dy, w - 0.28, c) }
    label(s, (x, y - h / 2 - 0.30)) }
  let vcoil(x, y, h, c) = {
    let pts = ()
    for i in range(9) { pts.push((x + if calc.odd(i) { 0.09 } else { -0.09 }, y - h / 2 + (i + 0.5) * h / 8)) }
    line((x, y - h / 2), ..pts, (x, y + h / 2), stroke: (paint: c, thickness: 1.15pt)) }
  let vhx(x, y, s, w: 1.55, h: 1.8) = {
    rect((x - w / 2, y - h / 2), (x + w / 2, y + h / 2), fill: white, stroke: wire)
    vcoil(x - 0.30, y, h - 0.25, red); vcoil(x + 0.30, y, h - 0.25, blue)
    label(s, (x, y - h / 2 - 0.30)) }
  let pump(x, y, s, dx: 0, dy: -0.98, anchor: "center") = {
    circle((x, y), radius: 0.46, fill: white, stroke: wire)
    line((x - 0.22, y + 0.22), (x + 0.24, y), (x - 0.22, y - 0.22), close: true, stroke: wire)
    line((x - 0.30, y - 0.46), (x + 0.30, y - 0.46), (x, y - 0.72), close: true, stroke: wire)
    label(s, (x + dx, y + dy), anchor: anchor) }
  let machine(x, y, s, g: "G", dy: -0.62) = {
    rect((x - 0.64, y - 0.17), (x - 0.39, y + 0.17), fill: white, stroke: wire)
    line((x - 0.39, y + 0.30), (x + 0.34, y + 0.30), (x + 0.55, y),
      (x + 0.34, y - 0.30), (x - 0.39, y - 0.30), close: true, fill: white, stroke: wire)
    line((x + 0.55, y), (x + 0.76, y), stroke: wire); circle((x + 0.98, y), radius: 0.25, fill: white, stroke: wire)
    label(g, (x + 0.98, y), sz: 8); label(s, (x, y + dy)) }
  let valve(x, y, s, dx: 0, dy: -0.40, anchor: "center") = {
    line((x - 0.22, y + 0.18), (x + 0.22, y - 0.18), (x + 0.22, y + 0.18),
      (x - 0.22, y - 0.18), close: true, fill: white, stroke: wire)
    label(s, (x + dx, y + dy), anchor: anchor) }
  let vessel(x, y, s, c: cyan) = {
    rect((x - 0.27, y - 0.48), (x + 0.27, y + 0.48), radius: 0.26, fill: white,
      stroke: (paint: c, thickness: 1.6pt))
    line((x - 0.27, y), (x + 0.27, y), stroke: (paint: c, thickness: 1.3pt)); label(s, (x + 0.72, y)) }
  let tank(x, y) = {
    rect((x - 0.72, y - 0.65), (x + 0.72, y + 0.40), fill: aqua, stroke: wire)
    arc((x, y + 0.40), radius: 0.72, start: 0deg, stop: 180deg, fill: aqua, stroke: wire)
    label("Liquid air", (x, y - 0.05), sz: 7.5); label("storage tank", (x, y - 0.38), sz: 7.5) }
  // Module fields and headings.
  panel((0.2, 15.1), (30.2, 22.55), rgb("#ffecdd")); panel((0.2, 11.35), (30.2, 15.1), rgb("#fff2c9"))
  panel((0.2, 5.85), (14.2, 11.35), rgb("#eee8f7")); panel((14.2, 5.85), (21.4, 11.35), rgb("#e9f2df"))
  panel((21.4, 5.85), (30.2, 11.35), rgb("#dff4fa")); panel((0.2, 0.2), (30.2, 5.85), rgb("#e9f6e4"))
  rect((0.2, 0.2), (30.2, 22.55), stroke: edge)
  for y in (15.1, 11.35, 5.85) { line((0.2, y), (30.2, y), stroke: edge) }
  for x in (14.2, 21.4) { line((x, 5.85), (x, 11.35), stroke: edge) }
  label("Energy storage module", (26.0, 21.50), sz: 13)
  label("Cold storage module for releasing energy", (15.2, 14.82), sz: 13)
  label("Storage/potential energy conversion module", (7.3, 12.20), sz: 11)
  label("Power generation module", (16.6, 6.12), sz: 10)
  label("Air conditioning module", (26.7, 10.55), sz: 13)
  label("Energy release module", (26.7, 1.15), sz: 13)
  // Six source legend entries.
  rect((0.7, 20.92), (13.8, 22.12), fill: white, stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"))
  for (x, y, c, s) in ((1.0, 21.82, blue, "LNG"), (1.0, 21.48, orange, "The thermal discharge from the power plant"),
    (7.4, 21.82, orange, "Propane"), (7.4, 21.48, ink, "Sea water"),
    (1.0, 21.14, green, "Air"), (7.4, 21.14, cyan, "Air conditioning circulating water")) {
    pipe(((x + 0.55, y), (x + 1.35, y)), c); label(s, (x + 1.55, y), sz: 7, anchor: "west") }
  // Energy storage: LNG/air/propane trains and compressors.
  label("LNG", (0.95, 16.35), c: blue); pipe(((1.30, 15.95), (2.24, 15.95)), blue); num(1, (1.55, 16.65), blue)
  pump(2.70, 15.95, "P1"); pipe(((3.16, 15.95), (4.0, 15.95)), blue, arrow: false)
  valve(4.0,17.35,"Z1",dx:-0.34,dy:0,anchor:"east");valve(4.0,15.35,"Z2",dx:-0.34,dy:0,anchor:"east")
  pipe(((4.0, 15.95), (4.0, 17.95), (6.90, 17.95)), blue); num(2, (5.15, 18.18), blue)
  vessel(4.70, 15.30, "PCST"); pipe(((4.70, 15.78), (4.70, 17.55), (6.90, 17.55)), orange)
  num(37, (5.55, 17.80), orange)
  for (x, s) in ((8.05, "HX4"), (12.30, "HX3"), (16.55, "HX2"), (20.80, "HX1")) { hx(x, 18.56, s) }
  for (a, b, n) in ((8.05, 12.30, 3), (12.30, 16.55, 4), (16.55, 20.80, 5)) {
    pipe(((a + 1.15, 17.95), (b - 1.15, 17.95)), blue); num(n, ((a + b) / 2, 18.18), blue)
    pipe(((b - 1.15, 17.55), (a + 1.15, 17.55)), orange); num(n + 35, ((a + b) / 2, 17.30), orange) }
  for (i, (a, b, x, ni, no)) in ((8.05, 12.30, 10.45, 15, 16), (12.30, 16.55, 14.70, 13, 14),
    (16.55, 20.80, 18.95, 11, 12)).enumerate() {
    machine(x, 20.0, "Comp" + str(i + 1), g: "M", dy: 0.64)
    pipe(((b + 1.15, 18.28), (x, 18.28), (x, 19.66)), green); num(ni, (x + 0.30, 18.95), green)
    pipe(((x - 0.64, 20.0), (x - 0.86, 20.0), (x - 0.86, 18.66), (a + 1.15, 18.66)), green)
    num(no, (x - 0.60, 19.30), green) }
  pipe(((1.8, 20.15), (8.05, 20.15), (8.05, 19.20)), green); num(17, (6.95, 20.40), green)
  pipe(((21.95, 18.66), (22.35, 18.66), (22.35, 20.15), (23.35, 20.15)), green)
  num(10, (22.62, 19.35), green); label("Air", (23.75, 20.15), c: green)
  // Cold storage: counter-running exchanger trains and PTST.
  pipe(((4.0, 15.35), (4.0, 13.95), (4.85, 13.95)), blue)
  pipe(((4.70, 14.82), (4.70, 14.25), (4.85, 14.25)), orange)
  for (x, i) in ((6.0, 1), (10.1, 2), (14.2, 3), (18.3, 4)) {
    hx(x, 13.60, "P-HX" + str(i), w: 2.3, h: 0.90, ys: (0.18, -0.18), cs: (red, blue)) }
  for (a, b) in ((6.0, 10.1), (10.1, 14.2), (14.2, 18.3)) {
    pipe(((a + 1.15, 14.25), (b - 1.15, 14.25)), orange)
    pipe(((b - 1.15, 13.95), (a + 1.15, 13.95)), blue) }
  pipe(((19.45, 14.25), (20.15, 14.25), (20.15, 14.82)), orange); vessel(20.15, 15.30, "PTST", c: pink)
  pipe(((21.95, 17.55), (22.20, 17.55), (22.20, 16.12), (20.15, 16.12), (20.15, 15.78)), orange)
  pipe(((21.95, 17.95), (22.75, 17.95), (22.75, 13.95), (19.45, 13.95)), blue); num(6, (23.02, 15.80), blue)
  pipe(((22.75, 15.45), (22.75, 15.12)), blue); num(41, (22.48, 16.55), orange)
  // Storage/potential-energy conversion module.
  pipe(((1.8, 20.15), (1.8, 5.15)), green, arrow: false)
  pipe(((1.8, 11.0), (4.48, 11.0)), green); num(32, (3.15, 10.62), green)
  hx(5.40, 10.45, "CB", w: 1.85, h: 1.25, ys: (0.30, 0, -0.30), cs: (green, red, blue))
  pipe(((6.325, 10.75), (8.75, 10.75), (8.75, 10.65)), green); num(31, (7.35, 11.02), green)
  valve(8.10, 10.65, "J-T"); pipe(((6.325, 10.15), (7.88, 10.15)), green); num(18, (7.05, 10.42), green)
  pipe(((8.32, 10.65), (9.15, 10.65), (9.15, 9.80), (9.75, 9.80)), green); num(19, (9.40, 10.88), green)
  tank(10.40, 9.50)
  pipe(((4.48, 10.15), (3.45, 10.15), (3.45, 9.03)), orange); num(34, (3.72, 9.65), orange)
  vessel(3.45, 8.55, "HST", c: pink)
  pipe(((3.45, 8.07), (3.45, 7.72), (2.15, 7.72), (2.15, 7.25), (2.63, 7.25)), orange)
  num(35, (3.72, 7.95), orange)
  hx(3.54, 7.08, "G-HX", w: 1.82, h: 0.90, ys: (0.18, -0.18), cs: (red, blue))
  pipe(((1.8, 6.90), (2.63, 6.90)), green); num(22, (1.52, 7.20), green, anchor: "east")
  vessel(7.10, 8.55, "CST")
  pipe(((7.10, 9.03), (7.10, 9.55), (6.0, 9.55), (6.0, 9.825)), orange); num(33, (7.38, 9.35), orange)
  pipe(((4.45, 7.26), (7.10, 7.26), (7.10, 8.07)), orange); num(36, (7.38, 7.62), orange)
  pump(7.38, 6.20, "P3", dx: 0.68, dy: 0, anchor: "west")
  pipe(((4.45, 6.90), (6.75, 6.90), (6.75, 6.20), (7.84, 6.20)), green); num(21, (5.95, 6.62), green)
  pipe(((10.40, 8.85), (10.40, 6.78), (7.38, 6.78), (7.38, 6.66)), green); num(20, (10.68, 7.72), green)
  pipe(((6.92, 6.20), (6.65, 6.20), (6.65, 6.02), (1.8, 6.02)), green, arrow: false)
  // Power generation: ORC exchangers, P2 and Tur5.
  vhx(15.30, 9.35, "HX-ORC2"); pump(17.40, 9.80, "P2"); vhx(19.60, 9.35, "HX-ORC1")
  pipe(((15.60, 10.25), (15.60, 10.95), (17.40, 10.95), (17.40, 10.26)), orange); num(43, (16.45, 11.20), orange)
  pipe(((17.86, 9.80), (18.25, 9.80), (18.25, 10.95), (19.30, 10.95), (19.30, 10.25)), orange)
  num(42, (18.55, 10.18), orange)
  pipe(((15.0, 10.25), (15.0, 11.05)), gold); num(49, (14.72, 10.78), gold)
  pipe(((15.60, 8.45), (16.45, 8.45), (16.45, 8.02)), gold); num(48, (15.95, 7.48), gold)
  pipe(((15.0, 8.45), (14.25, 8.45), (14.25, 7.82), (18.75, 7.82), (18.75, 7.46)), orange)
  num(44, (16.75, 8.35), orange)
  pipe(((19.90, 8.45), (20.55, 8.45), (20.55, 7.82), (20.25, 7.82), (20.25, 7.46)), orange)
  num(45, (20.88, 8.62), orange)
  machine(19.40, 7.05, "Tur5"); pipe(((22.05, 11.05), (19.90, 11.05), (19.90, 10.25)), blue)
  num(7, (21.55, 10.78), blue)
  // Air conditioning loop and natural-gas outlet.
  rect((21.80, 9.20), (24.20, 10.30), fill: white, stroke: wire)
  label("front area of", (23.0, 9.94), sz: 9); label("the factory", (23.0, 9.56), sz: 9)
  hx(24.50, 7.20, "HX-AIR", w: 1.83, h: 0.76, ys: (0.18, -0.18), cs: (red, blue))
  hx(28.45, 7.20, "HX9", w: 1.83, h: 0.76, ys: (0.18, -0.18), cs: (red, blue))
  pipe(((21.80, 9.75), (21.60, 9.75), (21.60, 7.38), (23.585, 7.38)), cyan); num(46, (21.88, 8.55), cyan)
  pipe(((24.20, 9.75), (25.05, 9.75), (25.05, 7.38), (25.415, 7.38)), cyan); num(47, (25.32, 8.55), cyan)
  pipe(((25.415, 7.02), (27.535, 7.02)), blue); num(8, (26.48, 6.72), blue)
  pipe(((29.365,7.02),(30.0,7.02)),blue);num(9,(29.72,6.72),blue);label("NG",(30.25,7.55),c:blue,anchor:"west")
  pipe(((30.0, 7.38), (29.365, 7.38)), gold); num(50, (29.72, 7.68), gold)
  pipe(((28.45, 7.58), (28.45, 8.45)), gold); num(51, (28.75, 8.12), gold)
  // Energy release: turbine bank, air header, thermal train and mixing basin.
  pipe(((1.8, 5.15), (29.55, 5.15)), green, arrow: false)
  for (x, i) in ((7.90, 1), (12.25, 2), (16.60, 3), (20.95, 4)) {
    machine(x, 4.65, "Tur" + str(i)); pipe(((x, 5.15), (x, 4.30)), green)
    hx(x, 2.20, "HX" + str(i + 4), w: 1.82, h: 0.76, ys: (0.18, -0.18), cs: (blue, red)) }
  for (x, n) in ((7.90, 23), (12.25, 25), (16.60, 27), (20.95, 29)) {
    pipe(((x - 0.90, 5.15), (x - 0.90, 2.38), (x - 0.91, 2.38)), green); num(n, (x - 0.58, 3.75), green) }
  for (x, n) in ((7.90, 24), (12.25, 26), (16.60, 28)) {
    pipe(((x + 0.91, 2.38), (x + 1.28, 2.38), (x + 1.28, 5.15)), green); num(n, (x + 1.55, 3.75), green) }
  pipe(((21.86, 2.38), (23.05, 2.38)), green); num(30, (22.48, 2.68), green)
  for (a, b, n) in ((20.95, 16.60, 53), (16.60, 12.25, 54), (12.25, 7.90, 55)) {
    pipe(((a - 0.91, 1.82), (b + 0.91, 1.82)), gold); num(n, ((a + b) / 2, 1.55), gold) }
  pipe(((23.05, 1.82), (21.86, 1.82)), gold); num(52, (22.48, 1.55), gold)
  pipe(((6.99, 1.82), (5.80, 1.82), (5.80, 1.70), (4.55, 1.70)), gold); num(56, (6.20, 2.10), gold)
  rect((3.05, 1.0), (4.55, 2.40), radius: 0.34, fill: rgb("#dff3f7"), stroke: wire)
  for y in (1.55, 1.90) { coil(3.80, y, 1.05, ink) }
  label("Mixing basin", (3.80, 0.70)); pipe(((3.80, 3.65), (3.80, 2.40)), ink)
  label("Sea water", (2.85, 3.72)); num(58, (4.12, 3.18), ink)
  pipe(((3.05, 1.70), (1.05, 1.70)), gold); num(57, (2.05, 1.43), gold); label("Drain sea", (1.12, 1.98), c: gold)
  pipe(((23.05, 3.70), (24.05, 3.70)), green)
  label("Normal temperature and", (25.45, 3.86), c: green, sz: 9); label("pressure air", (25.45, 3.54), c: green, sz: 9)
  pipe(((23.05, 2.95), (24.05, 2.95)), gold)
  label("The thermal discharge", (25.45, 3.11), c: gold, sz: 9)
  label("from the power plant", (25.45, 2.79), c: gold, sz: 9)
})
