# BlueShirtGuy

Concept: transparent full-body 3/4 illustration, 1024 x 1536.
Idle: eight 3/4 pixel-art frames, 160 ms each (1.28 second loop).
Walk: eight right-facing frames, 100 ms each (0.8 second loop).
Idle2: eight 3/4 frames with both hands in pants pockets, 160 ms each (1.28 second loop).
Walk2: eight right-facing frames with both hands in pants pockets, 100 ms each (0.8 second loop).
Attack1: twelve right-facing frames connecting a jab, cross and headbutt; 1.29 seconds with variable frame timing.
Launch1: eight right-facing frames for a compact grounded upward strike; 0.60 seconds with variable frame timing.
Jump: ten frames covering preparation, takeoff, rising, apex, falling, landing and recovery; 0.83 second preview.
AirAttack1: fourteen airborne frames covering punch, punch and downward smash; 1.00 second preview.

Individual animation frames are 128 x 128 PNGs. Idle, Walk, Idle2, Walk2 and Launch1 sheets are 512 x 256, four columns and two rows. Attack1 is 512 x 384, four columns and three rows. All sheets are ordered left-to-right then top-to-bottom. All six animations share the same 32-color palette including transparency, binary alpha and a ground baseline at y=120 measured from the top. Original character illustrations were generated with the built-in image tool; exports were normalized and palette-reduced, then assembled into editable Aseprite animations using the installed Aseprite CLI. GIFs are timing previews; use the PNGs for Unity.

Jump and AirAttack1 also use 128x128 canvases and the same palette, with airborne alignment described below. Their sheets are respectively 640x256 (5x2) and 896x256 (7x2).

Idle2 and Walk2 are in their own folders under Animations. Each folder contains eight numbered PNG frames, a Sheet.png, an editable .aseprite animation and a Preview.gif. They use the original project sprites as the visual reference and the original export palette. Their generation prompts preserve the original identity, proportions, outfit, pixel style and outlines while placing both hands inside pants pockets throughout the cycle. Idle2 uses subtle breathing in 3/4 view; Walk2 retains right-facing contact and passing poses with pocketed arms. No original animation files were replaced.

Unity import: Texture Type Sprite (2D and UI), Sprite Mode Multiple for sheets, Filter Mode Point, Compression None, Generate Mip Maps disabled. Slice by Grid by Cell Size, 128 x 128. Use a custom pivot of (0.5, 0.0625) and the same Pixels Per Unit for both animations (128 is a useful starting point). Enable Loop Time on animation clips. Individual PNGs use Sprite Mode Single. Unity playback has not been tested in the editor.

Prompt brief: preserve the photographed man's buzzcut, facial likeness, light-blue patterned short-sleeve shirt, dark trousers and grey athletic shoes. Use the game screenshot only for crisp pixel clusters, cel shading, outlines and readable arcade silhouettes. Derive both animations from the concept. Idle uses a relaxed 3/4 stance and subtle breathing; walk uses right-facing contact, recoil, passing and raised-knee poses. No copied reference characters, backgrounds, text or effects.

## Attack1

The Attack1 folder includes 12 numbered PNGs, a 4x3 sheet, editable Aseprite animation and GIF preview. The consistency revision uses Idle2 as the authoritative face, hairstyle, proportions, outfit and relaxed pocketed pose reference; the old attack sheet guides choreography only. Its prompt specifies a connected relaxed-ready, jab, recoil, cross, recoil, headbutt anticipation, lunge, forehead contact and recovery sequence. Frames 3, 6 and 10 are the contact poses. Opening and ending frames directly reuse Idle2 frame 01, translated eight pixels left for the attack pivot. Upright attack poses reuse the same Idle2 head pixels in Aseprite, with nearest-neighbor tilted copies during the headbutt, to prevent facial drift. The other poses were redrawn to match Idle2 and mapped to its exact palette. Hands leave the pockets for the punches and return to the relaxed pocketed endpoint.

Frame durations in milliseconds: 120, 90, 100, 70, 90, 120, 80, 120, 60, 160, 120, 160. These are saved in Aseprite and the GIF; PNGs contain no timing metadata. Use non-looping playback in Unity for the attack (the GIF repeats for inspection). Match these durations with animation keyframe timing rather than a uniform frame rate.

Frame 10 repair: the headbutt contact head and neck were redrawn as a connected silhouette to remove the gap and outline artifacts introduced by the earlier head transplant. This frame uses the existing palette, canvas, baseline and timing; all other PNG frames were preserved. The sheet, Aseprite animation and GIF include the repaired frame.

Attack1 uses custom pivot (0.4375, 0.0625), corresponding to x=56 and y=120 measured from the top, instead of the other animations' x=64 pivot. The eight-pixel shift reserves space for the extended cross while preserving character scale and world alignment. Slice the sheet at 128x128, use Point filtering and no compression, and retain the same Pixels Per Unit. The headbutt is deliberately shorter on screen because the torso bends; individual poses are not independently stretched to equal height. Unity gameplay playback and hitboxes have not been configured or tested.

## Launch1

Eight 128x128 PNG frames, a 512x256 sheet, editable Aseprite file and GIF preview are in Animations/Launch1. The opening and ending PNGs directly reuse Idle2 frame 01 without shifting or resizing. Use the standard pivot (0.5, 0.0625), Point filtering, no compression and the same Pixels Per Unit as Idle2. Slice the sheet into a 4x2 grid of 128x128 cells.

Sequence: relaxed pockets pose, hand release, slight dip, rising fist, high upward contact, short follow-through, recovery, relaxed pockets pose. Frame 5 is the launcher contact. Both feet stay grounded and the striking fist rises clearly above the head in frames 5 and 6. Frame durations in milliseconds: 90, 60, 70, 50, 90, 60, 80, 100 (600 ms total). Aseprite and GIF store this timing; PNGs do not. Disable Loop Time on the Unity attack clip; GIF repetition is for inspection only. Hitboxes and enemy launch behavior are not implemented by these art assets.

The revised generation used the built-in image tool with Idle2 as the main identity, face, buzzcut, proportions, outfit and pocket-pose reference, plus Walk2 for right-facing continuity. Prompt: a compact eight-frame grounded upward punch, brief dip, near-vertical arm with fist well above the crown, short recovery, and no leap or cinematic effects. Aseprite reuses Idle2's face/head pixels on the action poses while preserving connected necks and collars. Opening and ending match Idle2's pixels exactly. A common action-pose scale leaves safe space for the raised fist within the 128x128 canvas. Exports use the exact existing palette, binary transparency, standard pivot and baseline. Unity playback remains untested.

Middle-frame continuity revision: only PNG frames 4-6 were replaced. Frames 1-3 and 7-8 remain byte-identical to the approved set. New strike poses use approved frames 3 and 7 as body/pose references, retain the right-side attacking arm through rise, contact and recoil, reuse frame 7's head pixels, and reuse its lower-body pixels below y=72. The contact fist remains well above the head. The sheet, Aseprite and GIF were rebuilt; durations and pivot are unchanged.

## Jump

Animations/Jump contains BlueShirtGuy_Jump_01.png through _10.png, BlueShirtGuy_Jump_Sheet.png, BlueShirtGuy_Jump.aseprite and BlueShirtGuy_Jump_Preview.gif. Previously completed frames 1-3 were preserved. Frames 1 and 10 match Idle2 frame 01 exactly.

| Frames | Gameplay phase |
| --- | --- |
| 1 | Neutral, hands in pockets |
| 2-3 | Crouch and takeoff anticipation |
| 4-5 | Rising, legs fold after push-off |
| 6 | Apex, both knees tucked |
| 7-8 | Falling and preparing feet for landing |
| 9 | Landing compression |
| 10 | Recovery to relaxed neutral |

Aseprite includes Jump, Rising, Apex and Falling tags. Frame durations in milliseconds: 80, 60, 70, 70, 90, 120, 90, 70, 80, 100. The preview repeats for inspection; gameplay should use jump-state transitions. Hold/reuse frames 4-5 while rising, frame 6 at apex, and frames 7-8 while descending, then play 9-10 upon ground contact. No world-space jump trajectory is baked into the asset: move the actor using gameplay physics. Airborne feet move as legs tuck and extend, rather than being forced to the ground baseline.

## AirAttack1

Animations/AirAttack1 contains BlueShirtGuy_AirAttack1_01.png through _14.png, BlueShirtGuy_AirAttack1_Sheet.png, BlueShirtGuy_AirAttack1.aseprite and BlueShirtGuy_AirAttack1_Preview.gif. Frame 1 directly reuses Jump frame 6, so the aerial combo begins from the same apex pose.

| Frames | Gameplay phase |
| --- | --- |
| 1 | Airborne ready |
| 2-5 | First punch: wind-up, extension, contact on 4, recoil |
| 6-9 | Second punch: wind-up, extension, contact on 8, recoil |
| 10-11 | Raised-arm smash preparation and downward torso lean |
| 12-13 | Downward strike and smash contact on 13 |
| 14 | Follow-through and falling pose |

The finisher fist aims down-right below the waist; it is not another horizontal punch. Aseprite includes AirAttack1, Punch1, Punch2 and DownwardSmash tags. Durations in milliseconds: 70, 60, 40, 80, 50, 60, 40, 100, 60, 90, 70, 50, 130, 100. Use non-looping gameplay playback and return to the appropriate falling/landing state. Hitboxes, enemy launch/smash velocity and Animator transitions are not included.

For both new sets: slice by 128x128 grid in row-major order; use Sprite (2D and UI), Multiple for sheets or Single for individual frames, Point filtering, no mipmaps and no compression. Keep Pixels Per Unit and the pivot consistent with your character controller and other animations. The existing notes use normalized pivot (0.5, 0.0625); if the controller uses a center pivot, apply that consistently instead. Airborne alignment anchors the shirt/hips rather than each shoe; use actor position to control world height.

Both sets were generated with the built-in image tool from approved Idle2/Walk2 sprites, using the inspected concept, Attack1 and Launch1 for consistency. Jump prompt: ordinary right-facing jump with relaxed pocketed endpoints, crouch, folded-leg rising/apex poses, descending legs and landing compression, without flips or effects. AirAttack1 prompt: use the completed Jump apex as the airborne body template for a connected fourteen-frame punch-punch-downward-smash, preserving the same face, outfit, proportions and pixel style. Exports are mapped to the exact Idle2 palette and have binary alpha. Aseprite packages preserve per-frame timing and state tags. All required files are saved beneath this Unity project's Assets/ArtAssets path; the editor may need Assets > Refresh if automatic refresh is paused. Unity runtime playback has not been tested.
