#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 10pt)

// Amaral and Cardoso (2022), DOI 10.3390/signals3020020, Figure 7 (CC BY 4.0).
// Preserve both decisions and the shared feedback loop without adding missing program steps.
#canvas({
  import draw: *
  let st = 0.7pt + black
  let tip = (end: "stealth", fill: black, scale: 0.5)
  let edge(..pts) = draw.line(..pts, stroke: st, mark: tip)
  let io(cx, y, w, h, t) = {
    draw.line((cx - w / 2 - 0.25, y), (cx + w / 2 - 0.25, y),
      (cx + w / 2 + 0.25, y + h), (cx - w / 2 + 0.25, y + h), close: true, stroke: st)
    content((cx, y + h / 2), t)
  }
  let process(cx, y, w, h, t, sub: false) = {
    draw.rect((cx - w / 2, y), (cx + w / 2, y + h), stroke: st)
    if sub {
      for x in (cx - w / 2 + 0.3, cx + w / 2 - 0.3) {
        draw.line((x, y), (x, y + h), stroke: st)
      }
    }
    content((cx, y + h / 2), t)
  }
  let decision(cx, cy, w, h, t) = {
    draw.line((cx, cy + h / 2), (cx + w / 2, cy), (cx, cy - h / 2),
      (cx - w / 2, cy), close: true, stroke: st)
    content((cx, cy), t)
  }
  draw.rect((4.15, 16.8), (5.85, 17.55), radius: 0.37, stroke: st)
  content((5, 17.175), [Start])
  io(5, 15.2, 10.2, 0.75, [$V_("in"), R_S, R_d, V_d, R_L$, L, ESR, C, $R_("Load")$])
  io(5, 13.6, 4.8, 0.75, [P, DC, tf, TAM])
  process(5, 11.8, 6.3, 1.0, [PWM Generator], sub: true)
  process(5, 9.9, 4.6, 0.8, [$i_(L 0) = 0$ and $v_(C 0) = 0$])
  decision(5, 7.5, 4.2, 2.4, [CI < TAM])
  decision(11.5, 4.5, 5.5, 2.6, [PWM == 'HIGH'])
  process(0.7, 4.7, 3.8, 0.85, [$t, i_L, v_C, i_C, v_O$])
  io(0.7, 0.8, 4.1, 3.0, align(center)[Show $i_L$,\ $v_C$, $i_C$, $v_O$\ graphs as\ a function\ of time (t)])
  draw.rect((-0.15, -1.1), (1.55, -0.35), radius: 0.37, stroke: st)
  content((0.7, -0.725), [End])
  process(7.5, 0.7, 4.3, 1.6, align(center)[Conduction\ Stage], sub: true)
  process(15.8, 0.2, 5.6, 1.6, align(center)[Non-Conduction\ Stage], sub: true)
  edge((5, 16.8), (5, 15.95))
  edge((5, 15.2), (5, 14.35))
  edge((5, 13.6), (5, 12.8))
  edge((5, 11.8), (5, 10.7))
  edge((5, 9.9), (5, 8.7))
  edge((2.9, 7.5), (0.7, 7.5), (0.7, 5.55))
  content((1.5, 8.0), [False])
  edge((7.1, 7.5), (11.5, 7.5), (11.5, 5.8))
  content((8.3, 8.0), [True])
  edge((0.7, 4.7), (0.7, 3.8))
  edge((0.7, 0.8), (0.7, -0.35))
  edge((8.75, 4.5), (7.5, 4.5), (7.5, 2.3))
  content((7.2, 5.0), [True])
  edge((14.25, 4.5), (15.8, 4.5), (15.8, 1.8))
  content((15.4, 5.0), [False])
  edge((7.5, 0.7), (7.5, -0.9))
  edge((15.8, 0.2), (15.8, -0.9))
  draw.line((15.8, -0.9), (5, -0.9), stroke: st)
  edge((5, -0.9), (5, 6.3))
})
