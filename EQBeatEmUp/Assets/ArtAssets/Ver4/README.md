# Ver4 — graphic delinquent-manga idle concept

Ver4 gives the friend a more cartoony, serious face while retaining the blue short-sleeve shirt, dark pants, sneakers, hands-in-pockets stance and vintage Thai horror comic rendering. Earlier versions remain intact.

Start with [the animation preview](Notes/idle_preview.html), [the master keyframe](Keyframe/idle_master.png), and [the Krita workflow](Notes/README.md).

## What changed

| Element | Ver3 direction | Ver4 direction |
| --- | --- | --- |
| Face | Softer, more natural facial modelling | Graphic cartoon shapes and sparse intentional ink marks |
| Eyes/brows | Quiet natural eye treatment | Compact narrow eyes, bold upper lids, strong low brows |
| Jaw/cheeks | Softer cheek and jaw contour | Clear jaw angle, restrained cheek mark, bold jaw/neck shadow |
| Mouth | Relaxed natural lips | Short firm closed mouth line |
| Skin rendering | More finely modelled skin | Broad flat skin area, very little central-face detail |
| Attitude | Calm casual readiness | Serious, composed, confident delinquent-manga presence |
| Clothing | Smaller pale motifs and finer surface marks | Larger readable pale motifs and bold clothing hatch/shadow groups |
| Pose | Both hands in pockets | Same pose principle, stronger readable shoulder/arm silhouette |

The requested Rokudenashi Blues influence informs attitude and graphic simplification only; no existing character was used as a face, hairstyle or costume template. Reference A alone supplied the friend's identity. Reference B supplied Thai pulp-comic ink and print language only. No previous frame was fed into generation as a face reference.

## Process

One master was generated and visually inspected first. It met the intended graphic-face and pocket-pose direction, so it was selected for the concept pass. Frame 01 is an exact copy; frames 02–04 were separate edits of the SAME master. None was generated from another variation. This records assistant selection, not user likeness approval.

## Files

| Folder | Contents |
| --- | --- |
| References | `ref_friend.png`, `ref_style_thai_horror_comic.png`, copied unchanged |
| Prompts | Exact `base_prompt.txt` and four separate `frame_01.txt`–`frame_04.txt` instructions |
| Sketches | Face and pocket-pose construction notes for manual guides |
| Keyframe | Selected `idle_master.png` at the original 1254×1254 size |
| Frames | Original `idle_01.png`–`idle_04.png`, all 1254×1254 |
| Cleanup | Registered 1024×1024 `idle_XX_work.png` and four-layer `idle_layers.ora` |
| Export | Four transparent 512×512 PNGs, 2048×512 sprite sheet and timing/pivot JSON |
| Notes | Workflow, face cleanup guide, generation/QA notes, local preview and rebuild script |

## Export plan

Four **512×512** cells, one horizontal row, **2048×512 PNG**, order 01→02→03→04. Suggested hold: **250 ms per frame**, one-second loop. Shared pivot: **(256,476)** from the top-left, normalized bottom-left **(0.5,0.0703125)**. No per-frame trimming or automatic recentering; transparent margins are inside each cell.

## Current status

The concept package, four frames and final concept sheet are complete. Source/output dimensions, exterior alpha and master/frame-01 identity were checked. All four exported lowest visible soles reach y=475. Head top bounds range from y=36 to y=43; the generated exhale moves farther than the prompt's tiny pixel target.

These images still need a production paint-over: hair texture, shirt motifs, hatching and small facial contours vary between edits. The generator also leaves near-opaque rather than uniformly opaque interior alpha. See [face consistency guidance](Notes/face_cleanup.md) for reusing the master head, tightening motion and cleaning alpha.

`*_work.png` means cleanup input. Future manually reviewed files should use `*_clean.png`; AI originals have not been renamed to imply completed cleanup. The current sheet uses the working concept art.

The ORA is an editable layered still document, not an animated KRA. Import the four working frames in Krita to create a timeline, then save `Cleanup/idle_animation.kra`. No native Krita session or game animation controller was operated.
