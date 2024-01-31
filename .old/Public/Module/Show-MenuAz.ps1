function Show-MenuAz {
    Write-Output "`nAzure:"
    Write-Output "-----------------------"
    Write-Output "Select an option:"
    Write-Output "Working on it..."
    #Write-Output "1. Convert-AzureAdObject"
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        0 { Show-Menu }
        h {
            $commands = @(
                "Get-Help"
                #"Convert-AzureAdObject"
            )
            foreach ($command in $commands) {
                Get-Help $command | Format-List -Property Name, Synopsis
            }
            Show-MenuStringManipulation
        }
        default {
            Write-Output "Invalid selection"
            Show-MenuStringManipulation
        }
    }
}