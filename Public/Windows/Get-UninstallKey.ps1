<#
.SYNOPSIS
    This function searches for installed software in the specified locations in the Windows Registry, specifically the HKLM (HKEY_LOCAL_MACHINE), HKLM\WOW6432Node, HKCU (HKEY_CURRENT_USER), and HKCU\WOW6432Node hives. If any of these locations are not specified as parameters, the user will be prompted to enter them. The function then displays the DisplayName, DisplayVersion, UninstallString, and InstallDate of the software it finds, sorted by DisplayName. 
#>
function Get-UninstallKey {
    param(
        $HKLM,
        $HKLM_WOW,
        $HKCU,
        $HKCU_WOW
    )
    Write-Output "`nGet-UninstallKey"
    if (-not $HKLM) {
        $HKLM = Read-Host "Enter the path to search in the HKLM hive (e.g. 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*')"
    }
    if (-not $HKLM_WOW) {
        $HKLM_WOW = Read-Host "Enter the path to search in the HKLM\WOW6432Node hive (e.g. 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*')"
    }
    if (-not $HKCU) {
        $HKCU = Read-Host "Enter the path to search in the HKCU hive (e.g. 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*')"
    }
    if (-not $HKCU_WOW) {
        $HKCU_WOW = Read-Host "Enter the path to search in the HKCU\WOW6432Node hive (e.g. 'HKCU:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*')"
    }

    Get-ItemProperty -Path $HKLM, $HKLM_WOW, $HKCU, $HKCU_WOW -ErrorAction Ignore |
    Where-Object DisplayName |
    Select-Object -Property DisplayName, DisplayVersion, UninstallString, InstallDate |
    Sort-Object -Property DisplayName

    # Return to the menu if any of the parameters were not specified
    #if (-not $HKLM -or -not $HKLM_WOW -or -not $HKCU -or -not $HKCU_WOW) {
    #    Show-Menu
    #}
    Write-Output "`n`n"
    Show-Menu
}
