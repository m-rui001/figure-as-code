#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: ("Arial", "Segoe UI"), size: 11pt)

// Source: Auto-Encoders in Deep Learning--A Review with New Perspectives.
// Mathematics 2023, 11, 1777, doi:10.3390/math11081777.
#canvas({
  import draw: *

  // Each input and bias connects to all four feature units; each feature and
  // feature bias connects to all six outputs. Nodes cover line interiors.
  let blue = rgb("#385e94")
  let green = rgb("#4b966a")
  let grey = rgb("#a5a5a5")
  let radius = 0.50
  let inputs = range(7).map(i => (0.8, 8.4 - i * 1.25))
  let hidden = range(5).map(i => (4.2, 7.15 - i * 1.25))
  let outputs = range(6).map(i => (7.6, 8.4 - i * 1.25))
  let connect(a, b, paint) = {
    let dx = b.at(0) - a.at(0)
    let dy = b.at(1) - a.at(1)
    let distance = calc.sqrt(dx * dx + dy * dy)
    let ux = dx / distance
    let uy = dy / distance
    draw.line((a.at(0) + radius * ux, a.at(1) + radius * uy),
      (b.at(0) - radius * ux, b.at(1) - radius * uy),
      stroke: 0.9pt + paint, mark: (end: "stealth", fill: paint, scale: 0.28))
  }
  for a in inputs {
    for b in hidden.slice(0, 4) { connect(a, b, green) }
  }
  for a in hidden {
    for b in outputs { connect(a, b, grey) }
  }
  let neuron(p, label, paint) = {
    circle(p, radius: radius, fill: white, stroke: 1pt + paint)
    content(p, text(size: 17pt)[#label])
  }
  for (i, p) in inputs.enumerate() {
    neuron(p, if i < 6 { [$x_#(i + 1)$] } else { [+1] }, blue)
  }
  for (i, p) in hidden.enumerate() {
    neuron(p, if i < 4 { [$y_#(i + 1)$] } else { [+1] }, green)
  }
  for (i, p) in outputs.enumerate() { neuron(p, [$z_#(i + 1)$], blue) }
  for (x, label) in ((0.8, [Input]), (4.2, [Feature]), (7.6, [Output])) {
    content((x, 0.02), text(size: 15pt)[#label])
  }
})
