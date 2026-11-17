#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 8pt)
#set text(font: "Times New Roman", size: 11pt)

// Apostolou et al., Applied Sciences 2025, DOI 10.3390/app152011207, Figure 5.
// Preserve all original source counts, including the inconsistent database total.
#let vertical(t) = rotate(90deg, t, reflow: true)
#canvas({
  import draw: *
  let edge = 0.8pt + black
  let arrow(..pts) = line(..pts, stroke: edge, mark: (end: ">"))
  let box(x0, y0, x1, y1, title, body) = {
    rect((x0, y0), (x1, y1), stroke: edge)
    content(((x0 + x1) / 2, (y0 + y1) / 2), align(center)[*#title*\ #body])
  }
  let stage(y0, y1, t) = {
    rect((0, y0), (1.2, y1), radius: 0.2, fill: rgb("8ec5e4"), stroke: edge)
    content((0.6, (y0 + y1) / 2), vertical(t))
  }
  rect((2, 40.1), (24.6, 41.3), radius: 0.2,
    fill: rgb("ffc000"), stroke: 0.8pt + rgb("b88a00"))
  content((13.3, 40.7), text(weight: "bold")[Identification of studies via databases])
  stage(14.8, 39.5, [Identification])
  stage(3.8, 14.2, [Screening])
  stage(0, 3.2, [Include])
  rect((2.4, 14.8), (13.4, 39.5), stroke: edge)
  content((3.0, 38.8), text(weight: "bold")[Records identified from:], anchor: "west")
  content((3.7, 38.05), [Databases (n = 28):], anchor: "west")
  let sources = (
    [IEEE Xplore (n = 50)], [MDPI (n = 11)], [SpringerLink (n = 26)],
    [ACM Digital Library (n = 20)], [arXiv (n = 58)], [IJCNN (n = 1)],
    [AAAI (n = 6)], [NeurIPS (n = 14)], [PMLR (n = 7)],
    [Elsevier ScienceDirect (n = 18)], [ICML (n = 2)], [Frontiers (n = 2)],
    [CSOL (n = 1)], [Engineering Reports (n = 1)], [IOP Publishing (n = 1)],
    [Wiley Online Library (n = 5)], [IJASEIT (n = 1)], [JIHMSP (n = 1)],
    [iSECURE Journal (n = 1)], [BMVC (n = 1)], [bioRxiv (n = 1)],
    [MIT Press (n = 1)], [JMLR (n = 2)], [IAJIB (n = 1)],
    [Computer System and], [Information Technologies (n = 1)],
    [MNRAS Letters (n = 1)], [Bentham Science (n = 1)], [OpenReview (n = 1)], [PRISMA (n = 1)],
  )
  for (i, t) in sources.enumerate() {
    content((3.7, 37.25 - 0.73 * i), t, anchor: "west")
  }
  box(16.8, 25.8, 25.3, 29.4, [Records removed before\ screening:],
    [Duplicate records\ removed (n = 12)])
  arrow((13.4, 27.6), (16.8, 27.6))
  box(5.0, 11.9, 11.0, 14.0, [Records screened:], [(n = 225)])
  box(16.8, 11.9, 23.8, 14.0, [Records excluded:], [(n = 25)])
  arrow((8, 14.8), (8, 14))
  arrow((11, 12.95), (16.8, 12.95))
  box(3.7, 8.3, 12.3, 10.5, [Reports sought for retrieval:], [(n = 200)])
  box(16.8, 8.3, 24.8, 10.5, [Reports not retrieved:], [(n = 10)])
  arrow((8, 11.9), (8, 10.5))
  arrow((12.3, 9.4), (16.8, 9.4))
  box(3.0, 4.3, 13.0, 6.6, [Reports assessed for eligibility:], [(n = 190)])
  box(16.8, 3.7, 26.3, 7.1, [Reports excluded:],
    [Irrelevant (n = 35)\ Duplicate Publication (n = 10)\ Not in English (n = 2)])
  arrow((8, 8.3), (8, 6.6))
  arrow((13, 5.45), (16.8, 5.45))
  box(3.7, 0.4, 12.3, 2.7, [Studies included in review:], [(n = 143)])
  arrow((8, 4.3), (8, 2.7))
})
