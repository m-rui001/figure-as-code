#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Triple Spar 浮式平台几何与撑杆截面
// 来源：Energies 2025, 18, 2813, Figure 3；DOI: 10.3390/en18112813
// 左：三根竖直 spar 圆柱，顶部深灰框架与斜撑组成三脚架，点划线示 SPAR AXIS 与 BRACE AXIS
// 右：撑杆截面 B×H，壁厚 t，内腔 b×h，四壁剖面线，中心点划线，左侧 M 弯矩箭头
// 截面四壁用剖面线填充，尺寸 H/B/h/b/t 标注内外轮廓
// 左平台与右截面按原图左右并置，轴线用点划线
#canvas(length: 0.75pt, {
  import draw: *
  let blk = rgb("#333333")
  let fc = rgb("#d9d9d9")
  let eg = rgb("#4a4a4a")
  let dl = (paint: black, thickness: 0.6, dash: "dash-dotted")
  let thin = (paint: black, thickness: 0.8)
  let am = (start: "stealth", end: "stealth", fill: black, scale: 0.4)
  let ell(cx, cy, rx, ry) = {
    line(..range(33).map(i => {
      let a = 2 * calc.pi * i / 32
      (cx + rx * calc.cos(a), cy + ry * calc.sin(a))
    }), close: true, fill: fc, stroke: (paint: eg, thickness: 1.2pt))
  }
  let cyl(cx, yb, yt, r: 27) = {
    ell(cx, yb, r, 7)
    draw.rect((cx - r, yb), (cx + r, yt), fill: fc, stroke: none)
    draw.line((cx - r, yb), (cx - r, yt), stroke: (paint: eg, thickness: 1.2pt))
    draw.line((cx + r, yb), (cx + r, yt), stroke: (paint: eg, thickness: 1.2pt))
    ell(cx, yt, r, 7)
  }
  let hatch(x0, y0, x1, y1, step: 7) = {
    let c = x0 - y1
    while c <= x1 - y0 {
      let ya = calc.max(y0, x0 - c)
      let yb = calc.min(y1, x1 - c)
      if ya < yb {
        draw.line((c + ya, ya), (c + yb, yb), stroke: (paint: black, thickness: 0.8))
      }
      c += step
    }
  }
  cyl(55, 45, 345)
  cyl(160, 45, 352)
  cyl(265, 45, 330)
  draw.line((55, 345), (185, 352), stroke: (paint: blk, thickness: 6))
  draw.line((185, 352), (265, 334), stroke: (paint: blk, thickness: 5))
  draw.line((198, 344), (348, 292), stroke: dl)
  draw.content((330, 306), [BRACE AXIS], anchor: "south")
  draw.line((160, 30), (160, 378), stroke: dl)
  draw.content((160, 20), [SPAR AXIS], anchor: "north")
  draw.line((110, 354), (110, 378), stroke: thin)
  draw.line((142, 354), (142, 378), stroke: thin)
  draw.line((110, 372), (142, 372), stroke: thin, mark: am)
  draw.content((126, 378), [$l$], anchor: "south")
  draw.line((170, 322), (170, 350), stroke: (paint: black, thickness: 1.1),
    mark: (end: "stealth", fill: black, scale: 0.5))
  draw.content((170, 314), [$F$], anchor: "south")
  draw.rect((400, 80), (650, 360), fill: white, stroke: (paint: black, thickness: 1.2))
  hatch(400, 80, 416, 360)
  hatch(634, 80, 650, 360)
  hatch(400, 344, 650, 360)
  hatch(400, 80, 650, 96)
  draw.rect((416, 96), (634, 344), fill: white,
    stroke: (paint: black, thickness: 1.2))
  draw.line((678, 80), (678, 360), stroke: thin, mark: am)
  draw.content((684, 220), [$H$], anchor: "west")
  draw.line((400, 55), (650, 55), stroke: thin, mark: am)
  draw.content((525, 46), [$B$], anchor: "north")
  draw.line((612, 96), (612, 344), stroke: thin, mark: am)
  draw.content((604, 300), [$h$], anchor: "east")
  draw.line((416, 262), (634, 262), stroke: thin, mark: am)
  draw.content((525, 270), [$b$], anchor: "south")
  draw.line((400, 150), (416, 150), stroke: thin,
    mark: (start: "stealth", end: "stealth", fill: black, scale: 0.3))
  draw.content((424, 148), [$t$], anchor: "west")
  draw.line((370, 220), (668, 220), stroke: dl)
  draw.line((525, 58), (525, 267), stroke: dl)
  draw.line((525, 284), (525, 392), stroke: dl)
  draw.line((396, 220), (352, 220), stroke: (paint: black, thickness: 3.2),
    mark: (end: "stealth", fill: black, scale: 0.9))
  draw.content((362, 230), [$M$], anchor: "south")
})
