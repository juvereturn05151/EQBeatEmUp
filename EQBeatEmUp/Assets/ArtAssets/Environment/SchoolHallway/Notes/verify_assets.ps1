$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Split-Path $PSScriptRoot -Parent
$before=Get-Content (Join-Path $root 'Notes/character_hashes_before.json') -Raw | ConvertFrom-Json
foreach($entry in $before){if((Get-FileHash -LiteralPath $entry.Path).Hash -ne $entry.Hash){throw "Protected source changed: $($entry.Path)"}}
$bg=[System.Drawing.Bitmap]::new((Join-Path $root 'Background/SchoolHallway_BG.png'))
$palette=[System.Collections.Generic.HashSet[int]]::new()
for($y=0;$y -lt $bg.Height;$y++){for($x=0;$x -lt $bg.Width;$x++){$p=$bg.GetPixel($x,$y);if($p.A -ne 255){throw 'Background is not opaque'};[void]$palette.Add($p.ToArgb())}}
if($bg.Width -ne 640 -or $bg.Height -ne 360 -or $palette.Count -ne 32){throw 'Native dimensions or 32-color palette changed'}
$bg.Dispose()
$pixelTests=@()
foreach($anim in 'Idle2','Walk2'){
    $src=[System.Drawing.Bitmap]::new((Join-Path $root "Reference/${anim}_01_exact.png"))
    $out=[System.Drawing.Bitmap]::new((Join-Path $root "Preview/SchoolHallway_${anim}Preview.png"));$count=0
    for($y=0;$y -lt 128;$y++){for($x=0;$x -lt 128;$x++){$p=$src.GetPixel($x,$y);if($p.A -eq 255){$count++;if($out.GetPixel($x+246,$y+181).ToArgb() -ne $p.ToArgb()){throw "Character pixel changed in $anim preview"}}}}
    $pixelTests+=@{source=$anim;exactOpaquePixels=$count};$src.Dispose();$out.Dispose()
}
$layerCounts=@()
Get-ChildItem (Join-Path $root 'Background/Layers/*.png') | ForEach-Object {$b=[System.Drawing.Bitmap]::new($_.FullName);$partial=0;for($y=0;$y -lt 360;$y++){for($x=0;$x -lt 640;$x++){$a=$b.GetPixel($x,$y).A;if($a -ne 0 -and $a -ne 255){$partial++}}};$b.Dispose();if($partial){throw 'Layer contains partial-alpha pixels'};$layerCounts+=@{file=$_.Name;partialAlpha=0}}
$normal=[System.Drawing.Bitmap]::new((Join-Path $root 'Preview/SchoolHallway_GameplayPreview.png'))
$large=[System.Drawing.Bitmap]::new((Join-Path $root 'Preview/SchoolHallway_GameplayPreview_3x.png'))
for($y=0;$y -lt 360;$y++){for($x=0;$x -lt 640;$x++){$v=$normal.GetPixel($x,$y).ToArgb();for($oy=0;$oy -lt 3;$oy++){for($ox=0;$ox -lt 3;$ox++){if($large.GetPixel($x*3+$ox,$y*3+$oy).ToArgb() -ne $v){throw '3x preview is not exact nearest-neighbor replication'}}}}}
$normal.Dispose();$large.Dispose()
$result=@{protectedFilesUnchanged=$before.Count;backgroundPaletteColors=$palette.Count;nativeResolution=@(640,360);spritePixelTests=$pixelTests;layerChecks=$layerCounts;integer3xReplication='all pixels pass';unityRuntimeTest='not performed'}
$result | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $root 'Notes/final_checks.json') -Encoding utf8
$result | ConvertTo-Json -Depth 5
