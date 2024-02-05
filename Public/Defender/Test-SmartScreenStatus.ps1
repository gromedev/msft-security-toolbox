# PowerShell script to check the status of SmartScreen settings across Windows components and Microsoft Edge
function Test-SmartScreenStatus {
    function SmartScreenConfig {
        param (
            [string]$Path,
            [string]$ValueName = "*"
        )

        if (Test-Path $Path) {
            $value = Get-ItemProperty -Path $Path -Name $ValueName -ErrorAction SilentlyContinue
            if ($null -ne $value) {
                $value.PSObject.Properties | Where-Object {
                    $_.Name -ne "PSPath" -and $_.Name -ne "PSParentPath" -and $_.Name -ne "PSChildName" -and $_.Name -ne "PSDrive" -and $_.Name -ne "PSProvider"
                } | ForEach-Object {
                    Write-Output "$Path\$($_.Name) is set to $($_.Value)"
                }
            }
            else {
                Write-Host "$Path does not exist or is not configured." -ForegroundColor Red
            }
        }
        else {
            Write-Host "$Path does not exist or is not configured." -ForegroundColor Red
        }
    }

    # SmartScreen settings to check
    $registryPaths = @(
        # Updated registry paths for SmartScreen settings based on latest documentation and features
        "HKLM:\Software\Policies\Microsoft\Windows\System\SmartScreenEnabled",
        "HKLM:\Software\Policies\Microsoft\Edge\SmartScreenEnabled",
        "HKCU:\Software\Microsoft\Edge\SmartScreenEnabled",
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\SmartScreenEnabled",
        "HKLM:\Software\Policies\Microsoft\Windows Defender\SmartScreen\ConfigureSmartScreen",
        "HKLM:\Software\Policies\Microsoft\Edge\SmartScreenEnabled",
        "HKLM:\Software\Policies\Microsoft\Edge\PreventSmartScreenPromptOverride",
        "HKLM:\Software\Policies\Microsoft\Edge\PreventSmartScreenPromptOverrideForFiles"
    )

    # Iterate through each path and check its configuration
    foreach ($path in $registryPaths) {
        SmartScreenConfig -Path $path
    }

}