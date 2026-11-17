#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Control diagram of the exoskeleton（外骨骼控制流程图）
// 来源：Technologies 2025, 13(10), 463, Figure 14；DOI 10.3390/technologies13100463
// 结构：Start→Home position→Button pressed 菱形分流；左右支路各含求和圆、PID、
//       Motor 与角度反馈，末端 Button released 菱形汇合到 Stop。
// 左腿相对右腿偏置 180°，两腿各由 12 VDC 电机驱动。
// 坐标采用 y 向下的页面坐标，便于按流程图自上而下排布。
#canvas({
  import draw: *
  let H = 14.0
  let q(x, y) = (x, H - y)
  let st = 0.9pt + black
  let mk = (end: "stealth", fill: black, scale: 0.45)
  let arr(a, b) = line(q(a.at(0), a.at(1)), q(b.at(0), b.at(1)), stroke: st, mark: mk)
  let ln(a, b) = line(q(a.at(0), a.at(1)), q(b.at(0), b.at(1)), stroke: st)
  let box(x, y, w, h, body, fill: white) = {
    rect(q(x, y), q(x + w, y + h), fill: fill, stroke: st)
    content(q(x + w / 2, y + h / 2), body)
  }
  let oval(cx, cy, w, h, body) = {
    rect(q(cx - w / 2, cy - h / 2), q(cx + w / 2, cy + h / 2),
      radius: h / 2 * 1cm, fill: rgb("#999999"), stroke: st)
    content(q(cx, cy), body)
  }
  let dmd(cx, cy, hw, hh, body) = {
    let p = ((cx, cy - hh), (cx + hw, cy), (cx, cy + hh), (cx - hw, cy))
    for i in range(4) { ln(p.at(i), p.at(calc.rem(i + 1, 4))) }
    content(q(cx, cy), body)
  }
  // 顶部主流程
  oval(10, 0.55, 2.6, 0.7, [Start])
  arr((10, 0.9), (10, 1.5))
  box(8.8, 1.5, 2.4, 0.95, [Home \ position])
  arr((10, 2.45), (10, 2.95))
  dmd(10, 3.55, 2.6, 0.62, [Button pressed])
  arr((12.6, 3.55), (14.3, 3.55))
  dmd(16.2, 3.55, 1.9, 0.62, [$theta_(g r) > 180°$])
  arr((10, 4.17), (10, 4.7))
  arr((16.2, 4.17), (16.2, 4.7))
  // 左右控制框
  let branch(bx, title, fb, inp) = {
    let w = 6.6
    rect(q(bx, 4.7), q(bx + w, 8.0), fill: white, stroke: st)
    box(bx, 4.7, w, 0.55, title, fill: rgb("#b3b3b3"))
    circle(q(bx + 1.2, 6.15), radius: 0.5, stroke: st)
    content(q(bx + 1.0, 5.85), [+], size: 9pt)
    content(q(bx + 1.35, 6.5), [−], size: 9pt)
    box(bx + 2.0, 5.8, 1.45, 0.7, [PID])
    box(bx + 4.15, 5.8, 1.65, 0.7, [Motor])
    arr((bx + 1.75, 6.15), (bx + 2.0, 6.15))
    arr((bx + 3.45, 6.15), (bx + 4.15, 6.15))
    content(q(bx + 3.8, 6.0), [T], size: 9pt)
    ln((bx + 5.8, 6.15), (bx + 6.2, 6.15))
    ln((bx + 6.2, 6.15), (bx + 6.2, 7.25))
    ln((bx + 6.2, 7.25), (bx + 1.2, 7.25))
    arr((bx + 1.2, 7.25), (bx + 1.2, 6.65))
    content(q(bx + 3.6, 7.62), fb, size: 8pt)
    arr((bx - 0.8, 6.15), (bx + 0.7, 6.15))
    content(q(bx - 0.8, 6.55), inp)
    arr((bx + w / 2, 8.0), (bx + w / 2, 8.3))
    dmd(bx + w / 2, 9.15, 2.55, 0.88,
      [Button released \ & #fb $= 0°$])
  }
  branch(0.2, [Right leg motor starts], [$theta_(g r)$], [$theta_d$])
  branch(12.0, [Left leg motor starts], [$theta_(g l)$], [$theta_d + 180°$])
  // 汇合到 Stop
  ln((3.5, 10.03), (3.5, 10.65))
  ln((15.3, 10.03), (15.3, 10.65))
  ln((15.3, 10.65), (3.5, 10.65))
  arr((3.5, 10.65), (10, 10.65))
  arr((10, 10.65), (10, 11.2))
  oval(10, 11.8, 2.6, 0.75, [Stop])
})
