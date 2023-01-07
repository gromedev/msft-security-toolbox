<#
.SYNOPSIS
    The function checks which modules are already installed and which ones need to be installed. It then prompts the user to confirm the installation and installs the modules with the -Force parameter to automatically answer "Yes to All" to any prompts. The progress of the installation is displayed.
#>
function Install-MsftModules() {
    Write-Output "`nInstall-MsftModules"
    $modules = @('Az', 'AzureAD', 'AzureRM', 'MSOnline', 'Microsoft.Graph')
    # Check which modules are already installed
    Write-Output "Checking which modules are already installed..."
    foreach ($module in $modules) {
        # Check if the module is already installed
        if (Get-Module -Name $module -ListAvailable) {
            # If the module is already installed, check if it is the newest version
            $installedModule = Get-Module -Name $module
            if ($installedModule.Version -eq (Get-Module -Name $module -ListAvailable).Version) {
                # If the module is the newest version, display a message indicating that it is already installed
                Write-Output "$module is already installed and is the newest version."
            }
            else {
                # If the module is not the newest version, display a message indicating that it is already installed but an update is available
                Write-Output "$module is already installed, but an update is available."
            }
        }
    }

    # List the modules that will be installed
    Write-Output "The following modules will be installed:"
    Write-Output $modules

    # Prompt the user to confirm the installation
    $confirm = Read-Host "Do you want to continue with the installation? (Y/N)"

    if ($confirm -eq "Y") {
        foreach ($module in $modules) {
            # Show the module that is being installed
            Write-Output "$module is being installed..."

            # Install the module
            Install-Module -Name $module -Force

            # Show that the module has been installed
            Write-Output "$module installed."
        }
    }
    Write-Output "`n"
    Show-Menu
}
#Install-MsftModules
