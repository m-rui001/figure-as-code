#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Arial", size: 10pt)

// Amaral and Cardoso (2022), DOI 10.3390/signals3020020, Figure 9 (CC BY 4.0).
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
  io(4.4, [(Amp, P, tf, TAM)])
  draw.rect((0.45, 2.4), (8.55, 3.6), stroke: st)
  for x in (0.95, 8.05) {
    draw.line((x, 2.4), (x, 3.6), stroke: st)
  }
  content((4.5, 3.0), align(center)[Saw Tooth Generator])
  io(0.45, [(t, Saw Tooth Waveform)])
  draw.line((4.5, 4.4), (4.5, 3.6), stroke: st, mark: tip)
  draw.line((4.5, 2.4), (4.5, 1.55), stroke: st, mark: tip)
  let lines = (
    "def Saw_Tooth_generator(Amp,P,tf,TAM):",
    "    PA=tf/TAM;signal=np.zeros(TAM)",
    "    t=np.zeros(TAM);time=0;t0=0;i=0",
    "    while t0<P:",
    "        t0+=PA;i+=1",
    "    VS=Amp/i",
    "    i=0;t0=0;value=0;time=0",
    "    while i<TAM:",
    "        if t0>=P:",
    "            t0=0;value=0;signal[i]=value",
    "        else:",
    "            t0+=PA;value+=VS;signal[i]=value",
    "        time+=PA;t[i]=time;i+=1",
    "    return [t,signal]",
  )
  for (i, code) in lines.enumerate() {
    content((9.5, 5.3 - i * 0.38), text(size: 8.5pt,
      weight: if i in (0, 13) { "bold" } else { "regular" })[#code], anchor: "west")
  }
  content((4.5, -0.35), [(a)])
  content((14.2, -0.35), [(b)])
})
