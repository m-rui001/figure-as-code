#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 14pt)

// Apostolou et al., Applied Sciences 2025, DOI 10.3390/app152011207, Figure 8.
// Keep each gradient branch outside label bounds, including the loss return lines.
#canvas({
  import draw: *
  let peach = rgb("ffb198")
  let gen = rgb("b1c3ff")
  let disc = rgb("f39ac6")
  let gen-edge = rgb("899bd0")
  let disc-edge = rgb("b66f94")
  let arrow(..pts, color: black, dashed: false) = line(..pts,
    stroke: (paint: color, thickness: 1pt, dash: if dashed { "dashed" } else { "solid" }),
    mark: (end: ">"))
  let wire(..pts) = line(..pts, stroke: 0.85pt + black)
  let tag(x, y, width, t, fill) = {
    let x0 = x - width / 2
    let x1 = x + width / 2
    line((x0, y - 0.35), (x0 + 0.2, y - 0.55), (x1 - 0.2, y - 0.55),
      (x1, y - 0.35), (x1, y + 0.35), (x1 - 0.2, y + 0.55),
      (x0 + 0.2, y + 0.55), (x0, y + 0.35), close: true, fill: fill, stroke: none)
    content((x, y), t)
  }
  let network(x, y, t, fill) = {
    rect((x - 1.5, y - 0.85), (x + 1.5, y + 0.85), radius: 0.4,
      fill: fill, stroke: none)
    content((x, y), text(size: 22pt, t))
  }
  let row(y, loss) = {
    tag(2.7, y, 4, [$z$], peach)
    network(9.5, y, [G], gen)
    network(16.5, y, [D], disc)
    tag(23, y, 4, loss, peach)
    wire((4.7, y), (8, y))
    wire((11, y), (15, y))
    arrow((18, y), (21, y))
  }
  let gradients(y) = {
    tag(9.5, y, 3, [$theta_G$], gen)
    tag(16.5, y, 3, [$theta_D$], disc)
  }
  let multiply(x, y) = {
    circle((x, y), radius: 0.36, fill: rgb("d4b0ec"), stroke: none)
    content((x, y), text(size: 19pt)[$times$])
  }
  let frame(y0, y1, title) = {
    rect((0, y0), (26.5, y1), stroke: 0.7pt + black)
    content((13.25, y1 + 0.65), text(size: 20pt, title))
  }

  frame(19, 31, [Conventional])
  row(28.5, [$L_D$])
  gradients(26.1)
  arrow((21, 27.95), (16.5, 27.95), (16.5, 26.65), color: disc-edge)
  row(22.8, [$L_G$])
  gradients(20.4)
  arrow((21, 22.25), (9.5, 22.25), (9.5, 20.95), color: gen-edge)

  frame(9, 17, [FusedProp])
  row(14.7, [$L_D$])
  gradients(11.4)
  tag(13, 11.4, 2.5, [$lambda$], peach)
  multiply(13, 13.3)
  line((21, 14.15), (16.5, 14.15), (13, 14.15), (13, 13.66), stroke: 1pt + disc-edge)
  arrow((16.5, 14.15), (16.5, 11.95), color: disc-edge)
  arrow((12.64, 13.3), (9.5, 13.3), (9.5, 11.95), color: gen-edge)
  arrow((13, 11.95), (13, 12.94))
  arrow((19.5, 14.7), (19.5, 9.7), (13, 9.7), (13, 10.85), dashed: true)

  frame(0, 7.8, [InvFusedProp])
  row(5.8, [$L_G$])
  gradients(2.1)
  tag(13, 2.1, 2.5, [$lambda^(-1)$], peach)
  multiply(16.5, 3.7)
  arrow((21, 5.25), (9.5, 5.25), (9.5, 2.65), color: gen-edge)
  line((16.5, 5.25), (16.5, 4.06), stroke: 1pt + gen-edge)
  arrow((16.5, 3.34), (16.5, 2.65), color: disc-edge)
  arrow((13, 2.65), (13, 3.7), (16.14, 3.7))
  arrow((19.5, 5.8), (19.5, 0.65), (13, 0.65), (13, 1.55), dashed: true)
})
