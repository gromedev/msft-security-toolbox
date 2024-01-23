Function Check-SmartScreen {
    $SSValuePath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
    if (Test-Path $SSValuePath) {
        $SSvalue = Get-ItemPropertyValue -Path $SSValuePath -Name "SmartScreenEnabled"
        if ($SSvalue -eq 1) {
            Write-Host "SmartScreen Enabled" -ForegroundColor Green
        } else {
            Write-Host "SmartScreen Disabled" -ForegroundColor Red
        }
    } else {
        Write-Host "SmartScreen Path not found or inaccessible." -ForegroundColor Yellow
    }
}