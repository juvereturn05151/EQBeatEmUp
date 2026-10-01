# Ver4 generation and checks

Created 2026-10-01 with the built-in image generation tool, using transparent-background requests. No API fallback, external AI plugin, explicit regional mask, pose-control backend or native Krita automation was used.

## Inputs and order

- Reference A was copied unchanged from the prior package's original friend photo. It supplied identity, buzz cut, proportions and outfit.
- Reference B was copied unchanged from the supplied Thai comic cover. It supplied ink/print style only, not a character, layout or lettering.
- Optional previous-frame Reference C was not used as a generation input. Previous artwork did not condition the new face.
- `Prompts/base_prompt.txt` generated `Keyframe/idle_master.png`. The more graphic face and visible pocket entries were inspected before proceeding. The assistant selected this master for the concept pass; this is not a claim of user likeness approval.
- Frame 01 is an exact file copy of the master. Frames 02, 03 and 04 were each separate edits of that SAME master using their saved prompts. No chaining between variations.

All four generated images are preserved under this version. The source canvas for each is 1254×1254 RGBA. The base and four frame prompts are the actual instructions used. The frame-01 prompt describes copying rather than a generation call.

## Preparation and output

The export script preserves originals. Each entire source is fitted using the identical mapping into a 896×896 rectangle at `(64,64)` on a transparent 1024×1024 working canvas, then downsized to 512×512. No per-frame crop, recenter, face replacement, deformation or repainting was applied.

The four exported PNGs are placed left-to-right in a 2048×512 sheet. Metadata records the four rectangles, 250ms intended holds and shared pivot `(256,476)` from top-left / `(0.5,0.0703125)` normalized bottom-left. Alpha is preserved. The file `idle_layers.ora` packages the four working raster layers with only frame 01 visible; it is not a KRA timeline.

## Measured bounds

Visible bounds at alpha > 8/255 on the 512×512 exports:

| Frame | Left | Top | Right | Bottom |
| --- | ---: | ---: | ---: | ---: |
| 01 | 174 | 37 | 338 | 475 |
| 02 | 174 | 36 | 338 | 475 |
| 03 | 174 | 43 | 338 | 475 |
| 04 | 174 | 38 | 338 | 475 |

Every lowest visible sole reaches y=475; overall head-top range is 7 exported pixels, with frame 03 lower than the others. These are bounding-box measurements, not proof of identical foot contours or face pixels. The generator did not obey the one-to-two-source-pixel targets exactly.

## Visual evaluation and cleanup limitations

The master clearly shifts from Ver3's finer skin modelling toward graphic cartoon features: heavy upper lids/brows, firm mouth, clear jaw and a broad jaw/neck shadow. Likeness remains a stylized interpretation of a small mostly side-view photograph. The overall expression is serious and composed rather than snarling.

Both hands remain concealed by the pants pockets and both forearms are connected to their pocket entries. The character remains upright, full-body and right-facing. Most print/hatch detail is on clothing rather than the central face.

The AI variations still alter hair speckle, small face/ear contours, shirt motifs and clothing hatching. The exhale is more pronounced than requested. Use one corrected master head across the loop and tighten torso motion manually, as explained in `face_cleanup.md`, before calling this production-clean animation.

Exterior alpha is genuinely transparent. Some interior pixels are near-opaque rather than uniformly 255; preserve edges and paint solid interior base color during cleanup if required. Inspect fine colored fringes on contrasting backgrounds. No artistic cleanup was claimed by the mechanical export script.

## Verification performed

The assembled sheet was visually inspected. Source dimensions, 512px output dimensions, 2048×512 sheet dimensions and exterior alpha were checked. Master/frame-01 SHA-256 hashes match. ORA stack XML contains four layers and each referenced PNG exists in the archive. The updated JSON uses the Ver4 pivot.

The local HTML preview plays the same sheet with pause, step, speed and background controls. Native Krita opening/timeline playback and game-engine integration were not tested in this session. Earlier version artwork remains unchanged.
