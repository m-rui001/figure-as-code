#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 12pt)

// Source: Amaral and Cardoso, Signals 2022, 3, 313-325.
// DOI: 10.3390/signals3020020, Figure 3.
#let rotated(t) = rotate(-90deg, t, reflow: true)

// Geometry redraw; labels and electrical connectivity follow the source image.
#canvas({
  import draw: *
  let st = 0.65pt + black
  let arrow = (end: "stealth", fill: black, scale: 0.55)
  let wire(..pts) = draw.line(..pts, stroke: st)
  let label(p, t) = content(p, t)
  let resistor(x, y0, y1) = {
    let pts = ((x, y0),)
    for i in range(1, 8) {
      pts.push((x + if calc.odd(i) { -0.15 } else { 0.15 }, y0 + (y1 - y0) * i / 8))
    }
    pts.push((x, y1))
    wire(..pts)
  }
  let coil(x0, x1, y) = {
    for i in range(4) {
      let x = x0 + (x1 - x0) * i / 4
      let r = (x1 - x0) / 8
      let pts = ()
      for j in range(25) {
        let a = 180deg - j * 180deg / 24
        pts.push((x + r + r * calc.cos(a), y + r * calc.sin(a)))
      }
      wire(..pts)
    }
  }
  wire((0, 0), (8, 0), (8, 1.65))
  wire((8, 2.65), (8, 4.50), (4.50, 4.50))
  wire((0, 4.50), (1.80, 4.50))
  coil(1.80, 4.00, 4.50)
  wire((4.00, 4.50), (4.80, 4.50), (4.80, 3.18))
  wire((4.40, 3.18), (5.20, 3.18))
  wire((4.40, 2.98), (5.20, 2.98))
  wire((4.80, 2.98), (4.80, 1.50))
  resistor(4.80, 0.50, 1.50)
  wire((4.80, 0.50), (4.80, 0))
  resistor(8, 1.65, 2.65)
  label((2.90, 3.95), [L])
  label((4.00, 3.10), [C])
  content((4.15, 1.02), rotated([ESR]))
  label((7.00, 1.90), [$R_("Load")$])
  draw.line((0.65, 3.88), (2.00, 3.88), stroke: st, mark: arrow)
  label((1.30, 3.45), [$i_L$])
  draw.line((5.50, 4.00), (5.50, 2.60), stroke: st, mark: arrow)
  label((5.95, 3.40), [$i_C$])
  draw.line((6.30, 4.15), (7.60, 4.15), stroke: st, mark: arrow)
  label((6.95, 3.65), [$i_O$])
  draw.line((8.60, 4.15), (8.82, 2.70), stroke: st)
  draw.line((8.82, 1.90), (8.60, 0.30), stroke: st, mark: arrow)
  label((8.90, 2.30), [$v_O$])
  wire((0, 4.50), (0, 3.15))
  resistor(0, 1.95, 3.15)
  wire((0, 1.95), (0, 1.55))
  wire((-0.30, 1.55), (0.30, 1.55))
  wire((-0.60, 1.24), (0.60, 1.24))
  wire((0, 1.24), (0, 0))
  label((1.05, 1.40), [$V_d$])
  content((-0.65, 2.55), rotated($R_L + R_d$))
})
