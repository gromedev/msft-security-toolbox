<#
.SYNOPSIS
    Main menu for PowerShellCheatSheet module. 
#>

function Show-Menu() {

    # Welcome message
    Write-Output ""
    Write-Output "--------------------"
    Write-Output "PowerShellCheatSheet"
    Write-Output "--------------------"
    Write-Output " Select an option: "
    Write-Output ""
    # Define the menu options
    $menuOptions = @(
        @{ Label = "File and String manipulation"; Options = "Show-MenuStringManipulation" },
        @{ Label = "Azure and Defender"; Options = "Show-MenuDefender" },
        @{ Label = "Networking"; Options = "Show-MenuNetworking" },
        @{ Label = "Windows"; Options = "Show-MenuWindows" },
        @{ Label = "Linux WSL"; Options = "Show-MenuLinuxWSL" },
        @{ Label = "Quit"; Options = "Exit-PSSession" }
    )

    # Display the menu and prompt the user for a selection
    $selectedOption = $null
    while ($null -eq $selectedOption) {
        Write-Output "Select one of the following menus:"
        $menuIndex = 1
        foreach ($menu in $menuOptions) {
            Write-Output "$menuIndex) $($menu.Label)"
            $menuIndex++
        }
        $selection = Read-Host "Enter your selection"

        # Check if the selection is a valid option
        if ($selection -ge 1 -and $selection -lt $menuIndex) {
            $selectedOption = $menuOptions[$selection - 1].Options
        } else {
            Write-Output "Invalid selection"
        }
    }

    if ($selectedOption -eq "Quit") {
        # Quit the script
        exit
    } else {
        # Execute the selected option and handle errors
        try {
            Invoke-Expression $selectedOption
        } catch {
            Write-Output "There was an error. Returning to menu"
            $selectedOption = $null
        }
    }
}
