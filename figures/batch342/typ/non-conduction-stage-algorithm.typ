#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 10pt)

// Amaral and Cardoso (2022), DOI 10.3390/signals3020020, Figure 5 (CC BY 4.0).
// Preserve the algorithm and literal code panel; this is not executable Python.
#canvas({
  import draw: *
  let st = 0.7pt + black
  let tip = (end: "stealth", fill: black, scale: 0.5)
  let io(y, t) = {
    draw.line((0.4, y), (8.0, y), (8.6, y + 1.1), (1.0, y + 1.1),
      close: true, stroke: st)
    content((4.5, y + 0.55), t)
  }
  io(4.4, [($t_0$, PA, $V_d$, $R_d$, $i_(L 0)$, $R_L$, L, $v_(C 0)$, ESR, C, $R_("Load")$)])
  draw.rect((0.45, 2.4), (8.55, 3.6), stroke: st)
  for x in (0.95, 8.05) {
    draw.line((x, 2.4), (x, 3.6), stroke: st)
  }
  content((4.5, 3.0), align(center)[Non-conduction stage\ Discretization of equations (2) and (3)])
  io(0.45, [($t$, $i_L$, $i_C$, $v_C$, $v_O$)])
  draw.line((4.5, 4.4), (4.5, 3.6), stroke: st, mark: tip)
  draw.line((4.5, 2.4), (4.5, 1.55), stroke: st, mark: tip)
  let lines = (
    "def non_conducting_state(t0,PA,Vd,Rd,il0,Rl,L,vc0,ESR,C,R):",
    "    K1 = C + ESR*C/R",
    "    KA = - ESR*C/(K1*L) - (Rl + Rd)/L",
    "    KB = ESR*C/(R*K1*L) - 1/L",
    "    vc = vc0*(1 - PA/(R*K1)) + il0*(PA/K1)",
    "    il = - Vd*PA/L + il0*(1 + KA*PA) + vc0*(KB*PA)",
    "    ic = C*(vc - vc0)/PA",
    "    vo = ESR*ic + vc",
    "    t = t0 + PA",
    "    return [t,il,ic,vc,vo]",
  )
  for (i, code) in lines.enumerate() {
    content((9.5, 5.3 - i * 0.40), text(size: 8.5pt,
      weight: if i in (0, 9) { "bold" } else { "regular" })[#code], anchor: "west")
  }
  content((4.5, -0.35), [(a)])
  content((14.2, -0.35), [(b)])
})
