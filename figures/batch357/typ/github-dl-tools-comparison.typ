#import "@preview/cetz:0.4.2": canvas, draw
#set page(width: auto, height: auto, margin: 9pt)
#set text(font: "Times New Roman", size: 11pt, fill: rgb("555555"))

// Chen and Guo, Mathematics 2023, DOI 10.3390/math11081777, Figure 8.
// Values are source-image top-row pixels. None indicates no discernible colored bar.
#let samples = (
  ("Caffe", (1027, 1158, 1087)),
  ("CNTK", (1094, 1161, 1148)),
  ("deeplearning4j", (1113, none, 1146)),
  ("Keras", (924, 1159, 1085)),
  ("Mxnet", (1081, 1162, 1138)),
  ("Pytorch", (896, 1160, 1092)),
  ("Paddlepaddle", (1160, none, 1163)),
  ("Torch", (1130, none, 1157)),
  ("Theano", (1126, none, 1156)),
  ("Tensorflow", (441, 1134, 795)),
  ("Matlab", (1161, none, none)),
  ("OpenCV", (883, 1156, 937)),
)
#let rotated(label) = rotate(-48deg, label, reflow: true)
#canvas({
  import draw: *
  let palette = (rgb("5b9bd5"), rgb("ed7d31"), rgb("a5a5a5"))
  let grid = 0.8pt + rgb("d9d9d9")
  rect((-3.1, -5.8), (24.6, 12.9), stroke: grid)
  content((10.75, 11.9), text(size: 20pt)[Comparison of different DL tools on Github])
  for i in range(11) {
    line((0, i), (24, i), stroke: grid)
    content((-0.5, i), if i == 0 { [0] } else { [#(i * 20),000] }, anchor: "east")
  }
  for (i, (name, tops)) in samples.enumerate() {
    let center = 1 + i * 2
    for (j, top) in tops.enumerate() {
      if top != none {
        let x = center + (j - 1) * 0.44
        let height = (1167 - top) / (1167 - 322) * 10
        rect((x - 0.18, 0), (x + 0.18, height), fill: palette.at(j), stroke: none)
      }
    }
    content((center, -0.65), rotated(name), anchor: "north-east")
  }
  for (i, t) in ([stars], [watching], [forks]).enumerate() {
    let x = 7.9 + i * 3.1
    rect((x, -4.95), (x + 0.3, -4.65), fill: palette.at(i), stroke: none)
    content((x + 0.45, -4.8), t, anchor: "west")
  }
})
