#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#let side-label(body) = rotate(90deg, reflow: true, body)
#canvas(length: 0.53cm, {
  import draw: *
  let ink = rgb("#263442")
  let copper = rgb("#c87543")
  let glass = rgb("#d8e5ec")
  let dark = rgb("#3e4750")
  let pink = rgb("#efd7e5")
  let blue = rgb("#8aa9cc")
  let red = rgb("#df3535")
  let orange = rgb("#e88a2c")
  let sky = rgb("#168bd2")
  let edge = (paint: ink, thickness: 0.9pt)
  let arrow-mark = (end: "stealth", fill: ink, scale: 0.42)

  // 来源：Energies 2024，DOI 10.3390/en17123038，Figure 1。
  let arrow(a, b, paint: ink) = line(a, b, stroke: (paint: paint, thickness: 1.6pt),
    mark: (end: "stealth", fill: paint, scale: 0.5))
  let dimension(a, b, dash: "solid") = line(a, b,
    stroke: (paint: ink, thickness: 0.8pt, dash: dash),
    mark: (start: ">", end: "stealth", fill: ink, scale: 0.35))
  let ellipse(cx, cy, rx, ry, fill, stroke) = {
    let kx = 0.5523 * rx
    let ky = 0.5523 * ry
    bezier((cx - rx, cy), (cx, cy + ry), (cx - kx, cy + ry), (cx - rx, cy + ky),
      fill: fill, stroke: stroke, close: true)
    bezier((cx, cy + ry), (cx + rx, cy), (cx + rx, cy + ky), (cx + kx, cy + ry),
      fill: fill, stroke: stroke, close: true)
  }
  let tag(x, y, body, w: 3.2) = {
    rect((x, y), (x + w, y + 0.8), fill: white, stroke: edge)
    content((x + w / 2, y + 0.4), text(size: 8.5pt)[#body], anchor: "center")
  }
  let layer(x, y, w, fill) = {
    line((x, y), (x + w, y), (x + w + 1.4, y + 0.65), (x + 1.4, y + 0.65),
      close: true, fill: fill, stroke: edge)
    line((x + w, y), (x + w, y - 0.22), (x + w + 1.4, y + 0.43),
      (x + w + 1.4, y + 0.65), close: true, fill: fill, stroke: edge)
  }

  // Unlettered source overview: exploded stack at left and assembled collector at right.
  let overview-names = ("Glass", "Absorber plate", "Pipe", "Supporter fin", "Insulator", "Casing")
  let overview-fills = (glass, dark, copper, pink, pink, blue)
  for (i, name) in overview-names.enumerate() {
    let y = 47.0 - i * 0.78
    layer(0.8, y, 9.2, overview-fills.at(i))
    if name == "Pipe" {
      line((1.2, y + 0.32), (9.8, y + 0.32), stroke: copper + 2.4pt)
      for j in range(5) {
        let px = 1.6 + j * 1.65
        line((px, y + 0.32), (px, y + 0.85), stroke: copper + 2pt)
      }
    }
    if name == "Supporter fin" {
      for j in range(5) {
        let px = 1.6 + j * 1.65
        line((px, y + 0.05), (px, y - 0.35), stroke: ink + 0.8pt)
      }
    }
    line((10.6, y + 0.25), (11.4, y + 0.25), stroke: edge)
    content((11.6, y + 0.25), text(size: 6.5pt)[#name], anchor: "west")
  }
  line((18.0, 46.7), (25.2, 46.7), (26.1, 47.15), (18.9, 47.15), close: true,
    fill: rgb("#e7eaed"), stroke: edge)
  line((18.0, 46.7), (18.0, 43.6), (25.2, 43.6), (25.2, 46.7), close: true,
    fill: rgb("#d5dbe1"), stroke: edge)
  line((25.2, 43.6), (26.1, 44.05), (26.1, 47.15), (25.2, 46.7), close: true,
    fill: rgb("#b8c2cc"), stroke: edge)
  line((18.0, 44.0), (17.5, 44.0), stroke: red + 2.4pt)
  arrow((17.5, 44.0), (16.6, 44.9), paint: red)
  content((16.3, 45.25), text(size: 6.5pt, fill: red)[Hot water\ outlet], anchor: "east")
  line((25.2, 46.7), (25.7, 46.9), stroke: orange + 2.4pt)
  arrow((25.7, 46.9), (26.5, 47.8), paint: orange)
  content((26.7, 48.0), text(size: 6.5pt, fill: orange)[Heated air\ outlet], anchor: "west")
  line((18.0, 43.9), (17.5, 43.9), stroke: sky + 2.4pt)
  arrow((17.5, 43.9), (16.7, 43.1), paint: sky)
  content((16.3, 42.7), text(size: 6.5pt, fill: sky)[Cold air\ inlet], anchor: "east")
  line((25.2, 43.9), (25.7, 43.9), stroke: sky + 2.4pt)
  arrow((25.7, 43.9), (26.5, 43.1), paint: sky)
  content((26.7, 42.9), text(size: 6.5pt, fill: sky)[Cold water\ inlet], anchor: "west")

  // (a) Six exploded collector layers with exact leader ownership.
  content((5.5, 38.0), text(size: 11pt)[(a) Isometric exploded view], anchor: "center")
  let names = ("Glass", "Absorber plate", "Pipe", "Supporter fin", "Insulator", "Casing")
  let fills = (glass, dark, copper, pink, pink, blue)
  for (i, name) in names.enumerate() {
    let y = 35.8 - i * 1.55
    let x = 0.8
    layer(x, y, 7.8, fills.at(i))
    if name == "Pipe" {
      line((x + 0.5, y + 0.36), (x + 8.7, y + 0.36), stroke: copper + 3pt)
      for j in range(5) {
        let px = x + 0.8 + j * 1.45
        line((px, y + 0.36), (px, y + 1.0), stroke: copper + 2.5pt)
      }
    }
    if name == "Supporter fin" {
      for j in range(5) {
        line((x + 0.8 + j * 1.45, y + 0.1), (x + 0.8 + j * 1.45, y - 0.45),
          stroke: ink + 1pt)
      }
    }
    line((x + 8.8, y + 0.3), (10.2, y + 0.3), stroke: edge)
    content((10.4, y + 0.3), text(size: 9pt)[#name], anchor: "west")
  }

  // (b) Assembled enclosure and four directed fluid/air ports.
  content((18.5, 38.0), text(size: 11pt)[(b) Isometric assembly view], anchor: "center")
  line((13.2, 34.4), (22.2, 34.4), (23.6, 35.1), (14.6, 35.1), close: true,
    fill: rgb("#e7eaed"), stroke: edge)
  line((13.2, 34.4), (13.2, 28.8), (22.2, 28.8), (22.2, 34.4), close: true,
    fill: rgb("#d5dbe1"), stroke: edge)
  line((22.2, 28.8), (23.6, 29.5), (23.6, 35.1), (22.2, 34.4), close: true,
    fill: rgb("#b8c2cc"), stroke: edge)
  for i in range(3) {
    line((14.4 + i * 2.6, 34.45), (15.5 + i * 2.6, 35.05), stroke: ink + 0.8pt)
  }
  line((13.0, 30.0), (23.0, 30.0), stroke: copper + 3pt)
  arrow((13.0, 30.0), (12.6, 30.0), paint: red)
  content((14.0, 32.2), text(size: 8.5pt, fill: red)[Hot water\ outlet], anchor: "west")
  line((22.2, 34.4), (22.8, 34.7), stroke: orange + 2.4pt)
  arrow((22.8, 34.7), (23.7, 36.0), paint: orange)
  content((23.0, 36.7), text(size: 9pt, fill: orange)[Heated air\ outlet], anchor: "center")
  arrow((15.2, 27.0), (16.0, 29.0), paint: sky)
  content((14.0, 26.0), text(size: 9pt, fill: sky)[Cold air\ inlet], anchor: "center")
  arrow((23.8, 30.0), (23.0, 30.0), paint: sky)
  content((23.2, 26.7), text(size: 9pt, fill: sky)[Cold water\ inlet], anchor: "center")

  // (c) Front view: layered section, pipe and two dimensional spans.
  content((12.0, 24.4), text(size: 11pt)[(c) Front view], anchor: "center")
  let front-tags = ("Glass", "Absorber plate", "Pipe", "Fin supporter", "Insulator", "Casing")
  let front-targets = (17.8, 17.2, 16.0, 15.55, 14.1, 13.7)
  for (i, name) in front-tags.enumerate() {
    tag(0.2 + i * 3.9, 21.0, name, w: 3.3)
    arrow((1.85 + i * 3.9, 20.98), (1.85 + i * 3.9, front-targets.at(i)))
  }
  rect((0.3, 13.5), (23.7, 18.2), fill: none, stroke: edge)
  line((0.3, 17.8), (23.7, 17.8), stroke: ink + 2.3pt)
  line((0.3, 17.2), (23.7, 17.2), stroke: dark + 3.2pt)
  line((0.5, 16.0), (23.5, 16.0), stroke: copper + 4pt)
  line((0.5, 15.3), (23.5, 15.3), stroke: ink + 0.8pt)
  line((13.55, 15.95), (13.55, 15.3), stroke: ink + 1pt)
  line((0.5, 14.1), (23.5, 14.1), stroke: pink + 3pt)
  line((0.5, 13.7), (23.5, 13.7), stroke: blue + 2pt)
  for i in range(12) {
    ellipse(1.3 + i * 1.85, 16.0, 0.13, 0.13, copper, edge)
  }
  line((5.0, 16.0), (5.0, 14.1), (7.1, 14.1), stroke: edge)
  dimension((7.1, 14.1), (7.1, 16.0))
  content((6.75, 15.05), text(size: 8pt)[70 mm], anchor: "east")
  dimension((23.2, 13.5), (23.2, 18.2))
  line((22.8, 13.5), (23.4, 13.5), stroke: edge)
  line((22.8, 18.2), (23.4, 18.2), stroke: edge)
  content((18.5, 14.65), text(size: 8pt)[100 mm], anchor: "center")
  dimension((0.3, 12.9), (23.7, 12.9), dash: "dashed")
  line((0.3, 12.65), (0.3, 13.15), stroke: edge)
  line((23.7, 12.65), (23.7, 13.15), stroke: edge)
  content((12.0, 12.35), text(size: 9pt)[982 mm], anchor: "center")

  // (d) Side view: stagnant-air, air and water channels with flow arrows.
  content((12.0, 11.55), text(size: 11pt)[(d) Side view], anchor: "center")
  tag(1.0, 9.7, [Stagnant air])
  tag(9.0, 9.7, [Air channel])
  tag(17.0, 9.7, [Water channel])
  arrow((2.6, 9.68), (2.6, 7.1))
  arrow((10.6, 9.68), (10.6, 5.5))
  arrow((18.6, 9.68), (18.6, 3.0))
  rect((0.3, 2.1), (23.7, 8.9), fill: none, stroke: edge)
  rect((0.55, 7.4), (23.45, 8.55), fill: glass, stroke: edge)
  line((0.55, 6.8), (23.45, 6.8), stroke: ink + 2pt)
  line((0.55, 3.0), (23.45, 3.0), stroke: copper + 4pt)
  line((0.55, 3.8), (23.45, 3.8), stroke: pink + 3pt)
  line((0.55, 2.55), (23.45, 2.55), stroke: blue + 2pt)
  arrow((2.2, 5.5), (5.2, 5.5), paint: sky)
  arrow((8.0, 5.0), (11.0, 5.0), paint: rgb("#39a96b"))
  arrow((13.5, 4.5), (16.5, 4.5), paint: orange)
  arrow((19.0, 4.0), (22.0, 4.0), paint: red)
  dimension((0.3, 1.35), (23.7, 1.35), dash: "dashed")
  line((0.3, 1.1), (0.3, 1.6), stroke: edge)
  line((23.7, 1.1), (23.7, 1.6), stroke: edge)
  content((12.0, 0.78), text(size: 9pt)[1980 mm], anchor: "center")
})
