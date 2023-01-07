<#
.SYNOPSIS
This function searches the event logs for events that contain a specified keyword in the message. It displays the results in a table, along with the number of results and errors, and prompts the user to export the results to a CSV file. T
#>
function Search-EventLog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [String]
        $Keyword
    )
    Write-Output "`nSearch-EventLog"

    $results = Get-EventLog -LogName * -ErrorAction SilentlyContinue | ForEach-Object {
        Get-EventLog -LogName $_.Log -Newest 1000 -ErrorAction SilentlyContinue | Where-Object { $_.Message -like "*$Keyword*" }
    }

    $results | Format-Table -Property TimeGenerated, EntryType, Source, EventID, Message -AutoSize

    "Number of results: $($results.Count)"
    "Number of errors: $($error.Count)"

    if ($results.Count -eq 0) {
        Write-Output "No results. Not all applications generate event logs. Would you like to see which installed applications currently do not?"
        $proceed = Read-Host
        if ($proceed -eq 'Y') {
            Find-ApplicationsWithNoEventLogStatus
        }
    }

    $export = Read-Host "Do you want to export the results to a CSV file? (y/n)"
    if ($export -eq 'y') {
        $path = Read-Host "Enter the path to export the CSV file (default is C:\temp)"
        if ([string]::IsNullOrEmpty($path)) {
            $path = "C:\temp\event_log.csv"
        }
        $results | Export-Csv -Path $path -NoTypeInformation -Force
    }
    Write-Output "`n"
    Show-Menu
}
