#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#let side(body) = rotate(90deg, reflow: true, body)
#canvas(length: 0.48cm, {
  import draw: *
  let ink = rgb("#26364a")
  let blue = rgb("#1688cf")
  let pale = rgb("#f7fafc")
  let edge = (paint: ink, thickness: 0.8pt)
  let blue-line = (paint: blue, thickness: 1.15pt)

  // 来源：Applied Sciences 2025，DOI 10.3390/app15115871，Figure 4。
  let arrow(a, b, paint: blue, both: false, dash: "solid") = {
    let marks = if both { (start: ">", end: "stealth") } else { (end: "stealth") }
    line(a, b, stroke: (paint: paint, thickness: 1.15pt, dash: dash),
      mark: (..marks, fill: paint, scale: 0.4))
  }
  let box(a, b, title, fill: white, size: 7pt, dash: "solid") = {
    rect(a, b, fill: fill, stroke: (paint: ink, thickness: 0.8pt, dash: dash))
    content(((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2),
      text(size: size)[#title], anchor: "center")
  }
  let layer(y0, y1, title) = {
    rect((1.4, y0), (27.5, y1), fill: pale, stroke: edge)
    content((1.7, y1 - 0.35), text(size: 7pt, weight: "bold")[#title], anchor: "west")
  }

  // Application service layer: four dashed applications and service description.
  layer(30.5, 37.5, [Application service layer])
  for (i, name) in ("Data visualization", [ERP MES PDM\ WMS], [Decision support\ system], "Database").enumerate() {
    box((2.0 + i * 6.1, 34.5), (6.8 + i * 6.1, 36.4), name, size: 7.5pt, dash: "dashed")
  }
  box((2.0, 32.2), (25.8, 33.8), [The whole process, whole elements and whole process of intelligent production line.],
    fill: none, size: 8pt)
  arrow((2.2, 30.8), (23.0, 30.8))
  content((8.5, 31.65), text(size: 7pt, fill: blue)[Simulation, monitoring, evaluation,], anchor: "center")
  content((10.0, 31.15), text(size: 7pt, fill: blue)[optimization, prediction, decision making.], anchor: "center")
  content((21.0, 31.65), text(size: 7.5pt, fill: blue)[Data transfer interaction], anchor: "center")

  // Digital-twin production line, OPC UA client and two simulation modules.
  layer(21.0, 30.0, [Digital twin production line layer])
  box((2.0, 22.0), (8.2, 29.0), "", fill: white)
  for i in range(4) {
    let x = 2.5 + i * 1.3
    rect((x, 23.0), (x + 0.9, 24.2), fill: rgb("#dce6ef"), stroke: edge)
    line((x + 0.45, 24.2), (x + 0.45, 25.2), stroke: edge)
  }
  line((2.4, 22.5), (7.8, 22.5), stroke: edge)
  box((9.3, 25.0), (13.0, 27.0), [OPCUA client], fill: white, size: 7.5pt, dash: "dashed")
  box((17.0, 27.0), (22.0, 28.7), [Production planning\ simulation], fill: rgb("#fff0ee"), size: 6.8pt)
  box((17.0, 24.5), (22.0, 26.2), [Production process\ simulation], fill: rgb("#fff0ee"), size: 6.8pt)
  arrow((12.0, 30.55), (12.0, 30.05))

  // Data layer: twin-data functions, connection broker and two OPC UA servers.
  layer(12.0, 20.5, [Data layer])
  content((2.0, 19.55), text(size: 8pt, weight: "bold")[Twin data], anchor: "west")
  let functions = (([Data\ acquisition], 2.0, 17.6), ("Data transfer", 5.7, 17.6),
    ([Data\ integration], 2.0, 14.9), ("Data driven", 5.7, 14.9))
  for (name, x, y) in functions {
    box((x, y), (x + 3.0, y + 1.35), name, fill: rgb("#fff0ee"), size: 6.2pt)
  }
  content((10.4, 19.45), text(size: 6.2pt)[Configuring connections], anchor: "center")
  line((9.05, 17.2), (10.4, 18.35), (11.75, 17.2), (10.4, 16.05), close: true,
    fill: white, stroke: edge)
  content((10.4, 17.2), text(size: 7pt)[IOSEVER], anchor: "center")
  arrow((8.75, 18.275), (9.0, 17.2))
  rect((12.15, 15.35), (22.75, 19.15), stroke: blue-line)
  box((12.4, 15.7), (17.2, 18.8), [External\ OPCUA server], fill: white, size: 7pt, dash: "dashed")
  box((17.7, 15.7), (22.5, 18.8), [Internal\ OPCUA server], fill: white, size: 7pt, dash: "dashed")
  box((24.0, 16.3), (27.1, 18.0), [Data acquisition\ card], fill: rgb("#fff0ee"), size: 6.2pt)
  arrow((11.8, 17.2), (12.1, 17.2))
  arrow((27.05, 17.15), (22.8, 17.15), both: true)
  content((25.2, 19.15), text(size: 6.8pt, fill: blue)[Data acquisition], anchor: "center")
  arrow((10.4, 21.0), (10.4, 20.55))
  content((11.2, 21.45), text(size: 7.5pt, fill: blue)[Data transfer interaction], anchor: "west")

  // Physical production line and the device-entity bus share one lower enclosure.
  layer(0.4, 11.5, [Physical production line])
  line((1.4, 4.8), (27.5, 4.8), stroke: edge)
  content((1.7, 4.42), text(size: 6.3pt, weight: "bold")[Device entity layer], anchor: "west")
  box((2.0, 5.5), (8.0, 10.7), "", fill: white)
  for i in range(3) {
    rect((2.4 + i * 1.6, 6.2), (3.7 + i * 1.6, 7.5), fill: rgb("#dce6ef"), stroke: edge)
    line((2.8 + i * 1.6, 7.5), (3.2 + i * 1.6, 8.5), stroke: edge)
  }
  line((2.4, 5.9), (7.6, 5.9), stroke: edge)
  line((1.58, 12.0), (1.58, 11.55), stroke: blue-line)
  arrow((1.58, 11.55), (1.95, 11.55))
  content((1.05, 8.4), side(text(size: 6.3pt, fill: blue)[Exact mapping]), anchor: "center")
  line((0.75, 21.0), (0.75, 12.0), stroke: blue-line)
  arrow((0.75, 12.0), (1.35, 12.0))

  // Sensor/control backbone above ten physical device entities.
  content((9.0, 10.65), text(size: 7pt)[sensor], anchor: "west")
  content((12.0, 10.65), text(size: 7pt)[PLC], anchor: "west")
  content((14.2, 10.65), text(size: 7pt)[Industrial control computer], anchor: "west")
  content((22.0, 10.65), text(size: 7pt)[Motion controller], anchor: "west")
  line((8.8, 9.9), (13.2, 9.9), stroke: blue-line)
  line((12.4, 8.8), (25.0, 8.8), stroke: (paint: blue, thickness: 1.0pt, dash: "dashed"))
  arrow((17.0, 8.8), (17.0, 9.9))
  content((9.0, 8.35), text(size: 6.3pt, fill: blue)[Data awareness], anchor: "west")
  arrow((12.0, 11.55), (12.0, 12.05))
  arrow((23.2, 12.05), (23.2, 11.55))
  content((17.0, 11.78), text(size: 7.5pt, fill: blue)[Data transfer interaction], anchor: "center")
  let devices = ([Industrial\ robot], [Machining\ center], "CNC", [Tool\ unit], [Sorting\ unit],
    [Grinding\ unit], [Detection\ unit], [Storage\ unit], [Master\ control\ unit], "worker")
  line((8.4, 4.2), (27.22, 4.2), stroke: blue-line)
  for (i, name) in devices.enumerate() {
    let x = 8.4 + i * 1.9
    box((x, 1.2), (x + 1.72, 3.5), name, fill: rgb("#fff8e8"), size: 4.5pt)
    line((x + 0.86, 4.2), (x + 0.86, 3.5), stroke: blue-line)
  }

  // Outer acquisition-to-application route remains separate from the service arrow.
  line((26.85, 17.15), (28.0, 17.15), (28.0, 30.8), (25.4, 30.8), stroke: blue-line)
  arrow((25.4, 30.8), (25.4, 30.55))
  content((29.6, 23.7), side(text(size: 7.5pt, fill: blue)[Data transfer interaction]), anchor: "center")
  content((0.10, 16.5), side(text(size: 6.3pt, fill: blue)[Data driven]), anchor: "center")
})
