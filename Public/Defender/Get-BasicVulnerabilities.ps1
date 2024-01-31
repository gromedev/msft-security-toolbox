# Script to Audit Top 25 Common Registry Vulnerabilities

Write-Host "Note: This script scans for the top 25 most common registry vulnerabilities. It may not cover all potential issues in your environment."

function Get-BasicVulnerabilities {
    param (
        [string]$Path,
        [string]$Name,
        [string]$ExpectedValue
    )

    $value = (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue).$Name
    if ($value -ne $ExpectedValue) {
        return "$Path\$Name is set to $value; Expected: $ExpectedValue"
    }

    $misconfigurations = @(
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "EnableLUA" 1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters" "AutoDisconnect" -1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Services\LanManWorkstation\Parameters" "RequireSecuritySignature" 1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Lsa" "RestrictAnonymous" 1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Lsa" "RestrictAnonymousSAM" 1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Lsa" "LimitBlankPasswordUse" 1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Control\SecurePipeServers\Winreg" "AllowedPaths" "Machine"
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "shutdownwithoutlogon" 0
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile" "EnableFirewall" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile" "EnableFirewall" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile" "EnableFirewall" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile" "DefaultOutboundAction" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile" "DefaultOutboundAction" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile" "DefaultOutboundAction" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile" "DefaultInboundAction" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile" "DefaultInboundAction" 1
        Check-RegistrySetting "HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile" "DefaultInboundAction" 1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Terminal Server" "fDenyTSConnections" 1
        Check-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" "UserAuthentication" 1
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "ConsentPromptBehaviorAdmin" 2
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "EnableInstallerDetection" 1
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "PromptOnSecureDesktop" 1
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" "CachedLogonsCount" 0
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "DontDisplayLastUserName" 1
        Check-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "DisableCAD" 0
    )

    $misconfigurations = $misconfigurations | Where-Object { $_ }
    if ($misconfigurations) {
        Write-Host "Potential Vulnerabilities Found:"
        $misconfigurations | ForEach-Object { Write-Host $_ -ForegroundColor Red }
    }
    else {
        Write-Host "Common registry vulnerabilities not found or settings are as expected." -ForegroundColor Green
    }

    Execute the Registry Vulnerability Audit
    Write-Host "Auditing Registry for Common Vulnerabilities..."
    $misconfigurations | Format-Table -AutoSize
}