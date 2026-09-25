param([switch]$Strict)

$ErrorActionPreference = 'Stop'
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$root = (Get-Location).Path
$vaultRoot = (Resolve-Path -LiteralPath '../..').Path
$templateRoot = Join-Path $vaultRoot '00 System/Templates'
$templateNames = @('Software Engineering - Reference Note.md', 'Software Engineering - Category Index.md', 'Software Engineering - Inbox Capture.md')
$approvedAreas = @('Foundations','Architecture and System Design','Data Systems','State, Coordination and Workflows','Application Development','Languages, Runtimes and Frameworks','Cloud and Platform Engineering','Reliability and Operations','Security and Privacy','Testing and Quality','Software Delivery and Evolution','Engineering Practice','Domains and Specialisms')

function Get-RelativePath([string]$Path) { return $Path.Substring($root.Length + 1).Replace('\', '/') }
function Get-Wikilinks([string]$Text) {
    return @([regex]::Matches($Text, '\[\[([^\]|]+)(?:\|[^\]]+)?\]\]') | ForEach-Object {
        ($_.Groups[1].Value -split '#', 2)[0].Trim()
    } | Where-Object { $_ })
}
function Has-Target([string]$Text, [string]$Target) {
    foreach ($link in @(Get-Wikilinks $Text)) {
        $normalized = if ($link.EndsWith('.md')) { $link.Substring(0, $link.Length - 3) } else { $link }
        if ($normalized -eq $Target) { return $true }
    }
    return $false
}

$actualAreas = @(Get-ChildItem -LiteralPath 'Areas' -Directory | Select-Object -ExpandProperty Name)
foreach ($area in $actualAreas | Where-Object { $_ -notin $approvedAreas }) { $warnings.Add("Untracked area directory: Areas/$area") }
foreach ($area in $approvedAreas | Where-Object { $_ -notin $actualAreas }) { $errors.Add("Missing approved area: Areas/$area") }

$manifest = Get-Content -Raw -LiteralPath 'Resources/KnowledgeBase/Software Engineering Taxonomy.json' | ConvertFrom-Json
$categories = @($manifest.nodes | Where-Object { $_.kind -eq 'category' })
$terminals = @($manifest.nodes | Where-Object { $_.kind -eq 'terminal' })
if ($categories.Count -ne 159) { $errors.Add("Expected 159 approved categories; manifest has $($categories.Count).") }
if ($terminals.Count -ne 729) { $errors.Add("Expected 729 planned terminal occurrences; manifest has $($terminals.Count).") }
$indexes = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -File -Filter '_Index.md')
if ($indexes.Count -ne $categories.Count) { $errors.Add("Expected $($categories.Count) category indexes; found $($indexes.Count).") }

$categorySet = @{}
foreach ($category in $categories) { $categorySet[$category.path] = $true }
$notes = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -File -Filter '*.md')
foreach ($note in $notes) {
    $relative = Get-RelativePath $note.FullName
    $text = Get-Content -Raw -LiteralPath $note.FullName
    if ($null -eq $text) { $text = '' }
    $frontmatter = [regex]::Match($text, '\A---\s*\r?\n(?<yaml>[\s\S]*?)\r?\n---\s*(?:\r?\n|$)')
    if (-not $frontmatter.Success) { $errors.Add("Missing YAML properties: $relative"); continue }
    $yaml = $frontmatter.Groups['yaml'].Value
    $date = [regex]::Match($yaml, '(?m)^date:\s*["'']?(\d{4}-\d{2}-\d{2})["'']?\s*$').Groups[1].Value
    if (-not $date) { $errors.Add("Invalid or missing date property: $relative") }
    else {
        $parsedDate = [DateTime]::MinValue
        if (-not [DateTime]::TryParseExact($date, 'yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::None, [ref]$parsedDate)) {
        $errors.Add("Invalid date value: $relative")
        }
    }
    $status = [regex]::Match($yaml, '(?m)^status:\s*["'']?([^\r\n"'']+)["'']?\s*$').Groups[1].Value.Trim()
    if ($status -notin @('Needs Review', 'Current')) { $errors.Add("Invalid status property: $relative") }
    if ($yaml -notmatch '(?m)^tags:\s*(\[[^\r\n]*\]|\r?\n(?:\s+-\s+[^\r\n]+\r?\n?)+)\s*$') {
        $errors.Add("Invalid or missing tags property: $relative")
    }
    foreach ($heading in @('# ', '## Quick Reference', '## Related Concepts', '## Review Schedule')) {
        if ($text -notmatch "(?m)^$([regex]::Escape($heading))") { $errors.Add("Missing '$heading' heading: $relative") }
    }
    if ($text -match '(?:[\u2600-\u27BF]|[\uD800-\uDBFF][\uDC00-\uDFFF])') {
        $errors.Add("Decorative icon in live note (including code examples): $relative")
    }
    if ($note.Name -eq '_Index.md') {
        foreach ($link in @(Get-Wikilinks $text)) {
            if ($link -notmatch '/' -and $link -ne 'Areas/_Index') { $errors.Add("Bare index wikilink: $relative -> $link") }
        }
    }
}

# Every approved category must be linked by its parent, including planned-only branches.
foreach ($category in $categories | Where-Object { $_.path -ne 'Areas' }) {
    $parent = $category.path.Substring(0, $category.path.LastIndexOf('/'))
    $parentIndex = "$parent/_Index.md"
    $target = "$($category.path)/_Index"
    if (-not (Test-Path -LiteralPath $parentIndex)) { $errors.Add("Missing parent index: $parentIndex"); continue }
    if (-not (Has-Target (Get-Content -Raw -LiteralPath $parentIndex) $target)) {
        $errors.Add("Category unreachable from parent: $target")
    }
}

$topicNotes = @($notes | Where-Object { $_.Name -ne '_Index.md' })
$leafExtensions = @{}
foreach ($note in $topicNotes) {
    $relative = Get-RelativePath $note.FullName
    $directory = ($relative -split '/')[0..(($relative -split '/').Count - 2)] -join '/'
    $owner = $directory
    while ($owner -and -not $categorySet.ContainsKey($owner)) {
        $leafExtensions[$owner] = $true
        $owner = $owner.Substring(0, $owner.LastIndexOf('/'))
    }
    if (-not $owner) { $errors.Add("Topic lacks approved category: $relative"); continue }
    $ownerIndex = "$owner/_Index.md"
    $target = $relative.Substring(0, $relative.Length - 3)
    if (-not (Test-Path -LiteralPath $ownerIndex)) { $errors.Add("Missing owner index: $ownerIndex"); continue }
    if (-not (Has-Target (Get-Content -Raw -LiteralPath $ownerIndex) $target)) {
        $errors.Add("Published note unreachable from index: $target")
    }
}
if ($leafExtensions.Count -ne 29) { $errors.Add("Expected 29 registered content-bearing leaf extensions; found $($leafExtensions.Count).") }

# The source archive and migration ledger preserve historical wording. Live guidance and
# copyable templates use plain headings, bullets, and status values.
foreach ($file in @(Get-ChildItem -LiteralPath 'Resources/KnowledgeBase' -Recurse -File -Filter '*.md' | Where-Object {
    $_.Name -notin @('Taxonomy Hub Source Archive.md', 'Taxonomy Migration Ledger.md', 'Knowledge Base Audit.md')
})) {
    $text = Get-Content -Raw -LiteralPath $file.FullName
    if ($text -match '(?:[\u2600-\u27BF]|[\uD800-\uDBFF][\uDC00-\uDFFF])') {
        $errors.Add("Decorative icon in live guidance or template: $(Get-RelativePath $file.FullName)")
    }
}

foreach ($name in $templateNames) {
    $path = Join-Path $templateRoot $name
    if (-not (Test-Path -LiteralPath $path)) { $errors.Add("Missing vault template: 00 System/Templates/$name"); continue }
    $text = Get-Content -Raw -LiteralPath $path
    if ($text -match '(?:[\u2600-\u27BF]|[\uD800-\uDBFF][\uDC00-\uDFFF])') {
        $errors.Add("Decorative icon in vault template: 00 System/Templates/$name")
    }
    if ($text -notmatch '\A---\s*\r?\n' -or $text -notmatch '(?m)^# ') {
        $errors.Add("Missing properties or title heading in vault template: 00 System/Templates/$name")
    }
}

# Resolve wikilinks across live vault notes; ignore historical archive and audit evidence.
$allMarkdown = @(Get-ChildItem -Recurse -File -Filter '*.md' | Where-Object {
    $_.FullName -notlike '*\.git\*' -and $_.FullName -notlike '*\.github\*' -and $_.FullName -notlike '*\Jobs\*' -and
    $_.Name -ne 'CLAUDE.md' -and $_.Name -ne 'Taxonomy Hub Source Archive.md' -and
    $_.Name -ne 'Knowledge Base Audit.md'
})
$byBase = @{}
foreach ($file in $allMarkdown) {
    $key = $file.BaseName.ToLowerInvariant()
    if (-not $byBase.ContainsKey($key)) { $byBase[$key] = @() }
    $byBase[$key] += $file.FullName
}
foreach ($file in $allMarkdown) {
    $relative = Get-RelativePath $file.FullName
    $text = Get-Content -Raw -LiteralPath $file.FullName
    if ($null -eq $text) { $text = '' }
    foreach ($target in @(Get-Wikilinks $text)) {
        if ($target -match '/') {
            $path = $target.Replace('/', '\')
            if (-not $path.EndsWith('.md')) { $path += '.md' }
            if ($target -like '00 System/*') { $path = Join-Path $vaultRoot $path }
            if (-not (Test-Path -LiteralPath $path)) { $errors.Add("Broken path wikilink: $relative -> $target") }
        }
        else {
            $key = [IO.Path]::GetFileNameWithoutExtension($target).ToLowerInvariant()
            if (-not $byBase.ContainsKey($key)) { $errors.Add("Missing wikilink: $relative -> $target") }
            elseif ($byBase[$key].Count -gt 1 -and $key -ne '_index') { $errors.Add("Ambiguous wikilink: $relative -> $target") }
        }
    }
    foreach ($match in [regex]::Matches($text, '(?<!!)\[[^\]]+\]\((?<target>[^)]+)\)')) {
        $target = $match.Groups['target'].Value.Trim(' ', '<', '>')
        if ($target -match '^(?:https?://|mailto:|#|data:|obsidian:)') { continue }
        $target = [Uri]::UnescapeDataString(($target -split '#', 2)[0])
        if (-not $target) { continue }
        $resolved = if ($target -match '^(?:Areas|Resources|Inbox)/') { Join-Path $root $target }
        else { Join-Path $file.DirectoryName $target }
        if (-not (Test-Path -LiteralPath $resolved)) { $errors.Add("Broken local Markdown link: $relative -> $target") }
    }
}

$legacyPattern = 'Areas/(Architecture and Patterns|Cloud and Delivery|Data and State|Application State|Developer Workflow|Domain Overlays|Languages and Frameworks|Operations and Reliability|Security)(/|\]\])'
foreach ($file in $allMarkdown | Where-Object { $_.FullName -notlike '*Taxonomy Migration Ledger*' }) {
    $text = Get-Content -Raw -LiteralPath $file.FullName
    if ($text -match $legacyPattern) { $errors.Add("Retired taxonomy reference: $(Get-RelativePath $file.FullName)") }
}

Write-Host "Validation errors: $($errors.Count); warnings: $($warnings.Count)."
if ($warnings.Count) { $warnings | ForEach-Object { Write-Warning $_ } }
if ($errors.Count) { $errors | ForEach-Object { Write-Host "ERROR: $_" -ForegroundColor Red } }
if ($Strict -and $errors.Count) { exit 1 }
