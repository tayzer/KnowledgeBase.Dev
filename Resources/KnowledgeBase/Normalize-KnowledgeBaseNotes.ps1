param([switch]$Check)

$ErrorActionPreference = 'Stop'

function Get-TitleFromPath([string]$Path) {
    $name = [IO.Path]::GetFileNameWithoutExtension($Path)
    if ($name -eq '_Index') { return (Split-Path -Leaf (Split-Path -Parent $Path)) }
    return ($name -replace '([a-z])([A-Z])', '$1 $2')
}

function Get-Tags([string]$Path) {
    $folders = (Split-Path -Parent $Path) -split '[\\/]'
    $tokens = @('knowledge-base') + @($folders | Where-Object { $_ -and $_ -ne 'Areas' } | Select-Object -Last 2 | ForEach-Object { ($_ -replace '[^A-Za-z0-9]+', '-').ToLowerInvariant().Trim('-') })
    return (($tokens | Where-Object { $_ } | Select-Object -Unique | ForEach-Object { '#{0}' -f $_ }) -join ' ')
}

function Normalize-Note([IO.FileInfo]$File) {
    $text = Get-Content -Raw -LiteralPath $File.FullName
    $title = Get-TitleFromPath $File.FullName

    if ($text -notmatch '(?m)^# ') { $text = "# $title`n`n$text" }
    if ($text -notmatch '(?m)^Date:') { $text = [regex]::Replace($text, '(?m)^(# .*\r?\n)', { param($m) $m.Groups[1].Value + 'Date: 2026-08-13' + "`n" }, 1) }
    if ($text -notmatch '(?m)^Status:') { $text = [regex]::Replace($text, '(?m)^(# .*\r?\nDate: .*\r?\n)', { param($m) $m.Groups[1].Value + 'Status: Needs Review' + "`n" }, 1) }
    if ($text -notmatch '(?m)^Tags:') { $tags = Get-Tags $File.FullName; $text = [regex]::Replace($text, '(?m)^(# .*\r?\nDate: .*\r?\nStatus: .*\r?\n)', { param($m) $m.Groups[1].Value + "Tags: $tags`n" }, 1) }
    $text = [regex]::Replace($text, '(?m)^Status:.*$', 'Status: Needs Review')

    if ($text -notmatch '(?m)^## .*TL;DR / Quick Reference') {
        $insert = "`n## TL;DR / Quick Reference`n`n**Definition:** Reference guidance for $title.`n`n**When to use:**`n- Use this note when making a decision about $title.`n`n**Key Takeaways:**`n- Check scope, trade-offs, and related concepts before applying guidance.`n- This migrated note needs content review before it is marked current.`n"
        $text = [regex]::Replace($text, '(?m)^(Tags:.*\r?\n)', { param($m) $m.Groups[1].Value + $insert }, 1)
    }
    if ($text -notmatch '(?m)^## .*Related Concepts') { $text += "`n`n## Related Concepts`n- [[Areas/_Index|Software Engineering Knowledge Base]]" }
    if ($text -notmatch '(?m)^## .*Review Schedule') { $text += "`n`n## Review Schedule`n- [ ] Review in 3 months." }
    return $text.TrimEnd() + "`n"
}

$files = @(Get-ChildItem -LiteralPath 'Areas' -Recurse -Filter '*.md')
if (Test-Path -LiteralPath 'Resources/KnowledgeBase/Interview Preparation Workflow.md') { $files += Get-Item -LiteralPath 'Resources/KnowledgeBase/Interview Preparation Workflow.md' }
$changed = 0
foreach ($file in $files) {
    $before = Get-Content -Raw -LiteralPath $file.FullName
    $after = Normalize-Note $file
    if ($before -ne $after) {
        $changed++
        if (-not $Check) { Set-Content -LiteralPath $file.FullName -Value $after -NoNewline -Encoding utf8 }
    }
}

Write-Host "Normalized $changed of $($files.Count) notes."
