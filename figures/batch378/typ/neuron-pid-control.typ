#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 来源：Machines 2026，DOI 10.3390/machines14010091，Figure 5。
#canvas(length: 0.72cm, {
  import draw: *
  let ink = rgb("#20242b")
  let pale = rgb("#f4f7fb")
  let wire = (paint: ink, thickness: 1.1pt)
  let box-stroke = (paint: ink, thickness: 1.0pt)
  let arrow-mark = (end: "stealth", fill: ink, scale: 0.45)

  // Neuron PID control chain from Figure 5.
  let arrow(a, b) = line(a, b, stroke: wire, mark: arrow-mark)
  let block(x0, y0, x1, y1, title) = {
    rect((x0, y0), (x1, y1), fill: white, stroke: box-stroke)
    content(((x0 + x1) / 2 + 0.25, (y0 + y1) / 2),
      text(size: 9.5pt)[#title], anchor: "center")
  }
  let minus(x, y) = {
    let r = 0.27
    let k = 0.5523 * r
    bezier((x, y + r), (x + r, y), (x, y + k), (x + k, y),
      stroke: box-stroke, close: true)
    bezier((x + r, y), (x, y - r), (x + k, y - k), (x, y - k),
      stroke: box-stroke, close: true)
    line((x - 0.12, y), (x + 0.12, y), stroke: box-stroke)
  }
  let function-box(x0, x1, y0, y1) = {
    rect((x0, y0), (x1, y1), fill: white, stroke: box-stroke)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: 20pt)[$integral$], anchor: "center")
  }

  // Input trajectory and differentiating/integrating element.
  content((0.05, 5.65), text(size: 10pt)[Input], anchor: "west")
  line((0.1, 4.2), (0.65, 4.2), (1.1, 5.1), (2.0, 5.1), (2.45, 4.2), (2.9, 4.2),
    stroke: wire)
  arrow((2.9, 4.2), (3.0, 4.2))
  content((2.55, 5.25), $T_v$, anchor: "south")
  function-box(3.0, 4.25, 3.65, 5.55)
  arrow((4.25, 5.1), (5.68, 5.1))
  content((4.88, 5.48), $P^*[k]$, anchor: "south")

  // Position and speed controllers each contain an error subtractor.
  rect((5.45, 3.95), (10.0, 6.25), fill: white, stroke: box-stroke)
  minus(5.96, 5.1)
  content((6.35, 5.1), text(size: 6.5pt)[$e_p[k]$], anchor: "center")
  content((8.55, 5.1), text(size: 9.5pt)[Neuron Position\ PID Controller], anchor: "center")
  arrow((10.0, 5.1), (12.44, 5.1))
  content((11.1, 5.48), $V^*[k]$, anchor: "south")
  rect((12.2, 3.95), (16.75, 6.25), fill: white, stroke: box-stroke)
  minus(12.72, 5.1)
  content((13.1, 5.52), text(size: 6.5pt)[$e_v[k]$], anchor: "center")
  content((15.2, 5.0), text(size: 9.5pt)[Neuron Speed\ PID Controller], anchor: "center")

  // Pulse-shaping block produces the final control output.
  arrow((16.75, 5.1), (18.35, 5.1))
  function-box(18.35, 19.60, 4.35, 5.85)
  arrow((19.60, 5.1), (22.4, 5.1))
  content((18.0, 6.25), text(size: 8.5pt)[Pulse out], anchor: "center")
  content((22.62, 5.1), $U[k]$, anchor: "west")

  // Upper encoder measures velocity and feeds the speed controller.
  block(18.6, 7.3, 22.2, 8.35, [Encoder])
  arrow((20.2, 5.1), (20.2, 7.28))
  line((18.6, 7.82), (14.48, 7.82), (14.48, 6.65), (12.72, 6.65), stroke: wire)
  arrow((12.72, 6.65), (12.72, 5.39))
  content((15.95, 8.12), $V[k]$, anchor: "south")

  // Lower encoder closes the position loop from the pulsed output.
  block(5.45, 0.8, 9.05, 2.15, [Encoder])
  line((20.2, 5.1), (20.2, 1.48), stroke: wire)
  arrow((19.0, 1.48), (9.08, 1.48))
  line((7.25, 2.18), (7.25, 3.6), (5.96, 3.6), stroke: wire)
  arrow((5.96, 3.6), (5.96, 4.82))
  content((7.65, 3.15), $P[k]$, anchor: "west")
})
