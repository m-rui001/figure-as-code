# Collision review: batch309

Date: 2026-11-17. File: `typ/network-awareness-architecture.typ`.

Status: Fixed.

Moved Domain/RTPS Participant titles into free horizontal space. Put Publisher/Subscriber titles left of the vertical arrows with padding and smaller text. Stopped the RTPSReader upward arrow at its top boundary instead of drawing through its text. Routed RF-to-monitor connection around Passive Filter and transport title, and moved RSSI above the separator. No white patches hide structural lines.

The original 160 ppi render was actually viewed. Any modified render was then
compiled again and actually viewed, including subsequent adjustments.
Final preview: `render/network-awareness-architecture-collision.png`.

PNG and PDF compilation: zero errors, zero warnings; PDF has one page and all
text bounds are within the page. A comparison of the non-whitespace PDF text
character multisets against HEAD confirms all label characters and counts are
preserved. This character check does not by itself prove connector topology;
layout edits were additionally inspected in the final preview.

The review concerns label collisions in the existing redraw. It does not
certify fidelity to an unavailable original paper figure or all possible scales.
