function Show-MenuDefender() {
    Write-Output "`n`nAzure and Defender:"
    # Define the menu options
    $menuOptions = @(
        @{ Name = "Enable Defender"; Cmdlet = "Enable-Defender" },
        @{ Name = "Disable Defender"; Cmdlet = "Disable-Defender" },
        @{ Name = "Get Defender logs"; Cmdlet = "Get-DefenderLogs" },
        @{ Name = "Find BitLocker recovery key"; Cmdlet = "Find-BitLockerRecoveryKey" },
        @{ Name = "Convert-AzureAdObject"; Cmdlet = "Convert-AzureAdObject" },
        @{ Name = "Force Local Intune Sync"; Cmdlet = "Invoke-ForceIntuneSync" },
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
        }
        "Get help" {
            # Get the name of the function to get help for
            $functionName = Read-Host "Enter the name of the function you want to get help for"
            try {
                Get-Help $functionName
            }
            catch {
                Write-Output "There was an error getting help for $functionName. Returning to menu"
                Show-MenuDefender
            }
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