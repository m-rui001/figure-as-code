#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：热连轧数字孪生的虚拟空间、数据中心与物理空间架构。
// 来源：Sensors 2024, 24, 614，Figure 1，DOI 10.3390/s24020614，CC BY 4.0。
// 虚拟空间保留几何、动态和运动学模型，以及状态同步与属性更新。
// 数据中心保留双接收/发送接口、存储、预处理到分布的完整数据链。
// 物理空间保留基础自动化、过程自动化、参数优化和质量预测。
// 两条照片带抽象为线稿轧机，避免引入位图并保持出版比例。
// 实心 stealth 箭头区分物理数据上行、孪生更新下行及闭环反馈。

#let dt-ink = rgb("#203444")
#let dt-teal = rgb("#087f8c")
#let dt-green = rgb("#32a852")
#let dt-edge = rgb("#72968d")
#let dt-gold = rgb("#d39b32")
#let dt-panel(x, y, w, h, fill, edge, title, size: 9.5pt) = {
  draw.rect((x, y), (x + w, y + h), fill: fill, stroke: (paint: edge, thickness: 0.8pt), radius: 0.12)
  draw.content((x + w / 2, y + h - 0.60), text(fill: dt-ink, size: size)[#title], anchor: "south")
}
#let dt-chip(x, y, w, h, title, size: 8.2pt, fill: white) = {
  draw.rect((x, y), (x + w, y + h), fill: fill, stroke: (paint: dt-edge, thickness: 0.65pt), radius: 0.08)
  draw.content((x + w / 2, y + h / 2), text(fill: dt-ink, size: size)[#title])
}
#let dt-bar(x, y, w, h, title, fill: dt-teal, size: 9pt) = {
  draw.rect((x, y), (x + w, y + h), fill: fill, stroke: none, radius: 0.10)
  draw.content((x + w / 2, y + h / 2), text(fill: white, size: size, weight: "bold")[#title])
}
#let dt-arrow(points, paint: dt-teal, thickness: 1.05pt, both: false) = {
  for (index, pair) in points.enumerate() {
    if index == 0 { continue }
    let start = points.at(index - 1)
    let end = pair
    let last = index == points.len() - 1
    if last and both {
      draw.line(start, end, stroke: (paint: paint, thickness: thickness),
        mark: (start: "stealth", end: "stealth", fill: paint, scale: 0.42))
    } else if last {
      draw.line(start, end, stroke: (paint: paint, thickness: thickness),
        mark: (end: "stealth", fill: paint, scale: 0.42))
    } else {
      draw.line(start, end, stroke: (paint: paint, thickness: thickness))
    }
  }
}
#let dt-stand(cx, base, scale, id: none) = {
  let steel = rgb("#537b79")
  draw.rect((cx - 0.85 * scale, base), (cx + 0.85 * scale, base + 1.55 * scale),
    fill: rgb("#d5e8df"), stroke: (paint: steel, thickness: 0.75pt), radius: 0.04)
  draw.rect((cx - 0.98 * scale, base + 1.55 * scale), (cx + 0.98 * scale, base + 1.82 * scale),
    fill: rgb("#a9cdbf"), stroke: (paint: steel, thickness: 0.75pt))
  for side in (-1, 1) {
    let px = cx + side * 0.70 * scale
    draw.line((px, base + 0.15 * scale), (px, base + 1.45 * scale), stroke: steel)
    draw.circle((cx + side * 0.36 * scale, base + 0.68 * scale), radius: 0.26 * scale,
      fill: rgb("#eef6f1"), stroke: (paint: steel, thickness: 0.8pt))
    draw.line((cx + side * 0.70 * scale, base + 0.20 * scale),
      (cx + side * 0.70 * scale, base - 0.12 * scale), stroke: steel)
  }
  draw.line((cx - 1.12 * scale, base + 0.42 * scale), (cx + 1.12 * scale, base + 0.42 * scale),
    stroke: (paint: rgb("#e6a51d"), thickness: 3.2pt))
  if id != none { draw.content((cx, base + 2.15 * scale), text(size: 7pt, fill: dt-ink)[#id]) }
}

#canvas(length: 0.75cm, {
  import draw: *
  rect((0.1, 19.2), (19.9, 28.7), fill: rgb("#e9f7e8"), stroke: rgb("#83c98b"), radius: 0.18)
  rect((0.1, 10.7), (19.9, 18.6), fill: rgb("#fff7d9"), stroke: rgb("#d9c278"), radius: 0.18)
  rect((0.1, 0.1), (19.9, 10.1), fill: rgb("#e7f6fb"), stroke: rgb("#78bed2"), radius: 0.18)
  content((10, 27.88), text(size: 15pt, weight: "bold", fill: rgb("#21843a"))[Virtual Space], anchor: "south")
  content((10, 17.98), text(size: 15pt, weight: "bold", fill: rgb("#a37516"))[Data Center], anchor: "south")
  content((10, 9.35), text(size: 14pt, weight: "bold", fill: rgb("#176bb5"))[Physical Space], anchor: "south")

  // Cross-space trunks terminate at container edges and remain visible in the gutters.
  dt-arrow(((2.0, 15.5), (2.0, 16.2)), paint: rgb("#2465c7"))
  dt-arrow(((2.0, 10.1), (2.0, 14.7)), paint: rgb("#2465c7"))
  dt-arrow(((19.3, 16.6), (19.55, 16.6), (19.55, 19.875), (19.3, 19.875)))
  dt-arrow(((19.3, 15.1), (19.55, 15.1)))
  dt-arrow(((18.75, 14.7), (18.75, 8.0)))
  dt-arrow(((18.75, 7.15), (18.75, 5.95)))

  rect((0.7, 24.1), (19.3, 27.3), fill: rgb("#dcece6"), stroke: rgb("#6c9d91"), radius: 0.08)
  line((0.9, 25.03), (19.1, 25.03), stroke: (paint: rgb("#e6a51d"), thickness: 4pt))
  line((0.9, 24.72), (19.1, 24.72), stroke: rgb("#6c9d91"))
  for (index, cx) in (1.6, 4.25, 6.9, 9.55, 12.2, 14.85, 17.5).enumerate() {
    let number = if index < 9 { "0" + str(index + 1) } else { str(index + 1) }
    dt-stand(cx, 24.82, 0.78, id: number)
  }

  let models = (
    (0.7, "Geometric models", (("Equipment size", 2.55), ("Production line layout", 3.05)),
      (("Profiles of work and back-up rolls", 4.5), ("...", 1.0))),
    (6.95, "Dynamic models", (("Shape model", 2.0), ("Rolling deformation model", 3.55)),
      (("Steel material re-crystallize model", 4.65), ("...", 0.8))),
    (13.2, "Kinematic models", (("Equipment action", 2.5), ("Material movement", 2.95)), ()),
  )
  for (x, title, upper, lower) in models {
    dt-panel(x, 21.8, 6.1, 1.95, rgb("#d7f6cf"), rgb("#55ad55"), title, size: 10pt)
    circle((x + 0.34, 23.35), radius: 0.12, fill: none, stroke: rgb("#28a23c"))
    let cursor = x + 0.2
    for (label, width) in upper {
      dt-chip(cursor, 22.55, width, 0.48, label, size: 6.2pt)
      cursor += width + 0.15
    }
    cursor = x + 0.2
    for (label, width) in lower {
      dt-chip(cursor, 21.96, width, 0.48, label, size: 6.2pt)
      cursor += width + 0.15
    }
  }
  dt-bar(0.7, 20.55, 18.6, 0.9, "State synchronizing model", fill: rgb("#35ad47"), size: 10pt)
  dt-bar(0.7, 19.45, 18.6, 0.85,
    "Update the properties of digital twin to stay consistent with physical objects in real time",
    fill: rgb("#087f83"), size: 8.3pt)

  // Both receive branches merge before preprocessing; storage and distribution feed both send branches.
  dt-arrow(((3.4, 16.6), (3.65, 16.6), (3.65, 13.175), (3.9, 13.175)), paint: rgb("#2465c7"))
  dt-arrow(((3.4, 15.1), (3.65, 15.1)), paint: rgb("#2465c7"))
  dt-arrow(((7.75, 13.6), (7.75, 16.35)), paint: rgb("#2465c7"))
  dt-arrow(((10.475, 13.6), (10.475, 16.35)), paint: rgb("#2465c7"))
  dt-arrow(((14.6, 16.775), (16.0, 16.775)), paint: rgb("#2465c7"))
  dt-arrow(((16.85, 13.6), (16.85, 14.7)), paint: rgb("#2465c7"))
  for (y, title) in ((16.2, "Receive interface"), (14.7, "Receive interface")) {
    dt-chip(0.65, y, 2.75, 0.8, title, fill: rgb("#f4d88c"), size: 6.8pt)
  }
  dt-chip(6.65, 16.35, 7.95, 0.85, "Data storage", size: 9.5pt)
  for (y, title) in ((16.2, "Send interface"), (14.7, "Send interface")) {
    dt-chip(16.0, y, 3.3, 0.8, title, fill: rgb("#f4d88c"), size: 9pt)
  }
  let stages = (
    (3.9, 2.45, "Data peprocess"), (6.65, 2.2, "Data mapping"),
    (9.15, 2.65, "Feature extraction"), (12.1, 2.65, "Information fusion"),
    (15.65, 2.4, "Data distribution"),
  )
  for (index, (x, width, title)) in stages.enumerate() {
    dt-chip(x, 12.75, width, 0.85, title, size: 6.2pt)
    if index > 0 {
      let previous = stages.at(index - 1)
      dt-arrow(((previous.at(0) + previous.at(1), 13.175), (x, 13.175)), paint: rgb("#2465c7"))
    }
  }

  // Optimization feeds both automation layers; quality prediction closes the loop to the mill.
  dt-arrow(((4.3, 8.3), (4.3, 8.15)), paint: rgb("#087f83"))
  dt-arrow(((10.0, 8.3), (10.0, 8.15)), paint: rgb("#087f83"))
  dt-arrow(((6.7, 7.35), (7.0, 7.35)), paint: rgb("#176bb5"), both: true)
  dt-arrow(((15.3, 8.3), (15.65, 8.3), (15.65, 7.575), (16.0, 7.575)))
  dt-arrow(((1.75, 6.45), (1.75, 5.95)), paint: rgb("#176bb5"))
  dt-bar(4.3, 8.3, 11.0, 0.65, "Optimizing the parameters of control and process", size: 9.5pt)
  dt-panel(0.7, 6.35, 6.0, 1.8, rgb("#cce9f7"), rgb("#5aa8ca"),
    "Basic automation: control & execution", size: 7pt)
  dt-panel(7.0, 6.35, 8.3, 1.8, rgb("#cce9f7"), rgb("#5aa8ca"),
    "Process automation: process parameters setup", size: 8pt)
  for (x, width, title) in ((0.9, 1.7, "Sensors"), (2.75, 1.55, "PLCs"), (4.45, 1.95, "HMI")) {
    dt-chip(x, 6.65, width, 0.65, title, size: 8pt)
  }
  for (x, width, title) in ((7.2, 2.6, "Load distribution"), (9.95, 3.0, "Profile and flatness"),
      (13.1, 2.05, "Temperature")) {
    dt-chip(x, 6.65, width, 0.65, title, size: 6.8pt)
  }
  dt-bar(16.0, 7.15, 3.3, 0.85, "Quality prediction", fill: rgb("#087f83"), size: 8.2pt)

  rect((0.7, 0.55), (19.3, 5.95), fill: rgb("#dce8e5"), stroke: rgb("#6c8d87"), radius: 0.08)
  line((0.9, 1.52), (19.1, 1.52), stroke: (paint: rgb("#e6a51d"), thickness: 5pt))
  line((0.9, 0.95), (19.1, 0.95), stroke: rgb("#6c8d87"))
  line((0.9, 4.65), (19.1, 4.65), stroke: rgb("#6c8d87"))
  for x in (1.0, 5.7, 10.4, 15.1, 19.0) {
    line((x, 0.85), (x, 4.65), stroke: rgb("#6c8d87"))
  }
  for cx in (2.55, 7.25, 11.95, 16.65) { dt-stand(cx, 1.05, 1.55) }
})
