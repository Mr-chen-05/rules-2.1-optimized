$path = 'e:\AgentRules\English\rules-2.1-optimized\mcp-scripts\mcp-cross-platform-sync.ps1'
$tokens = $null
$errors = $null
[System.Management.Automation.Language.Parser]::ParseFile($path, [ref] $tokens, [ref] $errors) | Out-Null
if ($errors) {
    foreach ($e in $errors) {
        Write-Host ("Line {0}, Col {1}: {2}" -f $e.Extent.StartLineNumber, $e.Extent.StartColumnNumber, $e.Message)
    }
} else {
    Write-Host 'No parse errors'
}