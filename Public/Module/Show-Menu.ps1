function Show-Menu {
    Write-Host "`Description:" -ForegroundColor Green
    Write-Host "--------------------" -ForegroundColor Green
    $splashMessage = @"
The primary aim for this module is to provide a quick (but basic) security audits in a Microsoft environment. 
Items in the "Audit Menu" are automated functions a range of functions and save the results in a CSV file.
The Tool menu offers extra functionalities, including the individual components used in the full audit functions.
"@  
    Write-Host $splashMessage
   Write-Host "`n(The CIS-CAT clone is very WIP and there's a long way to go...)" -foreground Red 
    Write-Host "`n`nFull Audits:" -ForegroundColor DarkYellow
    Write-Host "--------------------" -ForegroundColor DarkYellow
    Write-Host "1) Defender Configurations"
    Write-Host "2) Azure Users"
    Write-Host "3) CIS Security Controls"

    
    Write-Host "`n`nAdditional Tools:" -ForegroundColor DarkYellow
    Write-Host "--------------------" -ForegroundColor DarkYellow
    Write-Host "4) Defender"
    Write-Host "5) Azure/M365"
    Write-Host "6) Networking"
    Write-Host "7) Windows OS"   
    Write-Host "8) Search Queries" 
    $choice = Read-Host "`nSelect an option"
    
    switch ($choice) {
        "2" {
            $result = Invoke-AzureUsersAudit
            Export-CSVResult $result "DefenderAudit"
        }
        "1" {
            $result = Invoke-DefenderAudit
            Export-CSVResult $result "AzureUsersAudit"
        }
        "3" {
            $result = Invoke-CIS
            Export-CSVResult $result "CIS"
        }
        "4" {
            $result = Show-MenuDefender 
        }
        "5" {
            $result = Show-MenuAz
        }
        "6" {
            $result = Show-MenuNetworking
        }
        "7" {
            $result = Show-MenuSearch
        }
        "8" {
            $result = Show-MenuWindows
        }
        default {
            Write-Host "Invalid choice."
        }
    }
}