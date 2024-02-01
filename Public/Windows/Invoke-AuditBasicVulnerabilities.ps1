function Test-RegistrySetting {
    param (
        [string]$Path,
        [string]$Name,
        [string]$ExpectedValue,
        [string]$Description
    )

    $value = (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue).$Name
    if ($null -eq $value) {
        return "Missing: $Path\$Name`nVulnerability: $Description`n_________________"
    } elseif ($value -ne $ExpectedValue) {
        return "Conflict: $Path\$Name `nResult; $value `nExpected: $ExpectedValue`nVulnerability: $Description`n_________________"
    }
}

function Invoke-AuditBasicVulnerabilities {
    Write-Host "Auditing Registry for Common Vulnerabilities..."

    $misconfigurations = @(
        Test-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "EnableLUA" 1 "EnableLUA: Enforces User Account Control (UAC) to mitigate the impact of malware. Disabling UAC increases the risk for privilege esclation."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters" "AutoDisconnect" 1 "AutoDisconnect: Sets the time before disconnecting idle sessions. Indefinite idle time (-1) increases the attack surface."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Services\LanManWorkstation\Parameters" "RequireSecuritySignature" 1 "Requires SMB security signatures. Disabling this can expose file transfers to tampering and eavesdropping."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Lsa" "RestrictAnonymous" 1 "Restricts anonymous access to the system. Anonymous access to the Security Account Manager (SAM) database allows for e.g. user account enumeration."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Lsa" "RestrictAnonymousSAM" 1 "Restricts anonymous access to the Security Account Manager. Prevents enumeration of user accounts and other sensitive data."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Lsa" "LimitBlankPasswordUse" 1 "Disallows remote use of accounts with blank passwords."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Control\SecurePipeServers\Winreg" "AllowedPaths" "Machine" "Restricts remote access to certain sensitive registry paths e.g. HKLM\Software\Microsoft\OLAP Server"
        Test-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "shutdownwithoutlogon" 0 "Controls ability to shut down the system without logging on. Prevents potential misuse of the shutdown/reboot process."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Terminal Server" "fDenyTSConnections" 1 "Disables Remote Desktop connections."
        Test-RegistrySetting "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" "UserAuthentication" 1 "Requires network-level authentication for Remote Desktop."
        Test-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "ConsentPromptBehaviorAdmin" 2 "Configures UAC prompt behavior for admins."
        Test-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "EnableInstallerDetection" 1 "Detects and elevates installation programs."
        Test-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "PromptOnSecureDesktop" 1 "UAC prompts appear on the secure desktop."
        Test-RegistrySetting "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" "CachedLogonsCount" 0 "Limits the number of cached logon credentials. Reduces the risk of credential theft on a compromised system."
        Test-RegistrySetting "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "DisableCAD" 0 "Requires Ctrl+Alt+Del to be pressed at logon."
    )

    foreach ($misconfig in $misconfigurations) {
        if ($misconfig) {
            if ($misconfig -match "Missing:") {
                Write-Host $misconfig -ForegroundColor White
            } elseif ($misconfig -match "Conflict:") {
                Write-Host $misconfig -ForegroundColor Yellow
            }
        }
    }

    if (-not $misconfigurations -or $misconfigurations.Count -eq 0) {
        Write-Host "No common registry vulnerabilities found or settings are as expected." -ForegroundColor Green
    }
}

# Execute the audit function
#Invoke-AuditBasicVulnerabilities