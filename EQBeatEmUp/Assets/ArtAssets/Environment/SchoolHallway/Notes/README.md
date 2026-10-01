# School hallway — pixel-art gameplay sample

Open `Preview/index.html` for the movable Idle2/Walk2 review, or `Preview/SchoolHallway_GameplayPreview_3x.png` for an integer-enlarged static view. The deliverable background is **`Background/SchoolHallway_BG.png`**, a native **640×360** PNG.

## Sources and reference status

The requested folders were found under the project's actual names:

- `Assets/ArtAssets/Characters/BlueShirtGuy/Animations/Idle2`
- `Assets/ArtAssets/Characters/BlueShirtGuy/Animations/Walk2`

Those existing sprites were inspected before any art was created. The still mockups use `BlueShirtGuy_Idle2_01.png` and `BlueShirtGuy_Walk2_01.png`. Unchanged copies of all eight frames in each set are included under `Reference/Idle2` and `Reference/Walk2` for a self-contained interactive preview. No earlier Ver2/3/4 concept frame was substituted.

The pasted request mentioned an attached hallway image, but the attachment supplied in this turn contained only `Pasted text.txt`. No user-supplied hallway image was available. The environment follows the written description; `Reference/Hallway_LayoutStudy_AI.png` is a NEW AI composition study created for this task, not the missing user reference. `Reference/request.txt` preserves the brief.

The AI study helped establish wall rhythm and the arrangement of windows, doors, lockers and display cases. The final background was independently drawn from scratch on a 640×360 integer pixel grid using `Notes/draw_hallway.ps1`. The script never loads the AI study: no HD downsampling, pixelation filter, palette-reduction filter or character regeneration was used for the final PNG.

## Character analysis before drawing

| Property | Idle2 | Walk2 |
| --- | --- | --- |
| File canvas | 128×128, eight frames | 128×128, eight frames |
| Visible height | 108px in every frame | 106–108px |
| Visible width | 57px | 37–78px depending on pose |
| Frame 01 bounds, inclusive | x=36–92, y=12–119 | x=29–106, y=12–119 |
| Colors per frame, excluding transparency | 27–30 | 27–30 |
| Partial-alpha pixels | 0 | 0 |
| Existing texture PPU | 100 | 100 |

The apparent smallest detail is **one source pixel**. Outlines are visually about 1px, with some 2px dark clusters at folds, hair and shoe contours. Shading uses compact stepped clusters: dark navy/near-black trousers, saturated mid/light blues, pale shirt motifs and warm tan skin. There are approximately 3–5 useful tonal steps per material, with fine one-pixel highlights kept within compact silhouettes. This is an observed stylistic assessment, not a claim of a single shared indexed palette across all frames.

Measured mean HSL saturation is about 0.38 for Idle2 and 0.35–0.37 for Walk2, excluding transparent pixels. Mean RGB luminance is about 75–76/255 for Idle2 and 68–77/255 for Walk2. The character's darkest masses are deliberately stronger than most background outlines, and its blue/skin highlights are more prominent than the muted corridor surfaces.

The sprite is a right-facing three-quarter figure with a shallow view of the shoes. The environment therefore uses a mostly straight-on back wall and shallow floor depth, not a long one-point corridor disappearing into the distance. The character keeps constant scale as it moves in depth, appropriate for an orthographic arcade sample.

## Native pixel design

- Background: **640×360**, opaque PNG, **32 actual colors**.
- One background pixel equals one original character pixel. All authoring coordinates are integers.
- Broad material fills use roughly 2–4 shading steps. There are no smooth gradients or semitransparent lighting washes.
- Diagonals are staircase clusters; line drawing uses explicit Bresenham pixel positions. Antialiasing is disabled.
- Muted teal lockers, warm plaster/wood, sunset bands and neutral floor tones support the blue-shirt character.
- Wear is sparse and placed around joints/edges. The central lane is quiet. Window light appears as broad matte blocks, not polished reflections.
- Three ceiling fixtures, classroom doors/transoms, notices, low lockers, exterior rooftops/foliage and a trophy cabinet establish the school setting. No NPCs or enemies are present.

Door openings are approximately 150px high, compared with the character's 108px visible height. This gives the corridor architecture headroom without making the player tiny. The character occupies about **30% of the native screen height**. At 3× display it is 324px high, with every source pixel displayed as a 3×3 block.

## Gameplay placement

The back-wall/floor boundary is near **y=239**. The recommended foot-anchor lane is **x=32–608, y=258–338** in top-left image coordinates. This leaves clearance from the wall and front edge, with around 80px of usable depth. It is a visual lane recommendation, not a collider asset.

The static previews place the unscaled 128×128 sprite canvas at **(246,181)**. Frame 01's lowest opaque sole is at scene **y=300**, and the contact boundary immediately below is y=301. Idle frame 01's visible bounds become x=282–338, y=193–300. No per-frame crop, resizing, recoloring or pixel modification is applied.

A small separate stepped ground-contact patch is drawn beneath the sprite in previews only. It is an environment/compositing element and does not overwrite source character pixels. The clean background has no baked-in character or player shadow.

The interactive HTML review loads the same original eight-frame sets, draws them at integer coordinates with `imageSmoothingEnabled=false`, and uses 8 fps for demonstration. Arrow keys move left/right and slightly toward/away from the camera. No character flipping or tinting is performed. This is a review tool, not a Unity scene or gameplay-controller change.

## Layer organization

All layer PNGs are 640×360 with matching registration and binary alpha:

1. `Background/Layers/01_BackWall.png`: ceiling, wall, window framing and exterior silhouettes.
2. `Background/Layers/02_Fixtures.png`: doors, lockers, notices, trophy cabinet and clock.
3. `Background/Layers/03_PlayableFloor.png`: tiles, sparse wear and broad light blocks.
4. `Background/Layers/04_ForegroundEdge.png`: one-pixel near-floor edge, with no tall occluders.

Composite in that order. Keep the first two behind the player and the floor below all actors. The near edge can remain behind the player for this sample. The layers are provided for editing/compositing, not as a fully seamless scrolling tileset; left/right continuation would need adjoining stage sections.

## Unity import recommendations

Use **100 Pixels Per Unit**, matching the existing character texture metadata. At GameObject scale 1, the 640×360 background is **6.4×3.6 Unity units**, while the visible character is about **1.08 units tall**. If your current character prefab has a non-unit transform scale, account for that consistently before evaluating the background. Do not change PPU to an arbitrary 16 or 32 just because this is pixel art.

| Setting | Recommendation |
| --- | --- |
| Texture Type | Sprite (2D and UI) |
| Sprite Mode | Single for each supplied background/layer PNG |
| Pixels Per Unit | 100 |
| Filter Mode | Point (no filter) |
| Compression | None, including platform overrides |
| Generate Mip Maps | Off |
| Max Size | At least 1024 for native images; 2048 for the 1920px preview |
| Non Power of 2 scaling | None |
| Wrap Mode | Clamp |
| sRGB | On for color artwork |
| Mesh Type | Full Rect for full-canvas layers |

The new background/preview texture metadata is configured for Point, uncompressed, 100 PPU and no mipmaps. **Original character import metadata remains unchanged.** The inspected character files currently use `filterMode: 1` (Bilinear) and compression mode 1 rather than Point/None. For an entirely crisp Unity result, review those existing character import settings yourself; this task did not modify them because the brief explicitly protects existing character files.

For a 640×360 reference view at 100 PPU, an orthographic camera size of **1.8** frames 360 vertical pixels. Use integer render scaling (e.g. 1280×720 or 1920×1080), align camera/sprite positions to the pixel grid and avoid post-process antialiasing. A Pixel Perfect Camera can help if your project already uses that package. Do not allow platform texture overrides or an atlas to silently reintroduce compression/filtering.

With a centered background at world (0,0), center-pivot character canvas at preview coordinates (246,181) maps to approximately **world (-0.10,-0.65)**. Existing character pivots are centered, so their foot anchor is roughly 56 source pixels below that pivot. For y-sorting, use a separate foot-anchor transform rather than changing protected source pivots. This sample does not write scene objects or colliders.

Official references: [Unity TextureImporter](https://docs.unity.com/en-us/engine/6000.0/script-reference/unityeditor/textureimporter), [Unity pixel-art import/settings presentation](https://unity3d.jp/wp-content/uploads/2025/05/Unite-Seoul-Unity-2D-project-workflow-for-Pixel-artist-JP.pdf).

## Outputs and verification

- `SchoolHallway_BG.png`: clean native background.
- `SchoolHallway_GameplayPreview.png`: exact Idle2 frame 01 integration at native size.
- `SchoolHallway_Idle2Preview.png`: same idle composition, named by animation.
- `SchoolHallway_Walk2Preview.png`: exact Walk2 frame 01 integration.
- `SchoolHallway_GameplayPreview_3x.png`: nearest-neighbor presentation enlargement.
- `Preview/index.html`: movable, animated source-sprite review.

`verification.json` records the background palette count, dimensions, lane and exact sprite-copy tests. Every one of the 3,514 opaque Idle2 frame-01 pixels and 3,330 opaque Walk2 frame-01 pixels matches its source color in the previews: **zero mismatches**. SHA-256 checks cover all 52 original files in the two source directories, including PNGs, Aseprite files, animation/controller files and importer metadata. They remained unchanged.

The supplied PNGs were visually inspected. Native Unity rendering was not run in this session. The requested external hallway image was unavailable, so composition matching to that specific reference remains unverified.

To reproduce the final art and stills, run `Notes/draw_hallway.ps1` from PowerShell. It only writes within this SchoolHallway folder. It intentionally refreshes its own generated outputs; preserve edited versions before rebuilding. The AI study is archived for provenance and is not an input to that drawing script.
