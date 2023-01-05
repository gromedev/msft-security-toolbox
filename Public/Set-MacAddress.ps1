<#
.SYNOPSIS
    setting the MAC (Media Access Control) address of a computer's Ethernet adapter. It takes one parameter, $MacAddress, which is optional and can be passed in from the pipeline. If the function is not being run as part of a pipeline (i.e., $MacAddress is $null), it prompts the user to enter a MAC address to use. If the function is being run as part of a pipeline, it generates a random MAC address. The function then uses the Get-WmiObject cmdlet to retrieve the Ethernet adapter and the SetMACAddress method to set its MAC address to the specified or generated value.
#>
function Set-MacAddress {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [string]$MacAddress = $null
    )
    Write-Output "`nSet-MacAddress"
    # Check if the function is being run as part of a pipeline or not
    if ($MacAddress -eq $null) {
        # If not, prompt the user to enter a MAC address
        $MacAddress = Read-Host "Enter a MAC address to use (e.g. 00-11-22-33-44-55):"
    } else {
        # If the function is being run as part of a pipeline, generate a random MAC address
        $MacAddress = Get-Random -Minimum 0x00 -Maximum 0xFF | ForEach-Object {$_.ToString("X2")}
        $MacAddress = "$MacAddress-$MacAddress-$MacAddress-$MacAddress-$MacAddress-$MacAddress"
    }

    $adapter = Get-WmiObject -Class Win32_NetworkAdapter | Where-Object {$_.NetConnectionID -eq "Ethernet"}
    $adapter.SetMACAddress($MacAddress)

    Write-Output "`n`n"
    Show-Menu
}
