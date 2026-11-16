#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图 1  混合电推进飞机动力系统：(a) 功率流框图，(b) 变换器电路拓扑
// 来源：Energies 2026, 19, 1931, Figure 1(a)(b)；DOI: 10.3390/en19081931
// 说明：三相发电机经 L_a~L_c 接入整流桥，直流母线穿 DC-DC 变换器接电池；
//       右侧逆变桥输出 V_an/V_bn/V_cn 驱动三相电机与螺旋桨。
#canvas({
  import draw: *
  let sw = 0.8pt
  let bw = 0.9pt
  let ls = 8.5pt
  let ink = black
  let blue = rgb("#3f6497")
  let blue-ink = rgb("#2b4d7d")
  let blue-bg = rgb("#f1f4f9")
  let ld = 0.45
  let node(p) = circle(p, radius: 0.048, fill: ink, stroke: none)
  // 电感：n 个半圆鼓包串联（贝塞尔四分之一圆拼接）。
  let inductor(a, b, n: 4) = {
    let (x0, y0) = a
    let w = (b.at(0) - x0) / n
    let r = w / 2
    let k = 0.5523 * r
    for i in range(n) {
      let xa = x0 + i * w
      let xm = xa + r
      let xb = xa + w
      bezier((xa, y0), (xm, y0 + r), (xa, y0 + k), (xm - k, y0 + r), stroke: sw)
      bezier((xm, y0 + r), (xb, y0), (xm + k, y0 + r), (xb, y0 + k), stroke: sw)
    }
  }
  // MOSFET 简化符号：加粗沟道 + 栅极条 + 反并联二极管，漏极在上、源极在下。
  let mosfet(x, y, name: none) = {
    let hc = 0.28
    let wd = 0.32
    line((x, y - hc), (x, y + hc), stroke: 2.4pt)
    line((x - 0.115, y - 0.16), (x - 0.115, y + 0.16), stroke: 1.4pt)
    line((x - 0.52, y - 0.16), (x - 0.115, y - 0.16), stroke: sw)
    line((x, y + hc), (x, y + ld), stroke: sw)
    line((x, y - hc), (x, y - ld), stroke: sw)
    line((x, y + hc), (x + wd, y + hc), (x + wd, y + 0.085), stroke: sw)
    line((x + wd, y - 0.085), (x + wd, y - hc), (x, y - hc), stroke: sw)
    line((x + wd - 0.08, y - 0.095), (x + wd + 0.08, y - 0.095), (x + wd, y + 0.075), close: true, fill: ink, stroke: (paint: ink, thickness: 0.5pt))
    line((x + wd - 0.115, y + 0.075), (x + wd + 0.115, y + 0.075), stroke: 1.2pt)
    if name != none { content((x - 0.64, y - 0.11), text(size: ls, weight: "bold", fill: ink, name), anchor: "south-east") }
  }
  // 三相桥：三条桥臂共用上下直流母线，桥臂中点引出相线。
  let bridge(xs, ytop, ybot, yu, yl, taps, names, xleft, xright) = {
    line((xleft, ytop), (xright, ytop), stroke: sw)
    line((xleft, ybot), (xright, ybot), stroke: sw)
    for (i, x) in xs.enumerate() {
      line((x, ytop), (x, yu + ld), stroke: sw)
      mosfet(x, yu, name: names.at(i))
      line((x, yu - ld), (x, yl + ld), stroke: sw)
      mosfet(x, yl, name: names.at(i + 3))
      line((x, yl - ld), (x, ybot), stroke: sw)
      node((x, taps.at(i)))
    }
  }
  let machine(c, r, label) = {
    circle(c, radius: r, stroke: bw)
    content(c, text(size: ls, weight: "bold", fill: ink, label), anchor: "center")
  }
  // 螺旋桨：两条交叉胶囊桨叶 + 黄色桨毂与桨尖。
  let propeller(c, r: 1.05, w: 0.20, ang: 42deg) = {
    let (cx, cy) = c
    for s in (1, -1) {
      let dx = r * calc.cos(s * ang)
      let dy = r * calc.sin(s * ang)
      line((cx - dx, cy - dy), (cx + dx, cy + dy), stroke: (paint: rgb("#3d3d3d"), thickness: w, cap: "round"))
      circle((cx + dx, cy + dy), radius: w / 2, fill: rgb("#e3c341"), stroke: none)
      circle((cx - dx, cy - dy), radius: w / 2, fill: rgb("#e3c341"), stroke: none)
    }
    circle(c, radius: 0.15, fill: rgb("#e3c341"), stroke: (paint: rgb("#8a7420"), thickness: 0.6pt))
  }
  // 电池：绿色三维方柱 + 前面板正负极符号。
  let battery(c, w: 0.70, h: 1.00) = {
    let (cx, cy) = c
    let x0 = cx - w / 2
    let x1 = cx + w / 2
    let y0 = cy - h / 2
    let y1 = cy + h / 2
    let d = 0.13
    line((x1, y0), (x1 + d, y0 + d), (x1 + d, y1 + d), (x1, y1), close: true, fill: rgb("#4f8a2f"), stroke: (paint: rgb("#2f5a18"), thickness: 0.5pt))
    line((x0, y1), (x0 + d, y1 + d), (x1 + d, y1 + d), (x1, y1), close: true, fill: rgb("#a6ce72"), stroke: (paint: rgb("#2f5a18"), thickness: 0.5pt))
    rect((x0, y0), (x1, y1), fill: rgb("#7fb544"), stroke: (paint: rgb("#2f5a18"), thickness: 0.6pt))
    line((cx - 0.13, cy - 0.15), (cx - 0.13, cy + 0.15), stroke: (paint: rgb("#274d12"), thickness: 1.5pt))
    line((cx - 0.01, cy - 0.08), (cx - 0.01, cy + 0.08), stroke: (paint: rgb("#274d12"), thickness: 2.4pt))
    content((cx + 0.13, cy + 0.19), text(size: 6pt, fill: rgb("#274d12"))[+], anchor: "center")
    content((cx + 0.13, cy - 0.12), text(size: 6pt, fill: rgb("#274d12"))[#sym.minus], anchor: "center")
  }
  // ===== 面板 (b)：电路拓扑 =====
  let ytop-l = 6.55
  let ybot-l = 2.15
  let xl = (5.00, 6.60, 8.20)
  let yl-mid = (5.15, 4.35, 3.55)
  machine((0.95, 3.55), 0.95, [3-Phase\ Generator])
  let lead-y = (3.85, 3.55, 3.25)
  let jog-x = (2.35, 2.55, 2.75)
  let ind-names = ($L_a$, $L_b$, $L_c$)
  for i in range(3) {
    let y0 = lead-y.at(i)
    let y1 = yl-mid.at(i)
    let xj = jog-x.at(i)
    line((1.85, y0), (xj, y0), (xj, y1), (2.95, y1), stroke: sw)
    inductor((2.95, y1), (4.05, y1))
    line((4.05, y1), (xl.at(i), y1), stroke: sw)
    content((3.50, y1 + 0.30), text(size: ls, weight: "bold", fill: ink, ind-names.at(i)), anchor: "south")
  }
  // 多字符下标写作 $S_(a 1)$、$V_("an")$，避免 Typst 把 a1 当变量相乘。
  bridge(xl, ytop-l, ybot-l, 5.85, 2.85, yl-mid, ($S_(a 1)$, $S_(a 3)$, $S_(a 5)$, $S_(a 2)$, $S_(a 4)$, $S_(a 6)$), 5.00, 9.40)
  rect((9.40, 0.05), (13.20, 7.05), stroke: (paint: ink, thickness: 1.1pt, dash: "dashed"))
  content((11.30, 3.55), text(size: 8.5pt, weight: "bold", fill: ink)[DC-DC Converter], anchor: "center")
  battery((2.35, 0.95))
  line((2.35, 1.43), (2.35, 1.75), (9.40, 1.75), stroke: sw)
  line((2.35, 0.47), (2.35, 0.30), (9.40, 0.30), stroke: sw)
  content((2.05, 1.72), text(size: ls, weight: "bold", fill: ink, $V_2$), anchor: "south-east")
  content((1.95, 0.85), text(size: ls, weight: "bold", fill: ink)[Battery], anchor: "east")
  let xr = (14.50, 16.05, 17.60)
  let yr-mid = (4.05, 3.55, 3.05)
  bridge(xr, 5.55, 1.55, 4.70, 2.40, yr-mid, ($S_1$, $S_3$, $S_5$, $S_2$, $S_4$, $S_6$), 13.20, 17.95)
  let v-names = ($V_("an")$, $V_("bn")$, $V_("cn")$)
  let motor-c = (19.95, 3.55)
  let motor-r = 0.90
  for i in range(3) {
    let y = yr-mid.at(i)
    let dy = y - motor-c.at(1)
    let dx = calc.sqrt(motor-r * motor-r - dy * dy)
    line((xr.at(i), y), (motor-c.at(0) - dx, y), stroke: sw)
    content((18.16, y + 0.03), text(size: ls, weight: "bold", fill: ink, v-names.at(i)), anchor: "south-west")
  }
  machine(motor-c, motor-r, [3-Phase\ Motor])
  line((motor-c.at(0) + motor-r, motor-c.at(1)), (21.80, motor-c.at(1)), stroke: (paint: ink, thickness: 1.4pt))
  propeller((22.00, 3.55))
  content((22.00, 2.50), text(size: ls, weight: "bold", fill: ink)[Propeller], anchor: "north")
  content((11.50, -0.62), text(size: 10pt, fill: ink)[(b)], anchor: "north")
  // ===== 面板 (a)：功率流框图 =====
  let ax = 1.05
  let ay = 9.30
  let blk(x0, y0, x1, y1, body) = {
    rect((ax + x0, ay + y0), (ax + x1, ay + y1), stroke: (paint: blue, thickness: bw), fill: blue-bg)
    content((ax + (x0 + x1) / 2, ay + (y0 + y1) / 2), body, anchor: "center")
  }
  let flow(a, b) = line(a, b, stroke: (paint: blue, thickness: 0.8pt), mark: (end: "stealth", fill: blue, scale: 0.45))
  blk(0, 3.00, 2.70, 5.20, text(size: 9pt, weight: "bold", fill: blue-ink)[3 Phase\ generator])
  blk(0, 0.00, 2.70, 2.20, text(size: 9pt, weight: "bold", fill: blue-ink)[Battery])
  blk(4.20, 0.00, 16.20, 5.20, text(size: 21pt, weight: "bold", fill: blue-ink)[DC-DC Converter])
  blk(18.00, 1.65, 20.90, 3.55, text(size: 8.5pt, weight: "bold", fill: blue-ink)[3 phase motor])
  flow((ax + 2.70, ay + 4.10), (ax + 4.20, ay + 4.10))
  flow((ax + 2.70, ay + 1.10), (ax + 4.20, ay + 1.10))
  flow((ax + 16.20, ay + 2.60), (ax + 18.00, ay + 2.60))
  content((ax + 10.45, ay - 0.60), text(size: 10pt, fill: ink)[(a)], anchor: "north")
})