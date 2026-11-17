# Collision review: batch318

Date: 2026-11-17. File: `typ/agri-sensing-architecture.typ`.

Status: Fixed.

Moved and reduced the four-line local-processing label; reduced Python Routines to fit inside its box. Narrowed MLX90614 font and extended the acquisition panel below LiDAR. Reduced/repositioned MAVLink and Telemetry to fit between communication and ground-station edges. Rechecked all adjacent labels.

The original 160 ppi render was actually viewed. Any modified render was then
compiled again and actually viewed, including subsequent adjustments.
Final preview: `render/agri-sensing-architecture-collision.png`.

PNG and PDF compilation: zero errors, zero warnings; PDF has one page and all
text bounds are within the page. A comparison of the non-whitespace PDF text
character multisets against HEAD confirms all label characters and counts are
preserved. This character check does not by itself prove connector topology;
layout edits were additionally inspected in the final preview.

The review concerns label collisions in the existing redraw. It does not
certify fidelity to an unavailable original paper figure or all possible scales.
