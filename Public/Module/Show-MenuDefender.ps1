function Show-MenuDefender {
    Write-Host "`n`nDefender:" -ForegroundColor Yellow
    Write-Host "-----------------------" -ForegroundColor Yellow

    Write-Host "Select an option:"
    Write-Host "1. Show Defender Status"   
    Write-Host "2. Enable Defender"
    Write-Host "3. Disable Defender"
    Write-Host "4. Reset Defender to default settings"
    Write-Host "5. Get Defender logs"
    Write-Host "6. Search Defender logs"
    Write-Host "7. Check ASR Rules"
    Write-Host "8. Test Cloud Delivered Protection"
    Write-Host "9. Test Potenially Unwanted Applications"
    Write-Host "10. Test SmartScreen"
    Write-Host "11. Get BitLocker Configuration"
    Write-Host "12. Get BitLocker Recovery Key (local)"
    Write-Host ""
    Write-Host "0. Return to main menu"
    Write-Host ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        1 { Test-DefenderSettings }
        2 { Enable-Defender }
        3 { Disable-Defender }
        4 { Reset-Defender }
        5 { Get-DefenderLogs }
        6 { Search-DefenderLogs }
        7 { Test-ASRRulesStatus }
        8 { Test-CloudDeliveredProtection }
        9 { Test-PotentiallyUnwantedApps }
        10 { Test-SmartScreen }
        11 { Get-BitLockerConfiguration }
        12 { Find-BitLockerRecoveryKey }
        0 { Show-Menu }
        default {
            Write-Host "Invalid selection"
            Show-MenuDefender
        }
    }
}