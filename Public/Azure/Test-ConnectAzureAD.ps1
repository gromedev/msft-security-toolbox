function Test-ConnectAzureAD {
    $sessionInfo = Get-AzureADCurrentSessionInfo 2>&1
    if ($sessionInfo -match "You must call the Connect-AzureAD cmdlet before calling any other cmdlets.") {
        # Prompt the user for connection if not connected
        $response = Read-Host "Not connected to AzureAD. Connect now? (Y/N)"
        if ($response -eq "Y") {
            $tenantId = Read-Host "Specify tenant ID (or leave blank)"
            if ($tenantId -eq "") {
                Connect-AzureAD
            }
            else {
                Connect-AzureAD -TenantId $tenantId
            }
        }
        else {
            Write-Host "Exiting script as AzureAD connection is required."
            Show-MenuAZ
        }
    }
}
