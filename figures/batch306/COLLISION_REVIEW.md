# Collision review: batch306

Date: 2026-11-17. File: `typ/pneumatic-finger-model.typ`.

Status: Fixed.

Moved local j and r_Si labels above the dashed reference line; labels now clear the dash and each other.

The original 160 ppi render was actually viewed. Any modified render was then
compiled again and actually viewed, including subsequent adjustments.
Final preview: `render/pneumatic-finger-model-collision.png`.

PNG and PDF compilation: zero errors, zero warnings; PDF has one page and all
text bounds are within the page. A comparison of the non-whitespace PDF text
character multisets against HEAD confirms all label characters and counts are
preserved. This character check does not by itself prove connector topology;
layout edits were additionally inspected in the final preview.

The review concerns label collisions in the existing redraw. It does not
certify fidelity to an unavailable original paper figure or all possible scales.
