$ErrorActionPreference = 'Stop'
$src = Join-Path $env:USERPROFILE '.zcode\workspace\default\cat-site'
$out = Join-Path $src 'single'
New-Item -ItemType Directory -Force -Path $out | Out-Null
$html = [IO.File]::ReadAllText((Join-Path $src 'index.html'))
$gif = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
$keys = @{ '01-bucket'='bucket'; '02-bag'='bag'; '03-belly'='belly'; '04-snack'='snack'; '05-rice'='rice'; '06-collar'='collar' }

# 1) embed each photo once, in the JS IMG map only (keyed replace is unique)
Get-ChildItem (Join-Path $src 'web\*.jpg') | ForEach-Object {
  $key = $keys[$_.BaseName]
  if (-not $key) { throw ('unknown file: ' + $_.Name) }
  $b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($_.FullName))
  $html = $html.Replace($key + ": '" + $_.Name + "'", $key + ": 'data:image/jpeg;base64," + $b64 + "'")
}

# 2) at init, assign images from the IMG map so nothing duplicates
$snippet = '(function(){var pics=[IMG.bucket,IMG.bag,IMG.belly,IMG.snack,IMG.rice,IMG.collar];var h=document.querySelector(''.hero-avatar'');if(h)h.src=IMG.bucket;var a=document.getElementById(''avatar'');if(a)a.src=IMG.bucket;document.querySelectorAll(''.photo img'').forEach(function(im,i){if(pics[i])im.src=pics[i];});document.querySelectorAll(''.photo'').forEach(function(f,i){if(pics[i])f.dataset.src=pics[i];});})();updateHUD();'
$before = $html
$html = $html.Replace("updateHUD();`ntypeCat(TXT.hello, null);", $snippet + "`ntypeCat(TXT.hello, null);")
if ($html -eq $before) { throw 'init anchor not found' }

# 3) remaining static src attributes become a 1px placeholder (real ones arrive via JS)
Get-ChildItem (Join-Path $src 'web\*.jpg') | ForEach-Object {
  $html = $html.Replace($_.Name, $gif)
}

[IO.File]::WriteAllText((Join-Path $out 'index.html'), $html, (New-Object System.Text.UTF8Encoding($false)))
'built: ' + (Get-Item (Join-Path $out 'index.html')).Length + ' bytes'
