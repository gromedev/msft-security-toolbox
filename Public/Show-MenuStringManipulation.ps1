function Show-MenuStringManipulation() {
    Write-Output "`n`nFile and String manipulation:"
    Write-Output "---------------------------------"
    # Define the menu options
    $menuOptions = @(
        @{ Name = "Search for filename"; Cmdlet = "Find-File" },
        @{ Name = "Search for string"; Cmdlet = "Find-String" },
        @{ Name = "Set string in files"; Cmdlet = "Set-StringInFiles" },
        @{ Name = "Set filenames by date"; Cmdlet = "Set-FileNamesByDate" },
        @{ Name = "Invoke Base64"; Cmdlet = "Invoke-Base64" },
        @{ Name = "Get SHA1"; Cmdlet = "Get-SHA1" },
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
            #Clear--Host
            Show-Menu
            
        }
        "Get help" {
            $commands = @(
                "Find-File", 
                "Find-String", 
                "Set-StringInFiles", 
                "Set-FileNamesByDate",
                "Invoke-Base64", 
                "Get-SHA1"
            )
            $commands | ForEach-Object { Get-Help $_ | Format-List -Property Name, Synopsis }
            Write-Output ""
            Show-MenuStringManipulation
        }
        default {
            # Execute the selected option and handle errors
            try {
                Invoke-Expression $selectedOption.Cmdlet
            }
            catch {
                Write-Output "There was an error executing $($selectedOption.Name). Returning to menu"
                Write-Output "`n"
                Show-MenuStringManipulation
            }
        }
    }
}