function Invoke-DefenderAudit {
    Test-DefenderSettings
    Test-ASRRulesStatus
    Get-BitLockerConfiguration
    Test-CloudDeliveredProtection
    Test-PotentiallyUnwantedApplications
    Test-SmartScreen
}