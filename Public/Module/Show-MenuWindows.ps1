function Show-MenuWindows {
    Write-Output "`nAzure and Defender:"
    Write-Output "-----------------------"

    Write-Output "Select an option:"
    Write-Output "1. Find-Process"
    Write-Output "2. Get-ProcessUsingFile"
    Write-Output "3. Find-Service"
    Write-Output "4. Search-Registry"
    Write-Output "5. Search-EventLog"
    Write-Output "6. Search-EventTraceLog"
    Write-Output "7. Find-ApplicationsWithNoEventLogStatus"
    Write-Output "8. Set-RegistryKeyPermissions"
    Write-Output "9. Get-UninstallKey"
    Write-Output "10. New-SelfSignedCert"
    Write-Output "11. Set-ChangeWindowsEdition"
    Write-Output "12. Set-RegistryKeyValue"
    Write-Output "13. Start-RemoteConnection"
    Write-Output "14. Disable-FastStartup"
    Write-Output ""
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        1 { Find-Process }
        2 { Get-ProcessUsingFile }
        3 { Find-Service }
        4 { Search-Registry }
        5 { Search-EventLog }
        6 { Search-EventTraceLog }
        7 { Find-ApplicationsWithNoEventLogStatus }
        8 { Set-RegistryKeyPermissions }
        9 { Get-UninstallKey }
        10 { New-SelfSignedCert }
        11 { Set-ChangeWindowsEdition }
        12 { Set-RegistryKeyValue }
        13 { Start-RemoteConnection }
        14 { Disable-FastStartup }
        0 { Show-Menu }
        h {
            $commands = @(
                "Find-Process",
                "Get-ProcessUsingFile",
                "Find-Service",
                "Search-Registry",
                "Search-EventLog",
                "Search-EventTraceLog",
                "Find-ApplicationsWithNoEventLogStatus",
                "Set-RegistryKeyPermissions",
                "Get-UninstallKey",
                "New-SelfSignedCert",
                "Set-ChangeWindowsEdition",
                "Set-RegistryKeyValue",
                "Start-RemoteConnection",
                "Disable-FastStartup"
            )
            foreach ($command in $commands) {
                Get-Help $command | Format-List -Property Name, Synopsis
            }
            Show-MenuWindows
        }
        default {
            Write-Output "Invalid selection"
            Show-MenuWindows
        }
    }
}