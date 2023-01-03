function Show-Menu {
    # Display menu options
    Write-Host "Menu:"
    Write-Host "1. Find-File"
    Write-Host "2. Find-String"
    Write-Host "3. Find-Process"
    Write-Host "4. Find-Service"
    Write-Host "5. Invoke-PingSweep"
    Write-Host "6. Invoke-PortScan"
    Write-Host "7. Get-SHA1"
    Write-Host "8. Invoke-Base64"
    Write-Host "9. Get-WebFile"
    Write-Host "10. Save-Video"
    Write-Host "11. Get-UninstallKey"
    Write-Host "12. Find-BitLockerRecoveryKey"
    Write-Host "13. New-SelfSignedCert"
    Write-Host "14. Convert AzureAD Object to/from SID"
    Write-Host "q. Quit"
    Write-Host ""
    Write-Host "Enter a number or 'q' to quit, or 'man' followed by a number to display a description of an option:"

    # Read user input
    $choice = Read-Host
    Write-Host ""

    # Check if choice is a number or 'q'
    if ($choice -match '^[0-9]$' -or $choice -eq 'q') {
        # Execute selected function
        switch ($choice) {
            '1' { Find-File }
            '2' { Find-String }
            '3' { Find-Process }
            '4' { Find-Service }
            '5' { Invoke-PingSweep }
            '6' { Invoke-PortScan }
            '7' { Get-SHA1 }
            '8' { Invoke-Base64 }
            '9' { Get-WebFile }
            '10' { Save-Video }
            '11' { Get-UninstallKey }
            '12' { Find-BitLockerRecoveryKey }
            '13' { New-SelfSignedCert }
            '14' { Convert-AzureAdObject }
            'q' { return }
            default { Write-Host "Invalid option." }
        }
    }
    elseif ($choice -match '^man \d+$') {
        # Get option number from choice
        $option = $choice.Substring(4)

        # Display description of selected option
        switch ($option) {
            '1' { Get-Help Find-File }
            '2' { Get-Help Find-String }
            '3' { Get-Help Find-Process }
            '4' { Get-Help Find-Service }
            '5' { Get-Help Invoke-PingSweep }
            '6' { Get-Help Invoke-PortScan }
            '7' { Get-Help Get-SHA1 }
            '8' { Get-Help Invoke-Base64 }
            '9' { Get-Help Get-WebFile }
            '10' { Get-Help Save-Video }
            '11' { Get-Help Get-UninstallKey }
            '12' { Get-Help Find-BitLockerRecoveryKey }
            '13' { Get-Help New-SelfSignedCert }
            '14' { Get-Help Convert-AzureAdObject }
            default { Write-Host "Invalid option." }
        }
    }
}