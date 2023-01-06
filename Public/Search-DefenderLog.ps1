<#
.SYNOPSIS
    The function will extract the .cab file, search each log file for the specified query, and then delete the extracted log files.
#>
function Search-DefenderLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$CabFile,
        [Parameter(Mandatory=$true)]
        [string]$Query
    )

    Write-Output "`nSearch-DefenderLog"

    # Prompt the user to confirm that they want to search the Defender logs
    $confirm = Read-Host "Do you want to search the Defender logs? (Y/N)"

    # If the user confirms, search the logs
    if ($confirm -eq "Y") {
        # Check if the CabFile parameter has a value
        if ($CabFile -eq $null) {
            # If the CabFile parameter is null, prompt the user to enter a path
            $CabFile = Read-Host "Enter the path to the .cab file or just continue to generate a new .cab file:"
        }

        # Check if the Query parameter has a value
        if ($Query -eq $null) {
            # If the Query parameter is null, prompt the user to enter a search query
            $Query = Read-Host "Enter the search query:"
        }

        # Extract the .cab file
        Expand-Archive -LiteralPath $CabFile -DestinationPath (Split-Path -Parent $CabFile)

        # Get the list of log files in the .cab file
        $logFiles = Get-ChildItem -Path (Split-Path -Parent $CabFile) -Filter *.log

        # Search each log file for the specified query
        foreach ($logFile in $logFiles) {
            Select-String -Path $logFile -Pattern $Query
        }

        # Delete the extracted log files
        Remove-Item -Path $logFiles -Force
    }
    else {
        Write-Output "Cancelled."
    }

    Write-Output "`n"
    Show-Menu
}
