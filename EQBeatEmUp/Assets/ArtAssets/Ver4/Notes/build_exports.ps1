param([switch]$UseCleanFrames)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.IO.Compression
$root = Split-Path $PSScriptRoot -Parent
$png = [System.Drawing.Imaging.ImageFormat]::Png
function New-Canvas([int]$w, [int]$h) {
    return [System.Drawing.Bitmap]::new($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
}
function Draw-Scaled($canvas, $source, $rect) {
    $g = [System.Drawing.Graphics]::FromImage($canvas)
    $g.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($source, $rect, 0, 0, $source.Width, $source.Height, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
}
$report = @()
$sheet = New-Canvas 2048 512
$sg = [System.Drawing.Graphics]::FromImage($sheet)
$sg.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
for ($i=1; $i -le 4; $i++) {
    $n = '{0:D2}' -f $i
    if ($UseCleanFrames) {
        $path = Join-Path $root "Cleanup/idle_${n}_clean.png"
    } else { $path = Join-Path $root "Frames/idle_$n.png" }
    $src = [System.Drawing.Bitmap]::new($path)
    if ($UseCleanFrames -and ($src.Width -ne 1024 -or $src.Height -ne 1024)) { throw 'Clean frames must be 1024 x 1024 with the same registration.' }
    if (-not $UseCleanFrames -and ($src.Width -ne 1254 -or $src.Height -ne 1254)) { throw 'Raw generation dimensions changed; review common registration before packing.' }
    $work = New-Canvas 1024 1024
    if ($UseCleanFrames) { $rect = [System.Drawing.Rectangle]::new(0,0,1024,1024) }
    else { $rect = [System.Drawing.Rectangle]::new(64,64,896,896) }
    Draw-Scaled $work $src $rect
    if (-not $UseCleanFrames) { $work.Save((Join-Path $root "Cleanup/idle_${n}_work.png"), $png) }
    $frame = New-Canvas 512 512
    Draw-Scaled $frame $work ([System.Drawing.Rectangle]::new(0,0,512,512))
    $frame.Save((Join-Path $root "Export/idle_$n.png"), $png)
    $sg.DrawImageUnscaled($frame, (($i-1)*512), 0)
    $minX=512; $minY=512; $maxX=-1; $maxY=-1; $transparent=0; $opaque=0; $partial=0
    for ($y=0; $y -lt 512; $y++) { for ($x=0; $x -lt 512; $x++) {
        $a=$frame.GetPixel($x,$y).A
        if ($a -eq 0) { $transparent++ } elseif ($a -eq 255) { $opaque++ } else { $partial++ }
        if ($a -gt 8) { $minX=[Math]::Min($minX,$x); $minY=[Math]::Min($minY,$y); $maxX=[Math]::Max($maxX,$x); $maxY=[Math]::Max($maxY,$y) }
    } }
    $report += [ordered]@{frame="idle_$n";sourceSize=@($src.Width,$src.Height);exportSize=@(512,512);boundsAlphaAbove8=@($minX,$minY,$maxX,$maxY);transparentPixels=$transparent;opaquePixels=$opaque;partialAlphaPixels=$partial}
    $frame.Dispose(); $work.Dispose(); $src.Dispose()
}
$sg.Dispose()
$sheet.Save((Join-Path $root 'Export/idle_sprite_sheet.png'),$png)
$sheet.Dispose()
$status = if ($UseCleanFrames) { 'exported from user cleanup files; inspect loop before shipping' } else { 'AI concept; common scale/padding only; manual temporal cleanup pending' }
[ordered]@{status=$status;cellWidth=512;cellHeight=512;columns=4;rows=1;order=@('idle_01','idle_02','idle_03','idle_04');durationMsPerFrame=250;loopDurationMs=1000;pivotPixelsFromTopLeft=@(256,476);pivotNormalizedFromBottomLeft=@(0.5,0.0703125);rects=@(@(0,0,512,512),@(512,0,512,512),@(1024,0,512,512),@(1536,0,512,512));frames=$report} | ConvertTo-Json -Depth 6 | Set-Content (Join-Path $root 'Export/idle_sprite_sheet.json') -Encoding utf8

# OpenRaster is a layered still document, not a Krita animation timeline.
if (-not $UseCleanFrames) {
    $oraPath = Join-Path $root 'Cleanup/idle_layers.ora'
    $stream = [System.IO.File]::Open($oraPath,[System.IO.FileMode]::Create)
    $zip = [System.IO.Compression.ZipArchive]::new($stream,[System.IO.Compression.ZipArchiveMode]::Create)
    function Add-ZipText($name,$value) {
        $entry=$zip.CreateEntry($name,[System.IO.Compression.CompressionLevel]::NoCompression)
        $writer=[System.IO.StreamWriter]::new($entry.Open(),[System.Text.UTF8Encoding]::new($false))
        $writer.Write($value); $writer.Dispose()
    }
    function Add-ZipFile($name,$path) {
        $entry=$zip.CreateEntry($name)
        $dest=$entry.Open(); $source=[System.IO.File]::OpenRead($path)
        $source.CopyTo($dest); $source.Dispose(); $dest.Dispose()
    }
    Add-ZipText 'mimetype' 'image/openraster'
    $layers=''
    for ($i=1;$i -le 4;$i++) {
        $n='{0:D2}' -f $i
        $visibility=if ($i -eq 1) { 'visible' } else { 'hidden' }
        $layers += "<layer name='idle_${n}_work' src='data/idle_$n.png' opacity='1.0' visibility='$visibility' composite-op='svg:src-over' x='0' y='0'/>"
        Add-ZipFile "data/idle_$n.png" (Join-Path $root "Cleanup/idle_${n}_work.png")
    }
    Add-ZipText 'stack.xml' "<?xml version='1.0' encoding='UTF-8'?><image version='0.0.3' w='1024' h='1024' name='Idle concept - cleanup pending'><stack>$layers</stack></image>"
    Add-ZipFile 'mergedimage.png' (Join-Path $root 'Cleanup/idle_01_work.png')
    $zip.Dispose(); $stream.Dispose()
}
$report | ConvertTo-Json -Depth 4
