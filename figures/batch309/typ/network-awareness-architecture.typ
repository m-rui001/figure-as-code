#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图名：Differences in network awareness structure（网络感知结构差异对比）
// 来源：Drones 2025, 9(8), 564, Figure 5；DOI: 10.3390/drones9080564
// 结构：左右两栏 (a) Existing / (b) Network awareness 架构，自下而上分
// Application / DDS Domain / RTPS Domain / Transport / Physical 五层；
// (b) 栏在 DDS/RTPS 层增加虚线 Network Monitor、Passive Filter 及 RSSI 连线。
// RSSI 只从 Network Monitor 向下送入 Passive Filter，不跨物理层。
#canvas(length: 0.6pt, {
  import draw: *
  let mk = (end: "stealth", fill: black, scale: 0.45)
  let arr(a, b, dash: none) = line(a, b, stroke: (paint: black, thickness: 1pt, dash: dash), mark: mk)
  let darr(a, b) = line(a, b, stroke: (paint: black, thickness: 1pt),
    mark: (start: "stealth", end: "stealth", fill: black, scale: 0.45))
  let rbox(x1, y1, x2, y2, f, s, lbl, r: 5) = {
    rect((x1, y1), (x2, y2), fill: f, stroke: (paint: s, thickness: 1pt), radius: r * 1pt)
    content(((x1 + x2) / 2, (y1 + y2) / 2), lbl, size: 8pt)
  }
  let pink = rgb("#f9c7ca")
  let pinkS = rgb("#c0504d")
  let blue = rgb("#c9d9f0")
  let blueS = rgb("#7396c9")
  let green = rgb("#c8e2c8")
  let greenS = rgb("#7ba87b")
  let orange = rgb("#fcd6b3")
  let orangeS = rgb("#e0962f")
  let grey = rgb("#efefef")
  let greyS = rgb("#999999")
  let col(x0, b) = {
    for y in (838, 595, 412, 285, 215, 90) {
      line((x0 + 40, y), (x0 + 770, y), stroke: (paint: black, thickness: 1.5pt))
    }
    content((x0 + 85, 897), [Application], size: 8.5pt)
    content((x0 + 85, 720), [DDS \ Domain], size: 8.5pt)
    content((x0 + 85, 505), [RTPS \ Domain], size: 8.5pt)
    content((x0 + 85, 348), [Transport], size: 8.5pt)
    content((x0 + 85, 150), [Physical], size: 8.5pt)
    rbox(x0 + 130, 872, x0 + 760, 922, pink, pinkS, [User Code])
    rbox(x0 + 130, 622, x0 + 760, 805, blue, blueS, none, r: 12)
    content((x0 + 445, 782), [Domain Participant], size: 8pt)
    let px = if b { (330, 510) } else { (180, 360) }
    let sx = if b { (560, 742) } else { (430, 612) }
    let dw = if b { (345, 495) } else { (195, 345) }
    let dr = if b { (575, 725) } else { (445, 595) }
    let dwx = if b { 420 } else { 270 }
    let drx = if b { 650 } else { 520 }
    rbox(x0 + px.first(), 638, x0 + px.last(), 742, white, black, none)
    content((x0 + (px.first() + px.last()) / 2, 722), [Publisher], size: 8pt)
    rbox(x0 + sx.first(), 638, x0 + sx.last(), 742, white, black, none)
    content((x0 + (sx.first() + sx.last()) / 2, 722), [Subscriber], size: 8pt)
    rbox(x0 + dw.first(), 660, x0 + dw.last(), 698, white, black, [DataWriter])
    rbox(x0 + dr.first(), 660, x0 + dr.last(), 698, white, black, [DataReader])
    darr((x0 + dw.last(), 679), (x0 + dr.first(), 679))
    content((x0 + (dw.last() + dr.first()) / 2, 652), [Topic], size: 7.5pt)
    rbox(x0 + 130, 440, x0 + 760, 562, green, greenS, none, r: 12)
    content((x0 + 445, 540), [RTPS Participant], size: 8pt)
    rbox(x0 + px.first(), 455, x0 + px.last(), 515, white, black, [RTPSWriter])
    rbox(x0 + sx.first(), 455, x0 + sx.last(), 515, white, black, [RTPSReader])
    rbox(x0 + 130, 320, x0 + 760, 375, orange, orangeS, [UDP/TCP/SHM])
    rbox(x0 + 130, 120, x0 + 760, 178, grey, greyS, [RF Receiver])
    arr((x0 + dwx, 872), (x0 + dwx, 698))
    arr((x0 + drx, 698), (x0 + drx, 872))
    arr((x0 + dwx, 660), (x0 + dwx, 515))
    arr((x0 + drx, 455), (x0 + drx, 660))
    arr((x0 + dwx, 455), (x0 + dwx, 375))
    arr((x0 + drx, 375), (x0 + drx, 455))
    content((x0 + 445, 248), [⋮], size: 11pt)
    if b {
      rect((x0 + 150, 638), (x0 + 290, 742), fill: white,
        stroke: (paint: black, thickness: 1.2pt, dash: "densely-dashed"), radius: 6pt)
      content((x0 + 220, 714), [Network \ Monitor], size: 7.5pt)
      rect((x0 + 160, 648), (x0 + 280, 684), fill: white,
        stroke: (paint: black, thickness: 1pt, dash: "densely-dashed"), radius: 4pt)
      content((x0 + 220, 666), [Passive Timer], size: 7pt)
      line((x0 + 270, 178), (x0 + 270, 638), stroke: (paint: black, thickness: 1pt), mark: mk)
      rect((x0 + 150, 455), (x0 + 290, 515), fill: white,
        stroke: (paint: black, thickness: 1.2pt, dash: "densely-dashed"), radius: 6pt)
      content((x0 + 215, 485), [Passive Filter], size: 7.5pt)
      arr((x0 + 175, 638), (x0 + 175, 515), dash: "densely-dashed")
      arr((x0 + 210, 455), (x0 + 210, 375))
      arr((x0 + px.first(), 485), (x0 + 290, 485))
      content((x0 + 185, 600), [RSSI], size: 7.5pt, anchor: "west")
    }
    let tag = if b { [(b)] } else { [(a)] }
    content((x0 + 405, 20), text(weight: "bold", size: 12pt, tag))
  }
  col(0, false)
  col(900, true)
})
