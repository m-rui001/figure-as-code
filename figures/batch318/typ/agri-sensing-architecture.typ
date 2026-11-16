#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：System architecture of the supervised mobile sensing and telemetry platform
// 来源：Agronomy 2026, 16(12), 1139, Figure 1；DOI 10.3390/agronomy16121139
// 结构：农业移动感知平台三层架构。左列 DATA ACQUISITION 面板含 BME280、BH1750、
// MLX90614、RGB Camera、LiDAR 五个传感器，箭头汇入 LOCAL PROCESSING UNIT；
// 上方 LOCAL LOGGING 以 CSV 记录，右侧 COMMUNICATION LAYER 经网络接远程云存储，
// 并经 MAVLink Telemetry 接 QGROUNDCONTROL 地面站；下方 OPERATOR INTERVENTION
// 与 COMBINED SESSION 构成人工干预回路，TERMINAL CONTROL 箭头回处理单元。

#let rtxt(t, a) = rotate(a, t, reflow: true)

#canvas({
  import draw: *
  let blue = rgb("#2e6f95")
  let pale = rgb("#e6eff7")
  let st = 1pt + blue
  let th = 0.8pt + blue
  let mk = (end: "stealth", fill: blue, scale: 0.32)
  let bar(a, b) = draw.line(a, b, stroke: th, mark: mk)
  let bt(t, s: 8.5pt) = text(weight: "bold", size: s, t)
  let nt(t, s: 8pt) = text(size: s, t)

  // 数据采集面板
  content((1.35, 6.04), text(weight: "bold", size: 9pt)[DATA \ ACQUISITION])
  draw.rect((0.55, 0.95), (2.2, 5.5), fill: pale, stroke: st)
  content((0.78, 3.25), rtxt(text(weight: "bold", size: 8pt)[DATA ACQUISITION], -90deg))
  draw.line((0.95, 0.95), (0.95, 5.5), stroke: th)
  for (y, t) in ((4.95, "BME280"), (4.05, "BH1750"), (3.15, "MLX90614"),
      (2.25, "RGB Camera"), (1.35, "LiDAR")) {
    content((1.55, y - 0.28), text(size: 8.5pt)[#t])
  }
  draw.rect((1.3, 5.02), (1.62, 5.3), stroke: th)
  for k in range(3) { draw.line((1.34 + k * 0.12, 4.94), (1.34 + k * 0.12, 5.02), stroke: th) }
  draw.rect((1.32, 4.1), (1.6, 4.35), stroke: th)
  draw.rect((1.38, 4.16), (1.54, 4.29), stroke: th)
  draw.rect((1.32, 3.2), (1.6, 3.48), stroke: th)
  draw.circle((1.46, 3.34), radius: 0.08, stroke: th)
  draw.rect((1.28, 2.24), (1.62, 2.48), stroke: th)
  draw.circle((1.45, 2.36), radius: 0.08, stroke: th)
  draw.circle((1.45, 1.42), radius: 0.14, stroke: th)
  draw.line((1.31, 1.42), (1.59, 1.42), stroke: th)

  // 本地记录
  draw.line((3.6, 5.0), (3.6, 4.6), stroke: th, mark: mk)
  draw.rect((3.35, 5.0), (3.85, 5.4), stroke: st)
  draw.line((3.35, 5.45), (3.85, 5.45), stroke: st)
  draw.line((3.35, 5.57), (3.85, 5.57), stroke: st)
  draw.line((3.35, 5.0), (3.35, 5.57), stroke: st)
  draw.line((3.85, 5.0), (3.85, 5.57), stroke: st)
  content((4.05, 5.35), anchor: "west", align(left)[#bt([LOCAL]) \ #nt([LOGGING]) \ #nt([(CSV Format)])])

  // 处理单元与通信层
  draw.rect((3.0, 2.6), (5.15, 4.55), fill: pale, stroke: st)
  content((4.07, 3.75), align(center)[#bt([LOCAL]) \ #bt([PROCESSING]) \ #bt([UNIT]) \ #nt([(Python Routines)])])
  draw.rect((5.75, 2.6), (7.9, 4.55), fill: pale, stroke: st)
  content((6.82, 3.55), align(center)[#bt([COMMUNICATION], s: 8pt) \ #bt([LAYER])])
  bar((5.15, 3.55), (5.75, 3.55))
  bar((2.2, 4.7), (3.0, 4.2))
  bar((2.2, 3.55), (3.0, 3.55))
  bar((2.2, 2.4), (3.0, 2.95))

  // 云端与远程监管
  draw.line((6.82, 4.55), (6.82, 5.0), (9.15, 5.0), stroke: th, mark: mk)
  draw.circle((9.55, 5.05), radius: 0.35, fill: pale, stroke: st)
  draw.circle((9.85, 5.2), radius: 0.26, fill: pale, stroke: st)
  draw.circle((9.75, 4.9), radius: 0.22, fill: pale, stroke: st)
  content((8.0, 5.33), align(center)[#text(size: 7.5pt)[NETWORK ACCESS] \ #text(size: 7.5pt)[AVAILABLE]])
  content((10.35, 5.05), anchor: "west", align(left)[#bt([REMOTE]) \ #bt([SUPERVISION]) \ #bt([& STORAGE])])

  // 地面站屏幕
  draw.rect((8.95, 2.05), (12.45, 4.4), radius: 0.08, fill: pale, stroke: st)
  draw.rect((9.1, 2.3), (12.3, 4.2), fill: luma(240), stroke: th)
  draw.line((9.1, 4.02), (9.5, 4.15), (10.2, 4.05), (10.9, 4.18), (11.6, 4.02),
    (12.3, 4.14), stroke: (paint: rgb("#c9a227"), thickness: 1.2pt))
  draw.line((9.55, 4.13), (9.9, 3.7), (10.6, 3.5), (11.2, 3.75), (11.9, 3.55),
    (12.2, 4.1), (11.5, 4.16), (10.8, 4.12), (10.1, 4.15), close: true,
    stroke: (paint: rgb("#c9a227"), thickness: 1pt))
  for p in ((9.8, 3.9), (10.35, 3.72), (10.95, 3.6), (11.55, 3.72), (12.0, 3.95)) {
    draw.circle(p, radius: 0.05, fill: blue, stroke: none)
  }
  content((10.7, 1.7), align(center)[#bt([QGROUNDCONTROL]) \ #nt([(Map-based Supervision)])])
  bar((7.9, 3.55), (8.95, 3.55))
  content((8.35, 3.85), align(center)[#text(size: 7pt)[MAVLink] \ #text(size: 7pt)[Telemetry]])

  // 操作员干预与联合会话
  draw.rect((6.0, 0.7), (8.6, 1.6), fill: pale, stroke: st)
  content((7.3, 1.12), align(center)[#bt([OPERATOR]) \ #bt([INTERVENTION])])
  draw.line((6.85, 2.6), (6.85, 1.6), stroke: th, mark: mk)
  bar((6.0, 1.45), (5.15, 1.45))
  bar((6.0, 1.0), (5.15, 1.0))
  content((5.1, 1.22), anchor: "east", align(right)[#text(size: 7.5pt)[TERMINAL] \ #text(size: 7.5pt)[CONTROL]])
  draw.rect((9.3, 0.55), (9.95, 1.3), fill: pale, stroke: st)
  draw.circle((9.62, 1.0), radius: 0.1, stroke: st)
  draw.line((9.62, 0.9), (9.45, 0.65), stroke: st)
  draw.line((9.62, 0.9), (9.8, 0.65), stroke: st)
  bar((9.3, 0.95), (8.6, 0.95))
  content((9.95, 0.3), anchor: "west", align(left)[#bt([COMBINED SESSION], s: 8pt) \
    #nt([(Automated Routines], s: 7.5pt) \ #nt([#sym.plus Human Control)], s: 7.5pt)])
})
