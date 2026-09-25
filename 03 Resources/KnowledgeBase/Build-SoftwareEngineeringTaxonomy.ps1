param(
    [string]$SourceTreePath,
    [string]$ManifestPath = 'Resources/KnowledgeBase/Software Engineering Taxonomy.json',
    [switch]$RefreshIndexes,
    [switch]$Check
)

$ErrorActionPreference = 'Stop'

function Get-SafeTag([string]$Name) {
    return (($Name.ToLowerInvariant() -replace '[^a-z0-9]+', '-') -replace '(^-|-$)', '')
}

function Get-QuickDescription([System.IO.FileInfo]$File) {
    $text = Get-Content -Raw -LiteralPath $File.FullName
    $match = [regex]::Match($text, '(?im)^\*\*(?:Definition|What it is):\*\*\s*(.+)$')
    if (-not $match.Success) { return '' }
    $description = $match.Groups[1].Value.Trim()
    # Index summaries are prose, not a second copy of the note's links or emphasis.
    $description = [regex]::Replace($description, '\[\[([^\]|]+)\|([^\]]+)\]\]', '$2')
    $description = [regex]::Replace($description, '\[\[([^\]]+)\]\]', '$1')
    $description = [regex]::Replace($description, '\[([^\]]+)\]\([^)]+\)', '$1')
    return (($description -replace '\*\*|__', '') -replace '\s+', ' ').Trim()
}

function Get-DirectNoteLinks([string]$Directory) {
    if (-not (Test-Path -LiteralPath $Directory -PathType Container)) { return @() }
    return @(Get-ChildItem -LiteralPath $Directory -File -Filter '*.md' |
        Where-Object { $_.Name -ne '_Index.md' } | Sort-Object BaseName | ForEach-Object {
            $relative = $_.FullName.Substring((Get-Location).Path.Length + 1).Replace('\', '/')
            $target = $relative.Substring(0, $relative.Length - 3)
            $summary = Get-QuickDescription $_
            if ($summary) { "- [[$target|$($_.BaseName)]] - $summary" }
            else { "- [[$target|$($_.BaseName)]]" }
        })
}

function Set-IfChanged([string]$Path, [string]$Content) {
    if ((Test-Path -LiteralPath $Path) -and (Get-Content -Raw -LiteralPath $Path) -eq $Content) { return }
    for ($attempt = 1; $attempt -le 8; $attempt++) {
        try {
            Set-Content -LiteralPath $Path -Value $Content -NoNewline -Encoding utf8
            return
        }
        catch {
            if ($attempt -eq 8 -or $_.Exception.Message -notmatch 'user-mapped section') { throw }
            Start-Sleep -Milliseconds (150 * $attempt)
        }
    }
}

function Get-TreeNodes([string]$Text) {
    $match = [regex]::Match($Text, '(?s)```text\s*Inbox/.*?```')
    if (-not $match.Success) { throw "Could not find target taxonomy tree in $SourceTreePath." }
    $stack = @{}
    $nodes = [System.Collections.Generic.List[object]]::new()
    foreach ($line in ($match.Value -split '\r?\n')) {
        if ($line -notmatch '/\s*$') { continue }
        $depth = [int](($line.Length - $line.TrimStart().Length) / 2)
        $stack[$depth] = $line.Trim().TrimEnd('/')
        foreach ($key in @($stack.Keys | Where-Object { $_ -gt $depth })) { $stack.Remove($key) }
        $parts = for ($i = 0; $i -le $depth; $i++) { if ($stack.ContainsKey($i)) { $stack[$i] } }
        $nodes.Add([pscustomobject]@{ Depth = $depth; Name = $stack[$depth]; Path = ($parts -join '/') })
    }
    return $nodes
}

# Keep boundary guidance in the generator so an index refresh does not erase it.
$boundary = @{
    'Areas/Architecture and System Design/Frontend Architecture' = @('System-level client structure, boundaries, rendering choices, and frontend architecture tradeoffs. For component implementation, accessibility, and UX practice, use Frontend and UX Engineering.', 'Areas/Application Development/Frontend and UX Engineering/_Index|Frontend and UX Engineering')
    'Areas/Application Development/Frontend and UX Engineering' = @('Building usable client interfaces: composition, browser behavior, accessibility, and UX practice. For system-level client architecture, use Frontend Architecture.', 'Areas/Architecture and System Design/Frontend Architecture/_Index|Frontend Architecture')
    'Areas/Engineering Practice/Engineering Process' = @('How engineers collaborate, review work, and improve team workflow. For delivery forecasting, scope, and estimation, use Planning and Estimation.', 'Areas/Software Delivery and Evolution/Planning and Estimation/_Index|Planning and Estimation')
    'Areas/Software Delivery and Evolution/Planning and Estimation' = @('Planning delivery scope, effort, and forecasts. For daily engineering workflow and team process, use Engineering Process.', 'Areas/Engineering Practice/Engineering Process/_Index|Engineering Process')
    'Areas/Data Systems/Data Access' = @('Provider-agnostic persistence boundaries, data access patterns, and transaction concerns. For .NET-specific ORM behavior, use Entity Framework Core.', 'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core/_Index|Entity Framework Core')
    'Areas/Languages, Runtimes and Frameworks/Frameworks and Platforms/DotNET/Entity Framework Core' = @('.NET-specific EF Core behavior, mapping, queries, and performance. For provider-agnostic persistence concepts, use Data Access.', 'Areas/Data Systems/Data Access/_Index|Data Access')
}

if ($SourceTreePath) {
    $nodes = @(Get-TreeNodes (Get-Content -Raw -LiteralPath $SourceTreePath))
    $areaNodes = @($nodes | Where-Object { $_.Path -eq 'Areas' -or $_.Path -like 'Areas/*' })
    $categoriesFromTree = @{}
    for ($i = 0; $i -lt $nodes.Count; $i++) {
        if ($i + 1 -lt $nodes.Count -and $nodes[$i + 1].Depth -gt $nodes[$i].Depth) { $categoriesFromTree[$nodes[$i].Path] = $true }
    }
    $manifest = [pscustomobject]@{
        schemaVersion = 1
        generatedOn = '2026-08-13'
        source = 'User-approved SWE body-of-knowledge taxonomy'
        rules = [pscustomobject]@{
            indexFile = '_Index.md'; plannedLeavesArePlainText = $true
            allowLeafExtensions = $true; canonicalConceptHome = $true
        }
        nodes = @($areaNodes | ForEach-Object {
            [pscustomobject]@{ path = $_.Path; name = $_.Name; kind = if ($categoriesFromTree.ContainsKey($_.Path)) { 'category' } else { 'terminal' } }
        })
    }
    if (-not $Check) { $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $ManifestPath -NoNewline -Encoding utf8 }
}
else { $manifest = Get-Content -Raw -LiteralPath $ManifestPath | ConvertFrom-Json }

$categories = @($manifest.nodes | Where-Object { $_.kind -eq 'category' })
$terminals = @($manifest.nodes | Where-Object { $_.kind -eq 'terminal' })
$categorySet = @{}
foreach ($node in $categories) { $categorySet[$node.path] = $true }
$notes = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -File -Filter '*.md' | Where-Object { $_.Name -ne '_Index.md' })

foreach ($node in $categories) {
    $path = "$($node.path)/_Index.md"
    if (-not $RefreshIndexes -and (Test-Path -LiteralPath $path)) { continue }
    $existing = if (Test-Path -LiteralPath $path) { Get-Content -Raw -LiteralPath $path } else { '' }
    $date = [regex]::Match($existing, '(?m)^(?:date|Date):\s*["'']?(\d{4}-\d{2}-\d{2})').Groups[1].Value
    if (-not $date) { $date = '2026-08-13' }
    $status = [regex]::Match($existing, '(?m)^(?:status|Status):\s*(.+)$').Groups[1].Value.Trim() -replace '^[^A-Za-z]+', ''
    if ($status -notin @('Needs Review', 'Current')) { $status = 'Needs Review' }
    $tag = Get-SafeTag $node.name
    $published = @(Get-DirectNoteLinks $node.path)
    $publishedNames = @(Get-ChildItem -LiteralPath $node.path -File -Filter '*.md' |
        Where-Object { $_.Name -ne '_Index.md' } | Select-Object -ExpandProperty BaseName)
    if ($published.Count -eq 0) { $published = @('- No directly published notes yet.') }

    $children = @($manifest.nodes | Where-Object {
        $_.path.StartsWith("$($node.path)/", [StringComparison]::Ordinal) -and
        $_.path.Substring($node.path.Length + 1) -notmatch '/'
    })
    $scope = if ($node.path -eq 'Areas') {
        'Browse the 13 software-engineering disciplines. Each category links to published notes and retains its planned topic map.'
    } elseif ($boundary.ContainsKey($node.path)) { $boundary[$node.path][0] }
    else {
        $topics = @($children | Select-Object -First 4 -ExpandProperty name)
        if ($topics.Count -eq 0) { $topics = @($publishedNames | Select-Object -First 4) }
        $suffix = if ($children.Count -gt 4) { ', and more' } else { '' }
        $hasPublishedBelow = @($notes | Where-Object {
            $_.FullName.Substring((Get-Location).Path.Length + 1).Replace('\', '/').StartsWith("$($node.path)/", [StringComparison]::OrdinalIgnoreCase)
        }).Count -gt 0
        if ($hasPublishedBelow) { "This category covers $($topics -join ', ')$suffix. Published notes and narrower categories are linked below." }
        else { "This planned category covers $($topics -join ', ')$suffix. Browse its approved branches and topic map; published notes will appear here when written." }
    }
    $subcategories = @($children | Where-Object { $_.kind -eq 'category' } | ForEach-Object {
        $childPath = $_.path
        $hasNotes = @($notes | Where-Object {
            $_.FullName.Substring((Get-Location).Path.Length + 1).Replace('\', '/').StartsWith("$childPath/", [StringComparison]::OrdinalIgnoreCase)
        }).Count -gt 0
        $label = if ($hasNotes) { 'published notes below' } else { 'planned coverage' }
        "- [[$($_.path)/_Index|$($_.name)]] - $label."
    })
    if ($subcategories.Count -eq 0) { $subcategories = @('- No approved subcategories at this level.') }

    $leafSections = @()
    foreach ($directory in @(Get-ChildItem -LiteralPath $node.path -Directory | Sort-Object Name)) {
        $childPath = "$($node.path)/$($directory.Name)"
        if ($categorySet.ContainsKey($childPath)) { continue }
        $links = @(Get-DirectNoteLinks $childPath)
        if ($links.Count -gt 0) {
            $leafSections += "### $($directory.Name)"; $leafSections += $links; $leafSections += ''
            $publishedNames += @(Get-ChildItem -LiteralPath $childPath -File -Filter '*.md' |
                Where-Object { $_.Name -ne '_Index.md' } | Select-Object -ExpandProperty BaseName)
        }
    }
    if ($leafSections.Count -eq 0) { $leafSections = @('- No published leaf-extension notes at this level.') }
    # The approved terminal uses a plural label; the canonical published note uses singular.
    if ($node.path -eq 'Areas/Architecture and System Design/Architectural Styles' -and
        'Modular Monolith' -in $publishedNames) { $publishedNames += 'Modular Monoliths' }
    $planned = @($children | Where-Object { $_.kind -eq 'terminal' -and $_.name -notin $publishedNames } |
        ForEach-Object { "- $($_.name)" })
    if ($planned.Count -eq 0) { $planned = @('- No planned terminal topics at this level.') }

    $related = [System.Collections.Generic.List[string]]::new()
    if ($node.path -eq 'Areas') { $related.Add('- [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]]') }
    else {
        $parent = $node.path.Substring(0, $node.path.LastIndexOf('/'))
        $parentName = if ($parent -eq 'Areas') { 'Areas' } else { ($parent -split '/')[-1] }
        $related.Add("- [[$parent/_Index|$parentName]]")
    }
    if ($boundary.ContainsKey($node.path)) { $related.Add("- [[$($boundary[$node.path][1])]]") }

    $body = @('---', "date: `"$date`"", "status: $status", "tags: [taxonomy, $tag]", '---', '',
        "# $($node.name)", '', '## Quick Reference', '', $scope, '', '## Published Notes', '') +
        $published + @('', '## Subcategories', '') + $subcategories +
        @('', '## Published Leaf Extensions', '') + $leafSections +
        @('', '## Planned Coverage', '') + $planned + @('', '## Related Concepts', '') + @($related) +
        @('', '## Review Schedule', '', '- Review when a topic is published or the category boundary changes.', '')
    if (-not $Check) { Set-IfChanged $path ($body -join "`n") }
}

if (-not $Check) {
    $areaLinks = @($categories | Where-Object { $_.path -match '^Areas/[^/]+$' } |
        ForEach-Object { "- [[$($_.path)/_Index|$($_.name)]]" })
    $taxonomy = @('---', 'date: "2026-08-13"', 'status: Current', 'tags: [knowledge-base, taxonomy, software-engineering]', '---', '',
        '# Software Engineering Taxonomy', '', '## Quick Reference', '',
        'The 13 approved areas classify software-engineering knowledge. Folders give concepts one canonical home; indexes expose published notes and planned coverage.', '',
        '## Approved Areas', '') + $areaLinks + @('', '## Related Concepts', '',
        '- [[Areas/_Index|Software Engineering Knowledge Base]]',
        '- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]',
        '- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]',
        '', '## Review Schedule', '', '- Review when an approved area boundary changes.', '')
    Set-IfChanged 'Resources/KnowledgeBase/Software Engineering Taxonomy.md' ($taxonomy -join "`n")

    $extensions = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Directory | Where-Object {
        $relative = $_.FullName.Substring((Get-Location).Path.Length + 1).Replace('\', '/')
        -not $categorySet.ContainsKey($relative) -and @(Get-DirectNoteLinks $_.FullName).Count -gt 0
    } | ForEach-Object { $_.FullName.Substring((Get-Location).Path.Length + 1).Replace('\', '/') } | Sort-Object)
    $register = @('---', 'date: "2026-08-13"', 'status: Current', 'tags: [knowledge-base, taxonomy, extensions]', '---', '',
        '# Taxonomy Leaf Extension Register', '', '## Quick Reference', '',
        'Published-note folders beneath approved terminal topics. Their parent category indexes link to every published note.', '',
        '## Registered Extensions', '') + @($extensions | ForEach-Object { "- ``$_``" }) +
        @('', '## Related Concepts', '', '- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]',
        '- [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]]',
        '', '## Review Schedule', '', '- Regenerate after a published note adds or removes a leaf extension.', '')
    Set-IfChanged 'Resources/KnowledgeBase/Taxonomy Leaf Extension Register.md' ($register -join "`n")
}

Write-Host "Indexed $($categories.Count) categories, $($terminals.Count) planned terminal occurrences, and $($notes.Count) published notes."
