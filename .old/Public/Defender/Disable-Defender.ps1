<#
.SYNOPSIS
    This script disables Windows Defender in various ways. It adds exclusions for all drives on the system, disables various scanning engines and default actions, and attempts to disable certain services. It can elevate itself to administrator or system privileges if necessary, and prompts the user to save the recovery key to a file if it is found.

.DESCRIPTION
    This script was taken from https://bidouillesecurity.com/disable-windows-defender-in-powershell
    It is NOT a disable/enable solution, I'm a malware analyst, I use it for malware analysis. It can completely DELETE Defender, and it is NOT REVERSIBLE (that's what I need). Once you have run it, you will no longer have any sort of antivirus protection, and WILL NOT BE ABLE to reactivate it.
#>

function Disable-Defender() {

    Write-Output "This (really great) function was removed:"
    Write-Output "Grab the original from here: https://bidouillesecurity.com/disable-windows-defender-in-powershell"
    Write-Output "`nEventually I'll get around to re-writing a version that isn't AS descructive."
}