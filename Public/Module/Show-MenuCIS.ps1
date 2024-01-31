function Show-MenuCIS {
    Write-Output "`nCIS-CAT Clone"
    Write-Output "-----------------------"

    Write-Output "Select an option:"
    Write-Output "1. Start CIS-CAT Scan"
    Write-Output ""
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        1 { Invoke-CISClone }
        0 { Show-Menu }
        h {
            $commands = @(
                "Incoke-CISClone"
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