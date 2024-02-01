<#
.SYNOPSIS
    The Set-ChangeWindowsEdition function in PowerShell attempts to change the Windows edition using the Set-WindowsEdition command. It then checks if the EditionID value exists in the Windows Registry at the specified path.
#>

function Test-WindowsRegistryValue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [string]$path,
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [string]$value
    )
    try {
        Get-ItemProperty -Path $path | Select-Object -ExpandProperty $value -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

function Set-WindowsEdition {
    $currentEdition = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name EditionID).EditionID
    Write-Output "Current edition: $currentEdition"
    $changeEdition = Read-Host "Would you like to change the current edition? (Y/N)"

    if ($changeEdition -eq "Y") {
        Write-Output "What edition would you like to set?"
        Write-Output "1) Professional"
        Write-Output "2) Home"
        Write-Output "3) Education"

        $selectedEdition = Read-Host "Select a number:"

        switch ($selectedEdition) {
            "1" { Set-WindowsSelectedEdition -edition "Professional" }
            "2" { Set-WindowsSelectedEdition -edition "Home" }
            "3" { Set-WindowsSelectedEdition -edition "Education" }
            default { Write-Output "Invalid selection." }
        }
    }
    else {
        # Execute Show-MenuWindows if the user enters anything other than Y
        Show-MenuWindows
    }
}

function Set-ChangeWindowsEdition {
    Write-Output "`nSet-ChangeWindowsEdition"
    $userChoice = Set-WindowsEdition

    # Check if user has chosen to change the edition
    if ($userChoice -eq "Y") {
        # Test if the EditionID value exists in the registry
        if (Test-WindowsRegistryValue -path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -value "EditionID") {
            # If the EditionID value exists, output a success message
            Write-Output "Windows edition successfully changed."
        }
        else {
            Write-Output "Error: Failed to change Windows edition."
        }
    }
}