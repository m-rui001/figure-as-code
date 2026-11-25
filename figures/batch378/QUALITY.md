# Batch 378 quality record

- Source: Machines 2026, 14(1), 91, Figure 5; DOI `10.3390/machines14010091`; CC BY 4.0.
- Reconstruction: Typst 0.15.1 + CeTZ 0.4.2, self-contained vector neuron-PID servo-control diagram.
- The input trajectory includes rise, plateau and fall; both PID controllers contain wired error subtractors.
- The upper encoder measures post-pulse U[k]; velocity and position feedback terminate at their respective minus nodes.
- All three functional blocks contain integral symbols; error labels, controller titles, Pulse out and Tv were repositioned to remove all detected collisions.
- `verify_batch.py`, `verify_text_clearance.py` and `style_audit.py` pass; independent overlap audit reports zero text overlaps and zero connector crossings.
- The renewed PDF review split `Neuron Position PID Controller` onto two lines inside its frame. The remaining e_p/circle path contact is intentional source geometry, not text overflow.
