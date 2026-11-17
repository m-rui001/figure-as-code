# Batch 337 quality review

Source: Krzysztof Sozanski, *Low Cost PID Controller for Student Digital Control
Laboratory Based on Arduino or STM32 Modules*, Electronics 2023, 12(15), 3235.
DOI: https://doi.org/10.3390/electronics12153235 . The paper is CC BY 4.0.
Downloaded original PNGs and SHA256 provenance are in `source/`.

## Converted figures

- Figure 1: `typ/analog-pid-feedback.typ`, analog PID feedback loop.
- Figure 2: `typ/digital-pid-structure.typ`, discrete PID internal structure.

Each is self-contained CeTZ and uses no external image resource. Final previews
are under `render/`, at 180 ppi.

## Verification (2026-11-17)

Run `python -X utf8 tools/verify_batch.py figures/batch337`.
The result in `validation.json` is passed, with complete coverage of both files.
Both compile to PDF and PNG with zero warnings. Each PDF has one page,
zero raster images, and all text bounds inside the page. Original SHA256 hashes,
declared label counts and the 120-column source limit all pass.

Additional structural results are recorded in `render/verification.json`:
Figure 1 has 3 multiplication and 2 summing nodes; Figure 2 has 5 multiplication
and 4 summing nodes and 3 Ts blocks. Maximum source line length is 85 characters.

## Visual review

Both original PNGs were inspected before drawing; both final rendered PNGs were
inspected against them. The final analog figure preserves the controller frame,
proportional bypass, derivative and integral branches, gains, time-domain and
Laplace-domain labels, plant and negative output feedback. The digital figure
preserves the upper proportional path, the negative delayed derivative input,
three Ts blocks, lower integrator recursion, and red sampling-frequency cues.

Review caught and corrected function arguments being absorbed into subscripts,
an ambiguous derivative label, a negative sign too close to its incoming arrow,
and tight spacing between the proportional-path label and controller frame.
Final renders have readable labels, clear branch joins and no clipped content.

## Fidelity limits

Fonts, line thickness, circle diameter and inter-block spacing differ from the
original. Gain ratios use stacked fractions instead of inline slashes. The three
blocks labelled Ts in the source are retained literally, without interpreting
or replacing them with a different delay notation. Structural validation is
not a pixel-similarity score or proof of mathematical correctness of the paper.
