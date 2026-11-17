#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: ("Arial", "Segoe UI"), size: 11pt)

// Source: Auto-Encoders in Deep Learning--A Review with New Perspectives.
// Mathematics 2023, 11, 1777, doi:10.3390/math11081777.
#canvas({
  import draw: *

  let blue = rgb("#528cdb")
  let green = rgb("#00af50")
  let purple = rgb("#7030a0")
  let dotted = (paint: black, thickness: 0.9pt, dash: "dotted")
  let arrow(a, b, paint) = {
    draw.line(a, b, stroke: 1pt + paint,
      mark: (end: "stealth", fill: paint, scale: 0.4))
  }
  let box(x0, y0, x1, y1, label, paint) = {
    rect((x0, y0), (x1, y1), fill: white, stroke: 1.2pt + paint)
    content(((x0 + x1) / 2, (y0 + y1) / 2), label)
  }
  let step(x, y, label) = {
    rect((x - 0.65, y - 0.34), (x + 0.65, y + 0.34),
      fill: rgb("#ffd06f"), stroke: none)
    content((x, y), text(weight: "bold")[#label])
  }
  rect((0.0, 0.0), (4.5, 3.85), stroke: dotted)
  rect((0.0, 4.35), (4.5, 8.20), stroke: dotted)
  rect((5.65, 3.65), (6.85, 5.95), stroke: dotted)
  rect((4.85, 2.55), (8.70, 3.30), stroke: dotted)
  box(0.25, 0.22, 4.25, 0.95, [$x$], blue)
  box(0.25, 1.45, 4.25, 2.48, [Encoder($q_phi (z | x)$)], blue)
  box(0.25, 2.95, 2.05, 3.65, [z_mean], blue)
  box(2.45, 2.95, 4.25, 3.65, [z_log_var], blue)
  arrow((2.25, 0.95), (2.25, 1.45), blue)
  arrow((2.25, 2.48), (1.15, 2.95), blue)
  arrow((2.25, 2.48), (3.35, 2.95), blue)
  box(4.95, 2.67, 8.60, 3.18, text(size: 9.5pt)[Sample $epsilon$ from $cal(N)(0, I)$], red)
  arrow((6.25, 3.30), (6.25, 3.85), purple)
  arrow((4.25, 3.32), (5.90, 4.20), purple)
  arrow((1.60, 3.65), (5.90, 5.35), purple)
  arrow((6.25, 4.55), (6.25, 5.10), purple)
  arrow((5.90, 5.45), (3.95, 5.10), purple)
  for (y, label) in ((4.20, [\*]), (5.45, [+])) {
    circle((6.25, y), radius: 0.35, fill: white, stroke: 1.2pt + purple)
    content((6.25, y), text(size: 19pt)[#label])
  }
  box(0.60, 4.55, 3.95, 5.30, [$z$], green)
  box(0.25, 5.78, 4.25, 6.82, [Decoder($p_theta (x | z)$)], green)
  box(0.25, 7.25, 4.25, 7.98, [$tilde(x)$], green)
  arrow((2.25, 5.30), (2.25, 5.78), green)
  arrow((2.25, 6.82), (2.25, 7.25), green)
  step(5.55, 0.55, [Step1])
  step(9.75, 2.93, [Step2])
  step(7.75, 5.55, [Step 3])
  step(5.55, 7.65, [Step4])
})
