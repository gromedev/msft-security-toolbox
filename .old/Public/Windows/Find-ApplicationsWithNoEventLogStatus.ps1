<#
.SYNOPSIS
This function lists all the applications that do not have any events logged in the event logs. It does this by retrieving a list of all the installed applications on the computer and searching the event logs for events with a source that contains the name of the application. If no events are found, the application is added to a list of results.
#>

function Find-ApplicationsWithNoEventLogStatus {
    Write-Output "This function lists all the applications that do not have any events logged in the event logs. It may take a while to run. Do you want to proceed? (Y/N)"
    $proceed = Read-Host
    if ($proceed -eq 'Y') {

        # Get a list of all installed applications
        $applications = Get-WmiObject -Class Win32_Product | Select-Object -Property Name

        # Initialize an array to store the results
        $results = @()

        # Iterate over each application
        foreach ($application in $applications) {
            # Search the event logs for events related to the application
            $events = Get-EventLog -LogName * -ErrorAction SilentlyContinue | ForEach-Object {
                Get-EventLog -LogName $_.Log -Newest 1000 -ErrorAction SilentlyContinue | Where-Object { $_.Source -like "*$($application.Name)*" }
            }

            # If no events were found, add the application to the results array
            if ($events.Count -eq 0) {
                $results += $application.Name
            }
        }

        # Display the results
        $results

        $export = Read-Host "Do you want to export the results to a CSV file? (y/n)"
        if ($export -eq 'y') {
            $path = Read-Host "Enter the path to export the CSV file (default is C:\temp)"
            if ([string]::IsNullOrEmpty($path)) {
                $path = "C:\temp\event_log.csv"
            }
            $results | Export-Csv -Path $path -NoTypeInformation -Force
        }
    }
}