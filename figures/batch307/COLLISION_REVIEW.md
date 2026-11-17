# Collision review: batch307

Date: 2026-11-17. File: `typ/dds-discovery-architectures.typ`.

Status: Reviewed, unchanged.

Viewed all three discovery panels: node names, central Server, EDP tags and captions clear connection paths and borders. EDP attachment boxes intentionally overlap node outlines, without text collisions.

The original 160 ppi render was actually viewed. Any modified render was then
compiled again and actually viewed, including subsequent adjustments.
Final preview: `render/dds-discovery-architectures-collision.png`.

PNG and PDF compilation: zero errors, zero warnings; PDF has one page and all
text bounds are within the page. A comparison of the non-whitespace PDF text
character multisets against HEAD confirms all label characters and counts are
preserved. This character check does not by itself prove connector topology;
layout edits were additionally inspected in the final preview.

The review concerns label collisions in the existing redraw. It does not
certify fidelity to an unavailable original paper figure or all possible scales.
