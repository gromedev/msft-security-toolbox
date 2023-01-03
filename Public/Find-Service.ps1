function Find-Service {
    param(
        $name
    )

    if (-not $name) {
        $name = Read-Host "Enter the name of the service you want to query (or enter 'all' to query all services)"
    }

    if ($name -eq "all") {
        Get-Service | Format-Table Name, Status, DisplayName, StartType
    }
    else {
        Get-Service -Name $name | Format-Table Name, Status, DisplayName, StartType
    }

    $confirm = Read-Host "Do you want to stop this service? (y/n)"
    if ($confirm -eq "y") {
        Stop-Service -Name $name
    }
    # Return to the menu if either $path or $name was not specified
    if (-not $name) {
        Show-Menu
    }
}
