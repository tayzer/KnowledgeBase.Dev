param([switch]$Check)

$ErrorActionPreference = 'Stop'
$windows1252 = [Text.Encoding]::GetEncoding(1252)
$utf8 = [Text.UTF8Encoding]::new($false)
$markers = [char[]]@(0x00F0, 0x00E2, 0x00C2)
$files = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Filter '*.md') + @(Get-ChildItem -LiteralPath 'Resources/KnowledgeBase' -Filter '*.md')
$changed = 0

foreach ($file in $files) {
    $before = Get-Content -Raw -LiteralPath $file.FullName
    if ($null -eq $before) { continue }
    if ($before.IndexOfAny($markers) -lt 0) { continue }
    $after = $before
    for ($pass = 0; $pass -lt 3; $pass++) {
        if ($after.IndexOfAny($markers) -lt 0) { break }
        $candidate = $utf8.GetString($windows1252.GetBytes($after))
        if ($candidate -eq $after) { break }
        $after = $candidate
    }
    if ($after -ne $before) {
        $changed++
        if (-not $Check) { [IO.File]::WriteAllText($file.FullName, $after, $utf8) }
    }
}

Write-Host "Repaired $changed files with reversible UTF-8 mojibake."
