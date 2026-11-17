#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 10pt)

// Amaral and Cardoso, Signals 2022, DOI 10.3390/signals3020020, Figure 8 (CC BY 4.0).
// Preserve PI feedback, reference polarity, comparator inputs and sawtooth source.
#let vertical-label(t) = rotate(-90deg, t, reflow: true)
#canvas({
  import draw: *
  let edge = 0.7pt + black
  let wire(..pts) = draw.line(..pts, stroke: edge)
  let label(p, t) = content(p, t)
  let resistor(x0, x1, y) = {
    let pts = ((x0, y),)
    for i in range(1, 7) {
      pts.push((x0 + (x1 - x0) * i / 7, y + if calc.odd(i) { 0.17 } else { -0.17 }))
    }
    pts.push((x1, y))
    wire(..pts)
  }
  let amplifier(x, y, upper: [−], lower: [+]) = {
    draw.line((x, y - 0.75), (x, y + 0.75), (x + 1.55, y), close: true,
      fill: white, stroke: edge)
    label((x + 0.28, y + 0.37), upper)
    label((x + 0.28, y - 0.37), lower)
    wire((x + 0.77, y + 0.38), (x + 0.77, y + 0.85))
    wire((x + 0.77, y - 0.38), (x + 0.77, y - 0.85))
  }
  let heading(x0, y0, x1, y1, t) = {
    draw.rect((x0, y0), (x1, y1), stroke: 1.4pt + black)
    label(((x0 + x1) / 2, (y0 + y1) / 2), t)
  }

  draw.rect((1.25, 4.75), (8.45, 11.4), stroke: 0.9pt + black)
  heading(1.45, 10.43, 8.25, 11.20, [PI Controller])
  circle((0.25, 7.45), radius: 0.14, stroke: edge)
  label((0.25, 8.50), [(Buck)])
  label((0.25, 8.08), [$v_("out")$])
  wire((0.39, 7.45), (2.12, 7.45))
  resistor(2.12, 3.10, 7.45)
  label((2.60, 7.98), [$R_1 = 10 thin "kΩ"$])
  wire((3.10, 7.45), (5.05, 7.45))
  amplifier(5.05, 7.07)
  wire((4.45, 7.45), (4.45, 9.35), (4.80, 9.35))
  resistor(4.80, 5.78, 9.35)
  label((5.29, 9.87), [$R_2 = 1 thin "kΩ"$])
  wire((5.78, 9.35), (7.08, 9.35))
  wire((7.08, 8.98), (7.08, 9.72))
  wire((7.27, 8.98), (7.27, 9.72))
  label((7.16, 10.05), [C = 470 nF])
  wire((7.27, 9.35), (8.25, 9.35), (8.25, 7.07))
  wire((6.60, 7.07), (8.25, 7.07))
  label((7.48, 7.46), [$v_("control")$])

  // Ground and reference source use the original long-positive plate convention.
  wire((0.25, 5.92), (3.12, 5.92))
  for (x, half) in ((0.25, 0.14), (0.18, 0.10), (0.11, 0.05)) {
    wire((x, 5.92 - half), (x, 5.92 + half))
  }
  wire((3.12, 5.60), (3.12, 6.24))
  wire((3.29, 5.45), (3.29, 6.39))
  wire((3.29, 5.92), (4.42, 5.92), (4.42, 6.69), (5.05, 6.69))
  label((2.93, 5.53), [−])
  label((3.47, 5.53), [+])
  label((3.22, 5.10), [$V_("REF")$])

  draw.rect((8.05, 0.85), (12.10, 3.65), stroke: 0.9pt + black)
  heading(8.72, 2.85, 11.90, 3.45, [Comparator])
  amplifier(8.95, 1.88, upper: [+], lower: [−])
  wire((8.25, 7.07), (8.25, 2.26), (8.95, 2.26))
  wire((10.50, 1.88), (12.83, 1.88))
  circle((12.97, 1.88), radius: 0.14, stroke: edge)
  content((13.45, 1.88), vertical-label([$v_("Square Waveform")$]))
  content((14.02, 1.88), vertical-label([MOSFET Driver]))

  draw.rect((4.75, 0.98), (6.25, 1.98), stroke: edge)
  wire((4.95, 1.24), (5.45, 1.78), (5.45, 1.24), (5.95, 1.78), (5.95, 1.24))
  wire((6.25, 1.50), (8.95, 1.50))
  label((5.50, 0.25), align(center)[Model\ Saw tooth])
})
