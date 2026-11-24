#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw
#canvas(length: 0.72cm, {
  import draw: *
  let ink = rgb("#172b3a")
  let blue = rgb("#168bc4")
  let blue-dark = rgb("#0d669a")
  let red = rgb("#e63d3d")
  let edge = (paint: ink, thickness: 0.9pt)
  let arrow-mark = (end: "stealth", fill: red, scale: 0.5)

  let semi(cx, cy, rx, ry, fill, up: true) = {
    let kx = 0.5523 * rx
    let ky = 0.5523 * ry
    let s = if up { 1 } else { -1 }
    bezier((cx - rx, cy), (cx, cy + s * ry), (cx - rx + kx, cy + s * ry), (cx - rx, cy + s * ky),
      fill: fill, stroke: edge, close: true)
    bezier((cx, cy + s * ry), (cx + rx, cy), (cx + rx, cy + s * ky), (cx + kx, cy + s * ry),
      fill: fill, stroke: edge, close: true)
  }

  // 来源：Processes 2025，DOI 10.3390/pr13030924，Figure 1。
  let poly(fill, ..points) = line(..points, fill: fill, stroke: edge, close: true)
  let plate(x, y, w, d, h, fill) = {
    poly(fill, (x, y), (x + w, y), (x + w + d, y + d * 0.45), (x + d, y + d * 0.45))
    poly(rgb("#0d669a"), (x + w, y), (x + w + d, y + d * 0.45),
      (x + w + d, y + d * 0.45 - h), (x + w, y - h))
    poly(fill, (x, y), (x + w, y), (x + w, y - h), (x, y - h))
  }
  let ellipse(cx, cy, rx, ry, fill) = {
    let kx = 0.5523 * rx
    let ky = 0.5523 * ry
    bezier((cx - rx, cy), (cx, cy + ry), (cx - kx, cy + ry), (cx - rx, cy + ky),
      fill: fill, stroke: edge, close: true)
    bezier((cx, cy + ry), (cx + rx, cy), (cx + rx, cy + ky), (cx + kx, cy + ry),
      fill: fill, stroke: edge, close: true)
  }

  // (a) Battery module: six front cells and ten top terminals.
  plate(0.8, 4.1, 6.4, 1.8, 4.3, white)
  for i in range(6) {
    let x = 1.05 + i * 1.02
    rect((x, 0.35), (x + 0.83, 4.05), fill: blue, stroke: white + 1.3pt)
  }
  for row in range(2) {
    for col in range(5) {
      let x = 1.35 + col * 1.18 + row * 0.32
      let y = 4.30 + row * 0.38
      ellipse(x, y, 0.28, 0.16, rgb("#58b7df"))
    }
  }
  content((4.2, -0.65), text(size: 13pt)[(a) Battery module], anchor: "center")

  // (b) Three exploded isometric plates share two partial tabs per plate.
  let bx = 11.0
  plate(bx, 9.4, 8.4, 2.0, 0.48, blue)
  plate(bx + 0.7, 6.3, 8.4, 2.0, 0.28, white)
  plate(bx + 1.4, 3.2, 8.4, 2.0, 0.48, blue)
  for x in (bx + 2.2, bx + 5.4) {
    semi(x, 9.16, 0.35, 0.18, blue-dark, up: false)
  }
  for x in (bx + 3.0, bx + 6.2) {
    semi(x, 7.2, 0.35, 0.18, white, up: true)
  }
  for x in (bx + 3.2, bx + 6.4) {
    semi(x, 3.45, 0.35, 0.18, blue-dark, up: true)
  }

  // Upper and lower arrows convey heat flow in opposite vertical directions.
  for x in (13.5, 16.2, 18.9) {
    line((x, 8.95), (x, 7.25), stroke: red + 1.8pt, mark: arrow-mark)
  }
  for x in (13.5, 16.2, 18.9) {
    line((x, 6.1), (x, 4.15), stroke: red + 1.8pt, mark: arrow-mark)
  }
  for x in (14.2, 16.9, 19.6) {
    line((x, 3.7), (x, 5.35), stroke: red + 1.8pt, mark: arrow-mark)
  }
  content((24.1, 8.2), text(size: 11pt, fill: red)[Heat transfer], anchor: "west")
  content((24.1, 6.3), text(size: 11pt, fill: red)[Heat transfer], anchor: "west")
  content((24.1, 4.8), text(size: 11pt, fill: red)[Heat transfer], anchor: "west")

  // Battery leaders reach both blue plates; the cooling leader reaches the white plate.
  line((21.1, 9.65), (22.2, 10.7), (23.8, 10.7), stroke: edge)
  line((20.9, 3.45), (23.8, 3.45), (23.8, 10.7), stroke: edge)
  content((24.0, 10.7), text(size: 11pt)[Battery], anchor: "west")
  line((21.5, 6.45), (22.3, 2.55), (24.6, 2.55), stroke: edge)
  content((24.8, 2.55), text(size: 10.5pt)[Cooling plate\ (computational unit)], anchor: "west")
  content((16.0, -0.65), text(size: 13pt)[(b) Heat transfer mechanism], anchor: "center")
})
