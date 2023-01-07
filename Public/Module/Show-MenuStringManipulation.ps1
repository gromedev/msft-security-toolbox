function Show-MenuStringManipulation {
    Write-Output "`nFile and String manipulation:"
    Write-Output "-----------------------"

    Write-Output "Select an option:"
    Write-Output "1. Find-File"
    Write-Output "2. Find-String"
    Write-Output "3. Set-StringInFiles"
    Write-Output "4. Set-FileNamesByDate"
    Write-Output "5. Invoke-Base64"
    Write-Output "6. Get-SHA1"
    Write-Output ""
    Write-Output "h. Get help"
    Write-Output "0. Return to main menu"
    Write-Output ""

    $selection = Read-Host "Enter your selection"
    switch ($selection) {
        1 { Find-File }
        2 { Find-String }
        3 { Set-StringInFiles }
        4 { Set-FileNamesByDate }
        5 { Invoke-Base64 }
        6 { Get-SHA1 }
        0 { Show-Menu }
        h {
            $commands = @(
                "Find-File",
                "Find-String",
                "Set-StringInFiles",
                "Set-FileNamesByDate",
                "Invoke-Base64",
                "Get-SHA1"
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
