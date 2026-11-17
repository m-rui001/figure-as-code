# Collision review — batches216–221 (2026-11-17)

Viewed all six actual 140-ppi PNG renders.
216: both Igniter PPU labels touched their green side frames. Reduced only these
labels from 9 to 7.5 pt. Recompiled without warnings and viewed the final 180-ppi
whole render; both labels now have visible side padding.
The enlarged preview also exposed the Insulator leader crossing Cathode text.
Routed it around the left side of the cathode frame to the insulator's left edge.
Viewed the final 180-ppi render and confirmed the leader clears the text.
217: inspected nozzle, regulator and valve labels; no change this pass.
218: inspected force, orbit and sunlight labels; no change this pass.
219: inspected density labels, reaction layer and heat-flow labels; no change this pass.
220: inspected classification nodes and connection endpoints; no change this pass.
221: inspected adhesive-arm and spring leaders; no change this pass. Its existing
unknown liberation-serif font warning remains, so this pass is not warning-free.

These findings describe the inspected renders, not universal collision freedom.
