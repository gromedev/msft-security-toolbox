
function Invoke-CIS {  
    Write-Host "`n1 Account Policies"
    Write-Host "`n1.1 Password Polics"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Password" -settingValueName "DevicePasswordHistory" -expectedValue 24 -baseMessage "1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more passwords'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "DevicePasswordExpiration" -expectedValue 0 -baseMessage "1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "MinimumPasswordAge" -expectedValue 1 -baseMessage "1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)'"
    Test-RegPathCIS -settingPath "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeviceLock" -settingValueName "PasswordComplexity" -expectedValue 1 -baseMessage "1.1.5 (L1) Ensure 'Password must meet complexity requirements' is set to 'Numbers, lowercase, uppercase and special characters required'"
    Write-Host "`n18 Administrative Templates (Computer)"
    Get-ASRRules
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
