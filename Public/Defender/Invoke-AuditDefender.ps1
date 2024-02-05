function Invoke-DefenderAudit {
    Test-DefenderSettings
    Test-ASRRulesStatus
    Test-SmartScreenStatus
    Test-CloudDeliveredProtection
    Test-PotentiallyUnwantedApplications
    Test-SmartScreenURL
    Get-BitLockerConfiguration
    #Get-MpPreference | Select *NetworkProtection* | Format-List

}