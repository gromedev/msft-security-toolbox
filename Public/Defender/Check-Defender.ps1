function Test-DefenderSettings() {
    Write-Host "Testing Windows Defender AV settings"

    # Retrieve current preferences
    $preferences = Get-MpPreference

    # Check each setting
    $settings = @{
        "Real-time monitoring" = $preferences.DisableRealtimeMonitoring
        "Archive scanning" = $preferences.DisableArchiveScanning
        "Behavior monitoring" = $preferences.DisableBehaviorMonitoring
        "Intrusion prevention system" = $preferences.DisableIntrusionPreventionSystem
        "IOAV protection" = $preferences.DisableIOAVProtection
        "Removable drive scanning" = $preferences.DisableRemovableDriveScanning
        "Block at first sight" = $preferences.DisableBlockAtFirstSeen
        "Scanning mapped network drives for full scan" = $preferences.DisableScanningMappedNetworkDrivesForFullScan
        "Scanning network files" = $preferences.DisableScanningNetworkFiles
        "Script scanning" = $preferences.DisableScriptScanning
        "Low threat default action" = $preferences.LowThreatDefaultAction
        "Moderate threat default action" = $preferences.ModerateThreatDefaultAction
        "High threat default action" = $preferences.HighThreatDefaultAction
    }

    foreach ($setting in $settings.GetEnumerator()) {
        if ($null -eq $setting.Value) {
            Write-Host "$($setting.Key) status: Not set"
        } else {
            Write-Host "$($setting.Key) status: $($setting.Value)"
        }
    }
}