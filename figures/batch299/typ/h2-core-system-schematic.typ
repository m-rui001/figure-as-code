#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图 1(a)：氢能综合测试台的物质流与能量流示意图。
// 来源：Energies 2025, 18, 6318, Figure 1(a)，DOI: 10.3390/en18236318。
// 虚线框内自上而下为燃料电池、储能电池、碱性电解槽与水槽、氢气干燥器。
// 绿色表示氢气回路，青色表示水，蓝色表示电能，红色表示市电输入与余热。
// 各徽标与云朵、液滴、气瓶均用几何图元绘制，标签置于色块内或箭头旁。

#canvas(length: 1.2cm, {
  import draw: *

  // 源图像素 -> 画布坐标：除以 100 并翻转 y（原点在左上角）
  let p(x, y) = (x / 100, -y / 100)
  let C = (
    frame: rgb("#e2622a"), green: rgb("#2fa14b"), pale: rgb("#7fc96a"),
    cyan: rgb("#25b3c6"), blue: rgb("#2f6fd0"), red: rgb("#e0342b"),
    plum: rgb("#5b3fa8"), ink: rgb("#333333"),
  )

  // 色块：左上角 (x,y)，宽 w、高 h，标签居中
  let block(x, y, w, h, fill, label) = {
    rect(p(x, y), p(x + w, y + h), fill: fill,
      stroke: (paint: C.ink, thickness: 1pt))
    content(p(x + w / 2, y + h / 2), label, anchor: "center")
  }

  // 实心 stealth 箭头；label 默认置于箭头中点上方
  let flow(a, b, color, label) = {
    line(p(..a), p(..b), stroke: (paint: color, thickness: 2.4pt),
      mark: (end: "stealth", fill: color))
    if label != none {
      content(p((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2 - 14),
        label, anchor: "south")
    }
  }

  // 圆形徽标：中心 c、文字 label、填充 color、半径 r（源像素）
  let bubble(c, label, color, r: 55) = {
    circle(p(..c), radius: r / 100, fill: color, stroke: none)
    if label != none { content(p(..c), label, anchor: "center") }
  }

  // 水滴：球心 (cx,cy)、半径 r，尖顶朝上
  let drop(cx, cy, r, fill) = {
    circle(p(cx, cy), radius: r / 100, fill: fill, stroke: none)
    line(p(cx, cy - 1.45 * r), p(cx - 0.62 * r, cy - 0.55 * r),
      p(cx + 0.62 * r, cy - 0.55 * r), close: true, fill: fill, stroke: none)
  }

  // 闪电符号：中心 (cx,cy)，尺寸 s（源像素）
  let bolt(cx, cy, s, col) = line(
    p(cx + 0.15 * s, cy - s), p(cx - 0.45 * s, cy + 0.12 * s),
    p(cx - 0.05 * s, cy + 0.12 * s), p(cx - 0.15 * s, cy + s),
    p(cx + 0.50 * s, cy - 0.12 * s), p(cx + 0.05 * s, cy - 0.12 * s),
    close: true, fill: col, stroke: none)

  // H2 储罐组：三只圆角瓶 + 中央 H2 圆标
  let tanks(cx, cy) = {
    for dx in (-72, 0, 72) {
      rect(p(cx + dx - 30, cy - 110), p(cx + dx + 30, cy + 100),
        radius: 0.18, fill: rgb("#efe9fb"),
        stroke: (paint: C.plum, thickness: 1.6pt))
      rect(p(cx + dx - 14, cy - 128), p(cx + dx + 14, cy - 110),
        radius: 0.08, fill: rgb("#efe9fb"),
        stroke: (paint: C.plum, thickness: 1.6pt))
    }
    bubble((cx, cy + 10), text(size: 15pt, weight: "bold", fill: C.plum)[$H_2$], white, r: 55)
    circle(p(cx, cy + 10), radius: 0.55, fill: none,
      stroke: (paint: C.plum, thickness: 1.6pt))
  }

  // “Live” 徽标：红色圆点 + 波纹 + 红色小标签
  let live(x, y) = {
    circle(p(x, y), radius: 0.04, fill: C.red, stroke: none)
    for (dx, dy) in ((7, 5), (13, 10)) {
      line(p(x - dx, y - dy), p(x, y - dy - dx), p(x + dx, y - dy),
        stroke: (paint: C.red, thickness: 1pt))
    }
    rect(p(x - 18, y + 7), p(x + 18, y + 27), radius: 0.05,
      fill: C.red, stroke: none)
    content(p(x, y + 17), text(size: 5.5pt, fill: white, weight: "bold")[Live],
      anchor: "center")
  }

  // 橙色虚线外框 The Integrated Test Rig
  rect(p(445, 182), p(800, 1148),
    stroke: (paint: C.frame, thickness: 1.8pt, dash: "dashed"))
  content(p(350, 92), text(size: 15pt, weight: "bold")[The Integrated Test Rig],
    anchor: "center")

  // 框内四个功能色块
  block(468, 206, 312, 78, rgb("#e9dcc8"),
    text(size: 10pt, weight: "bold")[PEM Fuel Cell])
  block(468, 366, 312, 190, rgb("#f5c844"),
    box(width: 100pt, align(center, text(size: 10pt, weight: "bold")[Battery Energy \ Storage])))
  block(468, 632, 312, 288, rgb("#b6e36a"),
    box(width: 100pt, align(center, text(size: 10pt, weight: "bold")[
      AEM \ Electrolyzer And \ Electrolyte \ Water Tank])))
  block(468, 1004, 312, 128, rgb("#ddd0ee"),
    text(size: 10pt, weight: "bold")[Hydrogen Dryer])

  // 框内：燃料电池向储能电池下行的蓝色箭头
  flow((624, 284), (624, 358), C.blue, none)

  // 顶部氢气排放绿管：自燃料电池上行、右转指向 H2 云朵
  line(p(636, 206), p(636, 44), p(886, 44),
    stroke: (paint: C.green, thickness: 2.6pt),
    mark: (end: "stealth", fill: C.green))
  content(p(716, 52), text(size: 9pt)[$H_2$ Vent], anchor: "north")
  for (cx, cy, r) in ((935, 78, 44), (975, 58, 56), (1018, 74, 42),
                      (955, 96, 42), (1000, 98, 38)) {
    circle(p(cx, cy), radius: r / 100, fill: rgb("#37a9d8"), stroke: none)
  }
  content(p(975, 72), text(size: 14pt, weight: "bold", fill: white)[$H_2$], anchor: "center")

  // 右侧输出：H2O Out / Electrical Power Out / O2 Vent / Heat Output
  flow((780, 246), (1044, 246), C.cyan, none)
  content(p(912, 262), text(size: 9pt)[$H_2 O$ Out], anchor: "north")
  flow((780, 426), (1055, 426), C.blue, none)
  content(p(918, 456), text(size: 9pt)[Electrical Power Out], anchor: "north")
  flow((780, 700), (1053, 700), C.pale, none)
  content(p(916, 684), text(size: 9pt)[$O_2$ Vent], anchor: "south")
  flow((780, 1008), (1057, 1008), C.red, none)
  content(p(930, 980), text(size: 9pt, weight: "bold")[Heat Output], anchor: "south")

  // 右侧图形：H2O 液滴、绿色电池圆标、O2 圆标
  drop(1120, 258, 46, rgb("#2f7fd0"))
  content(p(1120, 262), text(size: 11pt, weight: "bold", fill: white)[$H_2 O$], anchor: "center")
  bubble((1127, 429), none, C.green, r: 70)
  rect(p(1099, 405), p(1152, 453), fill: white, stroke: none)
  rect(p(1094, 417), p(1099, 441), fill: white, stroke: none)
  bolt(1127, 429, 20, rgb("#f5c844"))
  bubble((1115, 724), text(size: 13pt, weight: "bold", fill: white)[$O_2$], rgb("#5fbf5a"), r: 62)
  circle(p(1115, 724), radius: 0.50, fill: none,
    stroke: (paint: white, thickness: 2pt))

  // 左侧输入：H2O In / Electrical Power In
  flow((205, 660), (466, 660), C.cyan, text(size: 9pt)[$H_2 O$ In])
  flow((205, 738), (466, 738), C.red, none)
  content(p(330, 762), text(size: 9pt)[Electrical Power In], anchor: "north")

  // 左侧图形：H2O 液滴、市电警告三角、氢气储罐组
  drop(135, 645, 46, rgb("#2f7fd0"))
  content(p(135, 649), text(size: 10pt, weight: "bold", fill: white)[$H_2 O$], anchor: "center")
  line(p(126, 700), p(58, 832), p(194, 832), close: true,
    fill: rgb("#ffd83d"), stroke: (paint: black, thickness: 2.5pt))
  bolt(126, 775, 46, black)
  tanks(152, 1000)

  // 黑色折线：氢气由储罐组折向 AEM 电解槽（氢气进料）
  line(p(262, 952), p(360, 952), p(360, 884), p(466, 884),
    stroke: (paint: black, thickness: 2pt), mark: (end: "stealth", fill: black))

  // 绿色闭环：干燥器底部绕框下回到储罐组
  line(p(627, 1132), p(627, 1175), p(152, 1175), p(152, 1112),
    stroke: (paint: C.green, thickness: 2.6pt),
    mark: (end: "stealth", fill: C.green))

  // 三个红色 Live 徽标贴于 Fuel Cell、Battery、AEM 右缘
  live(748, 214)
  live(748, 374)
  live(748, 640)

  // 子图编号
  content(p(574, 1250), text(size: 11pt, weight: "bold")[(a)], anchor: "center")
})
