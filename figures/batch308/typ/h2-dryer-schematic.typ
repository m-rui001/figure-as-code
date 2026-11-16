#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Schematic of H2 dryer operation（Enapter DRY 2.1 双筒交替干燥流程）
// 来源：Energies 2025, 18(23), 6318, Figure 3(b)；DOI: 10.3390/en18236318
// 结构：虚线框内蓝色 H2 进气经阀分入上下两个干燥筒，经阀/止回阀/压力传感器后
//       绿线 H2 Out 排出，橙红线 H2 Vent 排放，另有黑色 Depressurization 支路；底部标 (b)。
// 坐标系：1 单位 = 0.1cm，画布约 16.5cm × 7.6cm。
#canvas(length: 0.1cm, {
  import draw: *
  let blue = rgb("#2b4bd8")
  let green = rgb("#00a651")
  let red = rgb("#ff3b1f")
  let yellow = rgb("#ffe08a")
  let lavender = rgb("#d8d4f2")
  let orange = rgb("#f6c7a9")
  let purple = rgb("#6a0dad")
  let teal = rgb("#256d7d")
  let navy = rgb("#16357f")
  let pipe = 2pt
  let arrow(c) = (end: "stealth", fill: c, scale: 0.45)
  let valvebox(cx, cy) = {
    rect((cx - 6.5, cy - 3), (cx + 6.5, cy + 3), radius: 0.8, fill: yellow, stroke: black + 1.2pt)
    content((cx, cy), text(weight: 700)[Valve])
  }
  let checkvalve(cx, cy, fill) = {
    rect((cx - 7, cy - 5), (cx + 7, cy + 5), radius: 0.8, fill: fill, stroke: black + 1.2pt)
    content((cx, cy), text(size: 9pt, weight: 700)[Check \ Valve])
  }
  let bottle(x, y) = {
    rect((x + 0.5, y + 4.4), (x + 1.9, y + 5.2), stroke: teal + 1pt)
    rect((x, y), (x + 2.4, y + 4.4), radius: 0.4, stroke: teal + 1pt)
    for i in range(3) { line((x + 0.3, y + 3 + i * 0.45), (x + 2.1, y + 3 + i * 0.45), stroke: teal + 0.7pt) }
    for i in range(3) {
      for j in range(2) {
        circle((x + 0.7 + i * 0.7, y + 0.5 + j * 0.5), radius: 0.12, fill: teal, stroke: none)
      }
    }
    circle((x + 3.2, y + 2.4), radius: 0.38, stroke: teal + 1pt)
  }
  let chip(x, y) = {
    rect((x, y), (x + 4.4, y + 3.4), radius: 0.3, stroke: black + 1.1pt)
    rect((x + 0.5, y + 0.8), (x + 3.9, y + 2.9), stroke: black + 0.7pt)
    for i in range(3) { line((x + 0.9, y + 1.2 + i * 0.5), (x + 3.5, y + 1.2 + i * 0.5), stroke: black + 0.6pt) }
    for i in range(5) { line((x + 0.6 + i * 0.8, y - 0.7), (x + 0.6 + i * 0.8, y), stroke: black + 0.9pt) }
  }
  let h2sym(cx, cy) = {
    let r = 3.0
    let dot(a) = (cx + r * calc.cos(a), cy + r * calc.sin(a))
    circle((cx, cy), radius: r, stroke: purple + 1.4pt, fill: none)
    line(dot(24deg), dot(6deg), stroke: purple + 1.8pt,
      mark: (end: "stealth", fill: purple, scale: 0.45))
    line(dot(204deg), dot(186deg), stroke: purple + 1.8pt,
      mark: (end: "stealth", fill: purple, scale: 0.45))
    content((cx, cy), text(fill: purple, weight: 700, size: 10pt)[$H_2$])
  }
  let cartridge(bx, by, col, name) = {
    rect((bx, by), (bx + 38, by + 27.5), radius: 2, fill: white, stroke: col + 2.5pt)
    bottle(bx + 3, by + 7.5)
    h2sym(bx + 13.5, by + 11)
    chip(bx + 19.5, by + 9)
    content((bx + 19, by + 5.5), anchor: "north", text(weight: 700, size: 12pt)[#name])
  }
  cartridge(25, 39, navy, [Drying Cartridge 0])
  cartridge(27, 1.5, black, [Drying Cartridge 1])
  // 蓝色进气与分流的两个进口阀
  rect((-22, 27), (-2, 38), radius: 0.8, fill: orange, stroke: black + 1.2pt)
  content((-12, 32.5), text(size: 8.5pt, weight: 700)[Input \ Pressure \ Sensor])
  line((-30, 32.5), (-22, 32.5), stroke: blue + pipe)
  content((-22, 40), anchor: "south", [H₂ in])
  line((-2, 32.5), (3, 32.5), stroke: blue + pipe)
  line((3, 14.5), (3, 52), stroke: blue + pipe)
  line((3, 14.5), (7, 14.5), stroke: blue + pipe, mark: arrow(blue))
  line((3, 52), (7, 52), stroke: blue + pipe, mark: arrow(blue))
  valvebox(13.5, 14.5)
  valvebox(13.5, 52)
  line((20, 14.5), (27, 14.5), stroke: blue + pipe, mark: arrow(blue))
  line((20, 52), (27, 52), stroke: blue + pipe, mark: arrow(blue))
  // 上筒绿色输出路径：阀 → 止回阀 → 输出压力传感器 → H2 Out
  line((63, 52), (70, 52), stroke: green + pipe, mark: arrow(green))
  valvebox(76.5, 52)
  line((83, 52), (89, 52), stroke: green + pipe)
  checkvalve(96, 52, lavender)
  line((103, 52), (108, 52), stroke: green + pipe)
  rect((108, 46), (128, 58), radius: 0.8, fill: orange, stroke: black + 1.2pt)
  content((118, 52), text(size: 8.5pt, weight: 700)[Output \ Pressure \ Sensor])
  line((128, 52), (152, 52), stroke: green + pipe, mark: arrow(green))
  content((138, 54), anchor: "south", [H₂ Out])
  // 下筒绿色输出路径与中间绿色汇流竖线
  line((65, 14.5), (70, 14.5), stroke: green + pipe, mark: arrow(green))
  valvebox(76.5, 14.5)
  line((83, 14.5), (86, 14.5), stroke: green + pipe)
  line((86, 14.5), (86, 52), stroke: green + pipe)
  // 上筒底部红色 vent 支路：止回阀后拱形跨过绿色竖线
  line((46, 39), (46, 34.5), stroke: red + pipe)
  line((46, 34.5), (66, 34.5), stroke: red + pipe, mark: arrow(red))
  checkvalve(73, 34.5, yellow)
  line((80, 34.5), (83, 34.5), stroke: red + pipe)
  arc((89, 34.5), start: 0deg, stop: 180deg, radius: 3, stroke: red + pipe)
  line((89, 34.5), (152, 34.5), stroke: red + pipe, mark: arrow(red))
  content((142, 34.0), anchor: "north", [H₂ Vent])
  // 黑色 Depressurization 支路，末端 T 形封头
  line((86, 24.5), (126, 24.5), stroke: black + 1.6pt)
  line((126, 22.3), (126, 26.7), stroke: black + 2.5pt)
  content((106, 26.0), anchor: "south", [Depressurization])
  // 虚线边界框与子图编号
  rect((-24, 0.5), (130, 68.5), stroke: (paint: black, thickness: 1.5pt, dash: "dashed"))
  content((53, 71.5), text(size: 12pt)[(b)])
})
