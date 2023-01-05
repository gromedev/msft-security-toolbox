<# 
.SYNOPSIS
    Set the registry key for the Outlook DelegateWastebasketStyle value
    
.PARAMETERS
  -registryPath: The registry path to the key. Default is "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\General"
  -name: The name of the key. Default is "DelegateWastebasketStyle"
  -value: The value to set for the key. Default is "4"
  -type: The data type for the key value. Default is "DWORD"
#>
function Set-RegistryKeyValue {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [string]$registryPath = "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\General",
        [Parameter(ValueFromPipeline)]
        [string]$name = "DelegateWastebasketStyle",
        [Parameter(ValueFromPipeline)]
        [string]$value = "4",
        [Parameter(ValueFromPipeline)]
        [string]$type = "DWORD"
    )
    Write-Output "`nSet-RegistryKey"
    if ($registryPath -eq $null) {
        $registryPath = Read-Host "Enter the registry path for the key (e.g. HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\General):"
    }
    if ($name -eq $null) {
        $name = Read-Host "Enter the name for the key (e.g. DelegateWastebasketStyle):"
    }
    if ($value -eq $null) {
        $value = Read-Host "Enter the value for the key (e.g. 4):"
    }
    if ($type -eq $null) {
        $type = Read-Host "Enter the data type for the key value (e.g. DWORD):"
    }

    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
    }

    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType $type -Force

    Write-Host ""
    Read-Host -Prompt "Press any key to reurn to main menu."
    Write-Output "`n`n"
    Show-Menu
    
}