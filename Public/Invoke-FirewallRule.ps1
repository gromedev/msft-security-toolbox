function Invoke-FirewallRule {
    param(
        $action,
        $name,
        $protocol,
        $localport,
        $remoteaddress,
        $remoteport,
        $direction,
        $profiles
    )

    # Prompt user for action and rule properties if they were not specified
    if (-not $action) {
        $action = Read-Host "Enter the action (list or modify): "
    }
    if ($action -eq "modify") {
        if (-not $name) {
            $name = Read-Host "Enter the name of the rule: "
        }
        if (-not $protocol) {
            $protocol = Read-Host "Enter the protocol (TCP or UDP): "
        }
        if (-not $localport) {
            $localport = Read-Host "Enter the local port: "
        }
        if (-not $remoteaddress) {
            $remoteaddress = Read-Host "Enter the remote address: "
        }
        if (-not $remoteport) {
            $remoteport = Read-Host "Enter the remote port: "
        }
        if (-not $direction) {
            $direction = Read-Host "Enter the direction (inbound or outbound): "
        }
        if (-not $profiles) {
            $profiles = Read-Host "Enter the profiles (public, private, or domain): "
        }
    }

    # Check the action
    if ($action -eq "list") {
        # List the firewall rules
        Get-NetFirewallRule | Format-Table -Property DisplayName, Protocol, LocalPort, RemoteAddress, RemotePort, Direction, Enabled, Profiles
    }
    elseif ($action -eq "modify") {
        # Modify the firewall rule
        Set-NetFirewallRule -Name $name -Protocol $protocol -LocalPort $localport -RemoteAddress $remoteaddress -RemotePort $remoteport -Direction $direction -Enabled True -Profile $profiles
    }
    else {
        # Invalid action
        Write-Output "Invalid action. Please specify either 'list' or 'modify'."
    }
    # Return to the menu if either $path or $name was not specified
    if (-not $path -or -not $name) {
        Invoke-Menu
    }
}
