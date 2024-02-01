function Invoke-AzureUsersAudit {
    Test-ConnectAzureAD
    # Fetch all Azure AD users
    $users = Get-AzureADUser -All $true
    
    # Fetch Global Admins
    $globalAdmins = Get-AzureADDirectoryRole | Where-Object { $_.DisplayName -eq "Global Administrator" }
    $globalAdminMembers = Get-AzureADDirectoryRoleMember -ObjectId $globalAdmins.ObjectId
    Write-Host "Global Admins:" -ForegroundColor DarkYellow
    $globalAdminMembers | Select-Object DisplayName, UserPrincipalName | Format-Table

    # Fetch all privileged roles
    $privilegedRoles = Get-AzureADDirectoryRole | Where-Object { $_.DisplayName -like "*admin*" }
    foreach ($role in $privilegedRoles) {
        $roleMembers = Get-AzureADDirectoryRoleMember -ObjectId $role.ObjectId
        Write-Host "Members of role: $($role.DisplayName)"  -ForegroundColor DarkYellow
        $roleMembers | Select-Object DisplayName, UserPrincipalName | Format-Table
    }

    # Fetch sign-in logs with legacy authentication
    $legacyAuthSignIns = $signInLogs | Where-Object { $_.AuthenticationDetails -like "*basic*" }
    $legacyAuthSignIns | Format-Table UserPrincipalName, AuthenticationDetails
    
    
    # Check for users without MFA
    $usersWithoutMFA = $users | Where-Object { $null -eq $_.StrongAuthenticationRequirements }
    Write-Host "Users without MFA:" -ForegroundColor DarkYellow
    $usersWithoutMFA | Format-Table DisplayName, UserPrincipalName
    
    # Fetch users and check last sign-in
    foreach ($user in $users) {
        if ($user.LastSignIn -lt (Get-Date).AddMonths(-6)) {
            # 6 months threshold
            Write-Host "Inactive User: $($user.DisplayName), Last Sign-In: $($user.LastSignIn)"  -ForegroundColor DarkYellow
        }
    }
    # Check for external users
    $externalUsers = $users | Where-Object { $_.UserType -eq "Guest" }
    Write-Host "External Users:" -ForegroundColor DarkYellow
    $externalUsers | Format-Table DisplayName, UserPrincipalName

    # Fetch conditional access policies
    $caPolicies = Get-AzureADMSConditionalAccessPolicy
    foreach ($policy in $caPolicies) {
        Write-Host "Policy: $($policy.DisplayName)"  -ForegroundColor DarkYellow
        # Add more details as needed
    }

}
