# Thai pulp-comic idle concept

Start with [the beginner Krita workflow](Notes/README.md) and [the looping preview](Notes/idle_preview.html).

This project lives in `Assets/ArtAssets/Ver2` inside the Unity project. All authored deliverables are contained here.

The master was generated first with the built-in image generation tool. Frames 02–04 were then generated one at a time from that SAME master. Frame 01 is an exact copy of the master. Reference A supplies identity/outfit; Reference B supplies only ink, hatching, shadows and print style.

## Contents

| Folder | Purpose |
| --- | --- |
| References | Original attached friend photo and comic style reference |
| Prompts | Exact base prompt and four separate frame instructions |
| Sketches | Transparent schematic pose guide; not a finished character drawing |
| Keyframe | Original generated `idle_master.png` at 1254×1254 |
| Frames | Four original generated PNGs at 1254×1254 |
| Cleanup | Padded 1024×1024 `*_work.png` files and layered `idle_layers.ora` |
| Export | Four 512×512 RGBA frames, 2048×512 sheet and registration/timing JSON |
| Notes | Full workflow, looping HTML preview, reproducible export script and generation notes |

## Current status

These are animation CONCEPT assets. Common sizing, transparent padding and sheet assembly are complete. Fine shirt motifs, hatching and small anatomical contours vary between AI frames. Manual temporal cleanup is still required for a production sprite. `*_work.png` names deliberately distinguish these starting files from future `*_clean.png` approvals. The export sheet currently uses those concept images.

`idle_layers.ora` is an editable layered still file that Krita can open. It is NOT an animated `.kra`; use the import instructions to create the timeline and save `Cleanup/idle_animation.kra` in Krita. No Krita plugin was installed and no native Krita session was controlled.

The default preview is four unique poses held for 250 ms each, giving a one-second loop. Every frame shares a fixed 512×512 cell and pivot `(256,474)` measured from the cell's top-left. See the JSON for details.
