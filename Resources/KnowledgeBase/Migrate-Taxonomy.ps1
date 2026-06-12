$ErrorActionPreference = "Stop"

$base = "c:\Users\Protayne\OneDrive\Obsidian Vault\Learning\Software Development\Knowledge base"

$mappings = @(
  @("Areas\CodingPractices\CodeReviewGuidelines.md",                           "Areas\Developer Workflow\CodeReviewGuidelines.md"),
  @("Areas\CodingPractices\Mappers.md",                                         "Areas\Developer Workflow\Mappers.md"),
  @("Areas\CodingPractices\Testing\IntegrationTestingAspNet.md",                "Areas\Testing and Quality\Testing\IntegrationTestingAspNet.md"),
  @("Areas\CodingPractices\Testing\MsTest.md",                                  "Areas\Testing and Quality\Testing\MsTest.md"),
  @("Areas\DotNet\ConfigurationOptionsPattern.md",                              "Areas\Languages and Frameworks\DotNet\ConfigurationOptionsPattern.md"),
  @("Areas\DotNet\DelegatesEventsActions.md",                                   "Areas\Languages and Frameworks\DotNet\DelegatesEventsActions.md"),
  @("Areas\DotNet\ExpressionBodiedMembers.md",                                  "Areas\Languages and Frameworks\DotNet\ExpressionBodiedMembers.md"),
  @("Areas\DotNet\GenericsConstraints.md",                                      "Areas\Languages and Frameworks\DotNet\GenericsConstraints.md"),
  @("Areas\DotNet\Linq.md",                                                     "Areas\Languages and Frameworks\DotNet\Linq.md"),
  @("Areas\DotNet\NullableReferenceTypes.md",                                   "Areas\Languages and Frameworks\DotNet\NullableReferenceTypes.md"),
  @("Areas\Patterns\Application\ApiVersioning.md",                              "Areas\Architecture and Patterns\Application\ApiVersioning.md"),
  @("Areas\Patterns\Application\CachingStrategies.md",                          "Areas\Architecture and Patterns\Application\CachingStrategies.md"),
  @("Areas\Patterns\Application\MVC.md",                                        "Areas\Architecture and Patterns\Application\MVC.md"),
  @("Areas\Patterns\Application\Repository.md",                                 "Areas\Architecture and Patterns\Application\Repository.md"),
  @("Areas\Patterns\Application\RepositoryUnitOfWork.md",                       "Areas\Architecture and Patterns\Application\RepositoryUnitOfWork.md"),
  @("Areas\Patterns\Concurrency\Async.md",                                      "Areas\Architecture and Patterns\Concurrency\Async.md"),
  @("Areas\Patterns\Concurrency\ThreadPool.md",                                 "Areas\Architecture and Patterns\Concurrency\ThreadPool.md"),
  @("Areas\Patterns\Design (CodeLevel)\DependencyInjection.md",                 "Areas\Architecture and Patterns\Design (CodeLevel)\DependencyInjection.md"),
  @("Areas\Patterns\Design (CodeLevel)\SolidPrinciples.md",                     "Areas\Architecture and Patterns\Design (CodeLevel)\SolidPrinciples.md"),
  @("Areas\Patterns\SystemArchitecture\CleanArchitecture.md",                   "Areas\Architecture and Patterns\SystemArchitecture\CleanArchitecture.md"),
  @("Areas\Patterns\SystemArchitecture\CQRS.md",                                "Areas\Architecture and Patterns\SystemArchitecture\CQRS.md"),
  @("Areas\Patterns\SystemArchitecture\CQRSMediator.md",                        "Areas\Architecture and Patterns\SystemArchitecture\CQRSMediator.md"),
  @("Areas\Patterns\SystemArchitecture\EventDriven.md",                         "Areas\Architecture and Patterns\SystemArchitecture\EventDriven.md"),
  @("Areas\Patterns\SystemArchitecture\Microservices.md",                       "Areas\Architecture and Patterns\SystemArchitecture\Microservices.md"),
  @("Areas\Patterns\SystemArchitecture\Monolith.md",                            "Areas\Architecture and Patterns\SystemArchitecture\Monolith.md"),
  @("Areas\Patterns\SystemArchitecture\Service Based Architecture.md",          "Areas\Architecture and Patterns\SystemArchitecture\Service Based Architecture.md"),
  @("Areas\Patterns\SystemArchitecture\Service Composition.md",                 "Areas\Architecture and Patterns\SystemArchitecture\Service Composition.md"),
  @("Areas\Patterns\SystemArchitecture\ServiceCommunication.md",                "Areas\Architecture and Patterns\SystemArchitecture\ServiceCommunication.md"),
  @("Areas\Patterns\SystemArchitecture\Games\ECS.md",                           "Areas\Architecture and Patterns\SystemArchitecture\Games\ECS.md"),
  @("Areas\Data Stores\Amazon Redshift.md",                                     "Areas\Data and State\Amazon Redshift.md"),
  @("Areas\Data Stores\Amazon S3.md",                                           "Areas\Data and State\Amazon S3.md"),
  @("Areas\Data Stores\Azure Blob Storage.md",                                  "Areas\Data and State\Azure Blob Storage.md"),
  @("Areas\Data Stores\Cassandra.md",                                           "Areas\Data and State\Cassandra.md"),
  @("Areas\Data Stores\Cloud Storage Services.md",                              "Areas\Data and State\Cloud Storage Services.md"),
  @("Areas\Data Stores\Data Warehouses.md",                                     "Areas\Data and State\Data Warehouses.md"),
  @("Areas\Data Stores\Google BigQuery.md",                                     "Areas\Data and State\Google BigQuery.md"),
  @("Areas\Data Stores\Google Cloud Storage.md",                                "Areas\Data and State\Google Cloud Storage.md"),
  @("Areas\Data Stores\MongoDB.md",                                             "Areas\Data and State\MongoDB.md"),
  @("Areas\Data Stores\MySQL.md",                                               "Areas\Data and State\MySQL.md"),
  @("Areas\Data Stores\NoSQL Databases.md",                                     "Areas\Data and State\NoSQL Databases.md"),
  @("Areas\Data Stores\Oracle.md",                                              "Areas\Data and State\Oracle.md"),
  @("Areas\Data Stores\PostgreSQL.md",                                          "Areas\Data and State\PostgreSQL.md"),
  @("Areas\Data Stores\Redis.md",                                               "Areas\Data and State\Redis.md"),
  @("Areas\Data Stores\Relational Databases.md",                                "Areas\Data and State\Relational Databases.md"),
  @("Areas\Data Stores\Snowflake.md",                                           "Areas\Data and State\Snowflake.md"),
  @("Areas\Data Stores\EntityFramework\MemoryAllocations.md",                   "Areas\Data and State\EntityFramework\MemoryAllocations.md"),
  @("Areas\Data Stores\EntityFramework\QueryOptimisations.md",                  "Areas\Data and State\EntityFramework\QueryOptimisations.md"),
  @("Areas\DevOps\AzureServicesOverview.md",                                    "Areas\Cloud and Delivery\AzureServicesOverview.md"),
  @("Areas\DevOps\DockerDotNet.md",                                             "Areas\Cloud and Delivery\DockerDotNet.md"),
  @("Areas\DevOps\PowerShellCliEssentials.md",                                  "Areas\Developer Workflow\PowerShellCliEssentials.md"),
  @("Areas\GameDev\AI\Index.md",                                                "Areas\Domain Overlays\Game Development\AI\Index.md"),
  @("Areas\GameDev\Unity\Resources.md",                                         "Areas\Domain Overlays\Game Development\Unity\Resources.md")
)

$legacyRoots = @(
  "Areas\CodingPractices",
  "Areas\Data Stores",
  "Areas\DevOps",
  "Areas\DotNet",
  "Areas\GameDev",
  "Areas\Patterns",
  "Areas\SourceControl"
)

$copied = [System.Collections.Generic.List[string]]::new()
$deleted = [System.Collections.Generic.List[string]]::new()
$missing = [System.Collections.Generic.List[string]]::new()
$failed = [System.Collections.Generic.List[string]]::new()

foreach ($pair in $mappings) {
  $src = Join-Path $base $pair[0]
  $dst = Join-Path $base $pair[1]

  if (-not (Test-Path -LiteralPath $src)) {
    $missing.Add($pair[0])
    continue
  }

  $dstDir = Split-Path -Parent $dst
  if (-not (Test-Path -LiteralPath $dstDir)) {
    New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
  }

  try {
    Copy-Item -LiteralPath $src -Destination $dst -Force
    Remove-Item -LiteralPath $src -Force
    $copied.Add("$($pair[0]) -> $($pair[1])")
    $deleted.Add($pair[0])
  }
  catch {
    $failed.Add("$($pair[0]) -> $($pair[1]) :: $($_.Exception.Message)")
  }
}

# Optional cleanup test artifact.
$writeTest = Join-Path $base "Resources\KnowledgeBase\_write-test.md"
if (Test-Path -LiteralPath $writeTest) {
  Remove-Item -LiteralPath $writeTest -Force
}

# Remove legacy roots only when empty.
$removedLegacyRoots = [System.Collections.Generic.List[string]]::new()
$nonEmptyLegacyRoots = [System.Collections.Generic.List[string]]::new()
foreach ($root in $legacyRoots) {
  $full = Join-Path $base $root
  if (-not (Test-Path -LiteralPath $full)) {
    continue
  }

  $children = Get-ChildItem -LiteralPath $full -Force -ErrorAction SilentlyContinue
  if ($null -eq $children -or $children.Count -eq 0) {
    Remove-Item -LiteralPath $full -Force
    $removedLegacyRoots.Add($root)
  }
  else {
    $nonEmptyLegacyRoots.Add($root)
  }
}

# Update known path-qualified wikilinks in Game Development Overlay.
$overlayPath = Join-Path $base "Areas\Domain Overlays\Game Development Overlay.md"
if (Test-Path -LiteralPath $overlayPath) {
  $overlay = Get-Content -LiteralPath $overlayPath -Raw
  $overlay = $overlay.Replace("[[Areas/GameDev/AI/Index|AI Index]]", "[[Areas/Domain Overlays/Game Development/AI/Index|AI Index]]")
  $overlay = $overlay.Replace("[[Areas/GameDev/Unity/Resources|Unity Resources]]", "[[Areas/Domain Overlays/Game Development/Unity/Resources|Unity Resources]]")
  $overlay = $overlay.Replace("[[Areas/Patterns/SystemArchitecture/Games/ECS|ECS]]", "[[Areas/Architecture and Patterns/SystemArchitecture/Games/ECS|ECS]]")
  Set-Content -LiteralPath $overlayPath -Value $overlay -NoNewline
}

Write-Host "\n=== Migration Summary ===" -ForegroundColor Cyan
Write-Host "Copied and moved: $($copied.Count)" -ForegroundColor Green
Write-Host "Missing sources:  $($missing.Count)" -ForegroundColor Yellow
Write-Host "Failures:         $($failed.Count)" -ForegroundColor Red
Write-Host "Legacy removed:   $($removedLegacyRoots.Count)" -ForegroundColor Green
Write-Host "Legacy non-empty: $($nonEmptyLegacyRoots.Count)" -ForegroundColor Yellow

if ($missing.Count -gt 0) {
  Write-Host "\nMissing source files:" -ForegroundColor Yellow
  $missing | ForEach-Object { Write-Host " - $_" }
}

if ($failed.Count -gt 0) {
  Write-Host "\nFailed operations:" -ForegroundColor Red
  $failed | ForEach-Object { Write-Host " - $_" }
}

if ($nonEmptyLegacyRoots.Count -gt 0) {
  Write-Host "\nLegacy folders still non-empty:" -ForegroundColor Yellow
  $nonEmptyLegacyRoots | ForEach-Object { Write-Host " - $_" }
}
