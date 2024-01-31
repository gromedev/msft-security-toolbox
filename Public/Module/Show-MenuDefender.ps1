function Show-MenuDefender {
    Write-Output "`nDefender:"
    Write-Output "-----------------------"

    Write-Output "Select an option:"
    Write-Output "1. Show Defender Status"   
    Write-Output "2. Enable Defender"
    Write-Output "3. Disable Defender"
    Write-Output "4. Reset Defender to default settings"
    Write-Output "5. Get Defender logs"
    Write-Output "6. Check ASR Rules"
    Write-Output "7. Test Cloud Delivered Protection"
    Write-Output "8. Test Potenially Unwanted Applications"
    Write-Output "9. Test SmartScreen"
    #"Search-DefenderLog"
    Write-Output ""
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        2 { Test-ASRRulesStatus}
        2 { Enable-Defender }
        3 { Disable-Defender }
        4 { Reset-Defender }
        5 { Get-DefenderLogs }
        6 { Test-ASRRulesStatus }
        7 { Test-CloudDeliveredProtection }
        8 { Test-PotentiallyUnwantedApps }
        9 { Test-SmartScreen }
        0 { Show-Menu }
        h {
            $commands = @(
               # GOTTA DO ALL THIS
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