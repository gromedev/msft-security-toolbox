function Show-MenuLinuxWSL {
    Write-Output "`nLinux WSL:"
    Write-Output "-----------------------"

    Write-Output "Select an option:"
    Write-Output "1. Enable Install-WSL"
    Write-Output ""
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        1 { Install-WSL }
        0 { Show-Menu }
        h {
            $commands = @(
                "Install-WSL"
            )
            foreach ($command in $commands) {
                Get-Help $command | Format-List -Property Name, Synopsis
            }
            Show-MenuLinuxWSL
        }
        default {
            Write-Output "Invalid selection"
            Show-MenuLinuxWSL
        }
    }
}