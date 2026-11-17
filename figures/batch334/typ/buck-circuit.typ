#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 12pt)

// Source: Amaral and Cardoso, Signals 2022, 3, 313-325.
// DOI: 10.3390/signals3020020, Figure 1.
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
  wire((0, 0), (8, 0), (8, 1.70))
  wire((8, 2.80), (8, 4.50), (5.90, 4.50))
  wire((5.90, 4.50), (5.90, 2.47))
  wire((5.90, 2.28), (5.90, 0))
  wire((5.50, 2.47), (6.30, 2.47))
  wire((5.50, 2.28), (6.30, 2.28))
  resistor(8, 1.70, 2.80)
  label((5.16, 2.38), [C])
  label((9.00, 2.18), [$R_("Load")$])
  coil(3.70, 5.40, 4.50)
  wire((5.40, 4.50), (5.90, 4.50))
  label((4.55, 3.95), [L])
  circle((0, 1.40), radius: 0.55, stroke: st)
  label((0, 1.68), [+])
  label((0, 1.12), [$minus$])
  wire((0, 0.85), (0, 0))
  label((1.00, 1.40), [$V_("in")$])
  wire((0, 1.95), (0, 4.50), (1.30, 4.50), (1.30, 3.88))
  wire((1.18, 3.88), (1.42, 3.88))
  wire((1.70, 3.88), (1.94, 3.88))
  wire((2.22, 3.88), (2.46, 3.88))
  wire((1.30, 3.75), (2.34, 3.75), (2.34, 2.52))
  wire((1.82, 3.88), (1.82, 5.10))
  draw.line((1.82, 4.85), (1.82, 4.12), stroke: st, mark: arrow)
  wire((2.34, 3.88), (2.34, 4.50), (3.70, 4.50))
  label((2.88, 3.95), [M])
  wire((3.20, 0), (3.20, 4.50))
  draw.line((2.94, 1.65), (3.20, 2.28), (3.46, 1.65), close: true, stroke: st)
  wire((2.94, 2.28), (3.46, 2.28))
  label((2.38, 2.10), [Di])
})
