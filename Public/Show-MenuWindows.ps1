function Show-MenuWindows() {
    Write-Output "`n`nWindows:"
    # Define the menu options
    $menuOptions = @(
        @{ Name = "Find-Process"; Cmdlet = "Find-Process" },
        @{ Name = "Get-ProcessUsingFile"; Cmdlet = "Get-ProcessUsingFile" },
        @{ Name = "Find-Service"; Cmdlet = "Find-Service" },
        @{ Name = "Get-UninstallKey"; Cmdlet = "Get-UninstallKey" },
        @{ Name = "New-SelfSignedCert"; Cmdlet = "New-SelfSignedCert" },
        @{ Name = "Set-WindowsSelectedEdition"; Cmdlet = "Set-ChangeWindowsEdition" },
        @{ Name = "Set-RegistryValue"; Cmdlet = "Set-RegistryValue" },
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
            # Check if the user has entered a function name or a number
            if ($selection -is [int]) {
                # If the user has entered a number, get the function name corresponding to that number
                $functionName = $menuOptions[$selection - 1].Name
            }
            else {
                # If the user has entered a function name, use that as the function name
                $functionName = $selection
            }
            try {
                Get-Help $functionName
            }
            catch {
                Write-Output "There was an error getting help for $functionName. Returning to menu"
                Show-MenuWindows
            }
        }         
    }
}