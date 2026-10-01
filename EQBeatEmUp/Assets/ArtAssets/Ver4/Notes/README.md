# Ver4 — working in Krita

## 1. Open and inspect

Open `Cleanup/idle_layers.ora` in Krita and save as `Cleanup/idle_design.kra`. It has four registered raster layers, initially showing frame 01. Working canvas is **1024×1024, RGB/Alpha, 8-bit sRGB**. Raw images in `Keyframe` and `Frames` remain intact at 1254×1254.

Use Krita's Reference Images Tool to place the friend photo and Thai comic beside the canvas. A controls identity, proportions and outfit; B controls ink/print language only. Keep reference images separate from the painted background. [Official reference tool documentation](https://docs.krita.org/en/reference_manual/tools/reference_images_tool.html).

Read `face_cleanup.md` first. Ver4's important change is deliberate graphic simplification: compact serious eyes, strong brow, clear jaw, firm mouth, flat skin and sparse face marks. Use `Sketches/face_and_pose_design.md` for rough guide construction. Don't let the rendering obscure identity.

## 2. Master and generation prompts

`Prompts/base_prompt.txt` is the exact master prompt. It explicitly separates the friend's identity from the comic's style and asks for delinquent-manga attitude without copying an existing character. The master was created and reviewed before the variations.

`frame_01.txt` specifies copying the selected master unchanged. For 02–04, use the same master as edit input every time, with each respective prompt. Do not chain one generated frame into the next. The supplied images were generated using the built-in tool with transparent-background requests; no external AI plugin or explicit pose-control backend was installed.

| Pose | Prompted motion on source canvas | Fixed elements |
| --- | --- | --- |
| 01 neutral | Exact master copy | Everything |
| 02 inhale | Shoulders 2px up, head 1px up, elbows 1px up | Face drawing, hips, pockets, feet |
| 03 exhale | Shoulders 2px down, head 1px down, torso/pelvis 1px toward support leg | Head angle/expression, pocket connections, lower legs |
| 04 return | Shoulders 1px below neutral, head/pelvis back to master | Hands concealed, feet and expression |

These are art-direction targets, not guaranteed numeric edits. The actual exhale is larger; see the measurements in `generation_notes.md`. For the most controlled result, use the generated sequence as guidance and make very small manual changes to duplicates of the corrected master.

If an existing compatible backend offers masks/line-art controls, protect the head and lower legs and guide only chest/shoulder motion. Freeze pocket-entry and foot anchors. Pose skeletons help joint placement but do not keep eyes or shirt patterns identical. A fixed seed alone is not an identity lock.

## 3. Create the animation timeline

Make a new transparent 1024×1024 document. Choose **File → Import Animation Frames** and add `Cleanup/idle_01_work.png` through `idle_04_work.png` in ascending order. Set Start to 0 and Step to 6. At **24 FPS**, use playback range **0–23**, giving poses at frames 0, 6, 12 and 18, held for 250 ms each. Save as `Cleanup/idle_animation.kra`.

Use the Animation workspace and enable the Animation Timeline and Onion Skins dockers. Enable onion skins on the animated layer. Scrub all four poses and check the 04→01 join. [Official frame-import documentation](https://docs.krita.org/en/reference_manual/import_animation.html).

## 4. Cleanup priorities

First correct and reuse one master head as described in `face_cleanup.md`. Then stabilize shoes, pocket entries, motifs and hatching. Keep both hands fully inside the pants pockets throughout; breathing should not reveal fingers or shift wrists away from the openings.

Don't independently crop, scale or recenter the four characters. They share a fixed canvas registration. Make local corrections where generated contours drift. In Ver4 exports, every lowest visible sole reaches y=475, but that alone does not guarantee identical shoe outlines.

Test at 512×512 and 256×256. This is illustrated sprite art, not pixel art; use smooth downsampling and simplify busy hatch groups before reducing. Keep thick outer contours and a few readable internal shadow shapes.

Inspect alpha on light and dark temporary backgrounds. Preserve real transparency and clean antialiasing; remove detached specks and unwanted fringes. Add opaque interior base color if needed. Hide backgrounds/guides before export.

Save the four reviewed poses as `Cleanup/idle_01_clean.png`–`idle_04_clean.png`, each **1024×1024**. `_work` files are concept inputs; `_clean` names are reserved for this paint-over stage.

## 5. Export transparent frames and sheet

Keep the editable KRA. Use **File → Render Animation → Export as Image Sequence**, PNG with alpha and Only Unique Frames where available. Check numbering/order after rendering. [Official render documentation](https://docs.krita.org/en/reference_manual/render_animation.html).

The included `build_exports.ps1` performs mechanical size/padding and sheet assembly, not artistic cleanup. Its default input is the raw 1254×1254 frame set. It maps every entire source into the same 896×896 rectangle at `(64,64)` on a 1024 square, then reduces to 512. No individual bounding-box fit is used.

After the four clean files exist, run from the Unity project root:

```powershell
& './Assets/ArtAssets/Ver4/Notes/build_exports.ps1' -UseCleanFrames
```

This refreshes four 512×512 PNGs, the 2048×512 sheet and JSON. Version any outputs you wish to keep first. Without the switch, the script rebuilds the concept package from raw frames and overwrites working copies/ORA; use the clean switch after painting.

Manual packing option: create a transparent 2048×512 document; place the four 512×512 PNG layers at x=0,512,1024,1536, y=0; export PNG. Use exact positions. Do not trim away each cell's transparent margins.

## 6. Game settings and naming

Slice the sheet into four 512×512 cells. Use identical pivots: **(256,476)** from top-left, or normalized bottom-left **(0.5,0.0703125)**. The working-size pivot is `(512,952)`. This positions the ground anchor just below the lowest visible pixels. Note that this numeric pivot differs slightly from Ver3's due to the new artwork; match game-world placement deliberately when comparing versions.

Use order 01→02→03→04 with 250 ms per pose and loop. Match pixels-per-unit to existing game characters. Start with smooth filtering for this illustrated style, then inspect texture compression and atlas bleed at gameplay scale. No Unity importer/controller settings were modified by this package.

Use lowercase snake_case, two-digit frame numbers, `_work` and `_clean` for stages. Keep revisions such as `idle_master_v002.png` and `idle_animation_v002.kra` instead of destroying the approved source. All artwork and supporting files for this version stay under `Assets/ArtAssets/Ver4`.

Before game use: confirm recognizable stylized face, stable buzz cut/eyes/mouth/jaw, no expression changes, two hands concealed, natural support balance, no sliding feet, no pattern flicker, a gentle loop join, transparent exterior, intentional interior opacity and readable art at actual display size.
