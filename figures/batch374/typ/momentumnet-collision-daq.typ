#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#canvas(length: 0.50cm, {
  import draw: *
  let ink = rgb("#263244")
  let blue = rgb("#377fc4")
  let pale = rgb("#e7eff9")
  let red = rgb("#d94444")
  let edge = (paint: ink, thickness: 0.8pt)
  let wire = (paint: ink, thickness: 1.0pt)

  // 来源：Machines 2025，DOI 10.3390/machines13040334，Figure 1。
  let arrow(a, b, paint: ink, both: false) = {
    let marks = if both { (start: ">", end: "stealth") } else { (end: "stealth") }
    line(a, b, stroke: (paint: paint, thickness: 1.25pt), mark: (..marks, fill: paint, scale: 0.4))
  }
  let block(a, b, title, fill: pale, size: 8pt) = {
    rect(a, b, fill: fill, stroke: edge)
    content(((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2),
      text(size: size)[#title], anchor: "center")
  }
  let ellipse(cx, cy, rx, ry, fill: pale, stroke: edge) = {
    let kx = 0.5523 * rx
    let ky = 0.5523 * ry
    bezier((cx - rx, cy), (cx, cy + ry), (cx - kx, cy + ry), (cx - rx, cy + ky),
      fill: fill, stroke: stroke, close: true)
    bezier((cx, cy + ry), (cx + rx, cy), (cx + rx, cy + ky), (cx + kx, cy + ry),
      fill: fill, stroke: stroke, close: true)
  }

  // Upper MomentumNet-CD panel and its four semantic regions.
  rect((0.1, 14.2), (29.9, 27.0), fill: rgb("#f5f7fb"),
    stroke: (paint: ink, thickness: 1pt, dash: "dashed"))
  content((15.0, 26.45), text(size: 14pt, weight: "bold")[MomentumNet-CD], anchor: "center")
  rect((0.45, 15.0), (6.25, 25.45), stroke: (paint: rgb("#c6a34b"), thickness: 1pt, dash: "dashed"))
  content((3.35, 24.95), text(size: 8.5pt, weight: "bold")[Dynamics Model Construction], anchor: "center")
  block((0.75, 22.55), (5.95, 23.95), [Robot Manipulator\ Dynamics],
    fill: rgb("#e2efdc"), size: 7.2pt)
  content((3.35, 21.85), text(size: 6.3pt, fill: red)[Introduction of\ Momentum Observer], anchor: "center")
  content((3.35, 20.8), text(size: 5.8pt)[$hat(p) = C^T(q, dot(q)) G(q) + tau + r$], anchor: "center")
  bezier((1.2, 21.2), (0.55, 21.4), (0.55, 23.5), (1.1, 23.3),
    stroke: (paint: blue, thickness: 1.2pt), mark: (end: "stealth", fill: blue, scale: 0.4))
  block((0.75, 18.25), (5.95, 19.45), [Discrete-Time\ Implementation of Observer],
    fill: rgb("#e2efdc"), size: 5.8pt)
  content((8.4, 25.05), text(size: 8pt, fill: red)[Feature Extraction], anchor: "west")
  arrow((5.95, 21.8), (6.95, 21.8), paint: red)

  // Four-stage feature cycle: torque -> feature -> normalization -> joint error -> torque.
  ellipse(7.9, 21.8, 1.6, 0.9)
  content((7.9, 21.8), text(size: 6.3pt)[Torque Residual\ Calculation], anchor: "center")
  ellipse(11.0, 23.75, 1.6, 0.9)
  content((11.0, 23.75), text(size: 6.3pt)[Feature Vector\ Construction], anchor: "center")
  ellipse(11.0, 18.7, 1.6, 0.9)
  content((11.0, 18.7), text(size: 6.5pt)[Data\ Normalization\ Processing], anchor: "center")
  ellipse(7.9, 16.65, 1.6, 0.9)
  content((7.9, 16.65), text(size: 6.8pt)[Joint Velocity\ Error], anchor: "center")
  arrow((9.0, 22.65), (9.8, 23.25), paint: blue)
  line((12.6, 23.75), (12.85, 23.75), (12.85, 18.7), stroke: blue + 1.25pt)
  arrow((12.85, 18.7), (12.6, 18.7), paint: blue)
  line((9.4, 18.7), (9.15, 18.7), (9.15, 17.9), (9.75, 17.9), (9.75, 16.65),
    stroke: blue + 1.25pt)
  arrow((9.75, 16.65), (9.5, 16.65), paint: blue)
  arrow((7.4, 17.55), (7.4, 20.9), paint: blue)

  // Marginal-distance states receive the constructed and normalized features.
  rect((13.25, 15.0), (19.25, 25.45), stroke: (paint: rgb("#c6a34b"), thickness: 1pt, dash: "dashed"))
  block((13.65, 22.0), (18.85, 24.0), [Normal (Non-Collision)\ State Distance\ Calculation], size: 6.8pt)
  content((16.25, 20.75), text(size: 9pt, weight: "bold")[Marginal Distance\ Model], anchor: "center")
  block((13.65, 17.25), (18.85, 18.85), [Collision State\ Distance Calculation], size: 7.2pt)
  bezier((12.6, 18.7), (13.0, 20.5), (12.9, 22.5), (13.6, 23.0),
    stroke: (paint: red, thickness: 1.25pt), mark: (end: "stealth", fill: red, scale: 0.4))
  bezier((12.6, 18.7), (13.0, 18.4), (13.0, 18.1), (13.6, 18.1),
    stroke: (paint: red, thickness: 1.25pt), mark: (end: "stealth", fill: red, scale: 0.4))

  // Fully connected neural network and its iterative return arrow.
  rect((20.0, 15.0), (29.55, 25.45), stroke: (paint: rgb("#c6a34b"), thickness: 1pt, dash: "dashed"))
  content((24.78, 24.95), text(size: 9pt, weight: "bold")[Neural Network Implementation], anchor: "center")
  let nn-arrow(a, b) = line(a, b, stroke: rgb("#8b96a5") + 0.55pt,
    mark: (end: "stealth", fill: rgb("#8b96a5"), scale: 0.25))
  let xs = (20.8, 24.2, 28.4)
  let ys = ((20.5, 22.4, 24.3), (20.7, 22.4, 24.1), (22.4,))
  for layer in range(2) {
    for y0 in ys.at(layer) {
      for y1 in ys.at(layer + 1) {
        nn-arrow((xs.at(layer), y0), (xs.at(layer + 1), y1))
      }
    }
  }
  for (layer, x) in xs.enumerate() {
    for y in ys.at(layer) {
      let fill = if x == 20.8 { rgb("#e9a3ad") } else if x == 28.4 { rgb("#f2b27c") } else { rgb("#a8c5e6") }
      ellipse(x, y, 0.34, 0.34, fill: fill)
    }
  }
  bezier((28.6, 19.0), (29.2, 14.4), (22.0, 14.4), (22.6, 19.0),
    stroke: (paint: blue, thickness: 1.2pt), mark: (end: "stealth", fill: blue, scale: 0.4))

  // Lower DAQ panel, software side and bidirectional hardware handshake.
  rect((0.1, 0.15), (29.9, 13.75), fill: rgb("#fbfcfe"),
    stroke: (paint: ink, thickness: 1pt, dash: "dashed"))
  content((15.0, 13.2), text(size: 14pt, weight: "bold")[CollisionSense DAQ System], anchor: "center")
  rect((0.45, 3.6), (6.2, 12.35), stroke: (paint: rgb("#c6a34b"), thickness: 1pt, dash: "dashed"))
  content((3.3, 11.9), text(size: 9pt, weight: "bold")[Software Part], anchor: "center")
  rect((0.85, 7.6), (2.65, 10.4), fill: white, stroke: edge)
  rect((1.0, 7.8), (2.5, 10.15), fill: rgb("#dbe8f4"), stroke: edge)
  line((1.75, 7.6), (1.75, 7.1), stroke: wire)
  line((1.25, 7.1), (2.25, 7.1), stroke: wire)
  arrow((2.7, 10.1), (2.95, 10.1), paint: red)
  block((3.0, 9.55), (4.3, 10.65), [Simulink], fill: rgb("#fff0cd"), size: 5.5pt)
  block((3.0, 8.25), (4.3, 9.35), [QUARC], fill: rgb("#fff0cd"), size: 5.5pt)
  block((7.0, 8.1), (9.2, 10.3), [Q8-USB\ Card], fill: white)
  arrow((4.33, 10.1), (6.95, 10.1), paint: red)
  arrow((4.33, 8.8), (6.95, 8.8), paint: red)

  // Acquisition and control channels remain separate until the servo driver.
  content((15.7, 11.9), text(size: 9pt, weight: "bold")[Control Part], anchor: "center")
  block((10.2, 8.9), (14.8, 11.35), [(Acquisition) Analog\ Input and Encoder\ Pulse Signal], size: 6.5pt)
  block((17.1, 9.35), (20.7, 11.1), [Signal Conditioning/\ Amplifier], size: 7pt)
  block((22.1, 9.35), (26.5, 11.1), [MR-J2S AC\ Servo Driver], size: 7.2pt)
  arrow((9.25, 10.0), (10.15, 10.0), paint: blue)
  arrow((22.05, 10.15), (20.75, 10.15), paint: blue)
  arrow((17.05, 10.15), (14.85, 10.15), paint: blue)
  block((10.2, 5.25), (14.8, 7.45), [(Control)\ Analog/Digital Output], size: 7pt)
  block((17.1, 5.25), (21.4, 7.45), [Differential to\ Single-Ended Signal\ Conversion Module], size: 6.0pt)
  line((9.25, 8.7), (9.25, 6.35), stroke: blue + 1.3pt)
  arrow((9.25, 6.35), (10.15, 6.35), paint: blue)
  line((14.8, 9.6), (15.4, 9.6), (15.4, 8.0), (19.25, 8.0), stroke: blue + 1.3pt)
  arrow((19.25, 8.0), (19.25, 7.5), paint: blue)
  line((21.4, 6.8), (21.8, 6.8), (21.8, 8.8), (23.0, 8.8), stroke: blue + 1.3pt)
  arrow((23.0, 8.8), (23.0, 9.3), paint: blue)
  line((14.85, 5.6), (14.85, 4.8), (21.7, 4.8), (21.7, 6.35), stroke: blue + 1.3pt)
  arrow((21.7, 6.35), (22.05, 6.35), paint: blue)

  // Servo outputs reach the trigger, isolator, encoder and force sensor.
  block((22.1, 5.35), (25.3, 7.35), [MOS FET\ Trigger Switch\ Module], size: 5.8pt)
  block((26.0, 5.35), (29.3, 7.35), [Isolator\ Transmitter], size: 6.8pt)
  arrow((24.3, 7.35), (24.3, 9.3), paint: blue)
  arrow((27.65, 7.35), (27.65, 9.3), paint: blue)
  line((29.3, 6.35), (29.65, 6.35), (29.65, 11.6), (26.8, 11.6), (26.8, 10.15),
    stroke: blue + 1.3pt)
  arrow((26.8, 10.15), (26.5, 10.15), paint: blue)
  block((18.4, 1.35), (22.9, 3.15), [Joint AC Servo\ Motor (Encoder)],
    fill: rgb("#fff0cd"), size: 6.3pt)
  block((24.0, 1.35), (29.3, 3.15), [End-Effector ATI\ Six-Axis Force Sensor], fill: rgb("#fff0cd"), size: 7pt)
  line((23.7, 5.35), (23.7, 3.6), (20.65, 3.6), stroke: blue + 1.3pt)
  arrow((20.65, 3.6), (20.65, 3.15), paint: blue)
  line((29.3, 5.35), (29.65, 5.35), (29.65, 2.25), stroke: blue + 1.3pt)
  arrow((29.65, 2.25), (29.3, 2.25), paint: blue)
  arrow((22.95, 2.25), (23.95, 2.25), paint: blue)

  // Robot collision and repeated human-collision pictograms.
  ellipse(2.1, 3.0, 0.55, 0.55, fill: rgb("#d9dee5"))
  line((2.1, 3.0), (3.1, 3.65), (3.7, 3.0), stroke: ink + 3pt)
  ellipse(3.7, 3.0, 0.3, 0.3, fill: rgb("#d9dee5"))
  line((3.1, 3.65), (3.7, 4.3), stroke: ink + 2.5pt)
  line((2.1, 3.0), (1.7, 1.7), stroke: ink + 2pt)
  content((5.1, 2.05), text(size: 7.5pt, fill: red)[Collision External\ Force], anchor: "center")
  arrow((6.0, 2.7), (4.3, 2.7), paint: red)
  for i in range(6) {
    let x = 7.0 + i * 1.85
    let fill = (rgb("#63b879"), rgb("#e4a23d"), rgb("#e37b32"), rgb("#6bbf6b"),
      rgb("#e4a23d"), rgb("#63b879")).at(i)
    ellipse(x, 1.65, 0.22, 0.22, fill: fill, stroke: none)
    line((x, 1.45), (x + 0.35, 0.9), (x + 0.7, 1.45), stroke: fill + 2pt)
    rect((x + 0.45, 0.55), (x + 0.95, 1.05), fill: fill, stroke: none)
  }
  bezier((16.2, 0.65), (15.5, 1.1), (15.5, 1.8), (16.2, 2.05),
    stroke: (paint: blue, thickness: 1.1pt), mark: (end: "stealth", fill: blue, scale: 0.35))
  bezier((16.7, 2.05), (17.4, 1.8), (17.4, 1.1), (16.7, 0.65),
    stroke: (paint: blue, thickness: 1.1pt), mark: (end: "stealth", fill: blue, scale: 0.35))
})
