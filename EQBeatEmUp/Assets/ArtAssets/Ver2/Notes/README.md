# Beginner Krita workflow

## 1. Know what is provided

The `Keyframe/idle_master.png` is the design authority. The blue short-sleeve shirt, dark pants, grey sneakers, buzz cut and calm alert expression come from the friend photograph. The vintage comic supplies strong irregular contours, directional hatching, graphic shadows and a restricted print palette. Its characters, cover arrangement and lettering are not design inputs.

The four AI images are a concept pass. They preserve overall identity and pose but do not preserve every motif or hatch stroke. The exhale also moves more than the requested pixel targets. Use them as motion/design guidance; the cleanest final loop will reuse as much master artwork as possible. Do not call the current sheet a fully cleaned production animation.

## 2. Set up your document and references

Recommended working canvas: **1024×1024, RGB/Alpha, 8-bit sRGB**. Recommended first game export: **512×512 per frame**, with the figure about 440 pixels tall. Test at 256×256 too if that is closer to the in-game size. This is inked illustration, not pixel art; smooth downsampling is appropriate. Resolution in pixels matters here; DPI does not determine game size.

Open `Cleanup/idle_layers.ora` in Krita and Save As `Cleanup/idle_design.kra`. It contains four same-sized, registered raster layers; only frame 01 is initially visible. Preserve this source rather than overwriting original PNGs. Alternatively open `Cleanup/idle_01_work.png`, then save as a KRA.

Use the Reference Images Tool to add `References/ref_friend.png` and `References/ref_style_thai_horror_comic.png` beside the canvas. Keep these as reference objects, not painted background layers. Label A “identity/outfit” and B “style only” in your notes. Compare the brow, nose, jaw, hairline and natural build to A. Compare contour weight and shadow vocabulary to B. The original photo is mainly a side view, so the three-quarter face is an interpretation.

Reference-tool behavior is described in the [official Krita manual](https://docs.krita.org/en/reference_manual/tools/reference_images_tool.html).

## 3. Prepare a rough pose sketch

Open `Sketches/idle_pose_guide.png` as a layer in the 1024×1024 working document, lower its opacity to about 25%, and lock it. It is a schematic guide, not a tracing of the generated anatomy. Make a new paint layer called `pose_sketch` above it.

Draw an oval for the head, a rib-cage wedge, a pelvis block, and simple limb lines. Aim the nose right while showing the front and side of the chest. Place feet apart, soften both knees, and keep the body balanced between the shoes. Separate elbows and fists from the torso so the pose reads as a small silhouette. Use mitten-like fist shapes first; do not begin by drawing fingernails or laces.

Our padded master places the lowest sole near y=948 on the working canvas. Mark a stable ground/pivot guide at `(512,948)`. The two shoe bottoms need not share a horizontal line in a three-quarter pose, but each individual contact point must remain fixed across time. Keep head and hands clear of canvas edges.

Fill the rough figure temporarily with one dark color and zoom out. If the guard and facing direction are unclear, fix spacing before adding details. Keep the guide and sketch hidden for export.

## 4. Establish the master before animating

Use `Prompts/base_prompt.txt` with Reference A and Reference B in their explicit roles. The supplied `idle_master.png` is already generated this way. On a duplicate, simplify shirt patterns to a small fixed set, group trouser shadows into a few large shapes, and keep hatching away from tiny silhouette edges. Keep a small palette sampled from the master: dark ink, blue shirt light/mid/shadow, tan skin light/shadow, charcoal trousers and grey shoes.

Check likeness and silhouette at actual display size. Preserve natural proportions and avoid over-muscular arms. The current near fist overlaps the chest slightly; retain a clear arm contour. Use one agreed head, collar, hem and shoe design throughout. Save the approved painted master before making other frames.

## 5. Generate one variation at a time

Use `frame_01.txt` through `frame_04.txt`. Frame 01 is a copy of the approved master, not a fresh generation. For every other frame, provide the SAME approved master as the edit target and its own frame prompt. Do not feed frame 02 into 03 or 03 into 04: errors accumulate. Keep a fixed seed if your generator exposes it, but do not expect a seed alone to lock identity.

| File | Intended motion at 1024px working height | Hold |
| --- | --- | --- |
| idle_01 | Neutral ready pose | 250 ms |
| idle_02 | Inhale: shoulders +4px up, head +2px up, fists +2px up | 250 ms |
| idle_03 | Exhale: shoulders 3px down, head 2px down, pelvis 2px toward rear leg | 250 ms |
| idle_04 | Return: shoulders 1px below neutral, head neutral, pelvis returns | 250 ms |

These are art-direction targets, not measurements guaranteed by the generator. Scale the motion with canvas size; at 512px output, 4 working pixels become 2 pixels. If the AI moves too much, use the pose as a guide for a smaller manual edit to a master duplicate. Keep feet fixed and avoid changing the character's overall scale to simulate breathing.

## 6. Optional pose and line-art controls

The built-in generator used for these assets accepts reference images, but this workflow did not use a pose-control network, explicit masks or numerical denoise settings. Krita alone is not an AI generator. If you already have a compatible AI plugin/backend, use its image-to-image or regional editing tools; UI names and available controls depend on that setup.

- Pose guidance: use one skeleton with fixed ankle/toe anchors. Change only shoulder, elbow and pelvis points slightly per frame. A skeleton constrains joints but does not lock the face or clothing.
- Line-art guidance: trace a simplified outline from the approved master. Keep the head, shoes, collar, motifs and big shadow shapes identical; redraw only breathing contours. This is usually more useful than pose alone for a tiny idle.
- Regional guidance: mask only chest, shoulders and small elbow seams. Exclude face, hair, hands and shoes where possible. Keep edit strength low; if your backend uses a normalized 0–1 denoise scale, around 0.15–0.30 can be a cautious starting experiment, not a universal setting.
- Manual route: duplicate the approved master, select the upper torso/arms, make a tiny transform, then repaint exposed seams and neck connections. Reuse the same head and shoe pixels. This gives more reliable identity than regenerating every surface.

Save guidance and masks under `Sketches/`; never flatten them into export art.

## 7. Build and inspect the animation in Krita

Create a new transparent 1024×1024 document. Choose **File → Import Animation Frames**, select the four `Cleanup/idle_XX_work.png` files in ascending order, set Start to 0 and Step to 6. Use 24 FPS and a playback range of 0–23: unique poses land on 0, 6, 12 and 18, each held for a quarter second. Save as `Cleanup/idle_animation.kra`.

Switch to the Animation workspace or enable the Animation Timeline and Onion Skins dockers. Scrub the four poses and enable onion skins on the animated layer. Watch soles first, then head size and face, then collar/buttons and shirt motifs. Check the 18→0 transition as carefully as the others. The [official import documentation](https://docs.krita.org/en/reference_manual/import_animation.html) explains ordering and frame step.

## 8. Clean up without losing the style

Work on duplicates or a separate animated cleanup layer. Keep a locked master copy for sampling. For each unique pose:

1. Match soles and ankle positions to the master. Use local corrections rather than independently centering or resizing the entire frame.
2. Reuse the master head where feasible; repaint only the neck connection. Keep ear, brow, nose, jaw and hairline stable. Do not let small edits alter the expression.
3. Reuse shirt motifs and buttons from the master. Remove extra generated marks. A few broad motifs read better than many tiny flowers. Do the same simplification in every pose.
4. Keep trouser folds and shoe stripes stable. Freeze lower-leg texture when the legs are stationary. Clean stray marks around fists and check finger counts visually.
5. Unify hatching: copy/transform a shared texture with the body part or redraw a few coarse strokes. Do not leave a different speckle pattern flashing on every frame.
6. Inspect silhouette edges over white, mid-grey and dark temporary backgrounds. Erase detached specks and colored fringes. Keep natural edge antialiasing; do not indiscriminately threshold all alpha or erase pale shirt details.
7. Hide the backgrounds and guides. Confirm Krita shows transparency outside the body. Do not paint a checkerboard into the image. Alpha-lock helps recolor existing pixels but is not a substitute for masking the silhouette.

Inspect both zoomed in and at 512/256px. If hatching turns into noise, simplify it before downscaling. Retain bold outer contours and a few expressive inner strokes. Play the loop: face/pattern flicker is a cleanup issue even when each still looks good.

Export each approved 1024×1024 unique pose as `Cleanup/idle_01_clean.png` through `idle_04_clean.png`. The `_clean` names are reserved for this manual pass; they have not been fabricated by renaming AI outputs.

## 9. Export transparent frames and sheet

Keep the `.kra` as the editable source. Use **File → Render Animation → Export as Image Sequence**, PNG, with alpha preserved and all backgrounds hidden. Use Only Unique Frames if available to avoid exporting every hold. Verify filename order; rename the four approved files to the convention above. The [official rendering documentation](https://docs.krita.org/en/reference_manual/render_animation.html) covers PNG sequences and unique-frame output. Video is not the transparent game deliverable.

The included `Notes/build_exports.ps1` does mechanical scaling/padding and sheet packing; it performs no artistic cleanup. Its default inputs are the original 1254×1254 generations. It maps each entire source into a fixed 896×896 rectangle at `(64,64)` on the 1024 canvas, then downsizes to 512. It does NOT trim or independently align characters, preserving their shared registration.

After the four approved clean files exist, run this from the Unity project root:

```powershell
& './Assets/ArtAssets/Ver2/Notes/build_exports.ps1' -UseCleanFrames
```

This intentionally refreshes the four PNG exports, sheet and JSON from the 1024×1024 clean frames. Keep those clean inputs registered exactly as the working files. Before rerunning, version any export you want to preserve. The default command without that switch rebuilds the concept set and layered ORA, so do not use the default after finishing cleanup.

Final layout: **2048×512 PNG, four 512×512 cells in one row, 01→02→03→04**, no spacing between cells. Transparent margins are already inside each cell. No per-frame trimming. Pivot is `(256,474)` from top-left, or `(0.5,0.07421875)` in normalized bottom-left coordinates. The JSON records timing and rectangles. Suggested loop: 250ms per cell, 1 second total; adjust all holds if it feels too slow/fast.

Manual sheet alternative: make a transparent 2048×512 document, place the four exported 512px PNG layers at x=0, 512, 1024, 1536 and y=0 using numeric positions, and export PNG. Do not drag them into place by eye or resize each character separately.

For a game importer, use fixed 512×512 grid slices and identical pivots, loop in numeric order, and choose pixels-per-unit to match your game's existing characters. Use smooth filtering for this illustrated style; use point filtering only if deliberately converting to pixel art. Start with uncompressed textures for inspection; test atlas padding/filtering before shipping. No Unity importer or animation-controller configuration has been changed by this art package.

## 10. Naming and approval checklist

Use lowercase snake_case and two-digit frame numbers. Keep base names `idle_01`–`idle_04`; use `_work` for cleanup inputs and `_clean` only after review. Keep iteration backups such as `idle_animation_v002.kra` or `idle_master_v002.png`. Retain the exact prompts with any revised generation so a variant has provenance.

Before approving: full body visible; friend likeness retained; right-facing three-quarter stance; all four frames share head/clothes/proportions; no sliding feet; no popping shirt motifs; smooth 04→01 join; true alpha; no guide/background; identical cell sizes and pivot; readable at actual game size. Save the final KRA, four clean working PNGs, four game PNGs, sheet and metadata together.
