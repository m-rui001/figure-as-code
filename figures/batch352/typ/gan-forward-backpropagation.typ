#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 13pt, weight: "bold")

// Apostolou et al., Applied Sciences 2025, DOI 10.3390/app152011207, Figure 1.
// Preserve the source arrow directions, including its generator-loss return to D.
#let vertical(t) = rotate(-90deg, t, reflow: true)
#canvas({
  import draw: *
  let forward = rgb("777777")
  let back = rgb("ff7900")
  let arrow(..pts, color: forward) = line(..pts, stroke: 1.7pt + color, mark: (end: ">"))
  let panel(x0, y0, x1, y1, t, fill, edge, turn: false) = {
    rect((x0, y0), (x1, y1), radius: 0.5, fill: fill, stroke: 2pt + edge)
    content(((x0 + x1) / 2, (y0 + y1) / 2), if turn { vertical(t) } else { t })
  }
  panel(0, 3, 2, 8.5, [Random noise], rgb("cfe7dc"), rgb("073d0d"), turn: true)
  panel(4, 3.5, 9, 8.5, [Generator (G)], rgb("fff7c7"), rgb("b59a00"))
  panel(4, 13, 9, 16.5, [Training data], rgb("f4cef7"), rgb("8a169d"))
  panel(20, 7.1, 26, 13, [Discriminator (D)], rgb("b9e8fa"), rgb("2a6680"))
  panel(29, 13, 31.5, 19, [Discriminator loss], rgb("fff7ec"), rgb("b76700"), turn: true)
  panel(29, 1, 31.5, 7, [Generator loss], rgb("fff7ec"), rgb("b76700"), turn: true)

  let samples(y, colors) = {
    rect((12, y), (17, y + 5), radius: 0.8, stroke: 0.7pt + rgb("cccccc"))
    for (i, color) in colors.enumerate() {
      let x = 13 + i * 0.35
      let yy = y + 1.8 - i * 0.35
      rect((x, yy), (x + 2.1, yy + 2.1), fill: color,
        stroke: 1.2pt + color.darken(55%))
    }
  }
  samples(12.1, (rgb("d4ebc1"), rgb("ffd9c0"), rgb("d7cdfb"), rgb("d9d9d9")))
  samples(3.5, (rgb("ffb9b9"), rgb("58c87e"), rgb("d498dc"), rgb("93e2ec")))
  content((14.5, 17.9), [Real samples])
  content((14.5, 2.7), [Generated samples])
  arrow((2.3, 6), (3.7, 6))
  arrow((9.4, 6), (11.6, 6))
  arrow((9.4, 14.7), (11.6, 14.7))
  line((17, 14.6), (18.2, 14.6), (18.2, 10), stroke: 1.7pt + forward)
  line((17, 6), (18.2, 6), (18.2, 10), stroke: 1.7pt + forward)
  arrow((18.2, 10), (19.9, 10))
  arrow((26, 10), (29, 14.5))
  arrow((26, 10), (29, 5.5))

  arrow((29, 16), (24.5, 16), (24.5, 13.1), color: back)
  content((24, 17.05), [Backpropagation])
  arrow((29, 4), (25, 4), (25, 7), color: back)
  arrow((22.3, 7.1), (22.3, 0), (6.5, 0), (6.5, 3.4), color: back)
  content((15.2, -0.7), [Backpropagation])
})
