<#
.SYNOPSIS
    Calculates the SHA1 hash of a file and displays the hash value. If no path is specified, prompts the user to enter the path of the file. Returns to the menu after displaying the hash value.
#>
function Get-SHA1 {
    param(
        $path
    )
    Write-Output "`nGet-SHA1"
    if (-not $path) {
        $path = Read-Host "Enter the path of the file"
    }

    Get-FileHash -Algorithm SHA1 "$path"

    # Return to the menu
    Write-Output "`n`n"
    Show-Menu
}
