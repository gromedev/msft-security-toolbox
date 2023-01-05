<#
.SYNOPSIS
    This script resets the preferences for Windows Defender to their default values. This will affect all the preferences, including the exclusion list, scan schedule, and real-time protection settings.
#>
function Reset-Defender() {
    Write-Output "`nResetting Defender to default settings."
    Set-MpPreference -ResetToDefaults

    Write-Output "`n`n"
    Show-Menu
}