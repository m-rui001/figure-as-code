# Batch 363 quality record

- Source: Applied Sciences 2024, 14, 877, Figure 4; DOI `10.3390/app14020877`; CC BY 4.0.
- Reconstruction: Typst 0.15.1 + CeTZ 0.4.2, self-contained vector hydraulic schematic.
- Retained both tension cylinders, V1/V2 directions, six pressure sensors, K1–K19, SV1–SV4, A/B/P/T ports, accumulators, relief units, filters, check valves, pump/motor and common return.
- Manual comparison confirmed callouts 1–37 and the left/right independent return circuits; exact PDF-text checks find every K label and callout once.
- Main-agent clearance repair moved leaders to component edges, separated K12/K16, routed callout 26 around the sensor row and relocated labels away from grounds and connectors.
- `verify_batch.py`, `verify_text_clearance.py` and `style_audit.py` pass. The independent overlap audit reports zero text overlaps and zero connector crossings.
