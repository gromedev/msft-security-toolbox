<#
.SYNOPSIS
    This function establishes a PowerShell session with a remote computer by starting a new PowerShell window and running the Enter-PSSession cmdlet. The user can specify the hostname or IP address of the remote computer and their credentials as parameters, or they can be prompted to enter them if the parameters are not specified. The function includes error handling and debug information to help troubleshoot any issues that may occur.
#>
Function Start-RemoteConnection
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$ComputerName,
        [Parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]$Credential
    )

    if (-Not $ComputerName) {
        Add-Type -AssemblyName Microsoft.VisualBasic
        $ComputerName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter Hostname or IP", "Hostname", "$ComputerName")
        write-host $ComputerName
    }

    if (-Not $Credential) {
        $Credential = Get-Credential
    }

    $ScriptBlock = {
        Enter-PSSession -ComputerName $ComputerName -Credential $Credential
    }

    $ScriptBlock = $ScriptBlock.ToString()

    try {
        Start-Process powershell -Credential $Credential -ArgumentList "-Command & { $ScriptBlock }"
    }
    catch {
        Write-Error "Error starting remote connection: $($_.Exception.Message)"
        Write-Debug "ComputerName: $ComputerName"
        Write-Debug "Credential: $Credential"
        Write-Debug "ScriptBlock: $ScriptBlock"
    }
}
