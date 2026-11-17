#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 12pt)

// Apostolou et al., Applied Sciences 2025, DOI 10.3390/app152011207, Figure 2.
// Retain source years and model names; keep year text outside branch lines.
#canvas({
  import draw: *
  let architecture = rgb("ffc34d")
  let domain = rgb("eda8ef")
  let dashed = (paint: black, thickness: 1.1pt, dash: "dashed")
  let dotted = (paint: black, thickness: 0.8pt, dash: "dotted")
  let branch(..pts, arrow: false) = line(..pts, stroke: dashed,
    mark: if arrow { (end: ">") } else { none })
  let box(x, y, t, fill, width: 3.4) = {
    rect((x - width / 2, y - 0.8), (x + width / 2, y + 0.8),
      radius: 0.15, fill: fill, stroke: none)
    content((x, y), text(weight: "bold", t))
  }
  let heading(x, y, t) = content((x, y), text(size: 14pt, weight: "bold", t))
  line((0, 0), (33, 0), stroke: 1.7pt + black)
  for i in range(12) {
    let x = i * 3
    circle((x, 0), radius: 0.22, fill: black, stroke: none)
    content((x, if i == 2 { 0.7 } else { -0.7 }), str(2014 + i))
  }
  branch((0, 0.22), (0, 2.2))
  box(0, 3, [cGAN], rgb("00b8d1"))
  heading(0, 4.25, [Latent Space])
  branch((3, 0.22), (3, 5.2))
  box(3, 6, [LAPGAN], architecture)
  heading(3, 7.4, [Architecture])
  branch((9, 0.22), (9, 2.2))
  box(9, 3, [Pix2Pix], rgb("7cd275"))
  branch((9, 3.8), (9, 5.2), arrow: true)
  box(9, 6, [CycleGAN], rgb("7cd275"))
  heading(9, 7.4, [Applications])
  branch((9, 0.25), (7.2, 1.2), (5.8, 3), (5.8, 5.4), (6.5, 8), (7.3, 10))
  box(9, 10, [WGAN], rgb("ff8eae"))
  branch((9, 10.8), (9, 12.2), arrow: true)
  box(9, 13, [WGAN-GP], rgb("ff8eae"))
  heading(9, 14.35, [Loss function])

  branch((12, 0.22), (13.3, 1), (14, 2.6), (14, 5.2))
  box(14, 6, [WaveGAN], domain)
  heading(23.5, 8.3, [Domain specific architectures])
  for (x, y, t) in ((24, 3, [PI-GAN]), (27, 6, [AnimalGAN]),
    (30, 3, [LeafyGAN]), (33, 6, [CRF-Guided\ GAN])) {
    branch((x, 0.22), (x, y - 0.8))
    box(x, y, t, domain, width: 3.8)
  }

  branch((6, -0.22), (6, -2.2))
  box(6, -3, [DCGAN], architecture)
  heading(1.1, -3, [Architecture])
  line((15, -1.15), (15, -2.2), stroke: dotted)
  line((18, -1.15), (18, -5.2), stroke: dotted)
  line((21, -1.15), (21, -8.2), stroke: dotted)
  branch((7.7, -3), (13.3, -3), arrow: true)
  box(15, -3, [StyleGAN], architecture)
  branch((15, -3.8), (15, -6), (16.3, -6), arrow: true)
  box(18, -6, [StyleGAN2], architecture)
  branch((18, -6.8), (18, -9), (19.3, -9), arrow: true)
  box(21, -9, [StyleGAN3], architecture)
})
