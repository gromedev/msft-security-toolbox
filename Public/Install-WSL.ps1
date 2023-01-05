<#
.SYNOPSIS
    Detects whether the Windows Subsystem for Linux (WSL) is installed on the system and gives the user the option to install it if it is not detected.
#>
function Install-WSL {
    Write-Output "Very much a WIP. Future version will include the option to install a distro e.g. Ubuntu, Kali, etc."
    # Check if WSL is installed
    if (!(Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux)) {
        # WSL is not installed
        # Prompt user to install WSL
        $installWSL = Read-Host "WSL is not installed. Would you like to install it? (Y/N)"
        if ($installWSL -eq "Y") {
            # Install WSL
            Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
            Write-Host "WSL has been installed. Please restart your system to complete the installation."
        } else {
            # Do not install WSL
            Write-Host "WSL installation cancelled."
        }
    } else {
        # WSL is already installed
        Write-Host "WSL is already installed."
    }
}
