param(
    [string]$ArchivePath = "Resources/KnowledgeBase/Taxonomy Hub Source Archive.md",
    [switch]$Check
)

$ErrorActionPreference = 'Stop'
$marker = '<!-- preserved-source:'
$sections = [System.Collections.Generic.List[string]]::new()

foreach ($index in Get-ChildItem -LiteralPath 'Areas' -Recurse -Filter '_Index.md') {
    $text = Get-Content -Raw -LiteralPath $index.FullName
    $start = $text.IndexOf($marker, [StringComparison]::Ordinal)
    if ($start -lt 0) { continue }

    $source = $text.Substring($start)
    $relative = $index.FullName.Substring((Get-Location).Path.Length).TrimStart('\')
    $sections.Add("## $relative`n`n$source")
}

if ($sections.Count -eq 0) {
    Write-Host 'No preserved hub material found.'
    exit 0
}

$archive = @"
# Taxonomy Hub Source Archive
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #taxonomy #migration #archive

## TL;DR / Quick Reference

**Definition:** Historical hub text retained as migration evidence after the clean taxonomy cutover.

**When to use:**
- Use only to recover context while reviewing or improving a canonical note.

**Key Takeaways:**
- This is not live navigation and must not receive new links.
- Canonical navigation lives in [[Resources/KnowledgeBase/Software Engineering Taxonomy|Software Engineering Taxonomy]].

## Historical Source Material

$($sections -join "`n`n---`n`n")

## Related Concepts
- [[Resources/KnowledgeBase/Taxonomy Rules|Taxonomy Rules]]
- [[Resources/KnowledgeBase/Taxonomy Migration Ledger|Taxonomy Migration Ledger]]

## Review Schedule
- [ ] Retain until all merged hub material has been reviewed into canonical notes.
"@

if (-not $Check) {
    Set-Content -LiteralPath $ArchivePath -Value $archive -NoNewline -Encoding utf8
}

Write-Host "Archived preserved material from $($sections.Count) indexes."
