# Batch 374 quality record

- Source: Machines 2025, 13(4), 334, Figure 1; DOI `10.3390/machines13040334`; CC BY 4.0.
- Reconstruction: Typst 0.15.1 + CeTZ 0.4.2, self-contained vector MomentumNet-CD and DAQ architecture.
- Preserved the observer feedback, four-stage feature cycle and two one-way normalization-to-distance arcs.
- Restored the source momentum equation with both velocity factors and the minus sign before G(q).
- Dynamics titles are split and sized to stay inside their region; feature-cycle labels remain inside their ellipses.
- Restored the complete 3-3-1 fully connected neural network and its external iteration return.
- Rechecked every DAQ endpoint, direction and owning port; the isolator output enters Signal Conditioning, while its lower output enters the servo driver.
- The differential-conversion output enters the servo driver at its left edge; MOS FET output reaches the motor top.
- `verify_batch.py`, `verify_text_clearance.py` and `style_audit.py` pass; independent overlap audit reports zero text overlaps and zero connector crossings.
- The renewed PDF audit kept `Dynamics Model Construction` inside its dashed region, enlarged the four feature ellipses, moved `Feature Extraction` off the ellipse, and split the lower control/signal-conditioning labels to remove tight or overflowing text.
