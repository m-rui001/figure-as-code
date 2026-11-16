#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Differences in network awareness structure（网络感知结构差异）
// 来源：Drones 2025, 9(8), 564, Figure 5；DOI: 10.3390/drones9080564
// 结构：左右两栏协议栈对照。左栏 (a) 为既有架构：Application、DDS Domain（Publisher/Subscriber 经 Topic 相连）、
// RTPS Domain（RTPSWriter/Reader）、Transport、Physical。右栏 (b) 增加网络感知：DDS 内嵌 Network Monitor/Passive Timer，
// RTPS 内嵌 Passive Filter，二者以 RSSI 反馈相连，PHY 另有一路输入上行到 Monitor。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.32)
  let st = 0.8pt + black
  let dash = (paint: black, thickness: 0.7pt, dash: "dashed")
  let lay(x, y, t) = content((x, y), text(size: 6pt)[#t])
  let box(x0, y0, x1, y1, t, s: 6.5pt) = {
    draw.rect((x0, y0), (x1, y1), radius: 0.06, fill: white, stroke: st)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: s)[#t])
  }

  // (a) 既有架构
  draw.rect((1.60, 7.95), (6.90, 8.35), fill: rgb("#f6c9c9"), stroke: st)
  content((4.25, 8.15), text(size: 7pt)[User Code])
  lay(0.85, 8.15, [Application])
  draw.rect((1.60, 5.65), (6.90, 7.55), radius: 0.12, fill: rgb("#dbe6f5"), stroke: st)
  lay(1.05, 6.72, [DDS])
  lay(1.05, 6.48, [Domain])
  box(2.10, 6.30, 3.55, 7.28, [])
  content((2.82, 7.05), text(size: 6.5pt, weight: "bold")[Publisher])
  box(2.28, 6.42, 3.38, 6.90, [DataWriter], s: 5.8pt)
  box(4.55, 6.30, 6.00, 7.28, [])
  content((5.28, 7.05), text(size: 6.5pt, weight: "bold")[Subscriber])
  box(4.73, 6.42, 5.83, 6.90, [DataReader], s: 5.8pt)
  box(3.80, 6.48, 4.30, 6.86, [Topic], s: 5.5pt)
  draw.line((3.55, 6.66), (3.80, 6.66), stroke: 0.6pt + black)
  draw.line((4.30, 6.66), (4.55, 6.66), stroke: 0.6pt + black)
  draw.rect((1.60, 4.00), (6.90, 5.35), radius: 0.12, fill: rgb("#d6ead6"), stroke: st)
  lay(1.05, 4.78, [RTPS])
  lay(1.05, 4.54, [Domain])
  box(2.20, 4.30, 3.75, 5.05, [RTPSWriter], s: 6pt)
  box(4.60, 4.30, 6.15, 5.05, [RTPSReader], s: 6pt)
  draw.rect((1.90, 3.20), (6.60, 3.70), radius: 0.10, fill: rgb("#fbdcb4"), stroke: st)
  content((4.25, 3.45), text(size: 7pt)[UDDP/TCP/SHM])
  lay(0.85, 3.45, [Transport])
  content((4.25, 2.88), text(size: 8pt)[$dots.v$])
  draw.rect((2.40, 2.05), (6.10, 2.45), radius: 0.06, fill: rgb("#e0e0e0"), stroke: st)
  content((4.25, 2.25), text(size: 6.5pt)[RF Receiver])
  lay(0.85, 2.25, [Physical])

  // (a) 竖向箭头
  draw.line((2.82, 7.95), (2.82, 7.28), stroke: st, mark: ar)
  draw.line((5.28, 7.28), (5.28, 7.95), stroke: st, mark: ar)
  draw.line((2.82, 6.30), (2.82, 5.05), stroke: st, mark: ar)
  draw.line((5.28, 6.30), (5.28, 5.05), stroke: st, mark: ar)
  draw.line((2.82, 4.30), (2.82, 3.70), stroke: st, mark: ar)
  draw.line((5.28, 4.30), (5.28, 3.70), stroke: st, mark: ar)
  draw.line((4.25, 3.20), (4.25, 2.45), stroke: st, mark: ar)

  // (b) 网络感知架构
  draw.rect((9.30, 7.95), (14.60, 8.35), fill: rgb("#f6c9c9"), stroke: st)
  content((11.95, 8.15), text(size: 7pt)[User Code])
  lay(8.55, 8.15, [Application])
  draw.rect((9.30, 5.65), (14.60, 7.55), radius: 0.12, fill: rgb("#dbe6f5"), stroke: st)
  lay(8.75, 6.72, [DDS])
  lay(8.75, 6.48, [Domain])
  draw.rect((9.55, 6.30), (10.90, 7.28), radius: 0.06, fill: white, stroke: dash)
  content((10.22, 6.95), text(size: 5.8pt, weight: "bold")[Network])
  content((10.22, 6.76), text(size: 5.8pt, weight: "bold")[Monitor])
  content((10.22, 6.52), text(size: 5.5pt)[Passive Timer])
  box(11.10, 6.30, 12.45, 7.28, [])
  content((11.78, 7.05), text(size: 6.5pt, weight: "bold")[Publisher])
  box(11.26, 6.42, 12.30, 6.90, [DataWriter], s: 5.8pt)
  box(13.05, 6.30, 14.40, 7.28, [])
  content((13.73, 7.05), text(size: 6.5pt, weight: "bold")[Subscriber])
  box(13.14, 6.42, 14.30, 6.90, [DataReader], s: 5.8pt)
  box(12.62, 6.48, 13.02, 6.86, [Topic], s: 5.5pt)
  draw.line((12.45, 6.66), (12.62, 6.66), stroke: 0.6pt + black)
  draw.line((13.02, 6.66), (13.05, 6.66), stroke: 0.6pt + black)
  draw.rect((9.30, 4.00), (14.60, 5.35), radius: 0.12, fill: rgb("#d6ead6"), stroke: st)
  lay(8.75, 4.78, [RTPS])
  lay(8.75, 4.54, [Domain])
  draw.rect((9.55, 4.30), (10.75, 5.05), radius: 0.06, fill: white, stroke: dash)
  content((10.15, 4.78), text(size: 5.8pt, weight: "bold")[Passive])
  content((10.15, 4.58), text(size: 5.8pt, weight: "bold")[Filter])
  box(10.95, 4.30, 12.30, 5.05, [RTPSWriter], s: 6pt)
  box(13.05, 4.30, 14.40, 5.05, [RTPSReader], s: 6pt)
  draw.rect((9.60, 3.20), (14.30, 3.70), radius: 0.10, fill: rgb("#fbdcb4"), stroke: st)
  content((11.95, 3.45), text(size: 7pt)[UDDP/TCP/SHM])
  lay(8.55, 3.45, [Transport])
  content((11.95, 2.88), text(size: 8pt)[$dots.v$])
  draw.rect((10.10, 2.05), (13.80, 2.45), radius: 0.06, fill: rgb("#e0e0e0"), stroke: st)
  content((11.95, 2.25), text(size: 6.5pt)[RF Receiver])
  lay(8.55, 2.25, [Physical])

  // (b) 竖向箭头与反馈
  draw.line((11.78, 7.95), (11.78, 7.28), stroke: st, mark: ar)
  draw.line((13.73, 7.28), (13.73, 7.95), stroke: st, mark: ar)
  draw.line((11.78, 6.30), (11.78, 5.05), stroke: st, mark: ar)
  draw.line((13.73, 6.30), (13.73, 5.05), stroke: st, mark: ar)
  draw.line((11.78, 4.30), (11.78, 3.70), stroke: st, mark: ar)
  draw.line((13.73, 4.30), (13.73, 3.70), stroke: st, mark: ar)
  draw.line((11.95, 3.20), (11.95, 2.45), stroke: st, mark: ar)
  draw.line((10.15, 6.30), (10.15, 5.05), stroke: st, mark: ar)
  content((9.84, 5.48), text(size: 5.5pt)[RSSI])
  draw.line((10.45, 5.05), (10.45, 6.30), stroke: st, mark: ar)
  draw.line((9.00, 2.25), (9.00, 6.79), (9.55, 6.79), stroke: st, mark: ar)

  content((4.25, 1.45), text(size: 8pt)[(a)])
  content((11.95, 1.45), text(size: 8pt)[(b)])
})
