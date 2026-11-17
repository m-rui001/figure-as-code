#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 6pt)
#set text(font: "Times New Roman", size: 11pt)

// Apostolou et al., DOI 10.3390/app152011207, Figure 3.
// Bar values are approximate readings from the source image.
#canvas({
  import draw: *
  let ink = rgb("200db5")
  let panel(x, w, unit, limit, ticks, bars) = {
    rect((x, 0), (x + w, 11), stroke: 0.8pt + black)
    content((x + 0.55, 10.25), text(fill: ink, size: 14pt, unit), anchor: "west")
    let left = x + 1.7
    let spacing = (w - 2.1) / bars.len()
    for (i, t) in ticks.enumerate() {
      let y = 4.1 + i / (ticks.len() - 1) * 5.5
      line((left, y), (x + w - 0.4, y), stroke: 0.4pt + rgb("eeeeee"))
      content((left - 0.25, y), t, anchor: "east")
    }
    for (i, (value, color, label)) in bars.enumerate() {
      let cx = left + (i + 0.5) * spacing
      let half = spacing * 0.42
      rect((cx - half, 4.1), (cx + half, 4.1 + value / limit * 5.5),
        fill: rgb(color), stroke: none)
      content((cx, 3.78), align(center, label), anchor: "north")
    }
    content((x + w / 2, 0.65), text(fill: ink, weight: "bold")[Estimation Method])
  }
  panel(0, 13.5, [kg CO#sub[2]eq], 0.10, ("0.00", "0.02", "0.04", "0.06", "0.08", "0.10"), (
    (0.089, "98d774", [Power x\ Realtime]),
    (0.050, "ff8989", [Power x CA\ Average]),
    (0.095, "84bdd3", [Power x EPA\ US Average]),
  ))
  panel(14, 18.8, [kWh], 0.4, ("0.0", "0.1", "0.2", "0.3", "0.4"), (
    (0.230, "f595bc", [Energy usage\ in real time]),
    (0.140, "ffea81", [Time x GPUs x\ 1/3Util x TDP]),
    (0.40, "008fa1", [Time x GPUs x\ 1Util x TDP]),
    (0.07, "ffa658", [GPU-hrs x TDP]),
    (0.01, "ff1020", [PFLOPs-hr x\ (GPU PFLOPS/W)]),
  ))
})
