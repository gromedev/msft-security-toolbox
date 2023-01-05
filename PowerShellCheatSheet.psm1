# Update-ModuleManifest -Path .\PowerShellCheatSheet.psd1 -ModuleVersion "0.3.0"
$Public  = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach ($Import in @($Public + $Private)) {
    try {
        . $Import.Fullname -ErrorAction Stop
    }
    catch {
        Write-Error -Message "Failed to import function $($Import.Fullname): $_" -ErrorAction Continue
    }
}

<#
# Prompt the user to launch the menu
$launchMenu = Read-Host "Do you want to launch the menu? (y/n)"

if ($launchMenu -eq 'y') {
    Clear-Host
    Show-Menu
}
#>

Export-ModuleMember -Function $Public.Basename
