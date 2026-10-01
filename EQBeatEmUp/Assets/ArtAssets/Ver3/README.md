# V3 — hands-in-pockets idle concept

V3 rebuilds the character from the friend photograph, emphasizing a calmer, more human face and a naturally balanced casual pose. It retains the blue shirt, dark pants, sneakers and vintage Thai pulp-comic ink language. V2 assets have not been edited.

Start with [the looping preview](Notes/idle_preview.html), [the master](Keyframe/idle_master.png), and [the Krita workflow](Notes/README.md).

## What changed from V2

| Area | V2 | V3 |
| --- | --- | --- |
| Face direction | Angular fighter styling and heavier facial hatching | Softer cheek/jaw, quieter brow, closed relaxed mouth, less central-face texture |
| Identity source | Friend reference plus strong comic styling | Friend is the sole face authority; no V2 image conditioned the new face |
| Pose | Wide bent-knee stance with visible fists | Upright, slightly staggered natural stance; both hands concealed in pants pockets |
| View | Three-quarter fighting guard | Three-quarter torso facing right, with the far forearm and pocket entry visible |
| Rendering | Dense hatching and small shirt marks | Broader blue color areas, larger pale motifs, fewer facial marks |
| Idle brief | Several-pixel breathing and more pronounced settling | One-to-two SOURCE-pixel targets, fixed expression/head angle and pocket anchors |
| Working/export sizes | 1024px working / 512px export | Same sizes for easy comparison |

The master was generated first, then refined to expose the far arm and second pocket. After assistant visual review, the selected master became frame 01; frames 02–04 were separate edits of that same image. This is an assistant-selected concept, not a record of user likeness approval. The three-quarter face remains an interpretation of a mostly side-view photograph.

## Folder and file map

| Folder | Files / purpose |
| --- | --- |
| References | `ref_friend.png` (identity/outfit), `ref_style_thai_horror_comic.png` (style only) |
| Prompts | Exact `base_prompt.txt`, `master_refinement.txt`, and four `frame_XX.txt` prompts |
| Sketches | First master candidate retained for process comparison, plus pose-guidance notes |
| Keyframe | Selected `idle_master.png`, original 1254×1254 generation |
| Frames | `idle_01.png`–`idle_04.png`, original 1254×1254 images |
| Cleanup | Padded 1024×1024 `idle_XX_work.png` and four-layer `idle_layers.ora` |
| Export | Four 512×512 transparent PNGs, 2048×512 `idle_sprite_sheet.png`, timing/registration JSON |
| Notes | Krita instructions, facial cleanup checklist, generation notes, preview and rebuild scripts |

## Export specification

- One horizontal row, four **512×512** cells: 01 → 02 → 03 → 04 → repeat.
- Sheet: **2048×512**, RGBA PNG. No external cell gutter; transparent margins are inside each cell.
- Suggested timing: **250 ms per pose**, one-second loop.
- Shared pivot: **(256,474)** in top-left pixel coordinates; normalized bottom-left **(0.5,0.07421875)**.
- All source canvases receive the same scale and padding; no per-frame crop or automatic recentering.

## What is finished, and what still needs cleanup

The requested concept package, prompts, four frames and assembled sheet are present. True exterior transparency and file dimensions were checked; master/frame-01 identity and ORA layer structure were verified.

The AI variations still change some hair texture, shirt motifs/hatching, and subtle facial contours. The shoe baseline differs by at most one exported pixel. Source interiors are near-opaque rather than uniformly alpha 255. Use the detailed cleanup checklist before treating this as production art. The notes describe exactly how to reuse the master head and footwear to stabilize the loop.

`*_work.png` denotes a cleanup starting point. `*_clean.png` is reserved for a reviewed paint-over; no unedited AI file has been mislabeled clean. The current final concept sheet is assembled from working copies.

`idle_layers.ora` is a layered still document for Krita, not an animated KRA. Import the four working frames into a timeline and save a KRA as described in the workflow. No native Krita session was operated or animation controller changed.
