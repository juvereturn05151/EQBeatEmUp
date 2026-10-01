# Ver4 face design and consistency

## Make simplification deliberate

Use the friend's skull silhouette, close buzz cut, forehead/nose profile and nose-mouth-chin spacing as identity anchors. The photo is mostly a side view, so the three-quarter drawing is an interpretation. Tougher cartoon styling should clarify those shapes instead of replacing the face with a generic handsome fighter.

Build the face from a few readable decisions:

- **Eyes:** narrow clean wedges with bold upper lids, small dark pupils and very little lower-lid detail. Keep gaze stable; avoid glossy highlights or enlarged anime eyes.
- **Brows:** strong and fairly straight, set low enough to feel serious. Avoid squeezing them into an angry V or changing their slope between poses.
- **Jaw:** a clear corner and compact chin that retain the friend's overall lower-face proportions. Do not endlessly widen or lengthen it to make the character tougher.
- **Cheek:** one short plane mark or a small coherent shadow. Avoid many contour lines that make the face look older or artificially sculpted.
- **Mouth:** a short firm closed line, possibly one restrained lower-lip mark. No painted shiny lips, smile or exposed teeth.
- **Hair:** the same close buzz-cut outline everywhere, with one consistent texture treatment. No wispy locks or new hairline.
- **Color:** flat skin base and one main jaw/neck shadow. Keep the central face clean. Place vintage paper grain and most rough hatching on clothes instead.

Seriousness should come from expression, posture and shape design, not extra wrinkles, giant muscles or an aggressive grimace. The manga influence is a guide to tone; no specific existing character should become the face solution.

## Correct the master before the other frames

Open `Cleanup/idle_01_work.png` or the layered ORA in Krita. Save an editable KRA. Put Reference A beside the canvas and compare at similar head sizes. Temporarily remove texture if needed so you judge proportions rather than surface detail.

Inspect brow angle, eye width, nose projection, firm mouth and jaw shape. If the stylization weakens resemblance, correct the silhouette and feature spacing before adding more detail. Recheck at 512px and 256px full-character scale: too many face lines will collapse into noise.

Save the corrected face as the only head authority for all poses. Preserve an unedited layer for comparison.

## Reuse one head throughout the loop

1. Copy the WHOLE corrected master head, including hair, ear, jaw and a short neck overlap, onto a transparent layer. Avoid patching individual eyes/nose/mouth separately.
2. On a duplicate of each body pose, mask or remove the old generated head. Simply pasting a new head over it can leave doubled hair/jaw edges.
3. Paste the SAME master head onto each pose. Start at the same coordinates in all four. Add at most 1–2 working pixels of vertical translation if necessary; no rotation, scaling or facial warp.
4. Repair only the neck/collar seam beneath it. Let the shoulder line breathe while the face retains one intentional drawing.
5. If the body exhale is too large, duplicate the approved master body and make a smaller torso/shoulder adjustment manually. Taper arm movement to zero at pocket entries; both hands remain hidden.
6. Reuse master shoe/lower-leg shapes for planted-foot stability. Keep each shoe's own contact outline fixed, not merely the lowest point of the combined bounding box.
7. Use onion skins and alternate frames. Watch pupils, brow angle, nose tip, mouth corner, jaw corner, ear and hairline. They should translate together without stretching or changing expression.

Use integer-pixel translations where possible and avoid repeated resampling. Do not regenerate an entire face for a one-pixel breathing shift. A stationary face is better than a subtly redesigning face.

## Specific Ver4 cleanup targets

The raw variations retain the graphic expression but alter some hair speckle and small face/ear contours. Frame 03 drops the head more than requested; the head top moves from y=36–38 in other exported frames to y=43. Tighten this if the desired idle is almost still. Keep the angular jaw graphic without sharpening it differently per frame.

Shirt motifs and hatch lines also drift. Copy simplified master motifs with the fabric; use shared hatch patches or a few stable strokes. Keep the bold jaw shadow the same shape across the loop and do not add gradients back into the face.

## Alpha and export checks

Check over white, mid-grey and dark temporary layers. The exported exterior is transparent; generated interior pixels may be near-opaque rather than fully alpha 255. If you need a solid character, paint opaque base colors inside the silhouette while preserving antialiased edge pixels. Do not flatten onto an opaque background or paint a checkerboard.

Look for fine colored fringes near nose, jaw, sleeves and shoes; remove detached specks without thinning important black contours. Hide review backgrounds and guide layers before PNG export. Save reviewed 1024×1024 poses as `Cleanup/idle_01_clean.png`–`idle_04_clean.png` and keep the editable KRA.
