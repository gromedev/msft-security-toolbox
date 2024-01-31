<#
.SYNOPSIS
    The Set-ChangeWindowsEdition function in PowerShell attempts to change the Windows edition using the Set-WindowsEdition command. It then checks if the EditionID value exists in the Windows Registry at the specified path.
#>

function Set-ChangeWindowsEdition {
    Write-Output "`nSet-ChangeWindowsEdition"
    try {
        # Set the Windows edition
        Set-WindowsEdition
    }
    catch {
        Write-Output "Error: Failed to change Windows edition."
    }# Test if the EditionID value exists in the registry
    if (Test-WindowsRegistryValue -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -value "EditionID") {
        # If the EditionID value exists, output a success message
        Write-Output "Windows edition successfully changed."
    }
    else {
        # If the EditionID value does not exist, output an error message
        Write-Output "Error: Failed to change WiAndows edition."
    }
}
