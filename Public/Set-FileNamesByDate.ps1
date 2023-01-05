<#
.SYNOPSIS
This function renames files in a specified directory based on the create date, keeping the original file name and affixing the formatted date in front of it. The user can specify the date format and file filter as parameters when calling the function. If the parameters are not provided, the user will be prompted to enter the date format and file filter. The function gets a list of all files in the specified path that match the filter, then renames each file by getting the create date of the file, formatting the date using the specified format, and constructing a new file name by affixing the formatted date in front of the original file name.
#>
function Set-FileNamesByDate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Path,
        [string]$Format = "yyyyMMdd",
        [string]$Filter = (Read-Host "Enter the file filter:")
        )

    if (-not $Path) {
        $Path = Read-Host "Enter the path:"
    }
    if (-not $Filter) {
        $Filter = Read-Host "Enter the file filter:"
    }

    # Get a list of all files in the specified path that match the filter
    $Files = Get-ChildItem -Path $Path -Filter $Filter

    # Rename each file
    foreach ($File in $Files) {
        # Get the create date of the file
        $Date = Get-ItemProperty -Path $File.FullName | Select-Object CreationTime

        # Format the date
        $DateString = $Date.CreationTime.ToString($Format)

        # Construct the new file name
        $NewName = "$DateString-$($File.Name)"

        # Rename the file
        Rename-Item -Path $File.FullName -NewName $NewName
    }
    Write-Output "`n`n"
    Show-Menu
}