#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#let side-label(body) = rotate(90deg, reflow: true, body)
#canvas(length: 0.68cm, {
  import draw: *
  let ink = rgb("#30343b")
  let panel = rgb("#f2f3f5")
  let border = rgb("#c9cdd3")
  let blue = rgb("#2176c7")
  let orange = rgb("#e88a2d")
  let red = rgb("#df3d43")
  let wire = (paint: ink, thickness: 1.0pt)

  // 来源：Robotics 2026，DOI 10.3390/robotics14080103，Figure 9。
  let panel-box(a, b) = rect(a, b, radius: 0.18, fill: panel, stroke: border + 1.2pt)
  let arrow(a, b, paint, dash: "solid") = {
    line(a, b, stroke: (paint: paint, thickness: 1.5pt, dash: dash),
      mark: (end: "stealth", fill: paint, scale: 0.48))
  }
  let two-arrow(a, b, paint) = {
    line(a, b, stroke: (paint: paint, thickness: 1.5pt),
      mark: (start: ">", end: "stealth", fill: paint, scale: 0.45))
  }
  let ellipse(cx, cy, rx, ry, fill: none, stroke: wire) = {
    let kx = 0.5523 * rx
    let ky = 0.5523 * ry
    bezier((cx - rx, cy), (cx, cy + ry), (cx - kx, cy + ry), (cx - rx, cy + ky),
      fill: fill, stroke: stroke, close: true)
    bezier((cx, cy + ry), (cx + rx, cy), (cx + rx, cy + ky), (cx + kx, cy + ry),
      fill: fill, stroke: stroke, close: true)
  }

  // Three software panels retain the source's triangular arrangement.
  panel-box((4.2, 8.9), (21.0, 15.7))
  panel-box((0.2, 0.3), (11.2, 7.8))
  panel-box((12.8, 0.3), (23.8, 7.8))

  // Vector robot line art replaces the SolidWorks viewport screenshot.
  rect((5.2, 10.1), (13.0, 14.5), fill: white, stroke: ink + 0.8pt)
  rect((6.0, 9.75), (12.4, 10.2), fill: rgb("#d7dbe2"), stroke: ink + 0.8pt)
  line((6.4, 9.75), (6.4, 8.98), stroke: wire)
  line((12.0, 9.75), (12.0, 8.98), stroke: wire)
  line((8.6, 10.25), (8.6, 12.0), stroke: ink + 3pt)
  ellipse(8.6, 12.1, 0.38, 0.38, fill: white, stroke: ink + 1.2pt)
  line((8.6, 12.1), (7.4, 13.0), stroke: ink + 3pt)
  ellipse(7.4, 13.0, 0.32, 0.32, fill: white, stroke: ink + 1.2pt)
  line((7.4, 13.0), (8.2, 13.85), stroke: ink + 2.5pt)
  ellipse(8.2, 13.85, 0.25, 0.25, fill: white, stroke: ink + 1pt)
  line((8.2, 13.85), (9.0, 13.65), stroke: ink + 2.5pt)
  content((4.0, 8.55), text(size: 11pt)[Robot 3D model], anchor: "center")

  // SolidWorks mark is rebuilt as an isometric cube and two letters.
  line((15.0, 13.9), (16.3, 14.45), (17.6, 13.9), (15.0, 13.9),
    fill: rgb("#df3c3c"), stroke: none, close: true)
  line((15.0, 13.9), (15.0, 12.8), (17.6, 12.8), (17.6, 13.9), stroke: none)
  line((17.6, 13.9), (16.3, 14.45), (16.3, 13.35), (15.0, 12.8),
    fill: rgb("#b9232c"), stroke: none, close: true)
  content((16.3, 13.45), text(size: 15pt, fill: white, weight: "bold")[SW], anchor: "center")
  content((16.3, 11.55), text(size: 12pt)[Solidworks], anchor: "center")

  // V-REP viewport and lizard-like software mark.
  rect((0.65, 1.35), (5.7, 5.35), fill: rgb("#e8edf3"), stroke: border + 0.9pt)
  rect((1.05, 1.65), (4.9, 4.95), fill: none, stroke: red + 1.2pt)
  for i in range(5) {
    line((0.8, 1.65 + i * 0.65), (5.55, 1.65 + i * 0.65), stroke: rgb("#cbd5e1") + 0.5pt)
  }
  for i in range(6) {
    line((1.0 + i * 0.8, 1.45), (1.0 + i * 0.8, 5.2), stroke: rgb("#cbd5e1") + 0.5pt)
  }
  line((3.15, 2.0), (3.15, 4.25), stroke: ink + 2pt)
  line((3.15, 3.25), (2.35, 3.85), (2.65, 4.55), stroke: ink + 2pt)
  ellipse(2.65, 4.55, 0.2, 0.2, fill: ink, stroke: none)
  line((3.15, 2.0), (3.85, 2.6), stroke: ink + 2pt)
  ellipse(3.85, 2.6, 0.2, 0.2, fill: ink, stroke: none)
  line((6.4, 4.9), (7.0, 5.4), (7.3, 4.8), (7.8, 5.4), (8.2, 4.8),
    stroke: ink + 1.6pt)
  ellipse(7.0, 5.45, 0.28, 0.18, fill: ink, stroke: none)
  content((7.35, 3.85), text(size: 12pt)[Vrep], anchor: "center")
  content((5.7, 0.65), text(size: 13pt, fill: red)[Robot urdf model], anchor: "center")

  // MATLAB panel uses a vector membrane icon and a readable code excerpt.
  line((14.25, 6.25), (14.8, 6.65), (15.35, 5.55), (15.9, 6.25), (16.45, 5.55),
    (17.0, 6.25), (17.55, 5.55), stroke: rgb("#e8752b") + 2.2pt)
  content((18.1, 4.0), text(size: 13pt)[Matlab], anchor: "center")
  rect((13.35, 0.45), (21.0, 3.35), fill: white, stroke: border + 0.9pt)
  content((13.55, 3.03), text(size: 7.5pt, font: "Consolas")[function vrep_matlab()], anchor: "north-west")
  content((13.55, 2.63), text(size: 7.5pt, font: "Consolas")[%addpath('./api');], anchor: "north-west")
  content((13.55, 2.23), text(size: 7.5pt, font: "Consolas")[disp('Program started');], anchor: "north-west")
  content((13.55, 1.83), text(size: 7.5pt, font: "Consolas")[% sim=remApi('remoteApi','ex'], anchor: "north-west")
  content((13.55, 1.43), text(size: 7.5pt, font: "Consolas")[vrep=remApi('remoteApi');], anchor: "north-west")
  content((13.55, 1.03), text(size: 7.5pt, font: "Consolas")[vrep.simxFinish(-1); % just], anchor: "north-west")

  // Two urdf exports leave the 3D model and enter the two simulators.
  arrow((10.0, 8.9), (5.7, 7.82), blue)
  arrow((13.0, 8.9), (17.0, 7.82), blue)
  content((7.15, 7.35), text(size: 11pt, fill: blue)[urdf], anchor: "north")
  content((15.8, 7.35), text(size: 11pt, fill: blue)[urdf], anchor: "north")

  // RemoteAPI is bidirectional; Verification returns to the model panel.
  two-arrow((10.95, 4.25), (13.05, 4.25), orange)
  content((12.0, 4.65), text(size: 11pt, fill: orange)[RemoteAPI], anchor: "south")
  line((1.05, 3.0), (-0.3, 3.0), (-0.3, 12.2),
    stroke: (paint: red, thickness: 1.4pt, dash: "dashed"))
  arrow((-0.3, 12.2), (5.2, 12.2), red, dash: "dashed")
  content((2.2, 12.8), text(size: 12pt, fill: red)[Verification], anchor: "center")
})
