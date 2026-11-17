# Batch 340 quality review

Source: Shuangshuang Chen and Wei Guo, *Auto-Encoders in Deep Learning--A Review
with New Perspectives*, Mathematics 2023, 11, 1777.
DOI: https://doi.org/10.3390/math11081777 . Original paper is CC BY 4.0.
Figure 1 is on page 3; Figure 2 is on page 14. Source images, complete paper and
SHA256 retrieval records are retained under `source/`.

## Converted figures

- `typ/basic-autoencoder.typ`: Figure 1, six inputs, four feature units, six
  reconstruction units, and two bias units. The 7-to-4 and 5-to-6 layer connections
  reproduce 28 encoder edges and 30 decoder edges. Arrow endpoints are calculated
  at circle boundaries, and white neuron interiors protect their labels.
- `typ/variational-autoencoder-flow.typ`: Figure 2, encoder, two distribution
  outputs, random sample, multiplication/addition operations, code, decoder,
  reconstruction and four numbered steps.

## Verification (2026-11-17)

`python -X utf8 tools/verify_batch.py figures/batch340` passes. `validation.json`
records full coverage, correct original SHA256s, successful compilation with
zero warnings, a single page per figure, no embedded rasters, all text bounds
inside the page, declared label counts, and source lines at most 120 columns.
PNG previews at 180 ppi and PDF renders are retained in `render/`.

Both original images were inspected before conversion; both final previews were
visually compared with them. All neuron labels and the two bias labels are
readable. Connections terminate at node boundaries; intentional network edge
crossings match the dense original. VAE labels fit inside their blocks, and
sampling, parameter, multiplication, addition and decoder arrows preserve
the original direction. The first VAE render had cramped sample text; reducing
that label's font size restored side padding and the updated preview was reviewed.

## Fidelity limits

Font faces, stroke widths and relative spacing differ. The VAE step-label dotted
orange texture is replaced with plain pale orange. Figure 2's encoder subscript
is a missing-glyph square in the downloaded original image; this redraw uses
phi, resolved from the surrounding paper's definition of q_phi(z|x) on pages
13--14. This is an explicit glyph repair. The source figure sends z_log_var
directly to multiplication without an exponential block; the redraw preserves
that schematic rather than inserting a mathematically inferred operation.
Machine checks verify structure and labels, not pixel similarity or the
mathematical correctness of the source schematic.
