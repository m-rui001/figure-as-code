# Collision review: batch313

Date: 2026-11-17. File: `typ/exoskeleton-control-diagram.typ`.

Status: Fixed.

Extended motor-control boxes downward; placed feedback-angle labels in the new bottom strip away from feedback wires and lower borders. Enlarged both release diamonds and reduced condition font; moved their connector/merge/Stop geometry consistently. Rechecked text padding.

The original 160 ppi render was actually viewed. Any modified render was then
compiled again and actually viewed, including subsequent adjustments.
Final preview: `render/exoskeleton-control-diagram-collision.png`.

PNG and PDF compilation: zero errors, zero warnings; PDF has one page and all
text bounds are within the page. A comparison of the non-whitespace PDF text
character multisets against HEAD confirms all label characters and counts are
preserved. This character check does not by itself prove connector topology;
layout edits were additionally inspected in the final preview.

The review concerns label collisions in the existing redraw. It does not
certify fidelity to an unavailable original paper figure or all possible scales.
