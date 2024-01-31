
<#
.SYNOPSIS
    This function searches a specified file path for a file with a specified name, and displays the results in the terminal.  If the string is found in a file, the file is included in the search results. The search results can be displayed in the terminal and optionally saved to a CSV file.
#>function Find-String() {
    param(
        $path,
        $file,
        $csvPath
    )
    Write-Output "`nFind-String"
    if (-not $path) {
        $path = Read-Host "Enter the path to search for the file"
    }
    if (-not $file) {
        $file = Read-Host "Enter the name of the file you are looking for"
    }

    $results = Get-ChildItem -Path $path -Recurse | Select-String -pattern $file

    # Display the results in the terminal
    $results

    # Prompt the user to save the results as a CSV file
    $save = Read-Host "Do you want to save the results as a CSV file? (Y/N)"
    if ($save -eq "Y") {
        # If the user wants to save the results, use the Export-Csv cmdlet to save them
        if (-not $csvPath) {
            $csvPath = Read-Host "Enter the path where the CSV file should be saved"
        }
        $results | Export-Csv $csvPath -NoTypeInformation
        Write-Host "Results saved to $csvPath" 
    }
}
