
function Test-RegPathCIS {
    param(
        [string]$settingPath,
        [string]$settingValueName,
        [int]$expectedValue,
        [string]$baseMessage
    )

    try {
        $settingValue = Get-ItemPropertyValue -Path $settingPath -Name $settingValueName -ErrorAction Stop

        if ($null -eq $settingValue) {
            Write-Host -ForegroundColor Yellow ($baseMessage + ": **not set**")
        }
        elseif ($settingValue -eq $expectedValue) {
            Write-Host -ForegroundColor Green ($baseMessage + ": **pass**")
        }
        else {
            Write-Host -ForegroundColor Red ($baseMessage + ": **fail**")
        }
    }
    catch {
        Write-Host -ForegroundColor Yellow ($baseMessage + ": **not set**")
    }
}

Function Get-ASR {
    # ASR rules
    $asrRules = @("26190899-1602-49e8-8b27-eb1d0a1ce869", "3b576869-a4ec-4529-8536-b80a7769e899", "5beb7efe-fd9a-4556-801d-275e5ffc04cc", "75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84", "7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c", "92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b", "9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2", "b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4", "be9ba2d9-53ea-4cdc-84e5-9b1eeee46550", "d3e037e1-3eb8-44c8-a917-57927947596d", "d4f940ab-401b-4efc-aadc-ad5f3c50688a", "e6db77e5-3df2-4cf1-b95a-636979351e5b")

    # Initial status
    $asrRulesStatus = @{}
    foreach ($rule in $asrRules) {
        $asrRulesStatus[$rule] = 0
    }

    # Registry path where the rules reside
    $regPath = "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender"

    # Get all subkeys
    $subKeys = Get-ChildItem -Path $regPath -Recurse -ErrorAction SilentlyContinue 

    # Loop through all subkeys and check ASR rules
    foreach ($subKey in $subKeys) {
        $ruleId = $subKey.PSChildName
        if ($asrRulesStatus.ContainsKey($ruleId)) {
            $ruleValue = Get-ItemPropertyValue -Path $subKey.PSPath -Name "default" -ErrorAction SilentlyContinue
            $asrRulesStatus[$ruleId] = $ruleValue
        }
    }

    # Check status
    $enabledRules = $asrRulesStatus.Values | Where-Object { $_ -eq 1 }

    switch ($enabledRules.Count) {
        0 {
            Write-Host "18.9.47.4.1.2(L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is configured: **fail**" -ForegroundColor Red
            $testResult = "fail"
        }
        { $_ -eq $asrRules.Count } {
            Write-Host "18.9.47.4.1.2(L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is configured: **pass**" -ForegroundColor Green
            $testResult = "pass"
        }
        default {
            Write-Output "18.9.47.4.1.2 (L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is configured: **pass (partially)**"
            $testResult = "partial pass"
        }
    }


}
function Invoke-CIS { 


        
    Write-Host "`n1 Account Policies"
    Write-Host "`n1.1 Password Polics"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Password" -settingValueName "DevicePasswordHistory" -expectedValue 24 -baseMessage "1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more passwords'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "DevicePasswordExpiration" -expectedValue 0 -baseMessage "1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "MinimumPasswordAge" -expectedValue 1 -baseMessage "1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "PasswordComplexity" -expectedValue 1 -baseMessage "1.1.5 (L1) Ensure 'Password must meet complexity requirements' is set to 'Numbers, lowercase, uppercase and special characters required'"
    Write-Host "`n18 Administrative Templates (Computer)"
    Get-ASR
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "CheckedValue" -expectedValue 0 -baseMessage "18.9.45.15 (L1) Ensure 'Turn off Microsoft Defender AntiVirus' is set to 'Disabled' (Automated)"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL" -settingValueName "CheckedValue" -expectedValue 1 -baseMessage "18.9.47.2 (L1) Ensure 'Turn on real-time protection' is set to 'Enabled'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "LocalSettingOverrideSpynetReporting" -expectedValue 0 -baseMessage "18.9.47.3.1 (L1) Ensure 'Configure local setting override for reporting to Microsoft MAPS' is set to 'Disabled'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "EnableNetworkProtection" -expectedValue 1 -baseMessage "18.9.47.4.3.1 (L1) Ensure 'Prevent users and apps from accessing dangerous websites' is set to 'Enabled: Block'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableIOAVProtection" -expectedValue 0 -baseMessage "18.9.47.8.1 (L1) Ensure 'Scan all downloaded files and attachments' is set to 'Enabled'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableRealtimeMonitoring" -expectedValue 0 -baseMessage "18.9.47.8.2 (L1) Ensure 'Turn off real-time protection' is set to 'Disabled'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableBehaviorMonitoring" -expectedValue 0 -baseMessage "18.9.47.8.3 (L1) Ensure 'Turn off behavior monitoring' is set to 'Disabled'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableRemovableDriveScanning" -expectedValue 0 -baseMessage "18.9.47.10 (L1) Ensure 'Turn off removable drive scanning' is set to 'Disabled'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender" -settingValueName "DisableAntiSpyware" -expectedValue 0 -baseMessage "18.9.47.15 (L1) Ensure 'Turn off Microsoft Defender AntiVirus' is set to 'Disabled'"
    Write-Host "`n"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" -settingValueName "MpEnablePus" -expectedValue 1 -baseMessage "Ensure 'PUAProtection' is set to 'Enabled'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -settingValueName "PasswordLess" -expectedValue 0 -baseMessage "Ensure 'Configure Passwordless RDP logon' is set to 'Not Configured'"

}
