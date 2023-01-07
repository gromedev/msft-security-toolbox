<#
.SYNOPSIS
    The Connect-MsftServices function is a PowerShell script that prompts the user for credentials and uses them to connect to various Microsoft services, including Azure AD, MSOL (Microsoft Online Services), and MG (Management Graph). The script also logs in to the Azure account and connects to the MG Service. Finally, the function displays the current Azure context, including the account and tenant that it is connected to.
#>
function Connect-MsftServices {
    # Prompt for credentials
    $cred = Get-Credential

    Write-Host "Connecting to Azure AD..."
    Connect-AzureAD -Credential $cred -Authentication Prompt

    Write-Host "Connecting to MSOL Service..."
    Connect-MsolService -Credential $cred -Authentication Prompt

    Write-Host "Logging in to Azure account..."
    Login-AzAccount -Credential $cred -Authentication Prompt

    Write-Host "Connecting to MgGraph Service..."
    Connect-MgService -Credential $cred -Authentication Prompt

    # Get current Azure context
    $context = Get-AzureRmContext
    $account = $context.Account
    $tenant = $context.Tenant.TenantId

    Write-Host "Connected to account '$account' in tenant '$tenant'"
}
