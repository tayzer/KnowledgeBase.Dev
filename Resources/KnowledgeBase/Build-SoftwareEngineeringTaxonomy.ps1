param(
    [Parameter(Mandatory = $true)]
    [string]$SourceTreePath,
    [string]$ManifestPath = "Resources/KnowledgeBase/Software Engineering Taxonomy.json",
    [switch]$RefreshIndexes,
    [switch]$Check
)

$ErrorActionPreference = 'Stop'

function Get-TreeNodes {
    param([string]$Text)

    $match = [regex]::Match($Text, '(?s)```text\s*Inbox/.*?```')
    if (-not $match.Success) { throw "Could not find target taxonomy tree in $SourceTreePath." }

    $stack = @{}
    $nodes = [System.Collections.Generic.List[object]]::new()
    foreach ($line in ($match.Value -split '\r?\n')) {
        if ($line -notmatch '/\s*$') { continue }
        $indent = $line.Length - $line.TrimStart().Length
        $depth = [int]($indent / 2)
        $name = $line.Trim().TrimEnd('/')
        $stack[$depth] = $name
        foreach ($key in @($stack.Keys | Where-Object { $_ -gt $depth })) { $stack.Remove($key) }
        $parts = for ($i = 0; $i -le $depth; $i++) { if ($stack.ContainsKey($i)) { $stack[$i] } }
        $nodes.Add([pscustomobject]@{ Depth = $depth; Name = $name; Path = ($parts -join '/') })
    }
    return $nodes
}

function Get-SafeTag {
    param([string]$Name)
    return (($Name.ToLowerInvariant() -replace '[^a-z0-9]+', '-') -replace '(^-|-$)', '')
}

function Write-Index {
    param(
        [string]$Path,
        [object]$Node,
        [object[]]$Children,
        [hashtable]$IsCategory
    )

    $title = $Node.Name
    $tag = Get-SafeTag $title
    $available = @()
    $planned = @()
    foreach ($child in $Children) {
        if ($IsCategory.ContainsKey($child.Path)) {
            $available += "- [[Areas/$($child.Path.Substring('Areas/'.Length))/_Index|$($child.Name)]] - category map."
        }
        else {
            $planned += "- $($child.Name)"
        }
    }
    if ($available.Count -eq 0) { $available = @('- No published child category yet.') }
    if ($planned.Count -eq 0) { $planned = @('- No planned terminal topics at this level.') }

    $body = @"
# $title
Date: 2026-08-13
Status: 🟡 Needs Review
Tags: #taxonomy #$tag

## TL;DR / Quick Reference

**Definition:** Navigation index for $title within this software-engineering body of knowledge.

**When to use:**
- Start here when locating a topic in this discipline.

**Key Takeaways:**
- This index routes published notes and child categories.
- Planned coverage is a roadmap, not a set of placeholder notes.

## Deep Dive

### Available Notes and Categories
$($available -join "`n")

### Planned Coverage
$($planned -join "`n")

## Related Concepts
- [[Areas/_Index|Software Engineering Knowledge Base]]

## Review Schedule
- [ ] Review when a planned topic becomes a published note.
"@

    if ($Check) { return }
    $directory = Split-Path -Parent $Path
    New-Item -ItemType Directory -Force -Path $directory | Out-Null
    if ((Test-Path -LiteralPath $Path) -and -not $RefreshIndexes) {
        $existing = Get-Content -Raw -LiteralPath $Path
        if ($existing -notmatch '<!-- taxonomy-navigation:start -->') {
            $body += "`n<!-- taxonomy-navigation:start -->`n<!-- taxonomy-navigation:end -->`n`n## Preserved Material`n`n$existing"
        }
    }
    Set-Content -LiteralPath $Path -Value $body -NoNewline -Encoding utf8
}

$source = Get-Content -Raw -LiteralPath $SourceTreePath
$nodes = @(Get-TreeNodes $source)
$areaNodes = @($nodes | Where-Object { $_.Path -eq 'Areas' -or $_.Path -like 'Areas/*' })
$categoryPaths = @{}
for ($i = 0; $i -lt $nodes.Count; $i++) {
    if ($i + 1 -lt $nodes.Count -and $nodes[$i + 1].Depth -gt $nodes[$i].Depth) {
        $categoryPaths[$nodes[$i].Path] = $true
    }
}

$manifest = [pscustomobject]@{
    schemaVersion = 1
    generatedOn = '2026-08-13'
    source = 'User-approved SWE body-of-knowledge taxonomy'
    rules = [pscustomobject]@{
        indexFile = '_Index.md'
        plannedLeavesArePlainText = $true
        allowLeafExtensions = $true
        canonicalConceptHome = $true
    }
    nodes = @($areaNodes | ForEach-Object {
        [pscustomobject]@{
            path = $_.Path
            name = $_.Name
            kind = if ($categoryPaths.ContainsKey($_.Path)) { 'category' } else { 'terminal' }
        }
    })
}

if (-not $Check) {
    $manifestDirectory = Split-Path -Parent $ManifestPath
    New-Item -ItemType Directory -Force -Path $manifestDirectory | Out-Null
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $ManifestPath -NoNewline -Encoding utf8
}

foreach ($node in $areaNodes | Where-Object { $categoryPaths.ContainsKey($_.Path) }) {
    $children = @($areaNodes | Where-Object {
        $_.Path -like "$($node.Path)/*" -and $_.Depth -eq ($node.Depth + 1)
    })
    $path = if ($node.Path -eq 'Areas') { 'Areas/_Index.md' } else { "$($node.Path)/_Index.md" }
    if ($RefreshIndexes -or -not (Test-Path -LiteralPath $path)) { Write-Index -Path $path -Node $node -Children $children -IsCategory $categoryPaths }
}

if (-not $Check) {
    $taxonomyMarkdown = @"
# Software Engineering Taxonomy
Date: 2026-08-13
Status: 🟢 Current
Tags: #knowledge-base #taxonomy #software-engineering

## TL;DR / Quick Reference

**Definition:** Authoritative classification model for this knowledge base.

**When to use:**
- When creating, moving, or linking a note under `Areas/`.

**Key Takeaways:**
- Areas define disciplines; folders classify concepts; notes contain knowledge; links express relationships; indexes teach the map.
- Each concept has one canonical home. Cross-cutting use cases link there instead of duplicating explanations.
- Terminal topics without notes are planned coverage, not empty folders or broken links.

## Deep Dive

The machine-readable taxonomy is [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]] (`Software Engineering Taxonomy.json`). Generated category maps live in [[Areas/_Index|Software Engineering Knowledge Base]].

### Approved Areas

$((@($areaNodes | Where-Object { $_.Depth -eq 1 } | ForEach-Object { "- [[Areas/$($_.Name)/_Index|$($_.Name)]]" }) -join "`n"))

## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]
- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]

## Review Schedule
- [ ] Review when an area boundary changes.
"@
    Set-Content -LiteralPath 'Resources/KnowledgeBase/Software Engineering Taxonomy.md' -Value $taxonomyMarkdown -NoNewline -Encoding utf8

    $extensionDirectories = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Directory | Where-Object {
        (Get-ChildItem -LiteralPath $_.FullName -Filter '*.md' -File).Count -gt 0 -and
        -not (Test-Path -LiteralPath (Join-Path $_.FullName '_Index.md'))
    })
    $extensionList = @($extensionDirectories | ForEach-Object {
        $relative = $_.FullName.Substring((Get-Location).Path.Length + 1).Replace('\', '/')
        "- ``$relative``"
    })
$extensionMarkdown = @"
# Taxonomy Leaf Extension Register
Date: 2026-08-13
Status: Current
Tags: #knowledge-base #taxonomy #extensions

## TL;DR / Quick Reference

**Definition:** Register of published-note folders that extend approved terminal taxonomy topics.

**When to use:**
- Before adding a note beneath a terminal topic without creating a new taxonomy category.

**Key Takeaways:**
- These are content-bearing leaf extensions, not empty navigation folders.
- Each remains under its nearest approved taxonomy category.
- New extensions require a canonical-home rationale in the note and a link to the parent category index.

## Registered Extensions

$($extensionList -join "`n")

## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]
- [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]]

## Review Schedule
- [ ] Regenerate after a published note adds or removes a leaf extension.
"@
    Set-Content -LiteralPath 'Resources/KnowledgeBase/Taxonomy Leaf Extension Register.md' -Value $extensionMarkdown -NoNewline -Encoding utf8
}

Write-Host "Generated $($categoryPaths.Count) category indexes and $($areaNodes.Count) area nodes."
