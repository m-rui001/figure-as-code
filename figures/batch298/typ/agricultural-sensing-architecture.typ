#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：农业传感与本地处理—通信—地面站系统架构图（Figure 1）
// 来源：Agronomy 2026, 16, 1139, Fig. 1；DOI: 10.3390/agronomy16121139
// 数据通路：五路传感器汇入本地处理单元，旁路 CSV 日志库，再送入通信层
// 上行通路：COMMUNICATION LAYER 经 MAVLink 到 QGROUNDCONTROL，经网络到 REMOTE SUPERVISION & STORAGE
// 控制回路：QGROUNDCONTROL 回折至 OPERATOR INTERVENTION，TERMINAL CONTROL 回写 LOCAL PROCESSING UNIT
#let P(x, y) = (x - 500, 285 - y)
#let PANEL = rgb("#e7f1fb")
#let BOX = rgb("#dcebf9")
#let EDGE = rgb("#2a4a6b")
#let INK = rgb("#12263f")
#let BLUE = rgb("#4a86c5")
#let YEL = rgb("#e0b20a")
#let MAP = rgb("#edf3e6")
#let GRID = rgb("#b9c9b2")
#let ST = (paint: EDGE, thickness: 1.05)
#canvas(length: 1pt, {
  let p = P
  let seg(pts, w, col: EDGE) = draw.line(..pts.map(q => p(q.at(0), q.at(1))),
    stroke: (paint: col, thickness: w))
  let arr(pts, w) = draw.line(..pts.map(q => p(q.at(0), q.at(1))),
    stroke: (paint: EDGE, thickness: w),
    mark: (end: (symbol: "stealth", fill: EDGE, stroke: EDGE)))
  let lab(x, y, body, size: 9pt, anchor: "center", bold: false, angle: 0deg) = {
    draw.content(p(x, y),
      text(fill: INK, size: size, weight: if bold { "bold" } else { "regular" })[#body],
      anchor: anchor, angle: angle)
  }
  let panel(x1, y1, x2, y2) = draw.rect(p(x1, y1), p(x2, y2), radius: 10, fill: PANEL, stroke: ST)
  let box(x1, y1, x2, y2) = draw.rect(p(x1, y1), p(x2, y2), radius: 7, fill: BOX, stroke: ST)
  let sensor(n, cx, cy) = {
    if n == 0 {
      draw.rect(p(cx - 11, cy - 9), p(cx + 11, cy + 8), radius: 2, fill: rgb("#d7dde3"), stroke: ST)
      draw.circle(p(cx + 5, cy - 3), radius: 2.2, fill: EDGE, stroke: none)
      seg(((cx - 7, cy + 4), (cx - 3, cy + 4)), 0.8)
      seg(((cx - 7, cy + 6), (cx - 3, cy + 6)), 0.8)
      for dx in (-7, -2, 3) { seg(((cx + dx, cy + 8), (cx + dx, cy + 12)), 0.8) }
    } else if n == 1 {
      draw.rect(p(cx - 11, cy - 8), p(cx + 11, cy + 8), radius: 2, fill: BLUE, stroke: ST)
      draw.rect(p(cx - 5, cy - 4), p(cx + 5, cy + 4), radius: 1, fill: rgb("#33414d"), stroke: none)
      draw.circle(p(cx - 8, cy - 5), radius: 1.6, fill: YEL, stroke: none)
      draw.circle(p(cx + 8, cy + 5), radius: 1.6, fill: YEL, stroke: none)
    } else if n == 2 {
      draw.circle(p(cx, cy), radius: 11, fill: rgb("#cfd5da"), stroke: ST)
      draw.circle(p(cx, cy), radius: 7, fill: rgb("#8fb6db"), stroke: ST)
      draw.circle(p(cx, cy), radius: 2.8, fill: EDGE, stroke: none)
    } else if n == 3 {
      draw.rect(p(cx - 13, cy - 8), p(cx + 13, cy + 8), radius: 3, fill: rgb("#cdd3d9"), stroke: ST)
      draw.rect(p(cx - 5, cy - 12), p(cx + 5, cy - 8), radius: 1, fill: rgb("#b7c0c8"), stroke: ST)
      draw.circle(p(cx - 2, cy), radius: 6, fill: BLUE, stroke: ST)
      draw.circle(p(cx - 2, cy), radius: 3, fill: rgb("#254f78"), stroke: none)
      draw.circle(p(cx + 9, cy - 4), radius: 1.6, fill: EDGE, stroke: none)
    } else {
      draw.circle(p(cx, cy + 8), radius: (13, 4), fill: rgb("#c6cdd4"), stroke: ST)
      draw.rect(p(cx - 13, cy - 6), p(cx + 13, cy + 8), fill: rgb("#d8dfe5"), stroke: ST)
      draw.rect(p(cx - 13, cy - 2), p(cx + 13, cy + 2), fill: BLUE, stroke: none)
      draw.circle(p(cx, cy - 6), radius: (13, 4), fill: rgb("#c6cdd4"), stroke: ST)
    }
  }
  // 左侧采集面板与竖排标题
  lab(96, 26, [DATA \ ACQUISITION], size: 11pt, bold: true)
  panel(18, 78, 168, 558)
  draw.rect(p(18, 86), p(52, 550), fill: rgb("#dceaf8"), stroke: none)
  seg(((52, 84), (52, 552)), 0.9)
  lab(35, 320, [DATA ACQUISITION], size: 10pt, bold: true, angle: 90deg)
  let sy = (138, 222, 306, 390, 474)
  let sname = ("BME280", "BH1750", "MLX90614", "RGB Camera", "LiDAR")
  for i in range(5) {
    sensor(i, 105, sy.at(i))
    lab(105, sy.at(i) + 23, sname.at(i), size: 8pt)
  }
  // 五路信号线：上两路下行、下三路上行，车道错开避免交叉
  let lane = (212, 205, 188, 197, 206)
  let entry = (225, 252, 280, 308, 336)
  for i in range(5) {
    let y0 = sy.at(i)
    arr(((120, y0), (lane.at(i), y0), (lane.at(i), entry.at(i)), (232, entry.at(i))), 0.9)
  }
  // 本地处理单元与本地日志库
  box(232, 200, 410, 350)
  lab(321, 250, [LOCAL \ PROCESSING \ UNIT], size: 10.5pt, bold: true)
  lab(321, 306, [(Python Routines)], size: 8.5pt)
  draw.circle(p(300, 112), radius: (22, 6), fill: BLUE.lighten(30%), stroke: ST)
  draw.rect(p(278, 112), p(322, 148), fill: BLUE.lighten(22%), stroke: ST)
  draw.circle(p(300, 148), radius: (22, 6), fill: BLUE.lighten(22%), stroke: ST)
  draw.circle(p(300, 112), radius: (22, 6), fill: BLUE.lighten(38%), stroke: ST)
  arr(((300, 152), (300, 197)), 1.2)
  lab(338, 122, [LOCAL LOGGING \ (CSV Format)], size: 8.5pt, anchor: "west")
  // 通信层
  box(445, 185, 630, 320)
  lab(537, 250, [COMMUNICATION \ LAYER], size: 10.5pt, bold: true)
  arr(((410, 262), (445, 262)), 1.3)
  // 网络可达 -> 云端 -> 远程监管与存储
  arr(((560, 185), (560, 140), (769, 115)), 1.3)
  lab(650, 106, [NETWORK ACCESS \ AVAILABLE], size: 8.5pt, bold: true)
  let cloud = ((770, 116), (766, 107), (769, 97), (778, 91), (786, 93), (790, 79),
    (801, 73), (812, 76), (820, 84), (830, 82), (840, 89), (843, 99), (839, 109), (830, 116))
  draw.line(..cloud.map(q => p(q.at(0), q.at(1))), close: true,
    fill: rgb("#dbeafa"), stroke: ST)
  lab(856, 82, [REMOTE \ SUPERVISION \ & STORAGE], size: 9pt, bold: true, anchor: "west")
  // MAVLink 链路与 QGroundControl 面板
  arr(((630, 252), (710, 252)), 1.4)
  lab(670, 234, [MAVLink \ Telemetry], size: 8pt)
  panel(710, 165, 982, 470)
  draw.rect(p(724, 182), p(968, 408), radius: 3, fill: MAP, stroke: (paint: EDGE, thickness: 0.7))
  for gx in (766, 808, 850, 892, 934) {
    seg(((gx, 182), (gx, 408)), 0.6, col: GRID)
  }
  for gy in (238, 294, 350) {
    seg(((724, gy), (968, gy)), 0.6, col: GRID)
  }
  let wp = ((752, 386), (806, 370), (864, 336), (918, 286), (946, 226), (872, 208), (790, 232))
  draw.line(..wp.map(q => p(q.at(0), q.at(1))), close: true,
    stroke: (paint: YEL, thickness: 2))
  for w in wp {
    draw.circle(p(w.at(0), w.at(1)), radius: 4, fill: BLUE, stroke: (paint: INK, thickness: 0.6))
  }
  draw.circle(p(860, 300), radius: 5, fill: EDGE, stroke: none)
  lab(846, 432, [QGROUNDCONTROL], size: 10pt, bold: true)
  lab(846, 450, [(Map-based Supervision)], size: 8.5pt)
  // 操作员干预与两条终端控制回写箭头
  box(445, 395, 640, 475)
  lab(542, 423, [OPERATOR \ INTERVENTION], size: 10pt, bold: true)
  arr(((772, 470), (772, 486), (660, 486), (660, 440), (642, 440)), 1.3)
  arr(((474, 395), (474, 364), (272, 364), (272, 352)), 1.2)
  arr(((566, 395), (566, 376), (342, 376), (342, 352)), 1.2)
  lab(400, 388, [TERMINAL CONTROL], size: 8pt, bold: true)
  // 联合会话人形图标，箭头指向操作员干预
  draw.rect(p(746, 500), p(798, 540), radius: 6, fill: PANEL, stroke: ST)
  for (dx, r) in ((-10, 4.5), (0, 5), (10, 4.5)) {
    draw.circle(p(772 + dx, 510), radius: r, fill: BLUE, stroke: none)
    draw.rect(p(772 + dx - 4, 516), p(772 + dx + 4, 532), radius: 3, fill: BLUE, stroke: none)
  }
  lab(808, 508, [COMBINED SESSION], size: 9pt, bold: true, anchor: "west")
  lab(808, 524, [(Automated Routines + Human Control)], size: 8pt, anchor: "west")
  arr(((746, 520), (700, 520), (700, 542), (560, 542), (560, 475)), 1.3)
})
