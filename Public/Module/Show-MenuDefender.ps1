function Show-MenuDefender {
    Write-Output "`nAzure and Defender:"
    Write-Output "-----------------------"

    Write-Output "Select an option:"
    Write-Output "1. Enable Defender"
    Write-Output "2. Disable Defender"
    Write-Output "3. Reset Defender to default settings"
    Write-Output "4. Get Defender logs"
    Write-Output "5. Search-EventTraceLog"
    Write-Output "6. Find BitLocker recovery key"
    #Write-Output "7. Convert-AzureAdObject"
    Write-Output "8. Force Local Intune Sync"
    Write-Output "9. Useful msft modules"
    Write-Output ""
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        1 { Enable-Defender }
        2 { Disable-Defender }
        3 { Reset-Defender }
        4 { Get-DefenderLogs }
        5 { Search-EventTraceLog }
        6 { Find-BitLockerRecoveryKey }
        7 { Convert-AzureAdObject }
        8 { Invoke-ForceIntuneSync }
        9 { Install-MsftModules }
        0 { Show-Menu }
        h {
            $commands = @(
                "Enable-Defender",
                "Disable-Defender",
                "Reset-Defender",
                "Get-DefenderLogs",
                "Search-EventTraceLog",
                "Find-BitLockerRecoveryKey",
                "Convert-AzureAdObject",
                "Invoke-ForceIntuneSync",
                "Install-MsftModules"
            )
            foreach ($command in $commands) {
                Get-Help $command | Format-List -Property Name, Synopsis
            }
            Show-MenuDefender
        }
        default {
            Write-Output "Invalid selection"
            Show-MenuDefender
        }
    }
}