#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：Resonant AC link power converters（谐振 AC link 变换器结构）
// 来源：Energies 2026, 19(8), 1931, Figure 2；DOI 10.3390/en19081931
// 结构：顶部三格通用结构条（Input switches / AC Voltage & Current Links / Output switches），
// 中线向下经双箭头分指 (a) Series AC Link 与 (b) Parallel AC Link 两种拓扑；
// 上部为电感-电容串联回路与并联 LC 回路，下部为两组三周期正弦波形。
// (a) 用三个半圆电感符号与双竖板电容；(b) 左侧横板电容、右侧三个半圆电感。
// 波形用采样正弦折线绘制，浅灰绘图区，无刻度数字，所有标签逐字保留。

#let vtext(t) = rotate(-90deg, reflow: true, t)

#canvas({
  import draw: *
  let st = 0.9pt + black
  let ax = 0.75pt + black
  let box = 0.8pt + black

  let bumpu(x0, x1, y) = {
    let r = (x1 - x0) / 2
    let cx = (x0 + x1) / 2
    let pts = ()
    for k in range(13) {
      let a = calc.pi - k / 12 * calc.pi
      pts.push((cx + r * calc.cos(a), y + r * calc.sin(a)))
    }
    draw.line(..pts, stroke: st)
  }

  let bumpr(x, y0, y1) = {
    let r = (y1 - y0) / 2
    let cy = (y0 + y1) / 2
    let pts = ()
    for k in range(13) {
      let a = calc.pi / 2 - k / 12 * calc.pi
      pts.push((x + r * calc.cos(a), cy + r * calc.sin(a)))
    }
    draw.line(..pts, stroke: st)
  }

  let sine(x0, x1, y0, amp, period) = {
    let n = 120
    let pts = ()
    for k in range(n + 1) {
      let x = x0 + (x1 - x0) * k / n
      pts.push((x, y0 + amp * calc.sin(2 * calc.pi * (x - x0) / period)))
    }
    draw.line(..pts, stroke: st)
  }

  // 顶部三格结构条
  draw.line((6.2, 10.0), (6.2, 11.2), (12.1, 11.2), (12.1, 10.0), close: true, stroke: box)
  draw.line((7.55, 10.0), (7.55, 11.2), stroke: box)
  draw.line((10.75, 10.0), (10.75, 11.2), stroke: box)
  content((6.87, 10.55), text(size: 8.5pt)[Input \ switches])
  content((9.15, 10.55), text(size: 8.5pt)[AC Voltage \ & Current \ Links])
  content((11.42, 10.55), text(size: 8.5pt)[Output \ switches])

  // 分指 (a)/(b) 的双向箭头
  draw.line((9.15, 10.0), (9.15, 9.65), stroke: box)
  draw.line((7.72, 9.65), (10.58, 9.65), stroke: box,
    mark: (start: "stealth", end: "stealth", fill: black, scale: 0.4))
  content((7.1, 9.24), text(size: 11pt)[(a)])
  content((9.15, 9.24), text(weight: "bold", size: 12.5pt)[OR])
  content((11.3, 9.24), text(size: 11pt)[(b)])

  // (a) Series AC Link
  let ys = 8.05
  draw.line((5.08, ys), (6.12, ys), stroke: st)
  bumpu(6.12, 6.76, ys)
  bumpu(6.76, 7.4, ys)
  bumpu(7.4, 8.04, ys)
  draw.line((8.04, ys), (8.83, ys), stroke: st)
  draw.line((8.83, ys - 0.33), (8.83, ys + 0.33), stroke: 1.1pt + black)
  draw.line((8.99, ys - 0.33), (8.99, ys + 0.33), stroke: 1.1pt + black)
  draw.line((8.99, ys), (9.76, ys), stroke: st)
  draw.line((5.02, 6.07), (9.82, 6.07), stroke: st)
  content((7.42, 5.55), text(size: 9.5pt)[Series AC Link])

  // (b) Parallel AC Link
  let (px0, px1, py0, py1) = (10.59, 11.8, 5.74, 9.05)
  draw.line((px0, py1), (px1, py1), stroke: st)
  draw.line((px0, py0), (px1, py0), stroke: st)
  draw.line((px0, py1), (px0, 7.53), stroke: st)
  draw.line((px0 - 0.24, 7.53), (px0 + 0.24, 7.53), stroke: 1.1pt + black)
  draw.line((px0 - 0.24, 7.39), (px0 + 0.24, 7.39), stroke: 1.1pt + black)
  draw.line((px0, 7.39), (px0, py0), stroke: st)
  draw.line((px1, py1), (px1, 8.4), stroke: st)
  bumpr(px1, 7.8, 8.4)
  bumpr(px1, 7.2, 7.8)
  bumpr(px1, 6.6, 7.2)
  draw.line((px1, 6.6), (px1, py0), stroke: st)
  content((11.2, 5.4), text(size: 9.5pt)[Parallel AC Link])

  // 左下波形：AC Current for Series AC Link
  draw.rect((4.63, 0.05), (9.71, 2.95), fill: luma(225), stroke: none)
  draw.line((4.63, 0.05), (4.63, 3.82), stroke: ax)
  draw.line((4.63, 1.32), (9.71, 1.32), stroke: ax)
  sine(4.63, 9.71, 1.32, 0.88, 1.693)
  content((7.15, 3.35), text(size: 9pt)[AC Current for Series AC \ Link])
  content((4.32, 2.45), vtext([Current (A)]))
  content((7.15, 0.22), text(size: 9pt)[Time (S)])

  // 右下波形：AC Voltage for Parallel AC Link
  draw.rect((10.1, 0.05), (15.18, 2.95), fill: luma(225), stroke: none)
  draw.line((10.1, 0.05), (10.1, 3.82), stroke: ax)
  draw.line((10.1, 1.32), (15.18, 1.32), stroke: ax)
  sine(10.1, 15.18, 1.32, 0.88, 1.693)
  content((12.62, 3.35), text(size: 9pt)[AC Voltage for Parallel AC \ Link])
  content((9.79, 2.45), vtext([Voltage (V)]))
  content((12.62, 0.22), text(size: 9pt)[Time (S)])
})
