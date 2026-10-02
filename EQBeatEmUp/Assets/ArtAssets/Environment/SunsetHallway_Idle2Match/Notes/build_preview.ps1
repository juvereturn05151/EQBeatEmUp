$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Split-Path $PSScriptRoot -Parent
$environment=Split-Path $root -Parent
$source=Join-Path $environment 'Sunset Hallway_ School Stage Backdrop.png'
$bg=[System.Drawing.Bitmap]::new($source)
$sprite=[System.Drawing.Bitmap]::new((Join-Path $root 'Reference/Idle2_01_exact.png'))
$preview=$bg.Clone();$scale=2;$px=700;$py=500
# Only composite exact 2x2 copies of opaque source pixels. No tint or interpolation.
$copied=0
for($y=0;$y -lt 128;$y++){for($x=0;$x -lt 128;$x++){$c=$sprite.GetPixel($x,$y);if($c.A -eq 255){for($oy=0;$oy -lt 2;$oy++){for($ox=0;$ox -lt 2;$ox++){$preview.SetPixel($px+$x*2+$ox,$py+$y*2+$oy,$c)}};$copied++}elseif($c.A -ne 0){throw 'Unexpected partial alpha in protected sprite'}}}
$path=Join-Path $root 'Preview/SunsetHallway_Idle2Preview.png'
$preview.Save($path,[System.Drawing.Imaging.ImageFormat]::Png)
$preview.Dispose();$check=[System.Drawing.Bitmap]::new($path);$mismatches=0
for($y=0;$y -lt 128;$y++){for($x=0;$x -lt 128;$x++){$c=$sprite.GetPixel($x,$y);if($c.A -eq 255){for($oy=0;$oy -lt 2;$oy++){for($ox=0;$ox -lt 2;$ox++){if($check.GetPixel($px+$x*2+$ox,$py+$y*2+$oy).ToArgb() -ne $c.ToArgb()){$mismatches++}}}}}}
$colors=[System.Collections.Generic.HashSet[int]]::new()
for($y=0;$y -lt $bg.Height;$y++){for($x=0;$x -lt $bg.Width;$x++){[void]$colors.Add($bg.GetPixel($x,$y).ToArgb())}}
$before=Get-Content (Join-Path $root 'Notes/character_hashes_before.json') -Raw | ConvertFrom-Json
foreach($entry in $before){if((Get-FileHash -LiteralPath $entry.Path).Hash -ne $entry.Hash){throw "Original character file changed: $($entry.Path)"}}
$report=[ordered]@{backdropSize=@($bg.Width,$bg.Height);actualBackdropColorCount=$colors.Count;sourceSpriteSize=@(128,128);sourceOpaquePixels=$copied;spriteScale=2;spriteTopLeft=@($px,$py);visibleCharacterHeight=216;lowestSolePixel=739;exactSpritePixelMismatches=$mismatches;originalCharacterFilesUnchanged=$before.Count;recommendedBackdropPPU=200;originalCharacterPPU=100}
$report | ConvertTo-Json | Set-Content (Join-Path $root 'Notes/verification.json') -Encoding utf8
$report | ConvertTo-Json
$check.Dispose();$bg.Dispose();$sprite.Dispose()
