param([switch]$Strict)

$ErrorActionPreference = 'Stop'
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$approvedAreas = @('Foundations','Architecture and System Design','Data Systems','State, Coordination and Workflows','Application Development','Languages, Runtimes and Frameworks','Cloud and Platform Engineering','Reliability and Operations','Security and Privacy','Testing and Quality','Software Delivery and Evolution','Engineering Practice','Domains and Specialisms')
$actualAreas = @(Get-ChildItem -LiteralPath 'Areas' -Directory | Select-Object -ExpandProperty Name)
foreach ($area in $actualAreas | Where-Object { $_ -notin $approvedAreas }) { $warnings.Add("Untracked empty legacy directory exists locally: Areas/$area") }
foreach ($area in $approvedAreas | Where-Object { $_ -notin $actualAreas }) { $errors.Add("Missing approved area: Areas/$area") }

$manifest = Get-Content -Raw -LiteralPath 'Resources/KnowledgeBase/Software Engineering Taxonomy.json' | ConvertFrom-Json
$expectedIndexes = @($manifest.nodes | Where-Object { $_.kind -eq 'category' }).Count
$indexes = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Filter '_Index.md')
if ($indexes.Count -ne $expectedIndexes) { $errors.Add("Expected $expectedIndexes category indexes; found $($indexes.Count).") }

$notes = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Filter '*.md')
$requiredPatterns = @('(?m)^# ','(?m)^Date:','(?m)^Status:','(?m)^Tags:','(?m)^## .*TL;DR / Quick Reference','(?m)^## .*Related Concepts','(?m)^## .*Review Schedule')
foreach ($note in $notes) {
    $text = Get-Content -Raw -LiteralPath $note.FullName
    if ($null -eq $text) { $text = '' }
    foreach ($pattern in $requiredPatterns) {
        if ($text -notmatch $pattern) { $errors.Add("Missing note-contract element in $($note.FullName): $pattern"); break }
    }
    $status = [regex]::Match($text, '(?m)^Status:\s*(.+)$').Groups[1].Value.Trim()
    if ($status -notin @('Needs Review','Current','🟢 Current','🟡 Needs Review')) { $errors.Add("Invalid status in $($note.FullName)") }
    if ($note.Name -eq '_Index.md') {
        foreach ($match in [regex]::Matches($text, '\[\[([^\]|#]+)(?:\|[^\]]+)?\]\]')) {
            $target = $match.Groups[1].Value
            if ($target -notmatch '/' -and $target -ne 'Areas/_Index') { $errors.Add("Bare index link in $($note.FullName): $target") }
        }
    }
}

$allMarkdown = @(Get-ChildItem -Recurse -Filter '*.md' | Where-Object {
    $_.FullName -notlike '*\.git\*' -and
    $_.FullName -notlike '*\Jobs\*' -and
    $_.Name -ne 'CLAUDE.md' -and
    $_.Name -ne 'Taxonomy Hub Source Archive.md'
})
$byBase = @{}
foreach ($file in $allMarkdown) {
    $key = $file.BaseName.ToLowerInvariant()
    if (-not $byBase.ContainsKey($key)) { $byBase[$key] = @() }
    $byBase[$key] += $file.FullName
}
foreach ($file in $allMarkdown) {
    if ($file.FullName -like '*Documentation Templates.md' -or $file.FullName -like '*note-template.md') { continue }
    $text = Get-Content -Raw -LiteralPath $file.FullName
    if ($null -eq $text) { $text = '' }
    foreach ($match in [regex]::Matches($text, '\[\[([^\]|#]+)(?:\|[^\]]+)?\]\]')) {
        $target = $match.Groups[1].Value.Trim()
        if ($target -match '/') {
            $path = $target.Replace('/','\\')
            if (-not $path.EndsWith('.md')) { $path += '.md' }
            if (-not (Test-Path -LiteralPath $path)) { $errors.Add("Broken path wikilink in $($file.FullName): $target") }
        }
        else {
            $key = [IO.Path]::GetFileNameWithoutExtension($target).ToLowerInvariant()
            if (-not $byBase.ContainsKey($key)) { $errors.Add("Missing wikilink in $($file.FullName): $target") }
            elseif ($byBase[$key].Count -gt 1 -and $key -ne '_index') { $errors.Add("Ambiguous wikilink in $($file.FullName): $target") }
        }
    }
}

$legacyPattern = 'Areas/(Architecture and Patterns|Cloud and Delivery|Data and State|Application State|Developer Workflow|Domain Overlays|Languages and Frameworks|Operations and Reliability|Security)(/|\]\])'
foreach ($file in $allMarkdown | Where-Object { $_.FullName -notlike '*Taxonomy Migration Ledger*' -and $_.FullName -notlike '*Migrate-ToSoftwareEngineeringTaxonomy.ps1*' }) {
    $text = Get-Content -Raw -LiteralPath $file.FullName
    if ($null -eq $text) { $text = '' }
    if ($text -match $legacyPattern) { $errors.Add("Retired taxonomy reference in $($file.FullName)") }
}

$terminalCount = @($manifest.nodes | Where-Object { $_.kind -eq 'terminal' }).Count
if ($terminalCount -ne 729) { $errors.Add("Expected 729 planned terminal occurrences; found $terminalCount in manifest.") }

Write-Host "Validation errors: $($errors.Count); warnings: $($warnings.Count)."
if ($warnings.Count) { $warnings | ForEach-Object { Write-Warning $_ } }
if ($errors.Count) { $errors | ForEach-Object { Write-Host "ERROR: $_" -ForegroundColor Red } }
if ($Strict -and $errors.Count) { exit 1 }
