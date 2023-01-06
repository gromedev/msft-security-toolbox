<#
.SYNOPSIS
This PowerShell script provides a function for searching for a list of keywords in ETL files. The function, called Search-ETL, accepts a list of keywords as input and searches all of the ETL files in the current directory for matches. It returns a list of objects, each of which has three properties: File, Line, and Match. The File property is the name of the ETL file that the match was found in, the Line property is the line number of the match, and the Match property is the actual line of text that matched the keywords.
#>

function Search-EventTraceLog {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]$Keywords,
        [switch]$ExportToCsv,
        [string]$Path
    )
    Write-output "`nSearch-EventTraceLog"

    # Define the CSV header row
    $csvHeader = "File,Line,Match"

    # Initialize an empty array to hold the search results
    $results = @()

    # Search the ETL files
    Get-ChildItem -Filter "*.etl" | ForEach-Object {
        $file = $_
        Get-Content $file | Select-String -Pattern $Keywords | ForEach-Object {
            # Add the search result to the array
            $results += [PSCustomObject]@{
                File  = $file.Name
                Line  = $_.LineNumber
                Match = $_.Line
            }
        }
    }

    # If the ExportToCsv flag is present, export the results to a CSV file
    if ($ExportToCsv) {
        # Check if the specified path is valid
        if (!(Test-Path -Path $Path -PathType Container)) {
            # If the path is not valid, write an error message and return
            Write-Error "The specified path is not valid or does not exist."
            return
        }

        # Export the results to a CSV file
        $csvHeader | Out-File "$Path\etl_search_results.csv"
        $results | Export-Csv -Path "$Path\etl_search_results.csv" -NoTypeInformation -Append
    }
    else {
        # If the ExportToCsv flag is not present, return the results as output
        $results
    }
    Write-Output "`n"
    Show-Menu
}
