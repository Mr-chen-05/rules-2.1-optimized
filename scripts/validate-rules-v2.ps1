# PowerShell Script for Rules Validation v2.0
# Author: AI Assistant
# Description: Comprehensive validation script for rules files

# Set console encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Color output function
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Function to get rule files only (focused on global-rules and project-rules)
function Get-RuleFiles {
    $ruleFiles = @()
    
    # Get .mdc files from global-rules and project-rules directories
    if (Test-Path "global-rules") {
        $ruleFiles += Get-ChildItem -Path "global-rules" -Filter "*.mdc" -File
    }
    if (Test-Path "project-rules") {
        $ruleFiles += Get-ChildItem -Path "project-rules" -Filter "*.mdc" -File
    }
    
    return $ruleFiles
}

# Function to check priority conflicts
function Test-PriorityConflicts {
    Write-ColorOutput "`n=== Priority Conflict Check ===" "Cyan"
    
    $conflicts = 0
    $priorityMap = @{}
    $ruleFiles = Get-RuleFiles
    
    $ruleFiles | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        if ($content -match '(?s)^---\s*\n(.*?)\n---') {
            $frontmatter = $matches[1]
            if ($frontmatter -match 'priority:\s*(\d+(?:\.\d+)?)') {
                $priority = [decimal]$matches[1]
                $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
                
                if ($priorityMap.ContainsKey($priority)) {
                    Write-ColorOutput "  Priority conflict detected: $priority" "Red"
                    Write-ColorOutput "    File 1: $($priorityMap[$priority])" "Yellow"
                    Write-ColorOutput "    File 2: $relativePath" "Yellow"
                    $conflicts++
                } else {
                    $priorityMap[$priority] = $relativePath
                }
            }
        }
    }
    
    if ($conflicts -eq 0) {
        Write-ColorOutput "  No priority conflicts found" "Green"
    } else {
        Write-ColorOutput "  Found $conflicts priority conflicts" "Red"
    }
    
    return $conflicts
}

# Function to check version fields
function Test-VersionFields {
    Write-ColorOutput "`n=== Version Field Check ===" "Cyan"
    
    $missingVersion = 0
    $ruleFiles = Get-RuleFiles
    
    $ruleFiles | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        
        if ($content -match '(?s)^---\s*\n(.*?)\n---') {
            $frontmatter = $matches[1]
            if ($frontmatter -notmatch 'version:\s*["\d\.]') {
                Write-ColorOutput "  Missing version field: $relativePath" "Red"
                $missingVersion++
            }
        } else {
            Write-ColorOutput "  No frontmatter found: $relativePath" "Red"
            $missingVersion++
        }
    }
    
    if ($missingVersion -eq 0) {
        Write-ColorOutput "  All files have version fields" "Green"
    } else {
        Write-ColorOutput "  $missingVersion files missing version fields" "Red"
    }
    
    return $missingVersion
}

# Function to check reference consistency
function Test-ReferenceConsistency {
    Write-ColorOutput "`n=== Reference Consistency Check ===" "Cyan"
    
    $inconsistencies = 0
    $allFiles = @()
    $ruleFiles = Get-RuleFiles
    
    # Collect all rule files
    $ruleFiles | ForEach-Object {
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\').Replace('\', '/')
        $allFiles += $relativePath
    }
    
    # Check references in each file
    $ruleFiles | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        
        # Find all references in the content
        $references = [regex]::Matches($content, '\[([^\]]+)\]\(([^)]+\.md)\)')
        
        foreach ($ref in $references) {
            $referencedFile = $ref.Groups[2].Value.Replace('/', '\')
            
            # Handle relative paths starting with ./ or .\
            if ($referencedFile.StartsWith('.\')) {
                $fullReferencedPath = Join-Path (Get-Location).Path $referencedFile.Substring(2)
            } else {
                $fullReferencedPath = Join-Path (Split-Path $_.FullName) $referencedFile
            }
            
            if (-not (Test-Path $fullReferencedPath)) {
                Write-ColorOutput "  Broken reference in $relativePath" "Red"
                Write-ColorOutput "    Referenced file: $referencedFile" "Yellow"
                $inconsistencies++
            }
        }
    }
    
    if ($inconsistencies -eq 0) {
        Write-ColorOutput "  All references are consistent" "Green"
    } else {
        Write-ColorOutput "  Found $inconsistencies broken references" "Red"
    }
    
    return $inconsistencies
}

# Function to check priority ranges
function Test-PriorityRanges {
    Write-ColorOutput "`n=== Priority Range Check ===" "Cyan"
    
    $outOfRangeCount = 0
    $priorityRanges = @{
        "global" = @{ Min = 1.0; Max = 1200.0 }
        "project" = @{ Min = 1.0; Max = 1200.0 }
        "core" = @{ Min = 1.0; Max = 1200.0 }
        "basic" = @{ Min = 1.0; Max = 1200.0 }
        "advanced" = @{ Min = 1.0; Max = 1200.0 }
        "expert" = @{ Min = 1.0; Max = 1200.0 }
        "specialized" = @{ Min = 1.0; Max = 1200.0 }
    }
    $ruleFiles = Get-RuleFiles
    
    $ruleFiles | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        
        # Extract level from path
        $level = "unknown"
        foreach ($levelName in $priorityRanges.Keys) {
            if ($relativePath -like "*$levelName*") {
                $level = $levelName
                break
            }
        }
        
        if ($content -match '(?s)^---\s*\n(.*?)\n---') {
            $frontmatter = $matches[1]
            if ($frontmatter -match 'priority:\s*(\d+(?:\.\d+)?)') {
                $priority = [decimal]$matches[1]
                
                if ($level -ne "unknown" -and $priorityRanges.ContainsKey($level)) {
                    $range = $priorityRanges[$level]
                    if ($priority -lt $range.Min -or $priority -gt $range.Max) {
                        Write-ColorOutput "  Priority out of range: $relativePath" "Red"
                        Write-ColorOutput "    Priority: $priority, Expected range: $($range.Min)-$($range.Max)" "Yellow"
                        $outOfRangeCount++
                    }
                }
            }
        }
    }
    
    if ($outOfRangeCount -eq 0) {
        Write-ColorOutput "  All priorities are within expected ranges" "Green"
    } else {
        Write-ColorOutput "  Found $outOfRangeCount priorities out of range" "Red"
    }
    
    return $outOfRangeCount
}

# Function to check frontmatter format
function Test-FrontmatterFormat {
    Write-ColorOutput "`n=== Frontmatter Format Check ===" "Cyan"
    
    $invalidCount = 0
    $requiredFields = @("priority", "version", "description")
    $ruleFiles = Get-RuleFiles
    
    $ruleFiles | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        
        if ($content -match '(?s)^---\s*\n(.*?)\n---') {
            $frontmatter = $matches[1]
            $missingFields = @()
            
            foreach ($field in $requiredFields) {
                if ($frontmatter -notmatch "$field\s*:") {
                    $missingFields += $field
                }
            }
            
            if ($missingFields.Count -gt 0) {
                Write-ColorOutput "  Invalid frontmatter: $relativePath" "Red"
                Write-ColorOutput "    Missing fields: $($missingFields -join ', ')" "Yellow"
                $invalidCount++
            }
        } else {
            Write-ColorOutput "  No frontmatter found: $relativePath" "Red"
            $invalidCount++
        }
    }
    
    if ($invalidCount -eq 0) {
        Write-ColorOutput "  All frontmatter formats are correct" "Green"
    } else {
        Write-ColorOutput "  $invalidCount files have frontmatter format errors" "Red"
    }
    
    return $invalidCount
}

# Function to check file encoding
function Test-FileEncoding {
    Write-ColorOutput "`n=== File Encoding Check ===" "Cyan"
    
    $encodingIssues = 0
    $ruleFiles = Get-RuleFiles
    
    $ruleFiles | ForEach-Object {
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        
        try {
            # Check for BOM at byte level (UTF-8 BOM: EF BB BF)
            $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
            if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
                Write-ColorOutput "  BOM detected: $relativePath" "Yellow"
            }
        } catch {
            Write-ColorOutput "  Encoding issue: $relativePath" "Red"
            $encodingIssues++
        }
    }
    
    if ($encodingIssues -eq 0) {
        Write-ColorOutput "  All files have correct encoding" "Green"
    } else {
        Write-ColorOutput "  Found $encodingIssues files with encoding issues" "Red"
    }
    
    return $encodingIssues
}

# Function to check rule dependencies
function Test-RuleDependencies {
    Write-ColorOutput "`n=== Rule Dependencies Check ===" "Cyan"
    
    $dependencyIssues = 0
    $ruleFiles = Get-RuleFiles
    
    $ruleFiles | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        
        if ($content -match '(?s)^---\s*\n(.*?)\n---') {
            $frontmatter = $matches[1]
            if ($frontmatter -match 'dependencies:\s*\[(.*?)\]') {
                $dependencies = $matches[1] -split ',' | ForEach-Object { $_.Trim().Trim('"').Trim("'") }
                
                foreach ($dep in $dependencies) {
                    if ($dep -and -not (Get-ChildItem -Path "." -Filter "*$dep*" -Recurse)) {
                        Write-ColorOutput "  Missing dependency: $dep in $relativePath" "Red"
                        $dependencyIssues++
                    }
                }
            }
        }
    }
    
    if ($dependencyIssues -eq 0) {
        Write-ColorOutput "  All rule dependencies are satisfied" "Green"
    } else {
        Write-ColorOutput "  Found $dependencyIssues dependency issues" "Red"
    }
    
    return $dependencyIssues
}

# Function to check file integrity
function Test-FileIntegrity {
    Write-ColorOutput "`n=== File Integrity Check ===" "Cyan"
    
    $integrityIssues = 0
    $ruleFiles = Get-RuleFiles
    
    $ruleFiles | ForEach-Object {
        $relativePath = $_.FullName.Replace((Get-Location).Path, "").TrimStart('\')
        
        if ($_.Length -eq 0) {
            Write-ColorOutput "  Empty file: $relativePath" "Red"
            $integrityIssues++
        } elseif ($_.Length -lt 100) {
            Write-ColorOutput "  Suspiciously small file: $relativePath" "Yellow"
        }
        
        $content = Get-Content $_.FullName -Raw -Encoding UTF8
        if (-not $content.Trim()) {
            Write-ColorOutput "  File with no content: $relativePath" "Red"
            $integrityIssues++
        }
    }
    
    if ($integrityIssues -eq 0) {
        Write-ColorOutput "  All files have good integrity" "Green"
    } else {
        Write-ColorOutput "  Found $integrityIssues file integrity issues" "Red"
    }
    
    return $integrityIssues
}

# Main execution
Write-ColorOutput "Rules Validation Script v2.0 - Focused Edition" "Magenta"
Write-ColorOutput "Focused on .mdc files in global-rules and project-rules directories" "Cyan"
Write-ColorOutput "=================================================" "Magenta"

$totalIssues = 0

# Run all validation tests
$totalIssues += Test-PriorityConflicts
$totalIssues += Test-VersionFields
$totalIssues += Test-ReferenceConsistency
$totalIssues += Test-PriorityRanges
$totalIssues += Test-FrontmatterFormat
$totalIssues += Test-FileEncoding
$totalIssues += Test-RuleDependencies
$totalIssues += Test-FileIntegrity

# Summary
Write-ColorOutput "`n=== Validation Summary ===" "Magenta"
if ($totalIssues -eq 0) {
    Write-ColorOutput "All validation checks passed successfully!" "Green"
    exit 0
} else {
    Write-ColorOutput "Found $totalIssues total issues that need attention." "Red"
    exit 1
}