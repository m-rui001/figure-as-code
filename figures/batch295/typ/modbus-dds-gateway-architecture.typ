#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图 2  Modbus–DDS 网关架构（Figure 2）
// 来源：Technologies 2025, 13, 526, Figure 2，DOI: 10.3390/technologies13110526
// 数据通路：RTU slave #1–#4 →（RS485 收发器 / UART）→ STM32F746 MCU（FreeRTOS）内的
//           Modbus poller → Mapping engine → DDS-XRCE Client 三个任务 → Ethernet →
//           XRCE Agent → DDS Domain（Topics → Subscribers/Applications）
// 画法：原图为 PPT 渐变+阴影，此处改为扁平浅色填充 + 0.6pt 描边。
//       画布 1 单位 = 1.14pt，坐标按「x 向右、y 向下」书写，由 P() 翻转到画布坐标。

#let c-navy   = rgb("#1F3864")   // 标题深蓝
#let c-ink    = rgb("#141C28")   // 正文近黑
#let c-wire   = rgb("#4467A6")   // 连线蓝
#let c-head   = rgb("#101B2C")   // 实心箭头填充
#let c-modbus = rgb("#C6D2EC")   // Modbus devices 面板：淡紫蓝
#let c-rtu    = rgb("#3E60A8")   // RTU slave：深蓝
#let c-mcu    = rgb("#C9C7C3")   // STM32 MCU 面板：灰
#let c-task   = rgb("#F6FAFD")   // 任务框：近白
#let c-xrce   = rgb("#DCEAF7")   // XRCE Agent：淡蓝
#let c-dds    = rgb("#E2E3F2")   // DDS Domain：淡紫
#let c-green  = rgb("#A2D873")   // Topics / Subscribers：绿
#let c-edge   = rgb("#8FA6C4")   // 通用描边
#let c-gedge  = rgb("#7CBB4E")   // 绿色框描边

#canvas(length: 1.14pt, {   // 1 画布单位 = 1.14pt：几何放大、字号不变，贴近原图字/框比例
  import draw: *

  // 所有坐标写成 (x, y)：x 向右、y 向下，交给 P 转成画布坐标（y 向上）
  let P(x, y) = (x, -y)

  // 箭头一律实心 stealth；显式 fill 保证箭头不被描边样式带成空心
  let ar-double = (start: "stealth", end: "stealth", fill: c-head, scale: 0.4)
  let ar-single = (end: "stealth", fill: c-head, scale: 0.4)

  // 大面板：左上角 (x, y)，宽 w 高 h，顶部居中标题（title 可为 none）
  // title-dy：标题中心相对面板顶边的偏移
  let panel(x, y, w, h, fill, title, edge: c-edge, title-dy: 14, r: 1) = {
    rect(P(x, y), P(x + w, y + h), radius: r, fill: fill,
      stroke: (paint: edge, thickness: 0.6pt))
    if title != none {
      content(P(x + w / 2, y + title-dy), anchor: "center", {
        set align(center)
        set par(leading: 0.5em)
        set text(size: 10pt, weight: "bold", fill: c-navy)
        title
      })
    }
  }

  // 圆角底框（不含文字）：pill 与自定义排版的小框共用
  let softbox(x, y, w, h, r, fill, edge) = rect(
    P(x, y), P(x + w, y + h), radius: r, fill: fill,
    stroke: (paint: edge, thickness: 0.6pt))

  // 圆角小框：左上角 (x, y)，文字在框内居中；r 为圆角半径（0.5h 即胶囊形）
  // body 为字符串时单行；为数组时逐行居中排布（行距 gap），避免多行段落基线偏移
  let pill(x, y, w, h, body, r: 5, fill: white, edge: c-edge,
           size: 10pt, weight: "bold", color: c-ink, gap: 9) = {
    softbox(x, y, w, h, r, fill, edge)
    if type(body) == array {
      for (i, ln) in body.enumerate() {
        content(P(x + w / 2, y + h / 2 + (i - (body.len() - 1) / 2) * gap),
          anchor: "center", text(size: size, weight: weight, fill: color, ln))
      }
    } else {
      content(P(x + w / 2, y + h / 2), anchor: "center",
        text(size: size, weight: weight, fill: color, body))
    }
  }

  // 任务框：MCU 内的胶囊形白框（圆角取半高）
  let task(x, y, w, h, label) = pill(x, y, w, h, label, r: h / 2,
    fill: c-task, edge: rgb("#A9C3DC"))

  // 双向箭头（两端实心 stealth）
  let darrow(a, b, color: c-wire, thick: 0.8pt) = line(
    P(a.at(0), a.at(1)), P(b.at(0), b.at(1)),
    stroke: (paint: color, thickness: thick), mark: ar-double)

  // 单向箭头（箭头在 b 端）
  let sarrow(a, b, color: c-wire, thick: 0.8pt) = line(
    P(a.at(0), a.at(1)), P(b.at(0), b.at(1)),
    stroke: (paint: color, thickness: thick), mark: ar-single)

  panel(0, 48, 190, 130, c-modbus, [Modbus devices], title-dy: 14)

  // 2×2 排列的 RTU slave：先列后行编号 #1 #2 / #3 #4
  let rtu-w = 76
  let rtu-h = 26
  let rtu-xs = (12, 102)
  let rtu-ys = (80, 138)
  let n = 0
  for j in range(2) {
    for i in range(2) {
      n += 1
      pill(rtu-xs.at(i), rtu-ys.at(j), rtu-w, rtu-h,
        "RTU slave #" + str(n), r: 7, fill: c-rtu, edge: c-rtu, color: white)
    }
  }

  pill(206, 99, 48, 34, ("RS485", "Transceiver/", "UART"), r: 9,
    fill: rgb("#F2F7FC"), edge: rgb("#A9C3DA"), size: 7pt, weight: "regular")

  panel(262, 34, 180, 166, c-mcu, [STM32F746 MCU \ (FreeRTOS)], title-dy: 18)

  // 三个任务框自上而下竖排，相邻任务用竖直双向箭头连接
  let task-x = 288
  let task-w = 128
  let task-h = 22
  let tasks = (
    (label: "Modbus poller task", y: 84),
    (label: "Mapping engine task", y: 124),
    (label: "DDS-XRCE Client task", y: 164),
  )
  for (k, t) in tasks.enumerate() {
    task(task-x, t.y, task-w, task-h, t.label)
    if k > 0 {
      let prev = tasks.at(k - 1)
      darrow((task-x + task-w / 2, prev.y + task-h), (task-x + task-w / 2, t.y))
    }
  }

  pill(448, 100, 44, 28, [Ethernet], r: 8,
    fill: rgb("#F2F7FC"), edge: rgb("#A9C3DA"), size: 8pt)

  let xrce-x = 526
  let xrce-w = 124
  let xrce-y = 6
  let xrce-h = 58
  softbox(xrce-x, xrce-y, xrce-w, xrce-h, 9, c-xrce, rgb("#A6C4DD"))
  // 标题 10pt + 两行 8pt 说明文字
  content(P(xrce-x + xrce-w / 2, xrce-y + xrce-h / 2 - 1), anchor: "center", {
    set align(center)
    set par(leading: 0.5em)
    text(size: 10pt, weight: "bold", fill: c-navy)[XRCE Agent]
    linebreak()
    text(size: 8pt, weight: "bold", fill: c-ink)[Session mgmt, stream ids,]
    linebreak()
    text(size: 8pt, weight: "bold", fill: c-ink)[reliability]
  })

  panel(506, 114, 164, 116, c-dds, [DDS Domain], title-dy: 13)
  pill(520, 140, 136, 34, [Topics], r: 12, fill: c-green, edge: c-gedge)
  pill(520, 190, 136, 34, [Subscribers/Applications], r: 12, fill: c-green, edge: c-gedge)

  // 7.1 Modbus 面板 ↔ RS485 收发器（水平双向）
  darrow((190, 116), (208, 116))
  // 7.2 RS485 收发器 ↔ Modbus poller task（斜向双向）
  darrow((254, 116), (288, 95))
  // 7.3 Modbus poller task → Ethernet（斜向下）
  sarrow((416, 95), (448, 110))
  // 7.4 DDS-XRCE Client task → Ethernet（斜向上）
  sarrow((416, 175), (458, 128))
  // 7.5 Ethernet → XRCE Agent（斜向上）
  sarrow((476, 100), (534, 64))
  // 7.6 Ethernet → DDS Domain（斜向下）
  sarrow((492, 121), (506, 132))
  // 7.7 XRCE Agent ↔ DDS Domain（竖直双向）
  darrow((588, 64), (588, 114))
})
