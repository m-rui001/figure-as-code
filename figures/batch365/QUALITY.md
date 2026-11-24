# Batch 365 quality record

- Source: Electronics 2024, 13, 1755, Figure 1; DOI `10.3390/electronics13091755`; CC BY 4.0.
- Reconstruction: Typst 0.15.1 + CeTZ 0.4.2, self-contained vector paths.
- Corrective source/render audit found a DC-source rail short, a wrong phase-c node, misplaced capacitor midpoints, continuous wires shorting series components, and two omitted damping resistors.
- The circuit was rebuilt node by node: phase a leaves the left upper midpoint, phase b the right midpoint, and phase c the left lower midpoint; a/c crossings use bridge arcs.
- The two C branches are in series across the DC rails with their midpoint on phase b; all three damping branches contain a resistor and Cf and share the lower bus.
- Resistor/inductor/current-sensor paths are segmented so components remain in series; the three grid sources return to the neutral bus.
- `verify_batch.py`, `verify_text_clearance.py` and `style_audit.py` pass. The independent overlap audit reports zero text overlaps and zero connector crossings.
