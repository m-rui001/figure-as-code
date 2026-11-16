#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：End-to-end data path from Modbus devices to the DDS domain（Modbus 到 DDS 数据通路）
// 来源：Technologies 2025, 13, 526, Figure 2；DOI 10.3390/technologies1300526
// 结构：左侧 Modbus devices 面板内四个 RTU 从站，经 RS485 收发器进入 STM32F746（FreeRTOS）网关；
// 网关内 Modbus poller → Mapping engine → DDS-XRCE Client 三任务串联，再经 Ethernet 接到 XRCE Agent，
// Agent 向下进入 DDS Domain（Topics → Subscribers/Applications）。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.45)
  let ar2 = (start: "stealth", end: "stealth", fill: black, scale: 0.45)
  let edge = 0.7pt + rgb("#8a96b8")
  let pill(x0, y0, x1, y1, t, f, s: 8pt) = {
    draw.rect((x0, y0), (x1, y1), radius: 0.24, fill: f, stroke: none)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: s, weight: "bold", fill: white)[#t])
  }

  // Modbus 设备面板与四个 RTU 从站
  draw.rect((0.25, 1.15), (6.35, 5.65), fill: rgb("#ccd6ea"), stroke: none)
  content((3.30, 5.32), text(size: 9pt, weight: "bold", fill: rgb("#2f3f66"))[Modbus devices])
  let rtu = rgb("#3f5f9e")
  pill(0.80, 3.90, 3.00, 4.65, [RTU slave #1], rtu)
  pill(3.70, 3.90, 5.90, 4.65, [RTU slave #2], rtu)
  pill(0.80, 2.00, 3.00, 2.75, [RTU slave #3], rtu)
  pill(3.70, 2.00, 5.90, 2.75, [RTU slave #4], rtu)

  // RS485 收发器小盒
  draw.rect((6.85, 2.88), (8.15, 3.88), radius: 0.12, fill: white, stroke: edge)
  content((7.50, 3.60), text(size: 6pt)[RS485])
  content((7.50, 3.37), text(size: 6pt)[Transceiver])
  content((7.50, 3.14), text(size: 6pt)[/UART])

  // STM32 网关面板与三个任务药丸
  draw.rect((8.15, 0.95), (13.85, 6.25), fill: rgb("#d9d9d9"), stroke: none)
  content((11.00, 5.85), text(size: 9pt, weight: "bold", fill: rgb("#2f3f66"))[STM32F746 MCU])
  content((11.00, 5.53), text(size: 9pt, weight: "bold", fill: rgb("#2f3f66"))[(FreeRTOS)])
  let task = rgb("#f2f7fd")
  draw.rect((9.30, 3.90), (12.70, 4.65), radius: 0.30, fill: task, stroke: edge)
  content((11.00, 4.275), text(size: 8.5pt, weight: "bold")[Modbus poller task])
  draw.rect((9.30, 2.45), (12.70, 3.20), radius: 0.30, fill: task, stroke: edge)
  content((11.00, 2.825), text(size: 8.5pt, weight: "bold")[Mapping engine task])
  draw.rect((9.30, 1.00), (12.70, 1.75), radius: 0.30, fill: task, stroke: edge)
  content((11.00, 1.375), text(size: 8.5pt, weight: "bold")[DDS-XRCE Client task])

  // Ethernet 小盒
  draw.rect((14.45, 3.20), (15.35, 4.10), radius: 0.12, fill: white, stroke: edge)
  content((14.90, 3.65), text(size: 6.5pt)[Ethernet])

  // XRCE Agent 与 DDS Domain 面板
  draw.rect((16.90, 5.10), (21.00, 6.90), radius: 0.25, fill: rgb("#dcebf9"), stroke: rgb("#b7c9e2"))
  content((18.95, 6.42), text(size: 9pt, weight: "bold", fill: rgb("#1f3864"))[XRCE Agent])
  content((18.95, 6.02), text(size: 7.5pt, fill: rgb("#1f3864"))[Session mgmt, stream ids,])
  content((18.95, 5.72), text(size: 7.5pt, fill: rgb("#1f3864"))[reliability])
  draw.rect((16.90, 0.05), (21.00, 3.45), fill: rgb("#e9e9f6"), stroke: rgb("#c9c9dd"))
  content((18.95, 3.05), text(size: 9pt, weight: "bold", fill: rgb("#1f3864"))[DDS Domain])
  draw.rect((17.65, 1.75), (20.25, 2.45), radius: 0.22, fill: rgb("#d4eaa2"), stroke: rgb("#9dbb63"))
  content((18.95, 2.10), text(size: 8pt, weight: "bold")[Topics])
  draw.rect((17.00, 0.35), (20.90, 1.15), radius: 0.22, fill: rgb("#d4eaa2"), stroke: rgb("#9dbb63"))
  content((18.95, 0.75), text(size: 7.5pt, weight: "bold")[Subscribers/Applications])

  // 连接：面板与 RS485 双向，收发器斜向进 poller
  draw.line((6.35, 3.37), (6.85, 3.37), stroke: 0.8pt + black, mark: ar2)
  draw.line((8.15, 3.72), (9.30, 4.18), stroke: 0.8pt + black, mark: ar)
  // 任务链
  draw.line((11.00, 3.90), (11.00, 3.20), stroke: 0.8pt + black, mark: ar)
  draw.line((11.00, 2.45), (11.00, 1.75), stroke: 0.8pt + black, mark: ar)
  // 客户端任务与 Ethernet 的双向斜线
  draw.line((12.72, 1.62), (14.48, 3.42), stroke: 0.8pt + black, mark: ar)
  draw.line((14.55, 3.35), (12.80, 1.52), stroke: 0.8pt + black, mark: ar)
  // Ethernet 与 Agent 的双向斜线
  draw.line((15.30, 4.02), (16.90, 5.25), stroke: 0.8pt + black, mark: ar)
  draw.line((16.90, 5.55), (15.22, 4.18), stroke: 0.8pt + black, mark: ar)
  // Agent 与 DDS Domain 双向
  draw.line((18.95, 5.10), (18.95, 3.45), stroke: 0.8pt + black, mark: ar2)
})
