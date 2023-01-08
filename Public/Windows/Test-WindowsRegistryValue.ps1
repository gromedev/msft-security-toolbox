<# 
.SYNOPSIS
Test if a registry value exists
#>
function Test-WindowsRegistryValue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [string]$path,
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [string]$value
    )

    try {
        Get-ItemProperty -Path $path | Select-Object -ExpandProperty $value -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}
