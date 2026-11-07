Add-Type -AssemblyName System.Drawing
$lines = @()
foreach ($f in @('assets\og-image.jpg', 'assets\favicon.svg')) {
  if (Test-Path $f) {
    if ($f -like '*.jpg' -or $f -like '*.jpeg' -or $f -like '*.png') {
      $img = [System.Drawing.Image]::FromFile((Resolve-Path $f))
      $lines += ($f + ' | ' + $img.Width + 'x' + $img.Height + ' | ' + [math]::Round((Get-Item $f).Length/1kb) + 'KB')
      $img.Dispose()
    } else {
      $lines += ($f + ' | exists | ' + [math]::Round((Get-Item $f).Length/1kb) + 'KB')
    }
  } else {
    $lines += ($f + ' | MISSING')
  }
}
$lines | Set-Content -Path '_tmp_out.txt' -Encoding UTF8
