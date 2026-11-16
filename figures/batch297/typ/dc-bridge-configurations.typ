#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
// 图 12  三种直流电桥配置：四分之一桥、半桥、全桥
// 来源：Sensors 2025, 25, 4726, Figure 12，DOI: 10.3390/s25154726
// 左上臂 R+ΔR 为应变电阻；半桥再增加右上臂，全桥四臂全部为 R+ΔR。
// U_e 为激励电压（下方两空心端），U_o 为输出电压（右侧两空心端）。
// 三组结构复用同一 bridge() 函数，仅四臂阻值标签不同。

#canvas(length: 1cm, {
  import draw: *
  set-style(stroke: (paint: black, thickness: 0.6pt), fill: none)

  // 在菱形一条边上画电阻：先断开导线，再沿边放置小矩形与平行标签
  let arm = (X, p, q, lab, tang) => {
    let mx = (p.at(0) + q.at(0)) / 2
    let my = (p.at(1) + q.at(1)) / 2
    let vx = q.at(0) - p.at(0)
    let vy = q.at(1) - p.at(1)
    let el = calc.sqrt(vx * vx + vy * vy)
    let ux = vx / el
    let uy = vy / el
    let nx = mx / (el / 2)
    let ny = my / (el / 2)
    let rh = 0.44
    let rw = 0.17
    line(X(..p), X(mx - rh * ux, my - rh * uy))
    line(X(mx + rh * ux, my + rh * uy), X(..q))
    line(X(mx - rh * ux + rw * uy, my - rh * uy - rw * ux),
         X(mx + rh * ux + rw * uy, my + rh * uy - rw * ux),
         X(mx + rh * ux - rw * uy, my + rh * uy + rw * ux),
         X(mx - rh * ux - rw * uy, my - rh * uy + rw * ux),
         close: true, fill: white)
    content(X(mx + 0.72 * nx, my + 0.72 * ny),
            text(size: 9pt, lab), angle: tang, anchor: "center")
  }

  // 画一座电桥：dx 为水平位移，ul/ur/lr/ll 为四臂标签，cap 为下方标题
  let bridge = (dx, ul, ur, lr, ll, cap) => {
    let X = (x, y) => (x + dx, y)
    let A = 2.35
    let XO = 3.25
    let YO = 0.62
    let XE = 0.62
    let YE = -3.15

    // 四臂：左上、右上、右下、左下（标签与所在边平行）
    arm(X, (-A, 0), (0, A), ul, 45deg)
    arm(X, (0, A), (A, 0), ur, -45deg)
    arm(X, (A, 0), (0, -A), lr, 45deg)
    arm(X, (0, -A), (-A, 0), ll, -45deg)

    // 激励引线：左右顶点下行后向内折到两个空心端
    line(X(-A, 0), X(-A, YE), X(-XE, YE))
    line(X(A, 0), X(A, YE), X(XE, YE))
    // 输出引线：上下顶点右行后折到右侧两个空心端
    line(X(0, A), X(XO, A), X(XO, YO))
    line(X(0, -A), X(XO, -A), X(XO, -YO))

    // 四个空心端点（白填充圆压住线头，形成开口端子）
    for (px, py) in ((-XE, YE), (XE, YE), (XO, YO), (XO, -YO)) {
      circle(X(px, py), radius: 0.09, fill: white)
    }
    content(X(0, YE - 0.36), text(size: 10pt, [$U_e$]), anchor: "center")
    content(X(XO - 0.46, 0), text(size: 10pt, [$U_o$]), anchor: "center")
    content(X(0, -3.98), text(size: 11pt, cap), anchor: "center")
  }

  bridge(0, [$R + Delta R$], [$R$], [$R$], [$R$], [Quarter-bridge (QB)])
  bridge(6.85, [$R + Delta R$], [$R + Delta R$], [$R$], [$R$], [Half-bridge (HB)])
  bridge(13.7, [$R + Delta R$], [$R + Delta R$], [$R + Delta R$], [$R + Delta R$], [Full-bridge (FB)])
})
