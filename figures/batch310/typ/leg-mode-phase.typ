#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Leg mode phase — 六腿轮机器人侧视相位示意图（仅线稿）
// 来源：Electronics 2026, 15, 3747, Figure 4(a)；DOI 10.3390/electronics15163747
// 结构：水平机架梁上三个曲柄三角组，每组经斜腿杆接左右车轮；
//       虚线 = 摆动相（轮 1,4,5），实线 = 支撑相（轮 2,3,6）。
#canvas(length: 0.75cm, {
  import draw: *
  let sol = (paint: black, thickness: 0.9pt)
  let das = (paint: black, thickness: 0.9pt, dash: "densely-dashed")
  let beamY = 4.2
  let wheelY = 1.4
  let wr = 0.64
  // 机架：两条平行细线 + 端部封口
  draw.line((0.6, beamY + 0.14), (13.4, beamY + 0.14), stroke: 0.7pt)
  draw.line((0.6, beamY - 0.14), (13.4, beamY - 0.14), stroke: 0.7pt)
  draw.line((0.6, beamY + 0.14), (0.6, beamY - 0.14), stroke: 0.7pt)
  draw.line((13.4, beamY + 0.14), (13.4, beamY - 0.14), stroke: 0.7pt)
  // 曲柄三角：hub 处三根杆 + 外轮廓，st 指定实/虚描边
  let tri(hx, p, q, r, st) = {
    draw.line((hx, beamY), p, stroke: st)
    draw.line((hx, beamY), q, stroke: st)
    draw.line((hx, beamY), r, stroke: st)
    draw.line(p, q, stroke: st)
    draw.line(q, r, stroke: st)
    draw.line(r, p, stroke: st)
  }
  let hubs = (2.2, 6.4, 10.6)
  let dashes = ((das, sol), (sol, das), (das, sol))
  let nums = ("1", "2", "3", "4", "5", "6")
  for k in range(3) {
    let hx = hubs.at(k)
    let dl = dashes.at(k).at(0)
    let dr = dashes.at(k).at(1)
    // 实线曲柄三角（当前姿态），尖端 a1 经短连杆接梁下缘
    let a1 = (hx + 1.05 * calc.cos(55deg), beamY + 1.05 * calc.sin(55deg))
    let b1 = (hx - 0.55, beamY)
    let c1 = (hx + 0.75 * calc.cos(293deg), beamY + 0.75 * calc.sin(293deg))
    tri(hx, a1, b1, c1, sol)
    draw.line(a1, (hx + 0.5, beamY - 0.14), stroke: sol)
    // 虚线曲柄三角（摆角极限）
    let a2 = (hx + 1.05 * calc.cos(130deg), beamY + 1.05 * calc.sin(130deg))
    let b2 = (hx + 0.55 * calc.cos(255deg), beamY + 0.55 * calc.sin(255deg))
    let c2 = (hx + 0.75 * calc.cos(8deg), beamY + 0.75 * calc.sin(8deg))
    tri(hx, a2, b2, c2, das)
    // 左右腿杆、车轮与编号
    let wxs = (hx - 1.0, hx + 1.0)
    let sts = (dl, dr)
    for j in range(2) {
      let wx = wxs.at(j)
      let st = sts.at(j)
      // 腿杆止于轮缘：由轮心指向 hub 的单位向量取 wr 处
      let dx = hx - wx
      let dy = beamY - wheelY
      let dn = calc.sqrt(dx * dx + dy * dy)
      draw.line((hx, beamY), (wx + wr * dx / dn, wheelY + wr * dy / dn), stroke: st)
      draw.circle((wx, wheelY), radius: wr, stroke: st)
      draw.content((wx, wheelY - wr - 0.42), text(nums.at(2 * k + j), size: 8pt))
    }
  }
  // 图下文字
  draw.content((7.0, -1.15), text("Set 1 = {1, 3, 5}    Set 2 = {2, 4, 6}"))
  draw.content((7.0, -2.05), text("(a) Schematic diagram of side view"))
})
