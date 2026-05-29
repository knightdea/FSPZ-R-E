$Root = "C:\Users\Sky\Downloads\SURVIVOR"
Set-Location $Root
$StockLib = Join-Path $Root "ANALYZE\libil2cpp_stock_1068.so"
$OutLib = Join-Path $Root "apk_decoded_1068\lib\arm64-v8a\libil2cpp.so"
$ApplyJs = Join-Path $Root "tools\apply_v97_1068.js"
if (-not (Test-Path $StockLib)) { Copy-Item $OutLib $StockLib -Force }
$jsBytes = [IO.File]::ReadAllBytes($ApplyJs)
if ($jsBytes.Length -ge 2 -and $jsBytes[1] -eq 0) {
    $t = [IO.File]::ReadAllText($ApplyJs, [Text.Encoding]::Unicode)
    [IO.File]::WriteAllText($ApplyJs, $t, [Text.UTF8Encoding]::new($false))
}
Copy-Item $StockLib $OutLib -Force
# run_v71 default patches SDK paths and crash on boot; gate flips are duplicated in apply --aggressive.
node $ApplyJs --aggressive
$apk = Join-Path $Root "ANALYZE\fury-survivor-v1.068-offline-bypass-v187.apk"
$apktool = Get-ChildItem "$Root\tools" -Filter "apktool*.jar" | Select-Object -First 1
java -jar $apktool.FullName b "$Root\apk_decoded_1068" -o $apk
$signer = Get-ChildItem "$Root" -Recurse -Filter "uber-apk-signer*.jar" | Select-Object -First 1
java -jar $signer.FullName --apks $apk --allowResign --overwrite
Write-Host "Built v187 $apk"

