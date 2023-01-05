<#
.SYNOPSIS
    This function is used to extract and store Microsoft Defender logs on a local machine. It runs a command prompt command to extract the logs and stores the resulting cab file in a specified directory. The function then checks if the cab file was successfully moved to the directory and opens it 
#>

function Show-MenuDefender() {
    Write-Output "`n`nAzure and Defender:"
    Write-Output "-----------------------"
    # Define the menu options
    $menuOptions = @(
        @{ Name = "Enable Defender"; Cmdlet = "Enable-Defender" },
        @{ Name = "Disable Defender"; Cmdlet = "Disable-Defender" },
        @{ Name = "Reset Defender to default settings"; Cmdlet = "Reset-Defender" },        
        @{ Name = "Get Defender logs"; Cmdlet = "Get-DefenderLogs" },
        @{ Name = "Find BitLocker recovery key"; Cmdlet = "Find-BitLockerRecoveryKey" },
        @{ Name = "Convert-AzureAdObject"; Cmdlet = "Convert-AzureAdObject" },
        @{ Name = "Force Local Intune Sync"; Cmdlet = "Invoke-ForceIntuneSync" },
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
                "Enable-Defender",
                "Disable-Defender",
                "Reset-Defender",
                "Get-DefenderLogs",
                "Find-BitLockerRecoveryKey",
                "Convert-AzureAdObject"
            )
            $commands | ForEach-Object { Get-Help $_ | Format-List -Property Name, Synopsis }
            Write-Output ""
            Show-MenuDefender
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