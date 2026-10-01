# BlueShirtGuy

Concept: transparent full-body 3/4 illustration, 1024 x 1536.
Idle: eight 3/4 pixel-art frames, 160 ms each (1.28 second loop).
Walk: eight right-facing frames, 100 ms each (0.8 second loop).
Idle2: eight 3/4 frames with both hands in pants pockets, 160 ms each (1.28 second loop).
Walk2: eight right-facing frames with both hands in pants pockets, 100 ms each (0.8 second loop).

Individual animation frames are 128 x 128 PNGs. Each sprite sheet is 512 x 256, four columns and two rows, ordered left-to-right then top-to-bottom. All four animations share a 32-color palette including transparency, binary alpha and a ground baseline at y=120 measured from the top. Original character illustrations were generated with the built-in image tool; exports were normalized and palette-reduced, then assembled into editable Aseprite animations using the installed Aseprite CLI. GIFs are timing previews; use the PNGs for Unity.

Idle2 and Walk2 are in their own folders under Animations. Each folder contains eight numbered PNG frames, a Sheet.png, an editable .aseprite animation and a Preview.gif. They use the original project sprites as the visual reference and the original export palette. Their generation prompts preserve the original identity, proportions, outfit, pixel style and outlines while placing both hands inside pants pockets throughout the cycle. Idle2 uses subtle breathing in 3/4 view; Walk2 retains right-facing contact and passing poses with pocketed arms. No original animation files were replaced.

Unity import: Texture Type Sprite (2D and UI), Sprite Mode Multiple for sheets, Filter Mode Point, Compression None, Generate Mip Maps disabled. Slice by Grid by Cell Size, 128 x 128. Use a custom pivot of (0.5, 0.0625) and the same Pixels Per Unit for both animations (128 is a useful starting point). Enable Loop Time on animation clips. Individual PNGs use Sprite Mode Single. Unity playback has not been tested in the editor.

Prompt brief: preserve the photographed man's buzzcut, facial likeness, light-blue patterned short-sleeve shirt, dark trousers and grey athletic shoes. Use the game screenshot only for crisp pixel clusters, cel shading, outlines and readable arcade silhouettes. Derive both animations from the concept. Idle uses a relaxed 3/4 stance and subtle breathing; walk uses right-facing contact, recoil, passing and raised-knee poses. No copied reference characters, backgrounds, text or effects.
