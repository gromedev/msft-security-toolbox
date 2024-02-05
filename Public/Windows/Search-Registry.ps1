<#
.SYNOPSIS
This function searches both the HKLM:\ and HKCU:\ paths in the registry (which represents the HKEY_LOCAL_MACHINE and HKEY_CURRENT_USER keys, respectively) and returns all items that match the search term.
#>
function Search-Registry() {
    # Check if the user is an administrator
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "You must be an administrator to run this script."
        exit
    }

    # Prompt the user for a search term
    $searchTerm = Read-Host "Enter a search term (wildcards allowed)"

    # Initialize array to store paths that encountered errors
    $errorPaths = @()

    # Search the entire registry for the specified term
    Write-Host "Searching the entire registry for items that match '$searchTerm'..."
    Write-Output "This will take a while..."
    $results = Get-ChildItem -Path HKLM:\, HKCU:\ -Recurse | Where-Object {
        try {
            $_.Name -match $searchTerm
        }
        catch {
            # Store the path in the errorPaths array
            $errorPaths += $_.PSPath
            # Return false to exclude this path from the results
            return $false
        }
    } | Select-Object -Property PSChildName, PSPath

    # Display the results
    Write-Host "Found $(($results | Measure-Object).Count) items:"
    $results | Format-Table -AutoSize

    # Check if any errors were encountered
    if ($errorPaths.Count -gt 0) {
        Write-Host "The following paths encountered errors:"
        $errorPaths | Format-Table -AutoSize
    }
}
