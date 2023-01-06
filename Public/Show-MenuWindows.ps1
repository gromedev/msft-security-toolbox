function Show-MenuWindows() {
    Write-Output "`n`nWindows:"
    Write-Output "(Bug: Reurn to menu and Help options not working.))"
    Write-Output "------------"
    # Define the menu options
    $menuOptions = @(
        @{ Name = "Find-Process"; Cmdlet = "Find-Process" },
        @{ Name = "Get-ProcessUsingFile"; Cmdlet = "Get-ProcessUsingFile" },
        @{ Name = "Find-Service"; Cmdlet = "Find-Service" },
        @{ Name = "Search-Registry"; Cmdlet = "Search-Registry" },
        @{ Name = "Search-EventLog"; Cmdlet = "Search-EventLog" },
        @{ Name = "Search-EventTraceLog"; Cmdlet = "Search-EventTraceLog" },
        @{ Name = "Find-ApplicationsWithNoEventLogStatus"; Cmdlet = "Find-ApplicationsWithNoEventLogStatus" },
        @{ Name = "Set-RegistryKeyPermissions"; Cmdlet = "Set-RegistryKeyPermissions" },
        @{ Name = "Get-UninstallKey"; Cmdlet = "Get-UninstallKey" },
        @{ Name = "New-SelfSignedCert"; Cmdlet = "New-SelfSignedCert" },
        @{ Name = "Set-WindowsSelectedEdition"; Cmdlet = "Set-ChangeWindowsEdition" },
        @{ Name = "Set-RegistryKeyValue"; Cmdlet = "Set-RegistryKeyValue" },
        @{ Name = "Start-RemoteConnection"; Cmdlet = "Start-RemoteConnection" },
        @{ Name = "Disable-FastStartup"; Cmdlet = "Disable-FastStartup" }
        #@{ Name = "Return to main menu"; Cmdlet = "Show-Menu" },
        #@{ Name = "Get help"; Cmdlet = "Get-Help" }
    )

    # Display the menu and prompt the user for a selection
    $selectedOption = $null
    while ($null -eq $selectedOption) {
        Write-Output "Select one of the following options:"
        $menuIndex = 1
        foreach ($menuOption in $menuOptions) {
            Write-Output "$menuIndex) $($menuOption.Name)"
            $menuIndex++
        }
        $selection = Read-Host "Enter your selection"

        # Check if the selection is a valid option
        if ($selection -ge 1 -and $selection -le $menuIndex) {
            $selectedOption = $menuOptions[$selection - 1]
        }
        else {
            Write-Output "Invalid selection"
            $selectedOption = $null
        }
    }

    switch ($selectedOption.Name) {
        "Return to main menu" {
            # Clear the host and return to the main menu
            #Clear-Host
            Show-Menu
        }
        "Get help" {
            $commands = @(
                "Find-Process",
                "Get-ProcessUsingFile",
                "Find-Service",
                "Get-UninstallKey",
                "New-SelfSignedCert",
                "Set-ChangeWindowsEdition",
                "Set-RegistryKeyValue",
                "Start-RemoteConnection",
                "Disable-FastStartup",
                "Search-Registry",
                "Set-RegistryKeyPermissions"
            )
            $commands | ForEach-Object { Get-Help $_ | Format-List -Property Name, Synopsis }
            Write-Output ""
            Show-MenuWindows
        }
        default {
            # Execute the selected option and handle errors
            try {
                Invoke-Expression $selectedOption.Cmdlet
            }
            catch {
                Write-Output "There was an error executing $($selectedOption.Name). Returning to menu"
                Show-MenuDefender
            }
        }
    }
}