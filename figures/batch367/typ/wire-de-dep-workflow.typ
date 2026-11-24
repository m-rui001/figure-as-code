#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#canvas(length: 1cm, {
  import draw: *

  let pale = rgb("#dbe5ec")
  let green = rgb("#1b5e20")
  let blue = rgb("#006bb6")
  let ink = rgb("#17232b")
  let edge = (paint: green, thickness: 0.9pt)
  let arrow-style = (paint: green, thickness: 1.3pt)
  let head = (end: "stealth", fill: green, scale: 0.58)

  let arrow = (a, b) => line(a, b, stroke: arrow-style, mark: head)
  let box = (a, b) => rect(a, b, fill: pale, stroke: edge)
  let label = (body, at, size: 10pt, color: ink) => {
    content(at, align(center, text(size: size, fill: color, body)), anchor: "center")
  }
  let chip = (word, at) => {
    rect((at.at(0) - 0.48, at.at(1) - 0.25), (at.at(0) + 0.48, at.at(1) + 0.25),
      fill: blue, stroke: none)
    label(word, at, color: white)
  }
  let ellipse = (at, rx, ry) => {
    let (x, y) = at
    let k = 0.5523
    bezier((x - rx, y), (x + rx, y),
      (x - rx, y + k * ry), (x + rx, y + k * ry), fill: pale, stroke: edge)
    bezier((x + rx, y), (x - rx, y),
      (x + rx, y - k * ry), (x - rx, y - k * ry), fill: pale, stroke: edge)
  }

  // 先画连接线，避免箭头压住节点边界。
  arrow((9.5, 10.5), (9.5, 8.95))
  arrow((9.5, 7.8), (9.5, 6.25))
  arrow((11.0, 5.1), (11.0, 3.7))
  line((8.65, 2.25), (6.83, 2.25), stroke: arrow-style)
  arrow((5.87, 2.25), (4.1, 2.25))
  line((13.35, 2.25), (15.22, 2.25), stroke: arrow-style)
  line((16.18, 2.25), (18.1, 2.25), stroke: arrow-style)
  arrow((18.1, 2.25), (18.1, 3.65))
  line((18.1, 5.65), (18.1, 11.075), stroke: arrow-style)
  arrow((18.1, 11.075), (14.0, 11.075))

  box((5.0, 10.5), (14.0, 11.65))
  box((5.0, 7.8), (14.0, 8.95))
  box((5.0, 5.1), (14.0, 6.25))
  box((0.2, 1.05), (4.1, 3.45))
  polygon((11.0, 2.25), 4, radius: (2.35, 1.45), angle: 90deg,
    fill: pale, stroke: edge)
  ellipse((18.1, 4.65), 2.4, 1.0)

  label([Designing part via CAD software and\ creating STL file], (9.5, 11.075))
  label([Importing STL file and extracting G-code], (9.5, 8.375))
  label([Importing G-code to machine and\ running experimental tests], (9.5, 5.675))
  label([Post processing of\ sample], (2.15, 2.25))
  label([Is the part\ successfully\ deposited?], (11.0, 2.25))
  label([Failure analysis], (18.1, 4.65))
  chip([Yes], (6.35, 2.25))
  chip([No], (15.7, 2.25))
})
