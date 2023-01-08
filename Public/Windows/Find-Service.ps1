<#
.SYNOPSIS
Find-Service is a function that displays information about a specified service, or all services if no name is provided, and allows the user to stop the service if desired. 
e.g. Find-Service -name "wuauserv"  will display information about the service named "wuauserv", which is the Windows Update service. It will also prompt the user to stop the service if they wish.
#>
function Find-Service {
    param(
        $name
    )
    Write-Output "`nFind-Service"
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
}
