# Collision review: batch308

Date: 2026-11-17. File: `typ/h2-dryer-schematic.typ`.

Status: Fixed.

Reduced cartridge-title font from 12pt to 10.5pt for side padding. Expanded the outer dashed frame leftward and downward; moved H2 in away from it. Rechecked both cartridge titles and input pressure sensor.

The original 160 ppi render was actually viewed. Any modified render was then
compiled again and actually viewed, including subsequent adjustments.
Final preview: `render/h2-dryer-schematic-collision.png`.

PNG and PDF compilation: zero errors, zero warnings; PDF has one page and all
text bounds are within the page. A comparison of the non-whitespace PDF text
character multisets against HEAD confirms all label characters and counts are
preserved. This character check does not by itself prove connector topology;
layout edits were additionally inspected in the final preview.

The review concerns label collisions in the existing redraw. It does not
certify fidelity to an unavailable original paper figure or all possible scales.
