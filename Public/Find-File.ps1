function Find-File {
    param(
        $path,
        $name,
        $csvPath
    )

    if (-not $path) {
        $path = Read-Host "Enter the path to search for the file"
    }
    if (-not $name) {
        $name = Read-Host "Enter the name of the file you are looking for"
    }

    $results = Get-ChildItem -Path $path -Filter $fileName -Recurse

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

    # Return to the menu if either $path or $name was not specified
    if (-not $path -or -not $name) {
        Show-Menu
    }
}
