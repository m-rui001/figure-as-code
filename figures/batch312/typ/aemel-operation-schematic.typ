#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Schematic illustration of AEMEL operation
// 来源：Energies 2025, 18(23), 6318, Figure 2(c)；DOI 10.3390/en18236318
// 结构：紫色虚线框内为 AEMEL 电解槽流程，H2O 经 Valve 进入 Electrolyte Tank，
// 由 Pump 送 Heat Exchanger 后进入 AEM Stack；产气经压力传感器与 Check Valve 输出，
// 红色支路经底部 Valve 接 H2 Vent，绿色主路为 H2 Out，右上角为 O2 出口与冷凝水回流。
// 顶部为 O2 Vent，底部为冷却回路，框底标注 (c)。

#canvas({
  import draw: *
  let blue = rgb("#1a4bff")
  let green = rgb("#00a050")
  let red = rgb("#ff2a1a")
  let purple = rgb("#8b2fc9")
  let yellow = rgb("#ffe6a0")
  let orange = rgb("#f4c2a1")
  let cyan = rgb("#19b5c9")

  let arrow(a, b, c, w: 1.8pt) = draw.line(a, b,
    stroke: (paint: c, thickness: w), mark: (end: "stealth", fill: c, scale: 0.45))

  let rbox(lo, hi, c, w, fill: none, r: 0.16) = {
    let (x0, y0) = lo
    let (x1, y1) = hi
    draw.line((x0 + r, y0), (x1 - r, y0), (x1, y0 + r), (x1, y1 - r),
      (x1 - r, y1), (x0 + r, y1), (x0, y1 - r), (x0, y0 + r),
      close: true, fill: fill, stroke: (paint: c, thickness: w))
  }

  let serpentine(x0, x1, y, n, d, col) = {
    let rr = d / 2
    let pts = ((x0, y), (x1, y))
    let yy = y
    let right = true
    for i in range(n - 1) {
      let xc = if right { x1 } else { x0 }
      let sg = if right { 1 } else { -1 }
      for k in range(1, 7) {
        let a = calc.pi / 2 - k / 6 * calc.pi
        pts.push((xc + sg * rr * calc.cos(a), yy - rr + rr * calc.sin(a)))
      }
      yy -= d
      pts.push((if right { x0 } else { x1 }, yy))
      right = not right
    }
    draw.line(..pts, stroke: (paint: col, thickness: 1.5pt))
  }

  let ell(c, rx, ry, n: 28) = {
    let pts = ()
    for k in range(n) {
      let a = k / n * 2 * calc.pi
      pts.push((c.at(0) + rx * calc.cos(a), c.at(1) + ry * calc.sin(a)))
    }
    pts
  }

  draw.line((1.0, 2.55), (21.9, 2.55), (21.9, 12.6), (1.0, 12.6), close: true,
    stroke: (paint: purple, thickness: 2pt, dash: "dashed"))

  arrow((0.1, 9.6), (1.42, 9.6), blue)
  content((0.12, 9.85), anchor: "south-west", [$"H"_2"O"$])
  rbox((1.42, 9.1), (2.85, 10.1), black, 1.2pt, fill: yellow)
  content((2.135, 9.6), [Valve])
  arrow((2.85, 9.6), (3.55, 9.6), blue)
  arrow((1.15, 8.95), (3.55, 8.95), blue)
  arrow((3.55, 8.63), (1.15, 8.63), blue)
  content((2.35, 8.36), anchor: "north", [Fill/Drain])

  rbox((3.55, 7.55), (6.95, 11.15), blue, 1.8pt)
  content((5.25, 7.95), [Electrolyte Tank])
  draw.circle((5.25, 9.68), radius: 0.36, fill: blue, stroke: none)
  draw.line((5.25, 10.46), (4.9, 9.72), (5.6, 9.72), close: true, fill: blue, stroke: none)
  draw.line((5.42, 10.22), (5.04, 9.72), (5.24, 9.72), (5.10, 9.32), (5.50, 9.86),
    (5.30, 9.86), close: true, fill: white, stroke: none)
  for i in range(3) {
    let pts = ()
    for k in range(9) {
      pts.push((4.6 + k * 0.16, 8.62 - i * 0.18 + 0.05 * calc.sin(k * calc.pi / 2)))
    }
    draw.line(..pts, stroke: (paint: blue, thickness: 1.4pt))
  }

  arrow((5.25, 7.55), (5.25, 6.48), black, w: 2pt)
  rbox((2.95, 5.2), (6.35, 6.48), black, 1.4pt)
  content((5.5, 5.84), [Pump])
  draw.line((3.35, 5.38), (4.6, 5.38), stroke: (paint: rgb("#e07a2f"), thickness: 2.6pt))
  rbox((3.62, 5.5), (4.38, 6.1), black, 0.8pt, fill: rgb("#8fd3f5"), r: 0.04)
  for i in range(3) {
    draw.line((3.72, 5.62 + i * 0.16), (4.16, 5.62 + i * 0.16),
      stroke: (paint: rgb("#1a3b5c"), thickness: 0.7pt))
  }
  draw.circle((3.42, 5.82), radius: 0.1, stroke: (paint: black, thickness: 0.8pt))
  draw.line((3.52, 5.82), (3.62, 5.82), stroke: (paint: black, thickness: 0.8pt))

  arrow((6.35, 5.84), (9.0, 5.84), black, w: 2.4pt)
  content((7.65, 6.08), anchor: "south", [Electrolyte])

  rbox((9.0, 4.85), (13.7, 6.75), blue, 1.8pt)
  content((12.65, 5.8), align(center)[Heat \ Exchanger])
  serpentine(9.2, 11.1, 6.5, 3, 0.28, red)
  serpentine(9.2, 11.1, 5.62, 3, 0.28, blue)
  for x in (11.3, 11.55) {
    draw.line((x, 5.0), (x, 6.6), stroke: (paint: blue, thickness: 1.6pt))
  }

  arrow((10.7, 6.75), (10.7, 7.45), black, w: 2pt)
  draw.line((5.9, 11.15), (5.9, 11.7), (10.6, 11.7), (10.6, 11.0),
    stroke: (paint: black, thickness: 1.8pt),
    mark: (end: "stealth", fill: black, scale: 0.45))

  rbox((8.6, 7.45), (12.65, 11.0), blue, 1.8pt)
  content((10.6, 7.85), [AEM Stack])
  let front = (10.95, 8.95)
  let back = (10.35, 9.72)
  let rx = 0.52
  let ry = 0.36
  draw.line(..ell(front, rx, ry), close: true, stroke: (paint: cyan, thickness: 1.3pt))
  draw.line(..ell(back, rx, ry), close: true, stroke: (paint: cyan, thickness: 1.3pt))
  for k in range(6) {
    let a = 0.2 + k / 6 * 2 * calc.pi
    let p = (front.at(0) + rx * calc.cos(a), front.at(1) + ry * calc.sin(a))
    let q = (back.at(0) + rx * calc.cos(a), back.at(1) + ry * calc.sin(a))
    draw.line(p, q, stroke: (paint: cyan, thickness: 0.9pt))
  }
  draw.line((11.08, 8.68), (11.08, 8.9), (11.22, 8.9),
    stroke: (paint: cyan, thickness: 1pt))

  arrow((12.65, 9.0), (13.05, 9.0), green)
  rbox((13.05, 8.1), (15.65, 9.9), black, 1.2pt, fill: orange, r: 0.22)
  content((14.35, 9.0), align(center)[Stack \ Pressure \ Sensor])
  arrow((15.65, 9.0), (16.05, 9.0), green)
  rbox((16.05, 8.45), (17.95, 9.55), black, 1.2pt, fill: yellow)
  content((17.0, 9.0), align(center)[Check \ Valve])
  arrow((17.95, 9.0), (18.35, 9.0), green)
  rbox((18.35, 8.1), (20.95, 9.9), black, 1.2pt, fill: orange, r: 0.22)
  content((19.65, 9.0), align(center)[Output \ Pressure \ Sensor])
  arrow((20.95, 9.0), (23.55, 9.0), green)
  content((22.5, 9.26), anchor: "south", [$"H"_2$ Out])

  draw.line((15.85, 9.0), (15.85, 7.5), stroke: (paint: red, thickness: 1.8pt))
  arrow((15.85, 7.5), (16.6, 7.5), red)
  rbox((16.6, 6.95), (18.5, 8.05), black, 1.2pt, fill: yellow)
  content((17.55, 7.5), [Valve])
  arrow((18.5, 7.5), (23.55, 7.5), red)
  content((22.5, 7.76), anchor: "south", [$"H"_2$ Vent])

  draw.line((4.7, 11.15), (4.7, 12.0), stroke: (paint: blue, thickness: 1.8pt))
  arrow((4.7, 12.0), (23.55, 12.0), blue)
  content((12.4, 12.14), anchor: "south", [$"O"_2$ Vent])
  arrow((22.7, 12.0), (22.7, 11.2), blue)
  content((22.85, 11.35), anchor: "west", [$"H"_2"O"$])
  content((23.5, 12.14), anchor: "south", [$"O"_2$])

  rbox((9.7, 2.75), (11.6, 3.85), blue, 1.4pt, fill: blue, r: 0.16)
  content((10.65, 3.3), text(fill: white)[Valve])
  arrow((10.65, 3.85), (10.65, 4.85), blue)
  arrow((10.65, 2.75), (10.65, 1.5), blue)
  content((10.42, 1.78), anchor: "east", [Cooling IN (EL LC Only)])
  arrow((12.85, 4.85), (12.85, 1.5), blue)
  content((13.1, 1.78), anchor: "west", [Cooling Out (EL LC Only)])
  content((13.5, 0.6), [(c)])
})
