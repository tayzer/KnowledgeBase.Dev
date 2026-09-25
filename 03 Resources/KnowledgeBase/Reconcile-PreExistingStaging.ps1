param(
    [string]$BaselinePatchPath = "$env:TEMP/kb-taxonomy-pre-stage.patch"
)

$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $BaselinePatchPath)) { throw "Missing baseline staged patch: $BaselinePatchPath" }

$oldPath = $null
$pairs = [System.Collections.Generic.List[object]]::new()
foreach ($line in Get-Content -LiteralPath $BaselinePatchPath) {
    if ($line -like 'rename from *') {
        $oldPath = $line.Substring('rename from '.Length)
    }
    elseif ($line -like 'rename to *' -and $null -ne $oldPath) {
        $pairs.Add([pscustomobject]@{ Old = $oldPath; Intermediate = $line.Substring('rename to '.Length) })
        $oldPath = $null
    }
}

$ledger = Get-Content -Raw -LiteralPath 'Resources/KnowledgeBase/Taxonomy Migration Ledger.json' | ConvertFrom-Json
$mappings = foreach ($pair in $pairs) {
    $entry = @($ledger | Where-Object { $_.Source -eq $pair.Intermediate })
    if ($entry.Count -ne 1) { throw "Could not resolve staged migration destination for $($pair.Intermediate)." }
    [pscustomobject]@{ Old = $pair.Old; Destination = $entry[0].Destination }
}

# Six former overview notes were intentionally merged during the final taxonomy move.
# Restore them as real overview notes so the user's already-staged migration remains a
# coherent, independently stageable layer at its final canonical destination.
foreach ($mapping in $mappings) {
    if (-not (Test-Path -LiteralPath $mapping.Destination)) {
        $directory = Split-Path -Parent $mapping.Destination
        New-Item -ItemType Directory -Force -Path $directory | Out-Null
        $content = (& git show "HEAD:$($mapping.Old)") -join "`n"
        [IO.File]::WriteAllText((Join-Path (Get-Location) $mapping.Destination), $content + "`n", [Text.UTF8Encoding]::new($false))
    }
}

# Rebuild the index as the user left it: only their original Data Systems migration is staged.
# This does not alter worktree content; all taxonomy normalization remains unstaged.
& git reset --quiet
foreach ($mapping in $mappings) {
    $blob = (& git rev-parse "HEAD:$($mapping.Old)").Trim()
    & git update-index --force-remove -- $mapping.Old
    & git update-index --add --cacheinfo "100644,$blob,$($mapping.Destination)"
}

Write-Host "Restored $($mappings.Count) pre-existing staged Data Systems migrations; later taxonomy changes remain unstaged."
