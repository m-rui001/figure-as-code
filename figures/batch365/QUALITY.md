# Batch 365 quality record

- Source: Electronics 2024, 13, 1755, Figure 1; DOI `10.3390/electronics13091755`; CC BY 4.0.
- Reconstruction: Typst 0.15.1 + CeTZ 0.4.2, self-contained vector paths, 174 lines, maximum 84 columns.
- Topology retained: two legs and four IGBTs with antiparallel diodes, split DC-link capacitors, three phase-current sensors, LCL branches, damping resistor, three filter capacitors, three grid sources and the neutral point.
- Manual source/render comparison checked current directions, component order, rail connectivity and labels. The DC source, vertical damping resistor and neutral bus were corrected after the first render.
- `verify_batch.py`: passed; single page, no warnings, no raster, source hash and declared label counts verified.
- `verify_text_clearance.py`: passed with no text/line intersections or text-span overlaps.
- `style_audit.py`: zero issues. Visual inspection remains the final fidelity check; the clearance tool does not test curved-path containment.
