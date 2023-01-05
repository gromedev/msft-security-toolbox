<#
.SYNOPSIS
    This function modifies the permissions of a registry key to allow the current user to read and execute it.
#>
function Set-RegistryKeyPermissions {
    [CmdletBinding()]
    Param (
        [Parameter(Position=0,Mandatory=$true)]
        [string]$Path,
        [Parameter(Position=1,Mandatory=$false)]
        [switch]$PassThru
    )

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
}

