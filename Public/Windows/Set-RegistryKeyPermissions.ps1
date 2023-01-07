<#
.SYNOPSIS
    The Set-RegistryKeyPermissions function in PowerShell modifies the permissions of a specified Windows Registry key to allow all users to read and execute the key. It does this by retrieving the current permissions of the key using the Get-Acl command, adding a new access rule to allow read and execute access to everyone using the New-Object and SetAccessRule commands, and then applying the modified permissions to the key using the Set-Acl command. If the -PassThru parameter is specified, the modified permissions are passed through the pipeline.
#>
function Set-RegistryKeyPermissions {
    [CmdletBinding()]
    Param (
        [Parameter(Position=0,Mandatory=$true)]
        [string]$Path,
        [Parameter(Position=1,Mandatory=$false)]
        [switch]$PassThru
    )
    Write-Output "`nSet-RegistryKeyPermissions"
    # Get the current permissions on the key
    $acl = Get-Acl $Path

    # Add a new access rule to allow the current user to read and execute the key
    $accessRule = New-Object System.Security.AccessControl.RegistryAccessRule('Everyone','ReadAndExecute','Allow')
    $acl.SetAccessRule($accessRule)

    # Apply the new permissions to the key
    Set-Acl $Path $acl

    # Pass the modified permissions through the pipeline if the -PassThru parameter is specified
    if ($PassThru) {
        $acl
    }
    Write-Output "`n"
    Show-Menu
}

