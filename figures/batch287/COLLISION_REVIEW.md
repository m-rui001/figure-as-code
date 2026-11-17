# Collision review — batches282–287 (in progress)

All nine actual PNG renders in these six batches were viewed at 140 ppi.
The LSTM-DDPG framework had Update labels touching network borders and a cramped
Gradient/formula pair. Applied explicit 7-pt text and adjusted the update labels.
Recompiled at 160 ppi and viewed the corrected whole image; these contacts are resolved.

Further review remains open for ADRC parameter arrows, the transformer feature
encoding boxes and small equations. Initial viewing is not a completed acceptance
of all nine diagrams. Other potentially tight labels must be checked at larger scale.

Follow-up: batch283 parameter output arrows now begin at the lower frame edge;
the gradient return takes a path outside the parameter frame, and its title has
more padding. Viewed the final 220-ppi render after compiling without warnings.
Batch285 encoder headings were reduced and the three output boxes made taller.
Softmax outgoing arrows now begin at the circle boundary, clearing their text.
Viewed the updated 220-ppi render; these repaired contacts have visible clearance.
Other small equations in this nine-diagram group remain under review.

Additional pass: batch282 W/C/H paths were spread horizontally and labels given
smaller explicit text, then the final 220-ppi parameter crop was viewed.
Batch284 K_i was moved into clear space above its switch, removing the old white
rectangle that covered part of the signal wire. Viewed the final 220-ppi diagram.
All nine PDFs were compiled and compared with HEAD: non-whitespace character
multisets are identical, including multiplicities. Results are saved in
`collision-text-validation.json`. This check detects lost characters but cannot
prove text ordering, topology or universal visual collision freedom.
