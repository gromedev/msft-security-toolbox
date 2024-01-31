function Show-MenuNetworking {
    Write-Output "`nNetworking:"
    Write-Output "-----------------------"

    Write-Output "Select an option:"
    Write-Output "1. Invoke-PingSweep"
    Write-Output "2. Invoke-PortScan"
    Write-Output "3. Set-MacAddress"
    Write-Output "4. Set-FirewallRulesNew"
    Write-Output "5. Get-WebFile"
    Write-Output "6. Save-Video"
    Write-Output "7. Get-DNSRecords"
    Write-Output ""
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        1 { Invoke-PingSweep }
        2 { Invoke-PortScan }
        3 { Set-MacAddress }
        4 { Set-FirewallRulesNew }
        5 { Get-WebFile }
        6 { Save-Video }
        7 { Get-DNSRecords }
        0 { Show-Menu }
        h {
            $commands = @(
                "Invoke-PingSweep",
                "Invoke-PortScan",
                "Set-MacAddress",
                "Set-FirewallRulesNew",
                "Get-WebFile",
                "Save-Video",
                "Get-DNSRecords"
            )
            foreach ($command in $commands) {
                Get-Help $command | Format-List -Property Name, Synopsis
            }
            Show-MenuNetworking
        }
        default {
            Write-Output "Invalid selection"
            Show-MenuNetworking
        }
    }
}