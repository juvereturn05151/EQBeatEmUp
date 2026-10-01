# Native pixel artwork. Every mark is an integer grid operation on 640x360.
# The AI study is NOT loaded, resampled, filtered or quantized by this script.
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Split-Path $PSScriptRoot -Parent
$png=[System.Drawing.Imaging.ImageFormat]::Png
$hex=@{
ink='272B32';deep='343940';metalShadow='384C50';metal='496567';metalLight='65807A';metalHi='91A096'
wallShadow='7F7467';wall='A39780';wallLight='BBAC8E';cream='D2BD97'
ceilShadow='48474A';ceil='5D5855';ceilHi='756D61';woodDark='4D4945';wood='75614E';woodLight='968064';rust='855F4B'
paper='D7C29C';paperDim='BBA788';goldShadow='966D43';gold='C59555';goldLight='E4B568';sun='F6CD88'
sky1='BD7960';sky2='D59569';sky3='E9AE76';distant='8B6863';tree='596461'
floorDark='756E69';floor='878077';floorLight='9A9081';floorSun='AE9980'
}
$colors=@{};$brush=@{}
foreach($key in $hex.Keys){$colors[$key]=[System.Drawing.ColorTranslator]::FromHtml('#'+$hex[$key]);$brush[$key]=[System.Drawing.SolidBrush]::new($colors[$key])}
function Canvas { [System.Drawing.Bitmap]::new(640,360,[System.Drawing.Imaging.PixelFormat]::Format32bppArgb) }
function Use-Canvas($b){$script:g=[System.Drawing.Graphics]::FromImage($b);$script:g.SmoothingMode=[System.Drawing.Drawing2D.SmoothingMode]::None;$script:g.CompositingMode=[System.Drawing.Drawing2D.CompositingMode]::SourceCopy;$script:g.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::None}
function Paint-Rect([int]$x,[int]$y,[int]$w,[int]$h,[string]$c){if($w -gt 0 -and $h -gt 0){$script:g.FillRectangle($brush[$c],$x,$y,$w,$h)}}
function Paint-Line([int]$x1,[int]$y1,[int]$x2,[int]$y2,[string]$c){
    # Explicit Bresenham pixels: no antialiased line rasterization.
    $dx=[Math]::Abs($x2-$x1);$sx=if($x1 -lt $x2){1}else{-1};$dy=-[Math]::Abs($y2-$y1);$sy=if($y1 -lt $y2){1}else{-1};$err=$dx+$dy
    while($true){Paint-Rect $x1 $y1 1 1 $c;if($x1 -eq $x2 -and $y1 -eq $y2){break};$e2=2*$err;if($e2 -ge $dy){$err+=$dy;$x1+=$sx};if($e2 -le $dx){$err+=$dx;$y1+=$sy}}
}
function Paint-Polygon([int[]]$xy,[string]$c){$pts=[System.Collections.Generic.List[System.Drawing.Point]]::new();for($i=0;$i -lt $xy.Count;$i+=2){$pts.Add([System.Drawing.Point]::new($xy[$i],$xy[$i+1]))};$script:g.FillPolygon($brush[$c],$pts.ToArray())}
function Border($x,$y,$w,$h,$fill,$edge){Paint-Rect $x $y $w $h $edge;Paint-Rect ($x+1) ($y+1) ($w-2) ($h-2) $fill}
function Tube($x,$w){Paint-Rect ($x-2) 7 ($w+4) 7 'ink';Paint-Rect $x 7 $w 5 'ceilHi';Paint-Rect ($x+2) 10 ($w-4) 3 'goldLight';Paint-Rect ($x+4) 11 ($w-8) 1 'sun';Paint-Rect ($x+1) 14 ($w-2) 1 'woodLight'}
function Windows($x,$y,$w,$h){
    Paint-Rect $x $y $w $h 'woodDark';Paint-Rect ($x+3) ($y+3) ($w-6) ($h-6) 'sky1'
    Paint-Rect ($x+3) ($y+22) ($w-6) 27 'sky2';Paint-Rect ($x+3) ($y+49) ($w-6) ($h-52) 'sky3'
    # Clustered clouds and a stepped sun; no gradient.
    Paint-Rect ($x+12) ($y+19) 25 2 'sky3';Paint-Rect ($x+19) ($y+17) 13 2 'sky3';Paint-Rect ($x+$w-43) ($y+30) 32 2 'sky3'
    if($w -gt 130){Paint-Rect ($x+126) ($y+41) 12 14 'sun';Paint-Rect ($x+123) ($y+44) 18 8 'sun'}
    for($i=0;$i -lt ($w-14);$i+=27){$rh=13+(($i*7)%17);Paint-Rect ($x+5+$i) ($y+$h-8-$rh) 24 $rh 'distant';Paint-Rect ($x+8+$i) ($y+$h-10-$rh) 18 2 'distant';for($j=0;$j -lt 3;$j++){Paint-Rect ($x+8+$i+$j*6) ($y+$h-3-$rh) 3 4 'wood'}}
    Paint-Rect ($x+3) ($y+$h-20) ($w-6) 13 'tree'
    for($i=0;$i -lt ($w-20);$i+=19){Paint-Rect ($x+7+$i) ($y+$h-25-(($i*3)%7)) 13 10 'tree';Paint-Rect ($x+10+$i) ($y+$h-28-(($i*3)%7)) 6 6 'tree'}
    for($i=0;$i -lt 4;$i++){Paint-Rect ($x+4+$i*($w-8)/4) $y 3 $h 'woodDark';Paint-Rect ($x+5+$i*($w-8)/4) ($y+2) 1 ($h-4) 'woodLight'}
    Paint-Rect $x ($y+32) $w 3 'woodDark';Paint-Rect $x ($y+33) $w 1 'woodLight';Paint-Rect $x ($y+$h-4) $w 4 'woodDark';Paint-Rect $x ($y+$h) $w 3 'cream';Paint-Rect ($x-2) ($y+$h+3) ($w+4) 2 'wallShadow'
    # A few designed highlights on glass, kept to single clusters.
    Paint-Line ($x+11) ($y+42) ($x+20) ($y+34) 'sky3';Paint-Line ($x+12) ($y+45) ($x+24) ($y+34) 'sky3'
}
function Transom($x,$w){Paint-Rect $x 45 $w 32 'woodDark';Paint-Rect ($x+2) 47 ($w-4) 28 'wood';for($j=0;$j -lt 4;$j++){Paint-Rect ($x+4) (49+$j*6) ($w-8) 3 'ceilShadow';Paint-Rect ($x+4) (52+$j*6) ($w-8) 1 'woodLight'};Paint-Rect ($x+[int]($w/2)-1) 46 3 29 'woodDark'}
function Door($x,$number){
    Paint-Rect ($x-2) 78 86 160 'wallShadow';Paint-Rect $x 78 82 159 'woodDark';Paint-Rect ($x+3) 82 76 152 'wood';Paint-Rect ($x+4) 83 74 150 'wallShadow';Paint-Rect ($x+5) 84 72 1 'wallLight'
    for($k=0;$k -lt 2;$k++){$d=$x+7+$k*36;Paint-Rect $d 90 29 66 'woodDark';Paint-Rect ($d+2) 92 25 61 'metalShadow';Paint-Rect ($d+3) 93 23 38 'sky1';Paint-Rect ($d+3) 105 23 26 'sky2';Paint-Rect ($d+3) 121 23 10 'sky3';Paint-Rect ($d+3) 132 23 20 'wood';Paint-Rect ($d+3) 138 23 2 'woodLight';Paint-Rect ($d+7) 132 17 2 'woodDark';Paint-Rect ($d+9) 140 2 12 'woodDark';Paint-Rect ($d+21) 140 2 12 'woodDark';Paint-Rect ($d+13) 92 2 61 'woodDark';Paint-Rect ($d+1) 153 27 2 'woodLight';Paint-Rect ($d+21) 168 3 16 'woodDark';Paint-Rect ($d+22) 169 1 12 'metalHi';Paint-Rect $d 218 29 8 'woodLight';Paint-Rect ($d+2) 219 25 6 'wallShadow';Paint-Rect ($d+3) 224 8 2 'wood'}
    Paint-Rect ($x+40) 82 2 152 'woodDark';Paint-Rect ($x+3) 234 76 3 'woodLight'
    # Small classroom plates use sparse pixel marks, no pseudo-language.
    Border ($x+25) 66 31 10 'metal' 'woodDark';Paint-Rect ($x+29) 69 4 4 'paper';Paint-Rect ($x+36) 69 3 4 'paper';Paint-Rect ($x+42) 69 7 1 'paper';Paint-Rect ($x+48) 70 1 3 'paper'
}
function Lockers($x,$n){
    Paint-Rect ($x-2) 168 ($n*24+4) 69 'woodDark';Paint-Rect $x 169 ($n*24) 2 'metalHi'
    for($i=0;$i -lt $n;$i++){$q=$x+$i*24;Paint-Rect $q 171 24 63 'metalShadow';Paint-Rect ($q+1) 172 21 60 'metal';Paint-Rect ($q+2) 173 1 57 'metalLight';Paint-Rect ($q+2) 172 19 1 'metalLight';Paint-Rect ($q+4) 179 12 5 'metalShadow';Paint-Rect ($q+5) 180 10 2 'paperDim';Paint-Rect ($q+4) 198 3 12 'deep';Paint-Rect ($q+5) 199 1 8 'metalHi';for($j=0;$j -lt 3;$j++){Paint-Rect ($q+6) (218+$j*3) 12 1 'metalShadow';Paint-Rect ($q+7) (219+$j*3) 10 1 'metalLight'};Paint-Rect ($q+19) 208 2 1 'metalLight';Paint-Rect ($q+18) 209 1 2 'metalLight';if($i%3 -eq 1){Paint-Rect ($q+4) 230 5 1 'rust'}}
    for($i=0;$i -lt $n;$i++){
        $q=$x+$i*24
        Paint-Rect ($q+3) 174 1 1 'metalHi';Paint-Rect ($q+19) 230 1 1 'metalShadow'
        if($i%2 -eq 0){Paint-Rect ($q+3) 188 2 1 'metalLight';Paint-Rect ($q+4) 187 1 1 'metalLight';Paint-Rect ($q+17) 228 3 1 'metalShadow';Paint-Rect ($q+19) 227 1 1 'metalShadow'}
        if($i%3 -eq 1){Paint-Rect ($q+9) 204 4 1 'metalLight';Paint-Rect ($q+10) 205 2 1 'metalLight';Paint-Rect ($q+2) 225 2 4 'rust';Paint-Rect ($q+3) 227 2 1 'woodLight'}
    }
    Paint-Rect ($x-2) 235 ($n*24+4) 3 'deep'
}
function Notice($x,$y,$w,$h,$paperColor){Paint-Rect ($x+1) ($y+1) $w $h 'woodDark';Paint-Rect $x $y $w $h $paperColor;Paint-Rect ($x+[int]($w/2)) ($y+1) 1 1 'goldShadow';Paint-Rect ($x+3) ($y+5) ($w-6) 2 'rust';for($j=0;$j -lt 3;$j++){Paint-Rect ($x+3) ($y+10+$j*3) ($w-6-($j%2)*3) 1 'wallShadow'}}
function Trophy($x,$y,$h){Paint-Rect ($x+4) ($y+$h-3) 16 3 'woodDark';Paint-Rect ($x+6) ($y+$h-4) 12 2 'gold';Paint-Rect ($x+11) ($y+9) 3 ($h-13) 'goldShadow';Paint-Rect ($x+10) ($y+9) 2 ($h-12) 'gold';Paint-Rect ($x+6) $y 13 4 'goldLight';Paint-Rect ($x+7) ($y+4) 11 4 'gold';Paint-Rect ($x+9) ($y+8) 7 3 'goldShadow';Paint-Rect ($x+7) ($y+2) 2 5 'sun';Paint-Line ($x+3) ($y+2) ($x+3) ($y+6) 'gold';Paint-Line ($x+3) ($y+6) ($x+8) ($y+9) 'gold';Paint-Line ($x+21) ($y+2) ($x+21) ($y+6) 'gold';Paint-Line ($x+21) ($y+6) ($x+17) ($y+9) 'gold'}

# Layer 1: architecture, ceiling, windows, exterior silhouettes.
$back=Canvas;Use-Canvas $back
Paint-Rect 0 0 640 238 'wall';Paint-Rect 0 0 640 29 'ceil';Paint-Rect 0 26 640 4 'ceilShadow';Paint-Rect 0 30 640 9 'wallShadow';Paint-Rect 0 39 640 2 'wallLight'
for($x=-60;$x -lt 700;$x+=110){Paint-Line $x 0 ($x-28) 27 'ceilShadow';Paint-Line ($x+1) 0 ($x-27) 27 'ceilHi'};Paint-Line 0 19 639 19 'ceilShadow'
Tube 25 76;Tube 278 85;Tube 532 78
Paint-Rect 0 167 640 68 'metalLight';Paint-Rect 0 166 640 2 'wallShadow';Paint-Rect 0 232 640 4 'woodDark';Paint-Rect 0 236 640 3 'deep'
Windows 5 78 113 84;Windows 239 78 195 84
Transom 5 113;Transom 130 82;Transom 239 195;Transom 549 82
foreach($x in 120,215,436,535){Paint-Rect $x 40 10 195 'wallShadow';Paint-Rect ($x+2) 41 7 123 'wall';Paint-Rect ($x+2) 166 7 65 'metal';Paint-Rect ($x+2) 233 7 3 'wood';Paint-Rect ($x+2) 43 1 118 'wallLight'}
# Designed chips near structural joints rather than random noise.
foreach($xy in @(@(18,42),@(117,119),@(226,191),@(441,85),@(537,221),@(610,39),@(87,165))){$x=$xy[0];$y=$xy[1];Paint-Rect $x $y 6 1 'wallShadow';Paint-Rect ($x+1) ($y+1) 3 2 'wallShadow'}
foreach($xy in @(@(227,64),@(443,144),@(533,171),@(112,224),@(221,213),@(629,62))){$x=$xy[0];$y=$xy[1];Paint-Rect $x $y 3 2 'wallShadow';Paint-Rect ($x+2) ($y-1) 3 1 'wallShadow';Paint-Rect ($x+1) ($y+2) 1 3 'wallShadow'}
$g.Dispose();$back.Save((Join-Path $root 'Background/Layers/01_BackWall.png'),$png)

# Layer 2: wall fixtures, no floor obstructions.
$fixtures=Canvas;Use-Canvas $fixtures
Door 130 '2A';Door 549 '2B';Lockers 5 4;Lockers 240 8
Border 451 77 79 79 'wood' 'woodDark';Border 454 80 73 73 'metalShadow' 'woodLight';Paint-Rect 456 82 69 69 'metal'
Notice 460 87 22 30 'paper';Notice 491 85 27 35 'paperDim';Notice 463 123 29 23 'paperDim';Notice 501 126 18 19 'paper'
Paint-Rect 452 157 77 3 'wallShadow'
# Pin heads, torn corners and a small illustrated notice instead of dense text.
Paint-Rect 475 86 3 1 'cream';Paint-Rect 480 114 2 3 'metal';Paint-Rect 493 91 8 5 'sky1';Paint-Rect 494 94 6 4 'sky2';Paint-Rect 503 92 11 1 'wood';Paint-Rect 503 95 8 1 'wood';Paint-Rect 472 136 9 3 'metalLight'
Border 451 163 79 74 'wood' 'woodDark';Paint-Rect 455 167 71 49 'deep';Paint-Rect 456 168 68 45 'metalShadow';Paint-Rect 456 169 68 2 'woodLight'
Trophy 459 183 29;Trophy 484 175 37;Trophy 504 187 25
Paint-Rect 456 212 68 3 'woodLight';Paint-Rect 455 216 71 17 'woodDark';Border 458 219 27 11 'woodLight' 'wood';Border 489 219 34 11 'woodLight' 'wood';Paint-Rect 482 222 1 4 'gold';Paint-Rect 491 222 1 4 'gold';Paint-Rect 490 167 2 48 'woodDark';Paint-Line 516 169 507 179 'metalLight';Paint-Line 519 169 508 180 'metalLight'
# Exposed conduit and a restrained clock.
Paint-Rect 448 44 85 1 'wallShadow';Paint-Rect 448 44 1 23 'wallShadow';Border 477 47 20 20 'woodDark' 'wallShadow';Paint-Rect 480 49 14 16 'paperDim';Paint-Rect 478 52 18 10 'paperDim';Paint-Rect 486 51 1 6 'woodDark';Paint-Rect 486 56 5 1 'woodDark';Paint-Rect 486 50 1 1 'wood';Paint-Rect 486 63 1 1 'wood';Paint-Rect 479 56 1 1 'wood';Paint-Rect 493 56 1 1 'wood'
$g.Dispose();$fixtures.Save((Join-Path $root 'Background/Layers/02_Fixtures.png'),$png)

# Layer 3: floor, shallow depth and subdued geometrical sunlight.
$floor=Canvas;Use-Canvas $floor
Paint-Rect 0 239 640 121 'floor';Paint-Rect 0 239 640 9 'floorDark';Paint-Rect 0 322 640 38 'floorLight'
# Broad opaque light patches, not detailed glossy reflections.
Paint-Polygon @(7,247,112,247,70,313,0,313,0,260) 'floorSun';Paint-Polygon @(243,247,426,247,390,304,206,304) 'floorSun'
# Window mullion breaks in the patches.
Paint-Polygon @(43,247,49,247,7,313,1,313) 'floor';Paint-Polygon @(79,247,86,247,44,313,37,313) 'floor'
foreach($x in 279,324,369){Paint-Polygon @($x,247,($x+6),247,($x-30),304,($x-36),304) 'floor'}
foreach($y in 251,275,310,352){Paint-Line 0 $y 639 $y 'floorDark';if($y -ge 275){Paint-Line 0 ($y+1) 639 ($y+1) 'floorLight'}}
for($x=-70;$x -lt 740;$x+=64){$end=[int](320+($x-320)*1.26);Paint-Line $x 239 $end 359 'floorDark'}
# Sparse wear: small clusters at edges, open lower-middle kept quiet.
foreach($xy in @(@(26,263),@(85,331),@(559,283),@(609,320),@(440,343),@(118,296))){$x=$xy[0];$y=$xy[1];Paint-Rect $x $y 5 1 'floorDark';Paint-Rect ($x+4) ($y-1) 3 1 'floorDark';Paint-Rect ($x+1) ($y+1) 3 1 'floorLight'}
$g.Dispose();$floor.Save((Join-Path $root 'Background/Layers/03_PlayableFloor.png'),$png)

# Layer 4: a one-pixel near edge, no tall occluders.
$front=Canvas;Use-Canvas $front;Paint-Rect 0 359 640 1 'floorDark';$g.Dispose();$front.Save((Join-Path $root 'Background/Layers/04_ForegroundEdge.png'),$png)
$bg=Canvas;$cg=[System.Drawing.Graphics]::FromImage($bg);$cg.CompositingMode=[System.Drawing.Drawing2D.CompositingMode]::SourceOver
foreach($layer in @($back,$fixtures,$floor,$front)){$cg.DrawImageUnscaled($layer,0,0)};$cg.Dispose();$bg.Save((Join-Path $root 'Background/SchoolHallway_BG.png'),$png)

# Exact pixel copies of actual sprites. Binary alpha, no tint, transform or redraw.
$verify=@()
foreach($anim in 'Idle2','Walk2'){
    $sprite=[System.Drawing.Bitmap]::new((Join-Path $root "Reference/${anim}_01_exact.png"));$preview=$bg.Clone();$x0=246;$y0=181
    # A separate two-step ground contact patch; no character pixel is altered.
    Use-Canvas $preview
    Paint-Rect 281 299 58 3 'floorDark';Paint-Rect 286 298 47 1 'floorDark';Paint-Rect 288 302 43 1 'floorDark'
    Paint-Rect 287 300 46 1 'ceilHi'
    $g.Dispose()
    for($y=0;$y -lt 128;$y++){for($x=0;$x -lt 128;$x++){$c=$sprite.GetPixel($x,$y);if($c.A -eq 255){$preview.SetPixel($x0+$x,$y0+$y,$c)}elseif($c.A -ne 0){throw 'Partial-alpha character pixel; do not alter source'}}}
    $out=Join-Path $root "Preview/SchoolHallway_${anim}Preview.png";$preview.Save($out,$png)
    $mismatch=0;$count=0;for($y=0;$y -lt 128;$y++){for($x=0;$x -lt 128;$x++){$c=$sprite.GetPixel($x,$y);if($c.A -eq 255){$count++;if($preview.GetPixel($x0+$x,$y0+$y).ToArgb() -ne $c.ToArgb()){$mismatch++}}}}
    $verify += @{animation=$anim;positionTopLeft=@($x0,$y0);scale=1;opaqueSourcePixels=$count;mismatches=$mismatch;footBaselineInclusive=300}
    if($anim -eq 'Idle2'){$preview.Save((Join-Path $root 'Preview/SchoolHallway_GameplayPreview.png'),$png)
        # Integer 3x enlargement: replicated pixels, not interpolated samples.
        $large=[System.Drawing.Bitmap]::new(1920,1080,[System.Drawing.Imaging.PixelFormat]::Format32bppArgb);$lg=[System.Drawing.Graphics]::FromImage($large);$lg.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::NearestNeighbor;$lg.PixelOffsetMode=[System.Drawing.Drawing2D.PixelOffsetMode]::Half;$lg.DrawImage($preview,[System.Drawing.Rectangle]::new(0,0,1920,1080),0,0,640,360,[System.Drawing.GraphicsUnit]::Pixel);$lg.Dispose();$large.Save((Join-Path $root 'Preview/SchoolHallway_GameplayPreview_3x.png'),$png);$large.Dispose()
    };$preview.Dispose();$sprite.Dispose()
}
$unique=[System.Collections.Generic.HashSet[int]]::new();$nonOpaque=0
for($y=0;$y -lt 360;$y++){for($x=0;$x -lt 640;$x++){$c=$bg.GetPixel($x,$y);[void]$unique.Add($c.ToArgb());if($c.A -ne 255){$nonOpaque++}}}
if($nonOpaque -ne 0){throw 'Background has an alpha gap'}
[ordered]@{resolution=@(640,360);paletteColors=$unique.Count;nonOpaqueBackgroundPixels=$nonOpaque;grid='native integer 1px; no downsampling';recommendedPPU=100;walkableFootRegion=@(32,258,608,338);previewTests=$verify} | ConvertTo-Json -Depth 6 | Set-Content (Join-Path $root 'Notes/verification.json') -Encoding utf8
$hex | ConvertTo-Json | Set-Content (Join-Path $root 'Notes/palette.json') -Encoding utf8
foreach($b in @($back,$fixtures,$floor,$front,$bg)){$b.Dispose()};foreach($b in $brush.Values){$b.Dispose()}
Write-Output 'Native pixel background and exact-sprite previews saved.'

