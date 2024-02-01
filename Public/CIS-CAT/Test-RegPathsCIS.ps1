function Test-RegPathsCIS {
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
        Write-Host ($baseMessage + ": **not set**")
    }
}