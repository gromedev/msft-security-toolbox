<#
.SYNOPSIS
This function enables Windows Defender by elevating to administrator privileges if necessary, removing the exclusions for all drives on the system, enabling the scanning engines, setting the default actions to their default values, and enabling the necessary services.
#>
function Enable-Defender() {

    Write-Host "[+] Enable Windows Defender (as $(whoami))"

    # Elevate to admin if necessary
    if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
        Write-Host "    [i] Elevate to Administrator"
        $CommandLine = "-ExecutionPolicy Bypass `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }

    # Remove all exclusions for Defender
    67..90 | foreach-object {
        $drive = [char]$_
        Remove-MpPreference -ExclusionPath "$($drive):\" -ErrorAction SilentlyContinue
        Remove-MpPreference -ExclusionProcess "$($drive):\*" -ErrorAction SilentlyContinue
    }

    # Enable scanning engines
    Set-MpPreference -DisableArchiveScanning 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableBehaviorMonitoring 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableIntrusionPreventionSystem 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableIOAVProtection 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableRemovableDriveScanning 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableBlockAtFirstSeen 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableScanningNetworkFiles 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableScriptScanning 0 -ErrorAction SilentlyContinue
    Set-MpPreference -DisableRealtimeMonitoring 0 -ErrorAction SilentlyContinue

    # Set default actions to default
    Set-MpPreference -LowThreatDefaultAction Default -ErrorAction SilentlyContinue
    Set-MpPreference -ModerateThreatDefaultAction Default -ErrorAction SilentlyContinue
    Set-MpPreference -HighThreatDefaultAction Default -ErrorAction SilentlyContinue

    # Enable services
    $svc_list = @("WdNisSvc", "WinDefend", "Sense")
    foreach ($svc in $svc_list) {
        $service = Get-Service -Name $svc -ErrorAction SilentlyContinue
        if ($service) {
            Set-Service -Name $service.Name -StartupType Automatic -ErrorAction SilentlyContinue
        }
    }
}
