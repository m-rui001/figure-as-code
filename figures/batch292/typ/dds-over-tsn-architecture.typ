#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：基于 TSN 的 DDS 分布式通信体系架构（应用/控制/数据三层平面）
// 来源：Future Internet 2026, 18, 297, Figure 2；DOI: 10.3390/fi18060297
// 说明：按原图 1:1 重绘，标签逐字保留；坐标单位为厘米，y 轴向上。
// 竖排文字助手须在 import draw:* 之前定义，避免 rotate 被 CeTZ 覆盖。
#let vtext(body) = rotate(-90deg, body)
#canvas({
  import draw: *
  let ink = rgb("#232323")
  let gray = rgb("#5a5a5a")
  let green = rgb("#00a651")
  let orange = rgb("#d9a63b")
  let red = rgb("#d23b3b")
  let card = rgb("#df9294")
  let white = rgb("#ffffff")
  // 统一箭头：实心 stealth；虚线箭头必须显式 fill，否则箭头随虚线退化。
  let bi = (p, q, col, w: 1.6pt, sc: 0.45) => line(p, q, stroke: w + col, mark: (start: "stealth", end: "stealth", fill: col, scale: sc))
  let ao = (p, q, col, w: 1.6pt, sc: 0.45) => line(p, q, stroke: w + col, mark: (end: "stealth", fill: col, scale: sc))
  let nc = (p, q) => line(p, q, stroke: (paint: red, thickness: 1.25pt, dash: "dash-dotted"), mark: (end: "stealth", fill: red, scale: 0.45))
  // 按圆心+半径+起止角采样圆弧（arc() 的 pos 是弧起点而非圆心）。
  let arcPts(center, r, a1, a2, n: 16) = range(n + 1).map(i => {
    let t = a1 + (a2 - a1) * i / n
    (center.at(0) + r * calc.cos(t), center.at(1) + r * calc.sin(t))
  })
  // 云朵轮廓（圆并集径向采样，归一化到 [-1,1]²）。
  let cloudPts = (
    (0.994,0.037),(1.000,0.108),(0.995,0.179),(0.978,0.248),(0.950,0.312),(0.910,0.370),(0.856,0.418),(0.784,0.451),(0.754,0.499),(0.736,0.555),
    (0.713,0.606),(0.685,0.654),(0.652,0.696),(0.614,0.732),(0.573,0.761),(0.528,0.783),(0.480,0.797),(0.431,0.802),(0.379,0.798),(0.335,0.800),
    (0.310,0.839),(0.282,0.875),(0.251,0.907),(0.218,0.935),(0.183,0.958),(0.146,0.976),(0.108,0.989),(0.070,0.997),(0.030,1.000),(-0.009,0.998),
    (-0.048,0.990),(-0.086,0.977),(-0.122,0.960),(-0.158,0.937),(-0.191,0.910),(-0.222,0.879),(-0.251,0.850),(-0.293,0.865),(-0.335,0.874),(-0.378,0.876),
    (-0.420,0.872),(-0.461,0.862),(-0.501,0.846),(-0.539,0.823),(-0.575,0.796),(-0.608,0.763),(-0.637,0.725),(-0.664,0.684),(-0.686,0.639),(-0.705,0.590),
    (-0.736,0.552),(-0.798,0.533),(-0.851,0.500),(-0.895,0.459),(-0.932,0.409),(-0.961,0.354),(-0.982,0.294),(-0.995,0.232),(-1.000,0.167),(-0.997,0.102),
    (-0.985,0.037),(-0.964,-0.025),(-0.935,-0.084),(-0.896,-0.137),(-0.846,-0.183),(-0.782,-0.218),(-0.725,-0.248),(-0.718,-0.297),(-0.709,-0.345),(-0.698,-0.393),
    (-0.685,-0.440),(-0.669,-0.486),(-0.652,-0.532),(-0.632,-0.576),(-0.610,-0.619),(-0.586,-0.661),(-0.560,-0.701),(-0.533,-0.739),(-0.503,-0.776),(-0.472,-0.810),
    (-0.439,-0.841),(-0.404,-0.870),(-0.368,-0.897),(-0.331,-0.920),(-0.293,-0.941),(-0.254,-0.959),(-0.213,-0.974),(-0.173,-0.985),(-0.131,-0.993),(-0.089,-0.998),
    (-0.048,-1.000),(-0.006,-0.998),(0.036,-0.993),(0.077,-0.985),(0.118,-0.974),(0.158,-0.959),(0.198,-0.941),(0.236,-0.920),(0.273,-0.897),(0.309,-0.870),
    (0.344,-0.841),(0.377,-0.810),(0.408,-0.776),(0.437,-0.739),(0.465,-0.701),(0.491,-0.661),(0.515,-0.619),(0.537,-0.576),(0.556,-0.532),(0.574,-0.486),
    (0.589,-0.440),(0.603,-0.393),(0.614,-0.345),(0.623,-0.297),(0.630,-0.248),(0.734,-0.235),(0.838,-0.207),(0.901,-0.158),(0.946,-0.098),(0.976,-0.032),
  )
  let cloud(cx, cy, w, h, col) = line(..cloudPts.map(p => (cx + p.at(0) * w / 2, cy + p.at(1) * h / 2)), close: true, fill: white, stroke: 2.1pt + col)
  // 堆叠卡片：逐张向左上偏移，前面的最后画。
  let cards(cx, cy, w, h, n: 3, dx: 0.22, dy: 0.18) = {
    for i in range(n) {
      let k = n - 1 - i
      rect((cx - k * dx - w/2, cy + k * dy - h/2), (cx - k * dx + w/2, cy + k * dy + h/2), radius: 0.12, fill: card, stroke: 1.4pt + ink)
    }
  }
  let tool(cx, cy, s: 1) = {
    line((cx - 0.26*s, cy - 0.26*s), (cx + 0.26*s, cy + 0.26*s), stroke: 3.4pt*s + gray)
    line(..arcPts((cx - 0.30*s, cy - 0.30*s), 0.13*s, 35deg, 310deg), stroke: 2.2pt*s + gray)
    line(..arcPts((cx + 0.30*s, cy + 0.30*s), 0.13*s, -145deg, 130deg), stroke: 2.2pt*s + gray)
  }
  let gear(cx, cy, ro: 0.26, ri: 0.18, teeth: 10) = {
    line(..range(teeth * 2).map(i => {
      let a = i * 360deg / (teeth * 2)
      let r = if calc.rem(i, 2) == 0 { ro } else { ri }
      (cx + r * calc.cos(a), cy + r * calc.sin(a))
    }), close: true, fill: white, stroke: 1.3pt + ink)
    circle((cx, cy), radius: 0.065, fill: white, stroke: 1.1pt + ink)
  }
  let server(cx, cy, s: 1) = {
    rect((cx - 0.60*s, cy - 0.66*s), (cx + 0.60*s, cy + 0.66*s), radius: 0.14*s, fill: white, stroke: 1.8pt + ink)
    for dy in (0.30*s, -0.06*s) {
      rect((cx - 0.44*s, cy + dy - 0.10*s), (cx + 0.42*s, cy + dy + 0.10*s), radius: 0.06*s, fill: white, stroke: 1.1pt + gray)
      circle((cx - 0.30*s, cy + dy), radius: 0.045*s, fill: ink)
    }
    gear(cx + 0.40*s, cy - 0.44*s, ro: 0.24*s, ri: 0.165*s)
  }
  // TSN 交换机：梯形顶面交叉箭头 + 前面板指示灯与端口点阵。
  let switchIcon(cx, cy, s: 1) = {
    line((cx - 0.62*s, cy - 0.08*s), (cx + 0.62*s, cy - 0.08*s), (cx + 0.46*s, cy + 0.52*s), (cx - 0.46*s, cy + 0.52*s), close: true, fill: white, stroke: 1.4pt + ink)
    ao((cx - 0.30*s, cy + 0.10*s), (cx + 0.28*s, cy + 0.42*s), ink, w: 1.0pt, sc: 0.32)
    ao((cx + 0.30*s, cy + 0.10*s), (cx - 0.28*s, cy + 0.42*s), ink, w: 1.0pt, sc: 0.32)
    rect((cx - 0.62*s, cy - 0.62*s), (cx + 0.62*s, cy - 0.08*s), radius: 0.05*s, fill: white, stroke: 1.4pt + ink)
    circle((cx - 0.42*s, cy - 0.35*s), radius: 0.075*s, fill: ink)
    for yy in (-0.24*s, -0.46*s) {
      for xx in (-0.14*s, 0.03*s, 0.20*s, 0.37*s) {
        rect((cx + xx - 0.055*s, cy + yy - 0.028*s), (cx + xx + 0.055*s, cy + yy + 0.028*s), fill: ink, stroke: none)
      }
    }
  }
  let L(p, body, size: 10pt) = content(p, strong(body), size: size)
  // ① 三层平面容器
  let planeL = 0.36
  let planeR = 14.12
  let divX = 1.13
  rect((planeL, 12.21), (planeR, 16.58), radius: 0.34, fill: white, stroke: 2.0pt + ink)
  line((divX, 12.21), (divX, 16.58), stroke: 1.5pt + ink)
  content((0.74, 14.40), vtext(strong([Application Plane])), size: 10.5pt)
  rect((3.83, 5.84), (9.58, 10.71), radius: 0.30, fill: white, stroke: 2.0pt + ink)
  line((4.61, 5.84), (4.61, 10.71), stroke: 1.4pt + ink)
  content((4.22, 8.27), vtext(strong([Control Plane])), size: 10.5pt)
  rect((planeL, 0.42), (planeR, 4.38), radius: 0.34, fill: white, stroke: 2.0pt + ink)
  line((divX, 0.42), (divX, 4.38), stroke: 1.5pt + ink)
  content((0.74, 2.40), vtext(strong([Data Plane])), size: 10.5pt)
  // ② 长距离链路（先画，端点留在云与交换机外沿）
  bi((3.01, 12.55), (2.96, 3.08), green, w: 1.8pt)
  bi((12.48, 12.55), (12.45, 3.08), green, w: 1.8pt)
  bi((7.68, 12.55), (7.68, 10.50), orange, w: 1.8pt)
  bi((3.65, 14.18), (6.10, 14.95), green)
  bi((12.25, 14.18), (9.80, 14.95), green)
  bi((7.68, 14.26), (7.68, 14.86), orange, w: 1.5pt, sc: 0.36)
  bi((7.68, 8.82), (7.68, 7.74), ink, w: 1.6pt)
  // ③ 数据层网状互连与 NETCONF 扇出
  for (a, b) in (
    ((3.67, 2.56), (7.00, 3.38)), ((8.39, 3.44), (11.79, 2.60)), ((3.61, 2.20), (5.16, 1.31)),
    ((6.50, 1.11), (9.41, 1.11)), ((10.74, 1.40), (11.79, 2.09)),
  ) { line(a, b, stroke: 1.0pt + gray) }
  for t in ((2.96, 3.06), (7.68, 3.74), (5.78, 2.04), (10.11, 2.04), (12.45, 3.06)) { nc((7.68, 6.15), t) }
  // ④ 图形实体（压在链路上方）
  for sw in ((2.96, 2.40), (7.68, 3.23), (5.78, 1.34), (10.11, 1.34), (12.45, 2.40)) { switchIcon(sw.at(0), sw.at(1), s: 1.15) }
  cloud(3.05, 13.43, 3.10, 1.64, green)
  cloud(7.68, 13.46, 2.58, 1.56, orange)
  cloud(12.42, 13.43, 3.10, 1.64, green)
  cards(7.94, 15.40, 3.75, 1.00)
  rect((6.96, 8.90), (8.42, 10.40), radius: 0.14, fill: white, stroke: 1.8pt + ink)
  line((7.02, 9.35), (8.36, 9.35), stroke: 1.1pt + gray)
  tool(7.69, 9.88, s: 1)
  for dy in (9.18, 9.03) { rect((7.06, dy - 0.045), (8.32, dy + 0.045), radius: 0.03, fill: white, stroke: 1.0pt + gray) }
  server(7.68, 6.93, s: 1)
  // ⑤ 文字标签
  L((7.94, 15.40), [DDS Applications], size: 10.5pt)
  for (x, body) in ((3.05, "DDS user-defined"), (7.68, "DDS built-in"), (12.42, "DDS user-defined")) {
    L((x, 13.60), body, size: 9pt)
    L((x, 13.26), [topics], size: 9pt)
  }
  L((10.25, 11.25), [DDS Centralized Discovery], size: 8pt)
  L((5.75, 8.72), [TSN], size: 9.5pt)
  L((5.75, 8.36), [Controller], size: 9.5pt)
  L((8.93, 9.31), [CUC], size: 10pt)
  L((8.10, 8.28), [UNI], size: 9.5pt)
  L((8.94, 6.62), [CNC], size: 10pt)
  content((2.60, 8.30), vtext(strong([DDS Messages])), size: 9pt)
  content((12.90, 8.30), vtext(strong([DDS Messages])), size: 9pt)
  L((10.55, 5.45), [NETCONF], size: 9.5pt)
  L((10.55, 5.12), [Protocol], size: 9.5pt)
  L((2.70, 0.72), [TSN Switches], size: 9pt)
})
