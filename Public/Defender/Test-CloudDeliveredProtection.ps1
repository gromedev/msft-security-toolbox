<#
This script automates the tests found here: https://demo.wd.microsoft.com/
#>
function Test-CloudDeliveredProtection {
    Write-Host "`nCloud-delivered protection" -ForegroundColor white
    Write-Host "--------------------------"
    Write-Host "`nImportant: The test file is not malicious, it is just a harmless file simulating a virus." -ForegroundColor Red
    Write-Host "If the file executes, or if you see it blocked by Microsoft Defender SmartScreen it means that cloud-delivered protection is not working and you should go to configure and validate network connections for Microsoft Defender Antivirus to learn more."
    Write-Host "`nExample: Failed to block (but stopped by Microsoft Defender SmartScreen)."

    
    $response = Read-Host "Do you wish to continue with the test? (Yes/No)"
    if ($response -eq "Yes") {
        $url = "https://wdtestgroundstorage.blob.core.windows.net/public/validate/validatecloud.exe"
        $localPath = "C:\Temp\validatecloud.exe"

        if (-not (Test-Path "C:\Temp")) {
            New-Item -Path "C:\Temp" -ItemType Directory
        }

        $webClient = New-Object System.Net.WebClient
        try {
            $webClient.DownloadFile($url, $localPath)
            Write-Host "Download complete."
        }
        catch {
            Write-Host "An error occurred: $_"
            exit
        }
        finally {
            $webClient.Dispose()
        }
        try {
            Write-Host "Attempting to execute payload..."
            Start-Process -FilePath $localPath
        }
        catch {
            Write-Host "Payload was blocked. Cloud-delivered protection is active. $_" -ForegroundColor Green
        }
    }
    elseif ($response -eq "No") {
        Write-Host "`nTest aborted by the user."
    }
    else {
        Write-Host "`nInvalid input. Please enter 'Yes' or 'No'."
    }
}