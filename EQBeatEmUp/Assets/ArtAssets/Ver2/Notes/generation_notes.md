# Generation and validation notes

Created 2026-10-01 using the built-in image generation tool with transparent-background requests. No API fallback, external AI plugin, pose-control backend or native Krita automation was used.

- Reference A: attached friend photograph, copied unchanged to `References/ref_friend.png`.
- Reference B: attached comic cover, copied unchanged to `References/ref_style_thai_horror_comic.png`; used only for visual style.
- Master: base prompt plus A and B. The returned original is 1254×1254 RGBA, despite the requested square working concept. The request's desired generous margins were not fully followed, so mechanical padding was added only to working/export copies.
- Frame 01: exact copy of master. Its prompt documents this intentional reuse.
- Frames 02, 03, 04: separate edits of the original master using their respective saved prompts. Each is 1254×1254 RGBA. None was generated from another variation.
- Original generated assets remain unchanged in `Keyframe` and `Frames`.
- Working copies use the same scale and placement for all four frames: source 1254 square to 896 square, offset (64,64) on a transparent 1024 square. No individual crop, centering, shape deformation or repainting was performed.
- Exports are 512 square with a 2048×512 horizontal sheet. JSON includes actual alpha bounds and pixel counts. All four exported lowest visible soles reach y=473. This shared bound is useful registration evidence, but does not prove every foot contour is identical.
- `idle_layers.ora` contains four named working raster layers and a master merged preview; it is not an animation timeline and is not a native KRA file. Save a KRA in Krita after importing the animation frames.
- The schematic pose guide is drawn using simple geometric construction lines. It is intended as beginner guidance, not an AI-rendered additional character.

Known cleanup: shirt motifs/buttons and fine hatching drift; the exhale lowers the head more than intended (export top bounds vary from y=36 to y=46). Some contours and shoe detail change slightly. Keep master face, shoe and texture pixels when painting the final loop, and reduce movement toward the small offsets in the workflow. The supplied sheet is ready for concept review, not final art approval.

Alpha check: exterior pixels are truly transparent. Sampled interior pixels in the original master are mostly alpha 252–253 of 255, so the generated figure is slightly translucent rather than uniformly opaque. This original alpha has been preserved. For production cleanup, paint solid base colors under the interior silhouette if it must be fully opaque, while retaining antialiased contour pixels. Review over both light and dark backgrounds. Do not fill the whole canvas.

File validation: OpenRaster archive and stack XML read successfully with four layers; all four source frames have expected dimensions; frame 01 is byte-identical to the master; the assembled sheet and schematic were visually inspected. Native Krita opening/timeline playback has not been tested in this session.
