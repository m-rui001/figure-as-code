# Collision review — batches149–155 (2026-11-17)

Five sources exist in this interval:149,150,151,152,155.
Viewed all five actual 140-ppi renders.
150: the node helper passed size and weight to CeTZ content rather than applying
them to the text. Multiple multiline labels consequently touched their frames.
Applied explicit text(size: fs, weight: ...) within the helper, preserving labels,
coordinates and all category edges. Viewed the final 200-ppi whole render;
two-line category text now clears its node frames.
149: inspected roadmap titles and transitions; no change this pass.
151: inspected regulator, heating and exhaust labels; no change this pass.
152: inspected feed, spool and extruder labels; no change this pass.
155: inspected mirror, photon and platform leaders; no change this pass.

The corrected source compiles without warnings. These scoped observations do not
certify universal collision freedom.
