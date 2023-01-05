function Show-MenuNetworking() {
    Write-Output "`n`nNetworking:"
    # Define the menu options
    $menuOptions = @(
        @{ Name = "Invoke-PingSweep"; Cmdlet = "Invoke-PingSweep" },
        @{ Name = "Invoke-PortScan"; Cmdlet = "Invoke-PortScan" },
        @{ Name = "Get-Whois"; Cmdlet = "Get-Whois" },
        @{ Name = "Spoof MacAddress"; Cmdlet = "Set-MacAddress" },
        @{ Name = "Invoke-FirewallRule"; Cmdlet = "Invoke-FirewallRule" },
        @{ Name = "Download file from URL"; Cmdlet = "Get-WebFile" },
        @{ Name = "Download video from website"; Cmdlet = "Save-Video" },
        @{ Name = "Return to main menu"; Cmdlet = "Show-Menu" }
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
            break
        }
        "Get help" {
            # Get the name of the function to get help for
            $functionName = Read-Host "Enter the name of the function you want to get help for"
            try {
                Get-Help $functionName
            }
            catch {
                Write-Output "There was an error getting help for $functionName. Returning to menu"
                Show-MenuNetworking
            }
        }
        default {
            # Execute the selected option and handle errors
            try {
                Invoke-Expression $selectedOption.Cmdlet
            }
            catch {
                Write-Output "There was an error executing $($selectedOption.Name). Returning to menu"
                Show-MenuNetworking
            }
        }
    }
}