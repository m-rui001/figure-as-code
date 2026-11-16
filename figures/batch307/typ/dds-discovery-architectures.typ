#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Three main discovery architectures of DDS
// 来源：Drones 2025, 9(8), 564, Figure 3；DOI: 10.3390/drones9080564
// 结构：横向三联图，每图四椭圆节点 Node 1-4，底部粗体子图标题
// (a) Simple 全连接双向实线箭头；(b) Server 中央圆柱数据库四向星形箭头
// (c) Static 全连接双向虚线箭头，四角外侧浅蓝 EDP 方框
// 实线表示 PDP+EDP 完整发现，虚线表示仅 PDP；Server 图中央圆柱为发现服务器

#canvas({
  import draw: *
  let ex = 1.6
  let ey = 0.72
  let thin = 0.8pt + black
  let solid = 0.85pt + black
  let dashed = (thickness: 0.85pt, dash: "densely-dashed", paint: black)
  let dual = (start: "stealth", end: "stealth", fill: black, scale: 0.5)
  let single = (end: "stealth", fill: black, scale: 0.5)
  let arcpts(c, rx, ry, a0, a1, n: 48) = range(n + 1).map(k => {
    let a = (a0 + (a1 - a0) * k / n) * calc.pi / 180
    (c.at(0) + rx * calc.cos(a), c.at(1) + ry * calc.sin(a))
  })
  let nodes(ox) = ((ox - 2.45, 1.55), (ox + 2.45, 1.55), (ox - 2.45, -1.55), (ox + 2.45, -1.55))
  let pairs = ((0, 1), (2, 3), (0, 2), (1, 3), (0, 3), (1, 2))
  let edge(c, t) = {
    let dx = t.at(0) - c.at(0)
    let dy = t.at(1) - c.at(1)
    let k = 1 / calc.sqrt((dx / ex) * (dx / ex) + (dy / ey) * (dy / ey))
    (c.at(0) + dx * k, c.at(1) + dy * k)
  }
  let node(c, n) = {
    line(..arcpts(c, ex, ey, 0, 360), stroke: thin)
    content(c, text(size: 9.5pt, "Node " + str(n)))
  }
  let link(a, b, s) = line(edge(a, b), edge(b, a), stroke: s, mark: dual)
  let cap(ox, s) = content((ox, -2.75), text(size: 10.5pt, weight: "bold", s))

  let a = nodes(0)
  for (i, j) in pairs { link(a.at(i), a.at(j), solid) }
  for (i, c) in a.enumerate() { node(c, i + 1) }
  cap(0, "Simple Discovery")

  let ox = 9.0
  let b = nodes(ox)
  let srx = 0.75
  let sry = 0.26
  let shh = 0.42
  let top = shh + sry
  for (i, c) in b.enumerate() { node(c, i + 1) }
  line(..arcpts((ox, top), srx, sry, 0, 360), stroke: thin)
  line((ox - srx, top), (ox - srx, -shh), stroke: thin)
  line((ox + srx, top), (ox + srx, -shh), stroke: thin)
  line(..arcpts((ox, -shh), srx, sry, 180, 360), stroke: thin)
  content((ox, 0.08), text(size: 8.5pt, weight: "bold", "Server"))
  line((ox - srx, 0), (ox - 1.95, 0), (ox - 1.95, 0.87), stroke: solid, mark: dual)
  line((ox, top), (ox, 1.0), (ox + 1.42, 1.0), stroke: solid, mark: dual)
  line((ox + srx, 0), (ox + 1.95, 0), (ox + 1.95, -0.87), stroke: solid, mark: dual)
  line((ox, -shh), (ox, -1.0), (ox - 1.42, -1.0), stroke: solid, mark: dual)
  cap(ox, "Server Discovery")

  let ox = 18.0
  let q = nodes(ox)
  for (i, j) in pairs { link(q.at(i), q.at(j), dashed) }
  for (i, c) in q.enumerate() { node(c, i + 1) }
  let epts = ((-3.55, 2.45), (3.55, 2.45), (-3.55, -2.45), (3.55, -2.45))
  for (dx, dy) in epts {
    let c = (ox + dx, dy)
    let hw = 0.62
    let hh = 0.38
    rect((c.at(0) - hw, c.at(1) - hh), (c.at(0) + hw, c.at(1) + hh),
      stroke: 0.6pt + black, fill: rgb("#dce6f5"))
    content(c, text(size: 8.5pt, weight: "bold", "EDP"))
  }
  cap(ox, "Static Discovery")
})
