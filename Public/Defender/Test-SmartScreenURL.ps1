<#
This script automates the tests found here: https://demo.wd.microsoft.com/
#>
function Test-SmartScreenURL {
    Write-Host "`nMicrosoft Defender SmartScreen URL Reputation" -ForegroundColor white
    Write-Host "--------------------------"
    Write-Host "`nImportant: The test pages is not malicious, it is just a harmless file simulating a virus." -ForegroundColor Red
    Write-Host "`nIf SmartScreen is enabled, you should see a RED warning page when the URL is launched.`n"
    Write-Host "`nChecking to see if Registry Paths exist:"
    Write-Host "This check only works if SmartScreen was deployed via GPO or Intune.`n" -ForegroundColor Yellow


    # Check if Microsoft Edge is installed
    if (-not (Test-Path "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")) {
        Write-Host "Sorry. Microsoft Edge is required to run this script." -ForegroundColor Red
        exit
    }

    # Check SmartScreen status
    try {
        $status = Get-ItemPropertyValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name SmartScreenEnabled -ErrorAction Stop
        if ($status -eq "Off") {
            Write-Host "SmartScreen is disabled.`n" -ForegroundColor Green
        }
        else {
            Write-Host "SmartScreen is enabled.`n" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "Unable to determine SmartScreen status:" -ForegroundColor Red
        Write-Host "$_"
        Write-Host "It might be configured differently on this system`n "
    
    }

    # Check for SmartScreen policy in Edge
    $edgePolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
    $edgePolicyKey = "EnableSmartScreen"
    $edgePolicyValue = $null
    try {
        $edgePolicyValue = Get-ItemPropertyValue $edgePolicyPath -Name $edgePolicyKey
    }
    catch {
        Write-Host "Unable to determine MS Edge SmartScreen status: " -ForegroundColor Red
        Write-Host "$_"
        Write-Host "It might be configured differently on this system`n "
    
    }

    # Check for SmartScreen policy in Windows System
    $systemPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
    $systemPolicyKey1 = "EnableSmartScreen"
    $systemPolicyValue1 = $null
    $systemPolicyKey2 = "ShellSmartScreenLevel"
    $systemPolicyValue2 = $null
    try {
        $systemPolicyValue1 = Get-ItemPropertyValue $systemPolicyPath -Name $systemPolicyKey1
        $systemPolicyValue2 = Get-ItemPropertyValue $systemPolicyPath -Name $systemPolicyKey2
    }
    catch {
        Write-Host "Unable to determine SmartScreen policies in Windows System:" -ForegroundColor Red
        Write-Host "$_"
        Write-Host "It might be configured differently on this system`n "
    
    }

    # Display SmartScreen policy status
    if ($edgePolicyValue -eq 1 -or $systemPolicyValue1 -eq 1 -or $systemPolicyValue2 -eq "Block") {
        Write-Host "SmartScreen policy is enabled." -ForegroundColor Green
    }
    else {
        Write-Host "SmartScreen policy is disabled" -ForegroundColor Red
        Write-Host "Check MS Edge browser settings to see if SmartScreen IS enabled.`n" -ForegroundColor Yellow
    
    }

    # Test each scenario
    $phishingUrl = "https://demo.smartscreen.msft.net/phishingdemo.html"
    $malwareUrl = "https://demo.smartscreen.msft.net/other/malware.html"
    $blockedDownloadUrl = "https://demo.smartscreen.msft.net/download/malwaredemo/freevideo.exe"
    $exploitUrl = "https://demo.smartscreen.msft.net/other/exploit.html"
    $malvertisingUrl = "https://demo.smartscreen.msft.net/other/exploit_frame.html"

    function Test-SmartScreenScenario {
        param (
            [string]$url,
            [string]$scenarioName
        )

        Write-Host "Scenario: $scenarioName"
        Write-Host "URL: $url"

        try {
            Start-Process msedge -ArgumentList $url -Wait
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }

    # Prompt the user to select a scenario
    do {
        Write-Host "`nSelect a test:"
        Write-Host "1) Phishing"
        Write-Host "2) Malware"
        Write-Host "3) Blocked Download"
        Write-Host "4) Exploit Page"
        Write-Host "5) Malvertising"
        Write-Host "6) Execute ALL tests"
        Write-Host "7) Exit"

        $choice = Read-Host "`nEnter the number of the scenario you want to test (or '7' to exit)"

        switch ($choice) {
            "1" {
                Test-SmartScreenScenario -url $phishingUrl -scenarioName "Phishing"
            }
            "2" {
                Test-SmartScreenScenario -url $malwareUrl -scenarioName "Malware"
            }
            "3" {
                Test-SmartScreenScenario -url $blockedDownloadUrl -scenarioName "Blocked Download"
            }
            "4" {
                Test-SmartScreenScenario -url $exploitUrl -scenarioName "Exploit Page"
            }
            "5" {
                Test-SmartScreenScenario -url $malvertisingUrl -scenarioName "Malvertising"
            }
            "6" {
                Test-SmartScreenScenario -url $phishingUrl -scenarioName "Phishing"
                Test-SmartScreenScenario -url $malwareUrl -scenarioName "Malware"
                Test-SmartScreenScenario -url $blockedDownloadUrl -scenarioName "Blocked Download"
                Test-SmartScreenScenario -url $exploitUrl -scenarioName "Exploit Page"
                Test-SmartScreenScenario -url $malvertisingUrl -scenarioName "Malvertising"
            }
            "7" {
                Write-Host "Exiting the script."
            }
            default {
                Write-Host "`nYou have to choose 1-7. Re-run the script." -ForegroundColor Red
            }
        }
    } while ($choice -ne "7")
}
