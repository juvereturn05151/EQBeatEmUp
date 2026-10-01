# V3 Krita workflow

## Open the project

Use a **1024×1024**, RGB/Alpha, 8-bit sRGB working document. Open `Cleanup/idle_layers.ora` in Krita, then Save As `Cleanup/idle_design.kra`. The four registered working poses are separate raster layers; only frame 01 is initially visible. Alternatively open `Cleanup/idle_01_work.png` and save it as a KRA.

Keep the original files in `Keyframe/` and `Frames/` intact. Work on duplicates or new layers. Export at **512×512 per frame** for the first gameplay test. Check at 256×256 too: inked game art often needs more simplification as it gets smaller. DPI is not a game-size setting.

Place Reference A and Reference B beside the canvas with Krita's Reference Images Tool. A controls likeness, body, hair and clothes. B controls contours, hatching and print mood only. No V2 artwork was used as a face-generation input. See the [official reference tool manual](https://docs.krita.org/en/reference_manual/tools/reference_images_tool.html).

## Inspect the master face first

Read [face consistency and cleanup](face_cleanup.md). Compare the selected master with Reference A at matching head sizes before judging finer texture. Focus on head outline, hairline, brow-to-eye spacing, nose profile, lip line and chin. A highly detailed face can be less recognizable than a simpler correctly proportioned one.

The first candidate in `Sketches/master_candidate_01.png` hid the far arm. `Prompts/master_refinement.txt` changed the torso view and pocket readability before any animation variations were made. `Keyframe/idle_master.png` is the selected revised result. If you revise its face further in Krita, make that corrected head the authority for ALL four poses.

## Prepare pose and control guidance

Keep a sketch layer above the master at low opacity. Mark skull, sternum, pelvis, elbows, wrist-to-pocket entries, knees and two separate sole-contact anchors. Use a line of balance that falls within the support footprint. The casual stance should have soft knees, relaxed shoulders and a modest weight bias, without leaning the whole body off balance.

Both forearms should lead continuously from sleeve to hip. Both wrists disappear into pants pockets; no thumbs/fingers should emerge. The far arm can be narrow because of perspective but must remain anatomically connected. Preserve the arm/waist contour and small elbow clearance instead of exaggerating a fighting guard. More detail is in `Sketches/pose_notes.md`.

If your existing AI backend supports pose control, freeze the ankle/toe and pocket-entry anchors. Move only chest/shoulder/elbow markers slightly. If it supports line-art control, supply a simple master outline with stable head, collar, shirt marks and shoes. For tiny breathing, line-art guidance and selective edits usually constrain detail better than a skeleton alone. Mask away the head and lower legs from regeneration if your backend allows it. Control availability and strength scales depend on your setup; none of these controls was used by the built-in generator in this package.

## Prompt sequence and intended movement

1. Generate a master from Reference A + Reference B with `Prompts/base_prompt.txt`.
2. Refine and inspect face/pose before proceeding. This package's exact refinement is saved in `master_refinement.txt`.
3. Use `frame_01.txt`: copy the selected master without regeneration.
4. Generate frame 02 using ONLY the selected master as edit target plus `frame_02.txt`.
5. Repeat separately from the SAME master for 03 and 04. Never chain 02→03→04.

| Pose | Intended motion, measured on source canvas | Unchanging anchors |
| --- | --- | --- |
| 01 neutral | Selected master | Face angle/expression, pocket entries, feet |
| 02 inhale | Shoulders 2px up, head 1px up, elbows 1px up | Wrists in pockets, hips and feet |
| 03 exhale | Shoulders 2px down, head 1px down, torso/pelvis 1px toward support leg | Pocket relationship, shoes and lower legs |
| 04 return | Shoulders 1px below neutral, head/pelvis return | Same face, hands concealed, feet |

These are prompt targets, not guaranteed subpixel editing. The supplied generator changed some features despite explicit locks. For a fully stable final animation, make small manual transforms of the approved master and repaint only connecting seams. Do not regenerate the entire face to animate a one-pixel nod. Do not introduce a blink or head turn into this particular four-frame loop.

## Build the Krita timeline

Create a transparent 1024×1024 document. Choose **File → Import Animation Frames** and select the four `Cleanup/idle_XX_work.png` files in ascending order. Import at frame 0 with Step 6. Use 24 FPS, playback range 0–23: unique poses appear at 0, 6, 12 and 18 and are held for 250 ms each. Save as `Cleanup/idle_animation.kra`.

Switch to the Animation workspace, enable the Animation Timeline and Onion Skins dockers, and turn onion skins on for the animated layer. Inspect each transition, including 04→01. The [official Krita import manual](https://docs.krita.org/en/reference_manual/import_animation.html) describes ordering and Step settings.

## Cleanup order

1. Stabilize the **head and face** using the master head procedure in `face_cleanup.md`.
2. Fix **shoe anchors**. The raw exports' lowest visible sole is y=474 or 475; remove that one-pixel jitter with local foot corrections. Do not resize the entire figure independently per frame.
3. Keep **wrists inside both pockets**. Repair any gap between wrist, pocket opening and shirt hem when moving shoulders. Pocket fabric should not float separately from the hips.
4. Stabilize **shirt marks/buttons** by reusing master details with the cloth, not redrawing a new pattern in every pose. Fewer broad motifs are easier to keep coherent.
5. Stabilize **hair, hatching and skin shading**. The generated variation hair has more wispy marks than the master; use the master's close buzz-cut texture consistently. Keep facial hatching sparse and clothing hatch groups attached to the moving fabric.
6. Inspect **alpha** over temporary white, grey and dark backgrounds. Exterior alpha is real, but the generated interior is slightly translucent. Paint opaque base colors within the body if required; retain smooth antialiased boundary pixels. Remove detached specks and colored fringes. Do not fill the canvas.

Review at full size and actual gameplay size. The user-visible friend likeness matters more than copying every line from either the photo or comic. Save each reviewed unique pose as `Cleanup/idle_01_clean.png` through `idle_04_clean.png`, all at 1024×1024 and the same registration. Keep KRA layers editable.

## Final exports

Hide guides and temporary backgrounds. Use **File → Render Animation → Export as Image Sequence**, PNG with alpha, and Only Unique Frames if available. Verify the order and names after rendering. Keep PNG game assets; a preview video is not a replacement for transparency. See the [official render documentation](https://docs.krita.org/en/reference_manual/render_animation.html).

The included `Notes/build_exports.ps1` scales/pads and packs files. It does not paint or repair artwork. Current generation dimensions are 1254×1254. Every source is mapped into the SAME 896×896 rectangle at `(64,64)` on a 1024 working canvas; exports are half that size. This preserves the generated relative placement instead of auto-aligning each silhouette.

After making all four clean 1024×1024 PNGs, rebuild from the Unity project root:

```powershell
& './Assets/ArtAssets/Ver3/Notes/build_exports.ps1' -UseCleanFrames
```

This refreshes `Export/idle_01.png`–`idle_04.png`, `idle_sprite_sheet.png` and metadata. Version any exports you want to retain before rebuilding. Running the script WITHOUT the switch recreates the concept outputs and ORA from the raw `Frames` images; use the switch after cleanup.

Manual sheet assembly: create a transparent 2048×512 document, add the four 512×512 exported PNGs as layers, place them at x=0, 512, 1024, 1536 and y=0, then export PNG. Use numeric positions, not visual approximation. Keep every 512px cell intact rather than trimming each figure.

Slice by a fixed 512×512 grid in the game engine. Use the same pivot for every frame: top-left `(256,474)` / normalized bottom-left `(0.5,0.07421875)`. Play 01–04 in order at 250 ms per pose and loop. Match pixels-per-unit to existing game characters. Start with smooth filtering for this illustrated style and inspect compression/atlas bleed at actual scale.

## Names and completion check

Use lowercase snake_case, two-digit frame numbers, and `_work` vs `_clean` to distinguish stages. Save revisions as `idle_master_v002.png` or `idle_animation_v002.kra` rather than replacing the only approved source.

Before final game use: recognizable friend face; consistent buzz cut; relaxed pocket pose with two connected arms; no exposed fingers; full body inside canvas; no foot sliding; no face/pattern popping; subtle breathing; stable 04→01 join; real transparent exterior; opaque intended interior; same cell sizes and pivot; no guides or comic-cover text in artwork.
