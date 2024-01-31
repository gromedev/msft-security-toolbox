<# 
.SYNOPSIS
Set the selected edition and update the related registry values
#>
function Set-WindowsSelectedEdition {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [string]$edition
    )

    # Valid editions: Professional, Home, Education, Enterprise
    # Additional editions may be supported depending on the version of Windows
    if ($edition -notmatch "^(Professional|Home|Education|Enterprise)$") {
        Write-Output "Error: Invalid edition selected."
        return
    }

    $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
    $editionID = "EditionID"
    $type = "STRING"

    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
    }

    New-ItemProperty -Path $registryPath -Name $editionID -Value $edition -PropertyType $type -Force

    $registryPathWow = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion"
    $productName = "ProductName"

    if (!(Test-Path $registryPathWow)) {
        New-Item -Path $registryPathWow -Force | Out-Null
    }

    New-ItemProperty -Path $registryPathWow -Name $editionID -Value $edition -PropertyType $type -Force
    New-ItemProperty -Path $registryPathWow -Name $productName -Value "Windows 10 $edition" -PropertyType $type -Force
}
