# More human likeness, less AI-looking face

## Use identity shapes before rendering

Reference A is a small, mostly side-view face. Treat the new three-quarter view as an interpretation; do not invent highly detailed eye folds or claim exact reconstruction of unseen features. The friend photo is the sole identity authority. The comic cover must not supply facial anatomy or expression.

Match these relationships before adding texture:

- Skull outline and short buzz-cut hairline. Keep hair close to the head, not a wavy or raised hairstyle.
- Forehead slope and brow-to-eye spacing. A quiet, naturally sized eye usually works better than a large shining eye with a heavy dramatic arch.
- Nose projection and its relationship to the mouth. Avoid a generic pinched nose or razor-sharp highlight.
- Cheek fullness, mouth corner and chin contour. Preserve the friend's softer lower-face silhouette instead of imposing a square superhero jaw or sunken cheek.
- Ear size and position relative to brow and nose. Keep ears and neck thickness stable between frames.

Compare at equal head height rather than comparing a large generated portrait to a tiny source photograph. Do not use a beautifying filter, perfect symmetry, sharp cheekbone cutouts, or repeated facial hatch lines to compensate for incorrect proportions. Two or three accurate shadow groups often look more human than many tiny artificial creases.

## Concrete V3 paint-over targets

The selected master is calmer and less angular than V2. It is still a stylized likeness, not guaranteed exact recognition. In particular, inspect the nose/lip profile and lower-face contour against A, and decide whether to soften or shorten any feature before animation cleanup.

The derived images redraw some buzz-cut texture into longer-looking marks, subtly change cheek/eye contours, and smooth skin differently from the master. These changes need a single consistent treatment. Do not accept them just because the pose remains similar.

## Reuse one corrected head

1. Work on `Cleanup/idle_animation.kra` with the original raw layer preserved underneath and a separate cleanup layer/group above it.
2. On the master, select the WHOLE head: hair, ear, face, jaw and a short neck section. Leave enough neck overlap to repair the collar connection. Isolating only eyes/mouth makes seams and proportions harder to manage.
3. Copy the corrected master head to a separate transparent layer. Use it as the head source for every pose. Establish its natural proportions once at frame 01.
4. On each pose, remove or mask the original generated head from a DUPLICATE body layer first. Merely laying a replacement over a larger old head can leave a second outline or hair fringe.
5. Place a duplicate of the same corrected head at that pose's small offset. Start with **no head movement**, then add at most 1 working pixel if breathing still needs it. A stable face is preferable to unnecessary animation.
6. Use integer-pixel translation where possible. Avoid repeated resize, rotation, warp and subpixel filtering: these can blur or bend facial features. Shoulders can breathe beneath a stable head.
7. Paint only the neck/collar seam, matching ink thickness and flat colors. Do not redraw eyes, nose or mouth separately for every frame. Keep expression and gaze fixed.
8. Turn onion skins on. Blink between poses at matching positions and watch the brow, nostril, lip corner, ear and jaw. They should move as one head shape without stretching.

If the head's tiny displacement exposes a gap, repair neck/body pixels rather than distorting the jaw to fill it. For hands-in-pockets animation, elbow/shoulder motion should taper down to zero near the pocket entries.

## Face style and transparency

Use a restrained skin palette: a base tone, one main shadow and a small highlight if needed. Keep strong contours around the silhouette, lighter internal marks around mouth/eye/nose, and very sparse central-face hatching. Let rough print texture live mainly on clothing. Keep slight natural asymmetry; don't mirror half a face.

Check over white, medium grey and dark layers. Sampled original master interiors were mostly alpha 253, with a sampled value of 254; these are near-opaque rather than fully solid. If the character must be fully opaque, add solid interior base color under the head/body silhouette and preserve boundary antialiasing. Never flatten onto an opaque background. Hide all review layers before PNG export.

The reliable final result comes from one good face reused across the loop. More generation passes are not a substitute for locking that drawing.
