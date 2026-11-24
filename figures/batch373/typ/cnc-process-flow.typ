#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 来源：Applied Sciences 2025，DOI 10.3390/app15147637，Figure 1。
#let vertical-label(body) = rotate(90deg, reflow: true, body)
#canvas(length: 0.65cm, {
  import draw: *
  let ink = rgb("#344054")
  let red = rgb("#ef6a67")
  let green = rgb("#27a376")
  let box-stroke = (paint: ink, thickness: 1.2pt)
  let wire = (paint: ink, thickness: 1.2pt)

  // CNC manufacturing process, reconstructed from Figure 1.
  let node(x, y, name) = {
    rect((x - 2.4, y - 0.85), (x + 2.4, y + 0.85), radius: 0.12,
      fill: white, stroke: box-stroke)
    content((x, y), text(size: 12pt, fill: ink)[#name], anchor: "center")
  }
  let down(a, b, paint: ink) = {
    line(a, b, stroke: (paint: paint, thickness: 1.25pt),
      mark: (end: "stealth", fill: paint, scale: 0.45))
  }

  // Five rectangular machining and inspection stages.
  node(3.0, 25.0, "Lathe Turning")
  node(3.0, 22.0, "CNC Turning")
  node(3.0, 19.0, "CNC Milling")
  node(3.0, 16.0, "Drilling")
  node(3.0, 13.0, "Inspection")

  // Rework is a decision diamond, followed by the End state.
  let ry = 9.7
  line((3.0, 12.15), (3.0, 11.25), stroke: wire)
  line((3.0, 11.25), (3.0, 11.0), stroke: wire,
    mark: (end: "stealth", fill: ink, scale: 0.45))
  line((0.9, ry), (3.0, ry + 1.3), (5.1, ry), (3.0, ry - 1.3), close: true,
    fill: white, stroke: box-stroke)
  content((3.0, ry), text(size: 12pt, fill: ink)[Rework], anchor: "center")
  down((3.0, ry - 1.3), (3.0, 6.7), paint: green)
  content((2.55, 7.65), text(size: 11pt, fill: green)[Yes], anchor: "east")
  node(3.0, 5.2, "End")

  // A failed inspection loops back only to CNC Turning.
  line((5.1, ry), (7.5, ry), stroke: (paint: red, thickness: 1.25pt))
  line((7.5, ry), (7.5, 22.0), stroke: (paint: red, thickness: 1.25pt))
  line((7.5, 22.0), (5.45, 22.0), stroke: (paint: red, thickness: 1.25pt),
    mark: (end: "stealth", fill: red, scale: 0.45))
  content((8.15, 15.7), vertical-label(text(size: 11pt, fill: red)[No]), anchor: "center")

  // Main process arrows run downward between adjacent stages.
  down((3.0, 24.15), (3.0, 22.9))
  down((3.0, 21.15), (3.0, 19.9))
  down((3.0, 18.15), (3.0, 16.9))
  down((3.0, 15.15), (3.0, 13.9))
})
