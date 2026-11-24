#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#let quarter-turn(body) = rotate(90deg, reflow: false, body)
#canvas({
  import draw: *
  let panel = rgb("#b2adab")
  let blue = rgb("#d7e4f5")
  let green-fill = rgb("#ddf0d9")
  let peach = rgb("#ffe6d7")
  let vcu-fill = rgb("#d3cfd0")
  let navy = rgb("#374c6a")
  let amber = rgb("#ffc200")
  let green = rgb("#59a949")
  let ink = rgb("#000000")
  let thin = 1.15pt
  let power = ink + 2.1pt
  let amber-line = (paint: amber, thickness: 1.55pt, dash: "dashed")
  let green-line = (paint: green, thickness: 1.55pt, dash: "dashed")

  // Rounded vehicle boundary.
  rect((0, 0), (17, 9.23), radius: 0.82, fill: panel, stroke: none)

  // Four winding icons: white capsules with three rows of short navy dashes.
  let coil(cx, cy) = {
    rect((cx - 1.82, cy - 0.50), (cx + 1.82, cy + 0.50),
      radius: 0.14, fill: white, stroke: navy + thin)
    for row in range(3) {
      let y = cy + (row - 1) * 0.25
      for i in range(13) {
        let x = cx - 1.48 + i * 0.246
        line((x, y), (x + 0.14, y), stroke: navy + 0.85pt)
      }
    }
  }
  coil(2.79, 7.83)
  coil(9.93, 7.83)
  coil(2.93, 1.32)
  coil(9.86, 1.32)

  let arrow(a, b, stroke, start: false) = {
    let marks = if start { (start: ">", end: ">") } else { (end: ">") }
    line(a, b, stroke: stroke, mark: (..marks, fill: stroke.paint, scale: 0.72))
  }

  // Mechanical power flow between each motor axis and its two winding icons.
  arrow((2.40, 6.24), (2.40, 7.33), power)
  arrow((2.40, 2.74), (2.40, 1.82), power)
  arrow((10.60, 6.13), (10.60, 7.33), power)
  arrow((10.60, 2.74), (10.60, 1.82), power)

  // Bidirectional VCU/MCU control and outgoing motor-control signals.
  arrow((6.23, 6.06), (6.23, 6.57), amber-line)
  arrow((6.99, 6.57), (6.99, 6.06), amber-line)
  arrow((5.46, 5.52), (3.50, 5.52), amber-line)
  arrow((7.52, 5.52), (9.38, 5.52), amber-line)

  // Electric power flows from the central battery to both motor axes.
  arrow((4.81, 4.09), (3.50, 4.09), green-line)
  arrow((8.15, 4.09), (9.38, 4.09), green-line)

  // Motor-axis blocks; each word is quarter-turned as in the source.
  let motor(x0, x1, name) = {
    rect((x0, 2.74), (x1, 6.24), radius: 0.25, fill: blue, stroke: none)
    let cx = (x0 + x1) / 2
    for (i, word) in ("Motor", "Axis", name).enumerate() {
      content((cx + (i - 1) * 0.66, 4.49),
        quarter-turn(text(size: 11pt)[#word]), anchor: "center")
    }
  }
  motor(1.30, 3.50, "Rear")
  motor(9.38, 11.83, "Front")

  // Central controller and energy store.
  rect((5.46, 4.97), (7.52, 6.06), radius: 0.10,
    fill: peach, stroke: (paint: rgb("#d9b29c"), thickness: 0.7pt))
  content((6.49, 5.52), text(size: 12pt)[MCU], anchor: "center")
  rect((5.50, 6.57), (7.47, 7.35), radius: 0.10,
    fill: vcu-fill, stroke: (paint: rgb("#aaa5a5"), thickness: 0.7pt))
  content((6.49, 6.96), text(size: 11pt)[VCU], anchor: "center")
  rect((4.81, 3.48), (8.15, 4.71), radius: 0.18,
    fill: green-fill, stroke: (paint: rgb("#b8d8ac"), thickness: 0.7pt))
  content((6.48, 4.10), text(size: 12pt)[Battery], anchor: "center")

  // Upper-right key: solid black power, dashed amber control, dashed green electricity.
  let legend-row(y, label, stroke, both: false) = {
    arrow((12.08, y), (13.25, y), stroke, start: both)
    content((13.43, y), text(size: 10pt)[#label], anchor: "west")
  }
  legend-row(7.95, "Power Flow", power)
  legend-row(6.94, "Control Signal", amber-line)
  legend-row(6.52, "Electric Power", green-line, both: true)
})
