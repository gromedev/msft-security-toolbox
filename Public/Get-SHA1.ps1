function Get-SHA1 {
    param(
        $path
    )

    if (-not $path) {
        $path = Read-Host "Enter the path of the file"
    }

    Get-FileHash -Algorithm SHA1 "$path"

    # Return to the menu
    Show-Menu
}
