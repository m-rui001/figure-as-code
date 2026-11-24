# Batch 363 quality record

- Source: Applied Sciences 2024, 14, 877, Figure 4; DOI `10.3390/app14020877`; CC BY 4.0.
- Reconstruction: Typst 0.15.1 + CeTZ 0.4.2, self-contained vector hydraulic schematic.
- Retained both tension cylinders, V1/V2 directions, six pressure sensors, K1–K19, SV1–SV4, A/B/P/T ports, accumulators, relief units, filters, check valves, pump/motor, reservoir and common return.
- Corrective source/render audit found and repaired a missing reservoir, a missing P13–K3 connection, piston rods crossing the sensor row, interrupted P18/P28 verticals, and misplaced K7/K13–K15 return nodes.
- Callouts 1–37 and all K labels were rechecked after the topology repair; labels are no longer used as a proxy for correct connectivity.
- `verify_batch.py`, `verify_text_clearance.py` and `style_audit.py` pass. The independent overlap audit reports zero text overlaps and zero connector crossings.
