#set page(width: auto, height: auto, margin: 6pt)
#set text(font: ("Arial", "Segoe UI"), size: 10pt)
#import "@preview/cetz:0.4.2": canvas, draw

#canvas(length: 1cm, {
  import draw: *

  let ink = black
  let wire = (paint: ink, thickness: 0.75pt)
  let dashed = (paint: ink, thickness: 0.75pt, dash: "dashed")
  let head = (end: "stealth", fill: ink, scale: 0.48)
  let tower-x = (3.2, 7.4)
  let pump-x = 12.25
  let return-x = 13.55
  let branch-y = (14.0, 12.25, 10.5, 8.75, 7.0)

  let label(body, at) = content(at, align(center, body), anchor: "center")
  let flow(a, b) = line(a, b, stroke: wire, mark: head)

  let tower(body, bottom) = {
    let top = bottom + 2.15
    rect((3.2, bottom), (7.4, top), stroke: dashed)
    line((3.65, top - 0.58), (4.12, top - 0.20), (4.59, top - 0.58), stroke: wire)
    line((5.55, top - 0.58), (6.02, top - 0.20), (6.49, top - 0.58), stroke: wire)
    line((4.12, top - 0.20), (4.40, top - 0.49), stroke: wire)
    line((6.02, top - 0.20), (6.30, top - 0.49), stroke: wire)
    label(body, (5.3, bottom + 0.55))
  }

  let pump(at, direction: "right", check: false) = {
    circle(at, radius: 0.43, stroke: dashed)
    let (x, y) = at
    let s = if direction == "right" { 1 } else { -1 }
    line((x - s * 0.08, y + 0.23), (x + s * 0.25, y),
      (x - s * 0.08, y - 0.23), (x - s * 0.08, y + 0.23), stroke: wire)
    if check {
      line((x - 0.31, y - 0.23), (x - 0.31, y + 0.23), stroke: wire)
      line((x - 0.31, y), (x - 0.08, y + 0.23), stroke: wire)
    }
  }

  let chiller(body, y) = {
    rect((6.45, y - 0.36), (11.05, y + 0.36), fill: white, stroke: wire)
    rect((6.72, y + 0.36), (10.78, y + 0.62), fill: white, stroke: wire)
    line((6.78, y - 0.36), (6.78, y - 0.50), stroke: wire)
    line((7.20, y - 0.36), (7.20, y - 0.50), stroke: wire)
    line((10.30, y - 0.36), (10.30, y - 0.50), stroke: wire)
    line((10.72, y - 0.36), (10.72, y - 0.50), stroke: wire)
    label(body, (8.75, y))
  }

  // Outer enclosure and the two circulating headers.
  rect((0.35, 0.25), (16.05, 28.0), stroke: dashed)
  line((1.15, 16.25), (15.25, 16.25), stroke: dashed)
  line((1.15, 16.25), (1.15, 10.5), stroke: dashed)
  flow((5.0, 10.5), (1.28, 10.5))
  line((15.25, 27.15), (15.25, 1.75), stroke: dashed)
  flow((15.02, 1.75), (11.85, 1.75))

  // Cooling-tower bank: three named towers represent all nine units.
  tower([Cooling tower 1], 25.0)
  tower([Cooling tower 2], 21.95)
  label([. . . . . .], (5.3, 20.95))
  tower([Cooling tower 9], 18.25)
  line((8.45, 26.075), (8.45, 18.825), stroke: dashed)
  for y in (26.075, 23.025, 19.325) {
    line((7.4, y), (8.45, y), stroke: dashed)
  }

  // Four parallel pumps between the tower header and condenser-water return.
  rect((9.65, 18.15), (13.15, 25.65), stroke: dashed)
  line((9.65, 24.7), (9.65, 19.55), stroke: dashed)
  line((13.15, 24.7), (13.15, 19.55), stroke: dashed)
  for y in (24.7, 23.35, 22.0, 20.65) {
    line((9.65, y), (13.15, y), stroke: dashed)
    pump((11.4, y), direction: "left")
  }
  line((13.15, 19.55), (15.25, 19.55), stroke: dashed)
  line((8.45, 22.0), (9.65, 22.0), stroke: dashed)
  flow((9.65, 22.0), (8.45, 22.0))
  label([Pump], (11.4, 17.55))

  // Chilled-water supply and return headers.
  line((5.0, 16.25), (5.0, 7.0), stroke: dashed)
  line((return-x, 14.0), (return-x, 7.0), stroke: dashed)
  line((return-x, 16.25), (return-x, 14.0), stroke: dashed)
  for y in branch-y {
    line((5.0, y), (6.45, y), stroke: dashed)
    line((11.05, y), (11.82, y), stroke: dashed)
    line((12.68, y), (return-x, y), stroke: dashed)
  }

  // Each chiller has a dedicated pump/check-valve assembly.
  for (body, y) in ([Chiller 1], [Chiller 2], [Chiller 3], [Chiller 4], [Chiller 5])
    .zip(branch-y) {
    chiller(body, y)
    pump((pump-x, y), check: true)
  }
  flow((return-x, 10.5), (15.02, 10.5))
  label([Pump], (pump-x, 5.95))

  // User supply from the left header and return up the right-hand riser.
  line((5.0, 7.0), (5.0, 1.75), stroke: dashed)
  flow((5.0, 1.75), (7.73, 1.75))
  rect((7.75, 0.75), (11.85, 2.75), fill: white, stroke: wire)
  label([User], (9.8, 1.75))
  flow((11.85, 1.75), (15.02, 1.75))
})
