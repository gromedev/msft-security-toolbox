function Find-Process {
    param(
        $name
    )

    if (-not $name) {
        $name = Read-Host "Enter the name of the process you want to query (or enter 'all' to query all processes)"
    }

    if ($name -eq "all") {
        Get-Process | Format-Table Name, Id, CPU, WorkingSet
    }
    else {
        Get-Process -Name $name | Format-Table Name, Id, CPU, WorkingSet
    }

    $confirm = Read-Host "Do you want to kill this process? (y/n)"
    if ($confirm -eq "y") {
        Stop-Process -Name $name
    }
    # Return to the menu if either $path or $name was not specified
    if (-not $name) {
        Invoke-Menu
    }
}
