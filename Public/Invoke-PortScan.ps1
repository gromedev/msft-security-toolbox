function Invoke-PortScan {
    param(
        $ip,
        $range
    )

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
    $start..$end | % {
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
    if (-not $path -or -not $name) {
        Show-Menu
    }
}
