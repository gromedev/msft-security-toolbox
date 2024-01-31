#function Invoke-IntuneBackupAppProtectionPolicy

<#
.AUTHOR
    thomas@grome.dev

.SYNOPSIS
    Check and Display Status of Attack Surface Reduction Rules.

.FUTURE
    Convert into function to be used in CIS-CAT clone module.

#>

function Get-IntuneASR {

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
            Write-Output "18.9.47.4.1.2(L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is configured: **fail**"
            $testResult = "fail"
        }
        { $_ -eq $asrRules.Count } {
            Write-Output "18.9.47.4.1.2(L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is configured: **pass**"
            $testResult = "pass"
        }
        default {
            Write-Output "18.9.47.4.1.2(L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is configured: **pass (partially)**"
            $testResult = "partial pass"
        }
    }

    # Output to CSV
    $results = $asrRulesStatus.GetEnumerator() | Select-Object @{n = 'Rule'; e = { $_.Key } }, @{n = 'Status'; e = { $_.Value } }
    $results | Export-Csv -Path .\ASRRules.csv -NoTypeInformation

    # Separator
    Write-Output "`n--------------------- Displaying all subkeys ---------------------`n"

    # Get the 'Defender' subkey
    $subKey = Get-Item -Path $regPath -ErrorAction SilentlyContinue 

    # Print out its name and data
    Write-Output "Subkey: $($subKey.PSChildName)"
    $properties = Get-ItemProperty -Path $subKey.PSPath -ErrorAction SilentlyContinue
    foreach ($property in $properties.PSObject.Properties) {
        if ($property.Name -notmatch "PSPath|PSParentPath|PSChildName|PSProvider") {
            Write-Output "`tProperty: $($property.Name), Value: $($property.Value)"
        }
    }
}