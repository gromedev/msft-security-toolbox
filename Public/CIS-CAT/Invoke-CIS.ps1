function Test-RegPathCIS {
    param(
        [string]$settingPath,
        [string]$settingValueName,
        [int]$expectedValue,
        [string]$baseMessage
    )

    try {
        $settingValue = Get-ItemPropertyValue -Path $settingPath -Name $settingValueName -ErrorAction Stop
        $result = ""

        if ($null -eq $settingValue) {
            $result = "not set"
        }
        elseif ($settingValue -eq $expectedValue) {
            $result = "pass"
        }
        else {
            $result = "fail"
        }
    }
    catch {
        $result = "missing"
    }
    return [PSCustomObject]@{
        'Name'           = $baseMessage
        'Expected Value' = $expectedValue
        'Result'         = $result
        #'Description'         = $description
    }
}


Function Get-ASRRules {
    # ASR rules with descriptions
    $asrRulesDescriptions = @{
        "26190899-1602-49e8-8b27-eb1d0a1ce869" = "Block Office communication application from creating child processes"
        "3b576869-a4ec-4529-8536-b80a7769e899" = "Block Office applications from creating executable content"
        "5beb7efe-fd9a-4556-801d-275e5ffc04cc" = "Block execution of potentially obfuscated scripts"
        "75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84" = "Block Office applications from injecting code into other processes"
        "7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c" = "Block Adobe Reader from creating child processes"
        "92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b" = "Block Win32 API calls from Office macros"
        "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2" = "Block credential stealing from the Windows local security authority subsystem (lsass.exe)"
        "b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4" = "Block untrusted and unsigned processes that run from USB"
        "be9ba2d9-53ea-4cdc-84e5-9b1eeee46550" = "Block executable content from email client and webmail"
        "d3e037e1-3eb8-44c8-a917-57927947596d" = "Block JavaScript or VBScript from launching downloaded executable content"
        "d4f940ab-401b-4efc-aadc-ad5f3c50688a" = "Block all Office applications from creating child processes"
        "e6db77e5-3df2-4cf1-b95a-636979351e5b" = "Block persistence through WMI event subscription"
    }

    # Results array
    $results = @()

    # Registry path where the rules reside
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules"

    # Loop through each rule and check its status
    foreach ($ruleId in $asrRulesDescriptions.Keys) {
        $rulePath = Join-Path -Path $regPath -ChildPath $ruleId
        $ruleStatus = Get-ItemPropertyValue -Path $rulePath -Name "Enabled" -ErrorAction SilentlyContinue

        # Determine rule status
        $status = if ($ruleStatus -eq 1) {"Enabled"} else {"Disabled"}

        # Add rule check result to results array
        $results += [PSCustomObject]@{
            'Name' = $asrRulesDescriptions[$ruleId]
            'Rule ID' = $ruleId
            'Status' = $status
            'Description' = "Check if ASR rule '$($asrRulesDescriptions[$ruleId])' is $status."
        }
    }

    # Return results
    return $results
}


function Invoke-CIS {  
    $results = @()

    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Password" -settingValueName "DevicePasswordHistory" -expectedValue 24 -baseMessage "1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more passwords'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "DevicePasswordExpiration" -expectedValue 0 -baseMessage "1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "MinimumPasswordAge" -expectedValue 1 -baseMessage "1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "PasswordComplexity" -expectedValue 1 -baseMessage "1.1.5 (L1) Ensure 'Password must meet complexity requirements' is set to 'Numbers, lowercase, uppercase and special characters required'"
    $asrResults = Get-ASRRules
    $results += $asrResults
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "CheckedValue" -expectedValue 0 -baseMessage "18.9.45.15 (L1) Ensure 'Turn off Microsoft Defender AntiVirus' is set to 'Disabled' (Automated)"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL" -settingValueName "CheckedValue" -expectedValue 1 -baseMessage "18.9.47.2 (L1) Ensure 'Turn on real-time protection' is set to 'Enabled'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "LocalSettingOverrideSpynetReporting" -expectedValue 0 -baseMessage "18.9.47.3.1 (L1) Ensure 'Configure local setting override for reporting to Microsoft MAPS' is set to 'Disabled'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "EnableNetworkProtection" -expectedValue 1 -baseMessage "18.9.47.4.3.1 (L1) Ensure 'Prevent users and apps from accessing dangerous websites' is set to 'Enabled: Block'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableIOAVProtection" -expectedValue 0 -baseMessage "18.9.47.8.1 (L1) Ensure 'Scan all downloaded files and attachments' is set to 'Enabled'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableRealtimeMonitoring" -expectedValue 0 -baseMessage "18.9.47.8.2 (L1) Ensure 'Turn off real-time protection' is set to 'Disabled'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableBehaviorMonitoring" -expectedValue 0 -baseMessage "18.9.47.8.3 (L1) Ensure 'Turn off behavior monitoring' is set to 'Disabled'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableRemovableDriveScanning" -expectedValue 0 -baseMessage "18.9.47.10 (L1) Ensure 'Turn off removable drive scanning' is set to 'Disabled'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableAntiSpyware" -expectedValue 0 -baseMessage "18.9.47.15 (L1) Ensure 'Turn off Microsoft Defender AntiVirus' is set to 'Disabled'"
    ###
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" -settingValueName "MpEnablePus" -expectedValue 1 -baseMessage "Ensure 'PUAProtection' is set to 'Enabled'"
    $results += Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -settingValueName "PasswordLess" -expectedValue 0 -baseMessage "Ensure 'Configure Passwordless RDP logon' is set to 'Not Configured'"
    
    #CSV Export
    if (-not (Test-Path -Path "c:\temp")) {
        New-Item -ItemType Directory -Path "c:\temp"
    }
    $results | Export-Csv -Path "c:\temp\CIS_results.csv" -NoTypeInformation
}



<#
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

#>