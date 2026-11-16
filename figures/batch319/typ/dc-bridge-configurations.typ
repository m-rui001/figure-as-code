#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

// 图名：DC bridge configuration（直流电桥三种接法）
// 来源：Sensors 2025, 25(15), 4726, Figure 12；DOI 10.3390/s25154726
// 结构：并排三幅菱形惠斯通电桥：Quarter-bridge (QB)、Half-bridge (HB)、Full-bridge (FB)。
// 每幅四臂各画斜置电阻，臂上标 $R$ 或 $R + Delta R$；顶部引线接 $U_o$ 上端子，
// 右顶点经竖线接 $U_o$ 下端子并落到下汇流排；下汇流排经 $U_e$ 两端子接左顶点。
// 三幅仅电阻分布不同：QB 一臂变化，HB 两臂变化，FB 四臂全变化。

#let rtxt(t, a) = rotate(a * 1deg, t, reflow: true)

#canvas({
  import draw: *
  let st = 1.1pt + black

  let res(p, a, off, t) = {
    let (cx, cy) = p
    let u = (calc.cos(a * calc.pi / 180), calc.sin(a * calc.pi / 180))
    let v = (-u.at(1), u.at(0))
    let q(du, dv) = (cx + du * u.at(0) + dv * v.at(0), cy + du * u.at(1) + dv * v.at(1))
    draw.line(q(-0.3, -0.1), q(0.3, -0.1), q(0.3, 0.1), q(-0.3, 0.1), close: true,
      stroke: st, fill: white)
    content((cx + off.at(0), cy + off.at(1)), rtxt(text(size: 8pt)[#t], -a))
  }

  let bridge(cx, cy, vals) = {
    let hw = 1.35
    let hh = 1.35
    let tx = cx + hw + 0.85
    let yb = cy - hh - 0.55
    draw.line((cx, cy + hh), (cx + hw, cy), (cx, cy - hh), (cx - hw, cy), close: true,
      stroke: st)
    draw.line((cx, cy + hh), (cx, cy + hh + 0.32), (tx, cy + hh + 0.32), (tx, cy + 0.6), stroke: st)
    draw.circle((tx, cy + 0.55), radius: 0.06, fill: white, stroke: st)
    draw.line((cx + hw, cy), (tx, cy), (tx, cy - 0.49), stroke: st)
    draw.circle((tx, cy - 0.55), radius: 0.06, fill: white, stroke: st)
    draw.line((tx, cy - 0.61), (tx, yb), stroke: st)
    draw.line((cx - hw, cy), (cx - hw, yb), stroke: st)
    draw.line((cx - hw, yb), (cx - 0.45, yb), stroke: st)
    draw.circle((cx - 0.5, yb), radius: 0.06, fill: white, stroke: st)
    draw.circle((cx + 0.5, yb), radius: 0.06, fill: white, stroke: st)
    draw.line((cx + 0.45, yb), (tx, yb), stroke: st)
    content((tx - 0.32, cy + 0.32), text(size: 8.5pt)[$U_o$])
    content((cx, yb - 0.26), text(size: 9pt)[$U_e$])
    res((cx - hw / 2, cy + hh / 2), 45, (-0.48, 0.18), vals.at(0))
    res((cx + hw / 2, cy + hh / 2), -45, (0.48, 0.18), vals.at(1))
    res((cx - hw / 2, cy - hh / 2), -45, (-0.12, -0.62), vals.at(2))
    res((cx + hw / 2, cy - hh / 2), 45, (0.12, -0.62), vals.at(3))
  }

  bridge(2.7, 2.95, ([$R + Delta R$], [$R$], [$R$], [$R$]))
  bridge(7.6, 2.95, ([$R + Delta R$], [$R + Delta R$], [$R$], [$R$]))
  bridge(12.5, 2.95, ([$R + Delta R$], [$R + Delta R$], [$R + Delta R$], [$R + Delta R$]))
  content((2.7, 0.35), [Quarter-bridge (QB)])
  content((7.6, 0.35), [Half-bridge (HB)])
  content((12.5, 0.35), [Full-bridge (FB)])
})
