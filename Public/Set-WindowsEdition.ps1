
<#
function Set-WindowsEdition() {
    $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
    $EditionID = "EditionID"
    $value = "Professional"
    $type = "STRING"
        
    $registryPathWow = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion"
    $EditionID = "EditionID"
    $ProductName = "Windows 10 Professional"
    $value = "Professional"
    $type = "STRING"
}
    
function Test-RegistryValue {
    
    param (

        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]$Path,

        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]$Value
    )

    try {
        Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
        return $true
    }

    catch {
        return $false
    }
}

Test-RegistryValue -Path $registryPath -Value 'EditionID'
Test-RegistryValue -Path $registryPathWow -Value 'EditionID'
Test-RegistryValue -Path $registryPathWow -Value 'ProductName'

write-output $registryPath
write-output $registryPathWow


if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}
else {
    write-host "noo"
}
#>