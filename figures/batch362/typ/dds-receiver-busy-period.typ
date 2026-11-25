#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：DDS 接收线程忙周期的时间轴定义。
// 来源：Future Internet 2026, 18, 297，Figure 8，DOI 10.3390/fi18060297。
// 三段色带依次表示方程 8 的 (b)、(c)、(a) 三个服务时间分量。
// 上方两条双向箭头区分线程间干扰与积压消息的处理区间。
// 蓝色箭头标记首条 DDS 消息与随后到达的消息 m_j。
// 虚线标出忙周期起点、积压处理起点与 CPU 进入空闲状态的终点。
// 下方三条引线将边界事件锚定到时间轴，保留原图全部文字与方向。

#let ink = rgb("#191919")
#let arrival-blue = rgb("#00adee")
#let label(body) = text(font: ("Times New Roman", "Libertinus Serif"), fill: ink, body)
#let stacked(top, bottom) = align(center)[#top\ #bottom]

#canvas(length: 0.75cm, {
  import draw: *

  let busy-start = 2.18
  let red-end = 7.20
  let message-arrival = 8.08
  let backlog-start = 11.68
  let busy-end = 18.05
  let axis-y = 1.65
  let band-top = 2.48
  let interval-y = 3.38
  let busy-y = 4.95

  let sections = (
    (busy-start, red-end, rgb("#ff7e79"), [Part (b) of Equation 8]),
    (red-end, backlog-start, rgb("#92d050"), [Part (c) of Equation 8]),
    (backlog-start, busy-end, rgb("#ffd78e"), [Part (a) of Equation 8]),
  )
  for (left, right, color, title) in sections {
    rect((left, axis-y), (right, band-top), fill: color, stroke: none)
    let center-x = if left == red-end { 9.80 } else { (left + right) / 2 }
    let body = if left == red-end { text(size: 7.5pt, fill: ink)[#title] } else { label(title) }
    content((center-x, (axis-y + band-top) / 2), body)
  }

  let guide = (paint: ink, thickness: 0.68pt, dash: "dashed")
  for (x, low, high) in (
    (busy-start, band-top, busy-y + 0.78),
    (backlog-start, band-top, interval-y + 0.24),
    (busy-end, band-top, busy-y + 0.78),
  ) {
    line((x, low), (x, high), stroke: guide)
  }

  let interval(left, right, y) = {
    line(
      (left, y), (right, y),
      stroke: (paint: ink, thickness: 0.8pt),
      mark: (start: "stealth", end: "stealth", fill: black, scale: 0.4),
    )
  }
  interval(busy-start, busy-end, busy-y)
  interval(busy-start, backlog-start, interval-y)
  interval(backlog-start, busy-end, interval-y)

  content(((busy-start + busy-end) / 2, busy-y + 0.36), label[Busy Period])
  content((6.95, interval-y + 0.36), label[Inter-thread interference])
  content((14.86, interval-y + 0.56), label(stacked([Processing backlogged], [DDS messages])))

  for x in (busy-start, message-arrival) {
    line(
      (x, axis-y), (x, interval-y - 0.34),
      stroke: (paint: arrival-blue, thickness: 0.75pt),
      mark: (end: "stealth", fill: arrival-blue, scale: 0.4),
    )
  }

  line(
    (1.18, axis-y), (19.65, axis-y),
    stroke: (paint: ink, thickness: 1.45pt),
    mark: (end: "stealth", fill: black, scale: 0.4),
  )

  let callout(boundary-x, text-x, tail-y) = {
    line(
      (text-x, tail-y), (boundary-x, axis-y),
      stroke: (paint: ink, thickness: 0.75pt),
      mark: (end: "stealth", fill: black, scale: 0.4),
    )
  }
  callout(busy-start, 3.10, 1.22)
  callout(message-arrival, 10.00, 1.22)
  callout(busy-end, 17.20, 1.22)

  content((3.10, 0.90), label(stacked(
    [Arrival of the first DDS message],
    [(start of the busy period)],
  )), anchor: "north")
  content((10.00, 0.90), label[Arrival of the DDS message $m_j$], anchor: "north")
  content((17.20, 0.90), label(stacked(
    [The CPU core enters the idle state],
    [(end of the busy period)],
  )), anchor: "north")

  content(
    (3.95, -0.70),
    label[*Figure 8.* The definition of the busy period in the receiver thread.],
    anchor: "west",
  )
})
