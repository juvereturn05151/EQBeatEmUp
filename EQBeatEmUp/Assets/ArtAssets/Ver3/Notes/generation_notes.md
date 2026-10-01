# V3 generation / verification record

Created 2026-10-01 with the built-in image generation tool. No API/CLI fallback, external AI backend, pose-control network, explicit image mask, or native Krita automation was used. V2 files were left intact; only its reference copies and export utility/preview structure were reused.

## Generation sequence

1. `Prompts/base_prompt.txt` + Reference A (identity) + Reference B (style) produced `Sketches/master_candidate_01.png`. Facial treatment was softer than V2, but the near-profile torso hid the second arm.
2. `Prompts/master_refinement.txt` + candidate (edit target) + original friend photo (identity authority) produced `Keyframe/idle_master.png`. The torso was opened toward the viewer so the far forearm and pocket entry read. This master was visually selected by the assistant before generating variations; user likeness sign-off was not obtained or implied.
3. `Frames/idle_01.png` is a byte-for-byte copy of the selected master. `frame_01.txt` documents this reuse.
4. `frame_02.txt`, `frame_03.txt`, `frame_04.txt` each edited the SAME selected master in separate calls. No variation was used as the input for another. Reference C / V2 artwork was not used to condition the V3 face.

All five generated images (first candidate, selected master, three edits) were copied into this V3 package. All original generated canvases are 1254×1254 with alpha. Prompts are the actual instructions used, including the targeted pose refinement.

## Mechanical preparation

Each original frame was scaled using the same operation into a 896×896 square at (64,64) on a transparent 1024×1024 working canvas. That padded working canvas was then reduced to 512×512 for export. No per-frame trimming, recentering, head replacement, retouching or artistic deformation was performed by the export script.

The horizontal 2048×512 sheet contains those four exported cells in order. `Export/idle_sprite_sheet.json` stores rectangles, shared pivot, intended timing and per-frame alpha bounds/pixel counts. The PNGs contain no background or guide layer.

`Cleanup/idle_layers.ora` contains four named raster working layers, with only the first visible, plus a merged master preview. This is an OpenRaster still document, not a native KRA timeline. Native Krita opening/playback was not tested in this session.

## Visual observations and limitations

The selected face uses less angular jaw/cheek shading and a less aggressive expression than V2. This is an artistic likeness judgment; the small source photo cannot establish exact unseen three-quarter anatomy. See `face_cleanup.md` for a controlled way to refine and reuse one head.

Both arms connect to pocket entries, hands remain concealed, and the stance is upright with a modest stagger. The far arm has substantial torso occlusion; preserve that connection in any paint-over rather than adding an exterior hand.

The raw variations redraw some hair marks, facial contours, shirt motifs and hatch strokes. The hair in variations looks more wispy than the master's buzz-cut texture. This is a known temporal consistency issue, not a deliberate hairstyle change. Current deliverables are the completed CONCEPT package; production face/pattern cleanup remains necessary.

At 512px export, alpha bounds above 8/255 are:

| Frame | Left | Top | Right | Bottom |
| --- | ---: | ---: | ---: | ---: |
| 01 | 189 | 39 | 332 | 474 |
| 02 | 190 | 39 | 332 | 475 |
| 03 | 190 | 41 | 331 | 475 |
| 04 | 190 | 39 | 332 | 474 |

Top-edge variation is 2 pixels; lowest-sole variation is 1 pixel. Bounding-box agreement is not proof that every shoe or facial pixel is identical. Stabilize shoes locally and reuse master head pixels during cleanup. The tiny numeric motion targets in prompts were not followed exactly by generation.

Exterior pixels have alpha 0. Original character interiors have near-opaque partial alpha as well as some fully opaque pixels; the original alpha was preserved through packing. Check on light/dark backgrounds and add opaque silhouette interior color when cleaning if fully solid game art is required.

## Final checks

The assembled sheet was visually inspected; expected source/output dimensions and transparent exterior pixels were measured. Master and frame 01 hashes match. The ORA archive's XML and four layer entries were checked. The preview is a local HTML player of the same PNG sheet, with pause, step, timing and background controls; it is a review aid rather than a new animation render.
