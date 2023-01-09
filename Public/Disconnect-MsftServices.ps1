<#
.SYNOPSIS
    The Connect-MsftServices function is a PowerShell script that prompts the user for credentials and uses them to disconnect to various Microsoft services, including Azure AD, MSOL (Microsoft Online Services), and MG (Management Graph). The script also logs in to the Azure account and connects to the MG Service. Finally, the function displays the current Azure context, including the account and tenant that it is connected to.
#>
function Disconnect-MsftServices {
    # Check if connected to Azure AD
    if (!(Get-AzureADTenantDetail)) {
        Write-Output "Not connected to Azure AD"
    }
    else {
        # Get current Azure context
        $context = Get-AzureRmContext
        $account = $context.Account
        $tenant = $context.Tenant.TenantId

        Write-Host "Disconnecting $account from $tenant..."
        Disconnect-AzureAD
    }

    # Check if connected to MSOL Service
    if (!(Get-MsolDomain)) {
        Write-Output "Not connected to MSOL Service"
    }
    else {
        # Get current Azure context
        $context = Get-AzureRmContext
        $account = $context.Account
        $tenant = $context.Tenant.TenantId

        Write-Host "Disconnecting $account from $tenant..."
        Disconnect-MsolService
    }

    # Check if logged in to Azure account
    if (!(Get-AzureRmContext)) {
        Write-Output "Not logged in to Azure account"
    }
    else {
        # Get current Azure context
        $context = Get-AzureRmContext
        $account = $context.Account
        $tenant = $context.Tenant.TenantId

        Write-Host "Disconnecting $account from $tenant..."
        Logout-AzAccount
    }

    # Check if connected to MG Service
    if (!(Get-MgApplication)) {
        Write-Output "Not connected to MG Service"
    }
    else {
        # Get current Azure context
        $context = Get-AzureRmContext
        $account = $context.Account
        $tenant = $context.Tenant.TenantId

        Write-Host "Disconnecting $account from $tenant..."
        Disconnect-MgService
    }
}
