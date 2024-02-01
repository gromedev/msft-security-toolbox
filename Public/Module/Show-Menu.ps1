function Show-Menu {
    Write-Host "`Description:" -ForegroundColor Green
    Write-Host "--------------------" -ForegroundColor Green
    $splashMessage = @"
The primary aim for this module is to provide a quick (but basic) security audits in a Microsoft environment. 
Items in the "Audit Menu" are automated functions a range of functions and save the results in a CSV file.
The Tool menu offers extra functionalities, including the individual components used in the full audit functions.
"@  
    Write-Host $splashMessage
   Write-Host "`n(The CIS-CAT Tool Works but is under development... Except bugs and limited results)" -foreground Red 
    Write-Host "`n`nFull Audits:" -ForegroundColor DarkYellow
    Write-Host "--------------------" -ForegroundColor DarkYellow
    Write-Host "1) Azure Users"
    Write-Host "2) Defender"
    Write-Host "3) Basic Windows Vulnerabilities"
    Write-Host "4) CIS-CAT Clone"

    
    Write-Host "`n`nAdditional Tools:" -ForegroundColor DarkYellow
    Write-Host "--------------------" -ForegroundColor DarkYellow
    Write-Host "5) Azure/M365"
    Write-Host "6) Defender"
    Write-Host "7) Networking"
    Write-Host "8) Windows OS"   
    Write-Host "9) Search Queries" 
    $choice = Read-Host "`nSelect an option"
    
    switch ($choice) {
        "1" {
            $result = Invoke-AzureUsersAudit
            Export-CSVResult $result "AzureUsersAudit"
        }
        "2" {
            $result = Invoke-DefenderAudit
            Export-CSVResult $result "DefenderAudit"
        }
        "3" {
            $result = Invoke-AuditBasicVulnerabilities
            Export-CSVResult $result "AuditBasicVulnerabilities"
        }
        "4" {
            $result = Invoke-CIS
            Export-CSVResult $result "CIS"
        }
        "5" {
            $result = Show-MenuAz
        }
        "6" {
            $result = Show-MenuDefender
        }
        "7" {
            $result = Show-MenuNetworking
        }
        "8" {
            $result = Show-MenuSearch
        }
        "9" {
            $result = Show-MenuWindows
        }
        default {
            Write-Host "Invalid choice."
        }
    }
}