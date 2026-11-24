#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
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
  let green = rgb("#39a96b")
  let edge = (paint: ink, thickness: 0.9pt)

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
  let tag(x, y, body, w: 1.9, size: 6.2pt, h: 0.72, paint: ink) = {
    rect((x, y), (x + w, y + h), fill: white, stroke: edge)
    content((x + w / 2, y + h / 2), text(size: size, fill: paint)[#body], anchor: "center")
  }
  let layer(x, y, w, fill) = {
    line((x, y), (x + w, y), (x + w + 1.2, y + 0.55), (x + 1.2, y + 0.55),
      close: true, fill: fill, stroke: edge)
    line((x + w, y), (x + w, y - 0.20), (x + w + 1.2, y + 0.35),
      (x + w + 1.2, y + 0.55), close: true, fill: fill, stroke: edge)
  }

  // (a) Exploded collector: six layers, pipe branches and supporter fins.
  let names = ("Glass", "Absorber plate", "Pipe", "Supporter fin", "Insulator", "Casing")
  let fills = (glass, dark, copper, pink, pink, blue)
  for (i, name) in names.enumerate() {
    let y = 17.0 - i * 1.1
    let x = 0.5
    layer(x, y, 7.8, fills.at(i))
    if name == "Supporter fin" or name == "Insulator" {
      let side-fill = rgb("#d9bfd0")
      line((x, y), (x + 7.8, y), (x + 7.8, y - 0.25), (x, y - 0.25),
        close: true, fill: side-fill, stroke: edge)
      line((x + 7.8, y), (x + 9.0, y + 0.55), (x + 9.0, y + 0.30), (x + 7.8, y - 0.25),
        close: true, fill: side-fill, stroke: edge)
    }
    if name == "Casing" {
      let side-fill = rgb("#718ba7")
      line((x, y), (x + 7.8, y), (x + 7.8, y - 0.50), (x, y - 0.50),
        close: true, fill: side-fill, stroke: edge)
      line((x + 7.8, y), (x + 9.0, y + 0.55), (x + 9.0, y + 0.05), (x + 7.8, y - 0.50),
        close: true, fill: side-fill, stroke: edge)
    }
    if name == "Pipe" {
      line((x + 0.5, y + 0.35), (x + 8.6, y + 0.35), stroke: copper + 2.6pt)
      line((x + 0.5, y - 0.15), (x + 8.6, y - 0.15), stroke: copper + 2.6pt)
      for j in range(5) {
        let px = x + 0.8 + j * 1.45
        line((px, y + 0.35), (px, y - 0.15), stroke: copper + 2pt)
      }
    }
    if name == "Supporter fin" {
      for j in range(6) {
        line((x + 0.8 + j * 1.2, y + 0.08), (x + 0.8 + j * 1.2, y - 0.38),
          stroke: ink + 0.9pt)
      }
    }
    line((x + 8.55, y + 0.25), (9.25, y + 0.25), stroke: edge)
    tag(9.3, y - 0.10, name, w: 3.2, size: 7pt, h: 0.7)
  }
  content((6.4, 9.55), text(size: 10pt)[(a) Isometric exploded view], anchor: "center")

  // (b) Assembled enclosure with four directed fluid and air ports.
  line((14.5, 17.0), (23.3, 17.0), (24.5, 17.55), (15.7, 17.55), close: true,
    fill: rgb("#e7eaed"), stroke: edge)
  line((14.5, 17.0), (14.5, 11.8), (23.3, 11.8), (23.3, 17.0), close: true,
    fill: rgb("#d5dbe1"), stroke: edge)
  line((23.3, 11.8), (24.5, 12.35), (24.5, 17.55), (23.3, 17.0), close: true,
    fill: rgb("#b8c2cc"), stroke: edge)
  for i in range(3) {
    line((15.6 + i * 2.5, 17.05), (16.6 + i * 2.5, 17.5), stroke: ink + 0.8pt)
  }
  line((14.5, 13.1), (23.3, 13.1), stroke: copper + 2.8pt)
  arrow((15.0, 17.15), (16.0, 18.15), paint: red)
  tag(12.8, 18.0, [Hot water\ outlet], w: 2.1, size: 7pt, h: 1.25, paint: red)
  line((23.3, 17.0), (23.9, 17.3), stroke: orange + 2.2pt)
  arrow((23.9, 17.3), (24.6, 18.1), paint: orange)
  tag(23.0, 18.5, [Heated air\ outlet], w: 2.8, size: 7pt, h: 1.25, paint: orange)
  arrow((15.0, 10.55), (15.8, 11.9), paint: sky)
  tag(12.7, 9.65, [Cold air\ inlet], w: 2.2, size: 7pt, h: 1.25, paint: sky)
  line((24.5, 12.8), (25.2, 12.8), stroke: sky + 2.2pt)
  arrow((25.2, 12.8), (26.1, 12.8), paint: sky)
  tag(24.0, 10.6, [Cold water\ inlet], w: 2.8, size: 7pt, h: 1.25, paint: sky)
  content((19.8, 9.55), text(size: 10pt)[(b) Isometric assembly view], anchor: "center")

  // (c) Front view: component leaders, pipe rivets and three dimensions.
  content((6.3, 8.55), text(size: 10pt)[(c) Front view], anchor: "center")
  let front-tags = ("Glass", [Absorber\ plate], "Pipe", [Fin\ supporter], "Insulator", "Casing")
  let front-targets = (6.3, 5.9, 5.1, 4.75, 3.6, 3.1)
  for (i, name) in front-tags.enumerate() {
    let x = 0.15 + i * 2.02
    tag(x, 7.25, name, w: 1.86, h: 0.9)
    arrow((x + 0.93, 7.23), (x + 0.93, front-targets.at(i)))
  }
  rect((0.3, 2.2), (12.3, 6.7), fill: none, stroke: edge)
  line((0.3, 6.3), (12.3, 6.3), stroke: ink + 2pt)
  line((0.3, 5.9), (12.3, 5.9), stroke: dark + 2.8pt)
  line((0.5, 5.1), (12.1, 5.1), stroke: copper + 3.2pt)
  line((0.5, 4.55), (12.1, 4.55), stroke: ink + 0.8pt)
  line((7.25, 5.05), (7.25, 4.55), stroke: ink + 0.9pt)
  line((0.5, 3.6), (12.1, 3.6), stroke: pink + 2.6pt)
  line((0.5, 3.1), (12.1, 3.1), stroke: blue + 1.8pt)
  for i in range(12) {
    ellipse(0.9 + i * 0.96, 5.1, 0.09, 0.09, copper, edge)
  }
  line((3.8, 5.1), (3.8, 3.6), (4.35, 3.6), stroke: edge)
  dimension((4.35, 3.6), (4.35, 5.1))
  content((3.55, 4.35), text(size: 6.5pt)[70 mm], anchor: "east")
  dimension((12.0, 2.2), (12.0, 6.7))
  line((11.7, 2.2), (12.3, 2.2), stroke: edge)
  line((11.7, 6.7), (12.3, 6.7), stroke: edge)
  content((10.85, 4.0), text(size: 6.5pt)[100 mm], anchor: "east")
  dimension((0.3, 1.35), (12.3, 1.35), dash: "dashed")
  line((0.3, 1.15), (0.3, 1.55), stroke: edge)
  line((12.3, 1.15), (12.3, 1.55), stroke: edge)
  content((6.3, 0.95), text(size: 7.5pt)[982 mm], anchor: "center")

  // (d) Side view: stagnant air, air channel and water channel.
  content((19.5, 8.55), text(size: 10pt)[(d) Side view], anchor: "center")
  tag(13.4, 7.35, [Stagnant air], w: 3.0, size: 7pt)
  tag(18.0, 7.35, [Air channel], w: 2.8, size: 7pt)
  tag(22.2, 7.35, [Water channel], w: 3.0, size: 7pt)
  arrow((14.9, 7.33), (14.9, 5.5))
  arrow((19.4, 7.33), (19.4, 3.7))
  arrow((23.7, 7.33), (23.7, 3.1))
  rect((13.4, 2.2), (25.6, 6.7), fill: none, stroke: edge)
  rect((13.65, 5.9), (25.35, 6.5), fill: glass, stroke: edge)
  line((13.65, 5.5), (25.35, 5.5), stroke: ink + 1.8pt)
  line((13.65, 3.1), (25.35, 3.1), stroke: copper + 3.2pt)
  line((13.65, 3.7), (25.35, 3.7), stroke: pink + 2.6pt)
  line((13.65, 2.6), (25.35, 2.6), stroke: blue + 1.8pt)
  arrow((14.4, 4.75), (17.4, 4.75), paint: sky)
  arrow((18.0, 4.35), (21.0, 4.35), paint: green)
  arrow((21.6, 3.95), (24.6, 3.95), paint: orange)
  arrow((14.4, 3.35), (17.4, 3.35), paint: red)
  dimension((13.4, 1.35), (25.6, 1.35), dash: "dashed")
  line((13.4, 1.15), (13.4, 1.55), stroke: edge)
  line((25.6, 1.15), (25.6, 1.55), stroke: edge)
  content((19.5, 0.95), text(size: 7.5pt)[1980 mm], anchor: "center")
})
