<#
.SYNOPSIS
    This function performs a port scan on a specified IP address over a specified range of ports. If the IP address or port range are not provided as parameters, the user will be prompted to enter them. The function scans each port in the specified range and prints a message if the port is open."
#>
function Invoke-PortScan {
    param(
        $ip,
        $range
    )
    Write-Output "`nInvoke-PortScan"
    # Prompt user for IP address and port range if they were not specified
    if (-not $ip) {
        $ip = Read-Host "Enter the IP address: "
    }
    if (-not $range) {
        $range = Read-Host "Enter the port range (e.g. 1-1024): "
    }

    # Split port range into start and end components
    $start, $end = $range -split '-'

    # Scan ports in the specified range
    $start..$end | ForEach-Object {
        # Try to connect to the current port
        $connection = New-Object Net.Sockets.TcpClient
        $connection.Connect($ip, $_)

        # If the connection is successful, print a message
        if ($connection.Connected) {
            Write-Output "Port $_ is open!"
        }

        # Close the connection
        $connection.Close()
    }
    # Return to the menu if either $path or $name was not specified
    #if (-not $ip -or -not $range) {
        Write-Output "`n`n"
        Show-Menu
    #}
}
