<#
.SYNOPSIS
  Validate consistency between rule metadata fields: type:"always_apply" and alwaysApply:true.

.DESCRIPTION
  Scans all .mdc rule files under global-rules/ and project-rules/.
  Enforces the convention-over-configuration rule:
    - If type: "always_apply" is present, alwaysApply must be true (and present).
  Optionally warns if alwaysApply:true is present but type is not "always_apply" (semantic inconsistency) — disabled by default.

.PARAMETER WarnOnSemanticInconsistency
  When present, emits warnings for rules that have alwaysApply:true but type != "always_apply".

.NOTES
  Exit code: 0 if no errors; non-zero if any violation is found.

.EXAMPLE
  pwsh ./scripts/validate-rules-consistency.ps1

.EXAMPLE
  pwsh ./scripts/validate-rules-consistency.ps1 -WarnOnSemanticInconsistency
#>
param(
  [switch] $WarnOnSemanticInconsistency = $false
)

$ErrorCount = 0
$WarningCount = 0

# Repo root resolved from script location
$RepoRoot = Split-Path -Path $PSScriptRoot -Parent
$RulesDirs = @(
  (Join-Path -Path $RepoRoot -ChildPath 'global-rules'),
  (Join-Path -Path $RepoRoot -ChildPath 'project-rules')
)

Write-Host "[validate] RepoRoot: $RepoRoot"
Write-Host "[validate] Scanning rule directories: $($RulesDirs -join ', ')"

# Collect all .mdc files
$RuleFiles = @()
foreach ($dir in $RulesDirs) {
  if (Test-Path $dir) {
    $RuleFiles += Get-ChildItem -Path $dir -Recurse -Filter '*.mdc' -File
  }
}

if ($RuleFiles.Count -eq 0) {
  Write-Host "[validate] No rule files (.mdc) found. Nothing to validate." -ForegroundColor Yellow
  exit 0
}

# Helper to parse first N lines for metadata
function Get-RuleMetadata {
  param(
    [Parameter(Mandatory=$true)][string] $FilePath,
    [int] $HeadLines = 50
  )
  try {
    $lines = Get-Content -LiteralPath $FilePath -Encoding UTF8 -TotalCount $HeadLines
  } catch {
    Write-Host "[error] Failed to read file: $FilePath - $_" -ForegroundColor Red
    return [PSCustomObject]@{ Type = $null; AlwaysApply = $null }
  }

  $type = $null
  $always = $null

  foreach ($line in $lines) {
    $trim = ($line -replace '\r?\n','').Trim()
    if ($trim -match '^type\s*:\s*"([^"]+)"') {
      $type = $Matches[1]
    }
    if ($trim -match '^alwaysApply\s*:\s*(true|false)') {
      $always = [bool]::Parse($Matches[1])
    }
    if ($type -ne $null -and $always -ne $null) { break }
  }
  return [PSCustomObject]@{ Type = $type; AlwaysApply = $always }
}

foreach ($file in $RuleFiles) {
  $meta = Get-RuleMetadata -FilePath $file.FullName
  $type = $meta.Type
  $always = $meta.AlwaysApply

  # Strict check: type == always_apply requires alwaysApply:true
  if ($type -eq 'always_apply') {
    if ($always -ne $true) {
      Write-Host "[violation] $($file.FullName): type=always_apply but alwaysApply is $always" -ForegroundColor Red
      $ErrorCount++
    }
  }

  # Optional warn: alwaysApply:true but type != always_apply
  if ($WarnOnSemanticInconsistency -and $always -eq $true -and $type -ne 'always_apply') {
    Write-Host "[warn] $($file.FullName): alwaysApply:true but type='$type' (recommend 'always_apply')" -ForegroundColor Yellow
    $WarningCount++
  }
}

Write-Host "[summary] Errors: $ErrorCount; Warnings: $WarningCount; Files scanned: $($RuleFiles.Count)"
if ($ErrorCount -gt 0) { exit 1 } else { exit 0 }