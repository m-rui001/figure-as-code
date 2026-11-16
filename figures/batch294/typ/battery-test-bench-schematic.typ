#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图 4  锂电池测试台实验系统接线示意图
// 来源：Energies 2025, 18, 2304, Figure 4，DOI: 10.3390/en18092304
// 组成：HMI/数据记录/工控机 + SDAYC 控制器 + 锂电池测量回路 + Sorensen/BK 电源测量仪
//       经无线路由器（Ethernet）与 NI USB-6281（USB/热电偶）构成完整充放电测试台。
#canvas({
  import draw: *
  let Hpx = 947                       // 参考图高度（像素），用于翻转 y 轴
  let P(x, y) = (x / 100, (Hpx - y) / 100)   // 像素坐标 -> 画布坐标（y 向上）
  let ink = black
  let sw = 0.8pt                      // 导线 / 内部细线
  let bw = 0.9pt                      // 设备外框
  let ar  = (end: "stealth", fill: ink, scale: 0.55)              // 单向（末端）
  let aru = (start: "stealth", fill: ink, scale: 0.55)            // 单向（起点，向上）
  let bar = (start: "stealth", end: "stealth", fill: ink, scale: 0.55) // 双向
  let dar = (end: "stealth", fill: ink, scale: 0.50)              // 虚线控制箭头
  let node(p) = circle(p, radius: 0.06, fill: ink, stroke: none)
  let seg(pts, mark: none, stroke: sw) = {
    line(..pts.map(p => P(p.at(0), p.at(1))), stroke: stroke, mark: mark)
  }
  let device(xp, yp, wp, hp, body) = {
    rect(P(xp - wp / 2, yp + hp / 2), P(xp + wp / 2, yp - hp / 2),
      fill: white, stroke: bw)
    content(P(xp, yp), body, anchor: "center")
  }
  let sensor_strip(xp, yp, wp, hp, body) = {
    rect(P(xp - wp / 2, yp + hp / 2), P(xp + wp / 2, yp - hp / 2),
      fill: white, stroke: sw)
    content(P(xp, yp), body, anchor: "center")
  }
  // 机械开关：上下两个空心触点 + 斜刀片（不含引线）
  let switch(xp, yup, ylo) = {
    circle(P(xp, yup), radius: 0.06, fill: white, stroke: sw)
    circle(P(xp, ylo), radius: 0.06, fill: white, stroke: sw)
    seg(((xp - 24, ylo - 4), (xp - 3, yup + 4)), stroke: 1.1pt)
  }
  // 圆柱数据库：顶面椭圆 + 两条侧线 + 底部前半椭圆 + 下方标签
  let cyl(xp, ytop, w, hs, label) = {
    let rx = w / 2
    let ry = w * 0.11
    circle(P(xp, ytop), radius: (rx / 100, ry / 100), fill: white, stroke: sw)
    seg(((xp - rx, ytop), (xp - rx, ytop + hs)), stroke: sw)
    seg(((xp + rx, ytop), (xp + rx, ytop + hs)), stroke: sw)
    let pts = ()
    for i in range(17) {
      let a = 180deg + 180deg * i / 16
      pts.push(P(xp + rx * calc.cos(a), ytop + hs - ry * calc.sin(a)))
    }
    line(..pts, stroke: sw)
    content(P(xp, ytop + hs + ry + 22), label, anchor: "center")
  }
  // 三次贝塞尔折线采样（输入像素坐标），供虚线弧形箭头使用
  let bezier-pts(p0, p1, p2, p3, n: 22) = {
    let pts = ()
    for i in range(n + 1) {
      let t = i / n
      let u = 1 - t
      let x = u*u*u*p0.at(0) + 3*u*u*t*p1.at(0) + 3*u*t*t*p2.at(0) + t*t*t*p3.at(0)
      let y = u*u*u*p0.at(1) + 3*u*u*t*p1.at(1) + 3*u*t*t*p2.at(1) + t*t*t*p3.at(1)
      pts.push(P(x, y))
    }
    pts
  }
  // 虚线弧形箭头（控制点采样），dash + 显式 fill 保持箭头实心
  let dashed_arc(p0, p1, p2, p3) = {
    line(..bezier-pts(p0, p1, p2, p3),
      stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"),
      fill: none, mark: dar)
  }
  let router(xp, yp, wp, hp) = {
    rect(P(xp, yp + hp / 2), P(xp + wp, yp - hp / 2),
      radius: 0.06, fill: white, stroke: bw)
    for dx in (26, 56, 84) {
      circle(P(xp + dx, yp), radius: 0.04, fill: white, stroke: sw)
    }
    seg(((xp + 18, yp - hp / 2), (xp + 18, yp - hp / 2 - 28)), stroke: sw)
    circle(P(xp + 18, yp - hp / 2 - 30), radius: 0.04, fill: white, stroke: sw)
    seg(((xp + 34, yp - hp / 2), (xp + 34, yp - hp / 2 - 14)), stroke: sw)
    for r in (9, 16, 23) {
      let pts = ()
      for i in range(9) {
        let a = 15deg + 60deg * i / 8
        pts.push(P(xp + wp - 30 + r * calc.cos(a), yp - hp / 2 - r * calc.sin(a)))
      }
      line(..pts, stroke: sw)
    }
  }
  seg(((124, 489), (124, 549)), mark: ar)
  seg(((245, 369), (245, 114), (444, 114)), mark: ar)
  seg(((570, 114), (690, 114)), mark: bar)
  seg(((278, 430), (436, 430)), mark: bar)
  // SDAYC 与 电池回路左节点 双向箭头
  seg(((558, 430), (672, 430)), mark: bar)
  let bus-l = 678
  let bus-r = 1000
  let node-y = 430
  let bat-l = 724
  let bat-r = 960
  let y-top-l = 290
  let y-top-r = 200
  let y-bot-l = 653
  let y-bot-r = 660
  seg(((bus-l, y-top-l), (bus-l, y-bot-l)), stroke: sw)  // 左母线
  seg(((bus-r, y-top-r), (bus-r, y-bot-r)), stroke: sw)  // 右母线
  node(P(bus-l, node-y))
  node(P(bus-r, node-y))
  seg(((bus-l, node-y), (bat-l, node-y)), stroke: sw)    // 左节点 -> 电池
  seg(((bat-r, node-y), (bus-r, node-y)), stroke: sw)    // 电池 -> 右节点
  seg(((772, 172), (772, 203)), stroke: sw)
  seg(((772, 257), (772, y-top-l)), stroke: sw)
  seg(((bus-l, y-top-l), (772, y-top-l)), stroke: sw)
  seg(((bus-r, y-top-r), (960, y-top-r), (960, 172)), stroke: sw)
  seg(((bus-l, y-bot-l), (770, y-bot-l)), stroke: sw)
  seg(((776, 700), (776, 715)), stroke: sw)
  seg(((bus-r, y-bot-r), (888, y-bot-r), (888, 715)), stroke: sw)
  // 两个机械开关（两个小圆 + 斜刀片）
  switch(772, 209, 250)   // Sorensen 下方
  switch(776, 653, 694)   // BK 上方
  dashed_arc((497, 403), (540, 340), (640, 240), (745, 238))
  dashed_arc((497, 457), (470, 580), (560, 720), (766, 692))
  dashed_arc((944, 500), (985, 510), (1010, 545), (1041, 540))
  seg(((265, 490), (265, 786), (714, 786)), mark: aru)
  seg(((233, 490), (233, 881), (1140, 881), (1140, 563)), mark: aru)
  rect(P(50, 452), P(198, 368), fill: white, stroke: bw)
  rect(P(61, 442), P(187, 378), fill: white, stroke: sw)
  seg(((112, 452), (112, 474)), stroke: sw)
  seg(((137, 452), (137, 474)), stroke: sw)
  rect(P(84, 489), P(164, 474), fill: white, stroke: sw)
  content(P(124, 410), text(size: 9pt, weight: "bold")[HMI], anchor: "center")
  cyl(123, 565, 134, 60, text(size: 8.5pt)[Data register])
  rect(P(218, 490), P(278, 369), fill: white, stroke: bw)
  rect(P(227, 399), P(273, 389), fill: white, stroke: sw)
  rect(P(227, 416), P(273, 406), fill: white, stroke: sw)
  device(497, 430, 122, 54, text(size: 9pt, weight: "bold")[SDAYC])
  rect(P(bat-l, 462), P(bat-r, 398), radius: 0.08, fill: white, stroke: bw)
  content(P(842, node-y), text(size: 7.5pt, weight: "bold")[Lithium battery], anchor: "center")
  rect(P(808, 483), P(870, 465), fill: white, stroke: sw)
  content(P(839, 498), text(size: 7.5pt)[Thermocouple K], anchor: "center")
  rect(P(690, 172), P(990, 22), fill: white, stroke: bw)
  content(P(840, 55), text(size: 7.5pt, weight: "bold")[Sorensen DLM 20-30], anchor: "center")
  sensor_strip(835, 97, 233, 38, text(size: 8pt)[Voltage sensor])
  sensor_strip(835, 134, 233, 37, text(size: 8pt)[Current sensor])
  rect(P(714, 840), P(974, 715), fill: white, stroke: bw)
  content(P(844, 745), text(size: 7.5pt, weight: "bold")[BK Precision 8614], anchor: "center")
  sensor_strip(844, 800, 236, 41, text(size: 8pt)[Current sensor])
  device(1137, 534.5, 180, 57, text(size: 7.5pt, weight: "bold")[NI USB-6281])
  router(444, 112.5, 126, 37)
  content(P(351, 87), text(size: 8.5pt)[Ethernet], anchor: "center")
  content(P(630, 150), text(size: 8.5pt)[Ethernet], anchor: "center")
  content(P(640, 756), text(size: 8pt)[USB], anchor: "center")
  content(P(640, 850), text(size: 8pt)[USB], anchor: "center")
})
