function Set-MacAddress {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [string]$MacAddress = $null
    )

    # Check if the function is being run as part of a pipeline or not
    if ($MacAddress -eq $null) {
        # If not, prompt the user to enter a MAC address
        $MacAddress = Read-Host "Enter a MAC address to use (e.g. 00-11-22-33-44-55):"
    } else {
        # If the function is being run as part of a pipeline, generate a random MAC address
        $MacAddress = Get-Random -Minimum 0x00 -Maximum 0xFF | ForEach-Object {$_.ToString("X2")}
        $MacAddress = "$MacAddress-$MacAddress-$MacAddress-$MacAddress-$MacAddress-$MacAddress"
    }

    $adapter = Get-WmiObject -Class Win32_NetworkAdapter | where {$_.NetConnectionID -eq "Ethernet"}
    $adapter.SetMACAddress($MacAddress)

    Show-Menu
}
