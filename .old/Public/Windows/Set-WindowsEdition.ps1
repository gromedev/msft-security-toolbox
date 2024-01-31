<#
.SYNOPSIS
    Output the current Windows edition and prompt the user to change it to one of the available options.
#>
function Set-WindowsEdition {
    # Get the current Windows edition
    $currentEdition = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name EditionID).EditionID

    # Output the current edition
    Write-Output "Current edition: $currentEdition"

    # Prompt the user to change the edition
    $changeEdition = Read-Host "Would you like to change the current edition? (Y/N)"

    if ($changeEdition -eq "Y") {
        # Display a menu of available editions to choose from
        Write-Output "What edition would you like to set?"
        Write-Output "1) Professional"
        Write-Output "2) Home"
        Write-Output "3) Education"

        # Prompt the user to select an edition
        $selectedEdition = Read-Host "Select a number:"

        # Set the selected edition
        switch ($selectedEdition) {
            "1" { Set-WindowsSelectedEdition -edition "Professional" }
            "2" { Set-WindowsSelectedEdition -edition "Home" }
            "3" { Set-WindowsSelectedEdition -edition "Education" }
            default { Write-Output "Invalid selection." }
        }
    }
}
