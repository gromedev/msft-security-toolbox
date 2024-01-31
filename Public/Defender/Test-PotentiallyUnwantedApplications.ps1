<#
This script automates the tests found here: https://demo.wd.microsoft.com/
#>
function Test-PotentiallyUnwantedApps {
    Write-Host "`nPotentially Unwanted Applications" -ForegroundColor White
    Write-Host "--------------------------"
    Write-Host "`nImportant: The test file is not malicious; it is just a harmless file simulating a virus." -ForegroundColor Red
    Write-Host ""
    Write-Host "If the file executes, or if you see it blocked by Microsoft Defender SmartScreen, it means that cloud-delivered protection is not working, and you should go to configure and validate network connections for Microsoft Defender Antivirus to learn more."
    Write-Host "`nExample: If successful, you should see that the file was blocked."

    $response = Read-Host "`nDo you wish to continue with the test? (Yes/No)"
    if ($response -eq "Yes") {
        $url = "http://amtso.eicar.org/PotentiallyUnwanted.exe"
        $localPath = "PotentiallyUnwanted.exe"

        if (-not (Test-Path "C:\temp")) {
            New-Item -Path "C:\temp" -ItemType Directory
        }

        $webClient = New-Object System.Net.WebClient
        try {
            $webClient.DownloadFile($url, $localPath)
            Write-Host "Download complete."
        }
        catch {
            Write-Host "An error occurred: $_"
        }
        finally {
            $webClient.Dispose()
        }

        try {
            Write-Host "Attempting to execute payload..."
            $process = Start-Process -FilePath $localPath -PassThru
            Start-Sleep -Seconds 2
            if ($process.HasExited -eq $false) {
                Write-Host "Potentially Unwanted Applications is NOT enabled. More details can be seen in the pop-up dialog windows." -ForegroundColor Red
            }
            else {
                Write-Host "Executable was blocked or closed immediately." -ForegroundColor Yellow
            }
        }
        catch {
            Write-Host "Payload was blocked. Potentially Unwanted Applications is active. $_" -ForegroundColor Red
        }
    }
    elseif ($response -eq "No") {
        Write-Host "`nTest aborted by the user."
    }
    else {
        Write-Host "`nInvalid input. Please enter 'Yes' or 'No'."
    }
}

