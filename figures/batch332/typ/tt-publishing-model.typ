#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#let rtxt(t) = rotate(90deg, t, reflow: true)

// 图名：DDS message publishing model based on the TT strategy（TT 策略下的 DDS 消息发布模型）
// 来源：Future Internet 2026, 18, 297, Figure 6；DOI: 10.3390/fi18060297
// 结构：左侧 DDS 发布者/订阅者线程链（Publisher→Flow Controller→车载 TSN 模块→Receiver→Subscriber），
// 外部触发 η 注入 Publisher Thread；右侧车载 TSN 模块内部依次为 FRER、TAS（8 门控 + GCL + 传输选择）、
// 抢占（pMAC/eMAC→MAC Merge Sublayer）与物理层；Timed-Event Thread 以虚线分别管理两处。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.35)
  let st = 0.9pt + black
  let dash = (paint: black, thickness: 0.7pt, dash: "dashed")
  let bar(x0, y0, x1, y1, t, fill: white, s: 7pt) = {
    draw.rect((x0, y0), (x1, y1), radius: (y1 - y0) / 2, fill: fill, stroke: st)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: s)[#t])
  }

  // 左侧：DDS Publisher
  draw.rect((0.40, 8.60), (3.95, 11.20), fill: rgb("#fbdcb4"), stroke: none)
  content((0.75, 10.95), text(size: 8pt, weight: "bold")[DDS Publisher], anchor: "west")
  bar(0.80, 9.90, 3.40, 10.50, [Publisher Thread])
  bar(0.80, 8.90, 3.40, 9.50, [Flow Controller Thread])
  draw.line((2.10, 9.90), (2.10, 9.50), stroke: st, mark: ar)
  content((3.98, 10.78), text(size: 5.6pt)[External trigger], anchor: "west")
  content((4.02, 10.46), text(size: 6.5pt)[$eta_i^p (Delta)$], anchor: "west")
  draw.line((4.48, 10.10), (3.48, 10.10), stroke: st, mark: ar)
  // 车载 TSN 模块
  bar(0.75, 7.45, 3.45, 8.10, [In-vehicle TSN Module], s: 6.2pt)
  draw.line((2.10, 8.90), (2.10, 8.10), stroke: st, mark: ar)

  // 左侧：DDS Subscriber
  draw.rect((0.40, 4.90), (3.95, 7.25), fill: rgb("#d6ead6"), stroke: none)
  content((0.75, 7.00), text(size: 8pt, weight: "bold")[DDS Subscriber], anchor: "west")
  bar(0.80, 6.10, 3.40, 6.70, [Receiver Thread])
  bar(0.80, 5.10, 3.40, 5.70, [Subscriber Thread])
  draw.line((2.10, 6.10), (2.10, 5.70), stroke: st, mark: ar)
  draw.line((2.10, 7.45), (2.10, 6.70), stroke: st, mark: ar)

  // 右侧：TSN 模块内部
  draw.rect((5.20, 4.60), (12.20, 11.30), stroke: dash)
  content((5.45, 11.05), text(size: 7.5pt, weight: "bold")[FRER], anchor: "west")
  bar(6.40, 10.50, 11.90, 10.82, [Stream Identification], s: 6.5pt)
  bar(6.40, 10.00, 11.90, 10.32, [Frame Replication/ Elimination], s: 6.5pt)
  draw.line((9.15, 10.00), (9.15, 9.60), stroke: st, mark: ar)
  content((5.45, 9.70), text(size: 7.5pt, weight: "bold")[TAS], anchor: "west")
  draw.line((6.90, 9.35), (11.60, 9.35), stroke: 0.8pt + black, mark: ar)
  for i in range(8) {
    content((7.15 + i * 0.62, 9.50), text(size: 5.5pt)[#i])
  }
  content((11.60, 9.68), text(size: 6pt)[Priority], anchor: "east")
  for i in range(8) {
    let x = 6.95 + i * 0.62
    draw.rect((x, 7.95), (x + 0.42, 9.25), fill: white, stroke: 0.7pt + black)
  }
  draw.rect((6.97, 7.97), (7.35, 9.23), fill: rgb("#3aa35a"), stroke: none)
  draw.rect((7.57, 7.97), (7.95, 9.23), fill: rgb("#3aa35a"), stroke: none)
  draw.rect((10.67, 7.97), (11.05, 9.23), fill: rgb("#3f9ad8"), stroke: none)
  draw.rect((11.29, 7.97), (11.67, 9.23), fill: rgb("#3f9ad8"), stroke: none)
  bar(9.00, 8.38, 9.95, 8.80, [GCL], s: 6pt)
  for x in (7.10, 7.70, 8.30) {
    draw.line((x, 7.70), (x + 0.14, 7.84), (x, 7.98), (x - 0.14, 7.84), close: true,
      fill: white, stroke: 0.7pt + black)
  }
  content((8.85, 7.84), text(size: 8pt)[...])
  draw.line((10.95, 7.70), (11.09, 7.84), (10.95, 7.98), (10.81, 7.84), close: true,
    fill: white, stroke: 0.7pt + black)
  draw.line((11.20, 7.70), (11.34, 7.84), (11.20, 7.98), (11.06, 7.84), close: true,
    fill: white, stroke: 0.7pt + black)
  bar(6.60, 7.05, 11.90, 7.40, [Transmission Selection], s: 6.5pt)
  for x in (7.45, 9.35, 11.05) {
    draw.line((x, 7.05), (x, 6.62), stroke: st, mark: ar)
  }
  content((5.45, 6.75), text(size: 7.5pt, weight: "bold")[Preemption], anchor: "west")
  bar(6.60, 6.20, 8.25, 6.55, [pMAC], s: 6.5pt)
  bar(9.55, 6.20, 11.20, 6.55, [eMAC], s: 6.5pt)
  draw.line((7.40, 6.20), (7.40, 5.92), stroke: st, mark: ar)
  draw.line((10.35, 6.20), (10.35, 5.92), stroke: st, mark: ar)
  bar(6.60, 5.55, 11.90, 5.90, [MAC Merge Sublayer], s: 6.5pt)
  draw.line((9.25, 5.55), (9.25, 5.22), stroke: st, mark: ar)
  bar(6.60, 4.85, 11.90, 5.20, [Physical Layer], s: 6.5pt)

  // Timed-Event Thread 与虚线控制
  draw.rect((4.35, 6.85), (4.95, 9.55), radius: 0.28, fill: white, stroke: st)
  content((4.65, 8.20), rtxt(text(size: 7pt)[Timed-Event Thread]))
  draw.line((4.95, 9.40), (6.45, 10.35), stroke: dash)
  draw.line((4.95, 7.10), (3.35, 7.78), stroke: dash)
})
