#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：The implementation workflow of the TT strategy（TT 策略实现流程）
// 来源：Future Internet 2026, 18, 297, Figure 5；DOI 10.3390/fi18060297
// 结构：五条泳道——Initialization、Processing TSQ、Processing PQ、Blocking、RTPSWriter；
// 流程控制器线程在初始化里取触发时刻并算关闭时刻，再按 t_close 与 t_now 比较分流到 TSQ 或 PQ；
// PQ 空则进 Blocking 设超时，否则发消息/分片；RTPSWriter 入队并唤醒控制器。各分支回环到判定处。

#canvas({
  import draw: *
  let ar = (end: "stealth", fill: black, scale: 0.42)
  let st = 0.8pt + black
  let band(x0, x1, c) = draw.rect((x0, 0.33), (x1, 9.73), fill: c, stroke: none)
  band(0.42, 4.95, rgb("#e6e6e6"))
  band(4.95, 9.35, rgb("#b9e6d3"))
  band(9.35, 13.75, rgb("#c9dcf2"))
  band(13.75, 18.00, rgb("#fbe5c0"))
  band(18.00, 21.50, rgb("#f8cccc"))
  let heads = (
    (2.685, [Initialization]), (7.15, [Processing TSQ]), (11.55, [Processing PQ]),
    (15.875, [Blocking]), (19.75, [RTPSWriter]),
  )
  for (x, t) in heads {
    content((x, 9.42), text(size: 9pt, weight: "bold")[#t])
  }
  let nd(x0, y0, x1, y1, t, s: 8pt) = {
    draw.rect((x0, y0), (x1, y1), fill: white, stroke: st)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: s)[#t])
  }
  let rnd(x0, y0, x1, y1, t) = {
    draw.rect((x0, y0), (x1, y1), radius: (y1 - y0) / 2, fill: white, stroke: st)
    content(((x0 + x1) / 2, (y0 + y1) / 2), text(size: 8pt)[#t])
  }
  let dec(cx, cy, hw, hh, t, s: 8pt) = {
    draw.line((cx - hw, cy), (cx, cy + hh), (cx + hw, cy), (cx, cy - hh), close: true,
      fill: white, stroke: st)
    content((cx, cy), text(size: s)[#t])
  }
  let poly(pts, m: ar) = draw.line(..pts, stroke: st, mark: m)
  let lab(x, y, t) = content((x, y), text(size: 8pt)[#t])

  // 节点
  rnd(0.68, 8.28, 4.66, 8.83, [Start flow controller thread])
  nd(0.63, 7.16, 4.74, 7.73, [Open Gates of TSQ and PQ])
  nd(0.63, 5.14, 4.74, 6.48, [Retrieve the next trigger \ time from timed-event table \ $t_("trig")$])
  nd(0.63, 4.40, 4.74, 5.14, [Compute closing time of PQ \ $t_("close") = t_("trig") - t_("gdb")$], s: 7.5pt)
  dec(2.685, 2.43, 1.40, 0.55, [$t_("close") > t_("now")$])
  nd(5.20, 8.20, 9.14, 8.75, [Close PQ gate])
  nd(5.20, 7.05, 9.14, 7.60, [Block thread until $t_("trig")$])
  dec(7.17, 6.03, 1.70, 0.55, [$t_("now") = t_("trig")$])
  nd(5.20, 3.57, 9.14, 4.50, [Publish the DDS message \ bound to the timed event])
  nd(5.20, 2.02, 9.14, 2.94, [Reset timed event \ and open PQ gate])
  dec(11.55, 8.48, 1.50, 0.52, [Is PQ empty])
  nd(9.75, 6.58, 13.15, 7.38, [Publish the first \ message/fragment in PQ])
  dec(11.55, 4.56, 1.60, 0.62, [All fragments \ published])
  nd(10.07, 2.04, 13.19, 2.92, [Remove the first \ message from PQ])
  nd(14.50, 8.21, 17.20, 8.85, [Set timeout timer])
  nd(14.54, 6.08, 17.16, 7.01, [Block the thread])
  dec(15.85, 4.58, 1.48, 0.60, [Timeout or \ Wake-Up])
  rnd(18.80, 8.30, 20.60, 8.85, [Start])
  nd(18.27, 6.35, 21.28, 7.52, [Enqueue message \ Information into PQ])
  nd(18.49, 4.66, 21.05, 5.68, [Wake up flow \ controller thread])
  rnd(19.15, 3.88, 20.30, 4.43, [End])

  // 竖向与横向连线
  poly(((2.685, 8.28), (2.685, 7.73)))
  poly(((2.685, 7.16), (2.685, 6.48)))
  poly(((2.685, 4.59), (2.685, 2.98)))
  poly(((2.685, 1.88), (2.685, 1.25), (9.60, 1.25), (9.60, 8.48), (10.05, 8.48)))
  poly(((4.085, 2.43), (5.05, 2.43), (5.05, 8.475), (5.20, 8.475)))
  poly(((7.17, 8.20), (7.17, 7.60)))
  poly(((7.17, 7.05), (7.17, 6.58)))
  poly(((8.87, 6.03), (9.21, 6.03), (9.21, 7.325), (9.14, 7.325)))
  poly(((7.17, 5.48), (7.17, 4.50)))
  poly(((7.17, 3.57), (7.17, 2.94)))
  poly(((7.17, 2.02), (7.17, 0.63), (0.43, 0.63), (0.43, 5.81), (0.63, 5.81)))
  poly(((11.55, 7.96), (11.55, 7.38)))
  poly(((13.05, 8.48), (14.50, 8.48)))
  poly(((11.55, 6.58), (11.55, 5.13)))
  poly(((11.55, 3.99), (11.55, 2.92)))
  poly(((13.05, 4.56), (13.76, 4.56), (13.76, 0.95), (0.72, 0.95), (0.72, 2.43), (1.285, 2.43)))
  poly(((11.55, 2.04), (11.55, 0.95)), m: none)
  poly(((17.33, 4.58), (17.60, 4.58), (17.60, 6.545), (17.16, 6.545)))
  poly(((15.85, 3.98), (15.85, 0.95)))
  poly(((15.85, 8.21), (15.85, 7.01)))
  poly(((15.85, 6.08), (15.85, 5.18)))
  poly(((19.75, 8.30), (19.75, 7.52)))
  poly(((19.75, 6.35), (19.75, 5.68)))
  poly(((19.75, 4.66), (19.75, 4.43)))

  // 分支标签
  lab(4.30, 2.62, [No])
  lab(3.12, 1.70, [Yes])
  lab(9.32, 6.24, [No])
  lab(7.55, 5.28, [Yes])
  lab(13.40, 8.66, [Yes])
  lab(13.32, 4.80, [No])
  lab(11.85, 3.80, [Yes])
  lab(17.48, 4.80, [No])
  lab(16.25, 3.80, [Yes])
})
