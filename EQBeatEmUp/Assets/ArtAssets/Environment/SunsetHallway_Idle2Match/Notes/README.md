# Sunset Hallway — Idle2 style match

The existing `Assets/ArtAssets/Environment/Sunset Hallway_ School Stage Backdrop.png` was updated in place. Its **1672×941** dimensions and Unity GUID were retained. The original PNG and importer settings are backed up in `Reference/SunsetHallway_original.png` and `Reference/original_importer.txt`.

## Art changes

The built-in image generator restyled the supplied hallway using the actual `BlueShirtGuy_Idle2_01.png` as a visual anchor. The character was explicitly excluded from generation. A second focused pass replaced the highly reflective floor with quieter matte tiles and broad muted warm patches.

The doors, overhead pipes/lights, open locker, poster/bench area, clock, trophy cabinet and sunset windows remain recognizable. Fine grime and micro-detail were simplified into larger clusters. Floor litter and the wet-floor stand were removed from the lane. The dark character silhouette and blue shirt have more separation from the floor.

Exact prompts are saved in `edit_prompt.txt` and `floor_refinement_prompt.txt`; the intermediate style pass is archived in `Reference/style_pass_01.png`. No blur, mosaic/pixelation filter, palette quantization or photographic downsampling was applied to the final generated backdrop.

## Exact character integration

`Preview/SunsetHallway_Idle2Preview.png` composites the actual Idle2 frame 01 over the empty backdrop. Each opaque source pixel is replicated into a **2×2** block, with no interpolation, tint or redraw. Sprite canvas top-left is `(700,500)`; visible character height is **216px**, and the lowest sole pixel is **y=739**. The next pixel row, y=740, is the ground-contact boundary.

All 3,514 original opaque sprite pixels match in all four replicated pixels: **zero mismatches**. All 52 original files in Idle2 and Walk2, including importer settings, remained unchanged. `verification.json` records the checks and `build_preview.ps1` reproduces them. The clean background contains no actor.

The approximately 310px-high classroom opening is about 1.44 times the 216px preview character height. This is why the 2× test was selected instead of the initially considered 3× test.

## Unity scale and import

The backdrop importer now uses **200 PPU**, **Point** filtering, **None** compression across its listed platforms, no mipmaps and no NPOT resize. Its GUID is unchanged, preserving asset references. The original character textures remain at **100 PPU**. With both transforms at scale 1, two background texture pixels correspond to one character source pixel, matching the composited test.

At this setting the backdrop is 8.36×4.705 world units and the visible character is about 1.08 units tall. Changing background PPU from its previous 100 reduces its world footprint by half; check the camera/stage placement if it was already placed in a scene. No scene transforms, camera or character importer were changed. Preserve integer display scaling and avoid camera smoothing/post-process antialiasing when checking pixel sharpness.

The original character metadata still uses its existing filtering/compression values; this task does not change those protected files. The PNG mockup tests the actual source artwork rather than Unity's runtime texture processing.

## Important distinction

This is an **AI-rendered visual style match**, not a verified native-grid, indexed-palette background. The actual generated file contains **291,304 distinct colors**, despite the deliberately stepped appearance and limited-palette prompt. Edge/texture sampling therefore does not exactly reproduce Idle2's 27–30-color native pixel structure. Point filtering prevents added sampling blur but cannot turn that artwork into strict palette-limited pixel art. If the earlier strict native-pixel specification is required for a production asset, manual grid/palette cleanup remains necessary; a simple pixelation filter would not satisfy that requirement.

The final backdrop and exact-sprite preview were visually inspected. Unity runtime rendering was not tested. The original is retained for comparison or restoration.
