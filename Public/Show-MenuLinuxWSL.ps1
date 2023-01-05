function Show-MenuLinuxWSL() {
    Write-Output "`n`nLinux WSL:"
    Write-Output "--------------"
    # Define the menu options
    $menuOptions = @(
        @{ Name = "Detect and/or Install WSL"; Cmdlet = "Install-WSL" },
        @{ Name = "Return to main menu"; Cmdlet = "Show-Menu" },
        @{ Name = "Get help"; Cmdlet = "Get-Help" }
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
                "Install-WSL"
            )
            $commands | ForEach-Object { Get-Help $_ | Format-List -Property Name, Synopsis }
            Write-Output ""
            Show-MenuLinuxWSL
        }
    }
    default {
        # Execute the selected option and handle errors
        try {
            Invoke-Expression $selectedOption.Cmdlet
        }
        catch {
            Write-Output "There was an error executing $($selectedOption.Name). Returning to menu"
            Show-MenuLinuxWSL
        }
    }
}