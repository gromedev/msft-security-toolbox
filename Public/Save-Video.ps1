function Save-Video() {
    
    param(
        $URLIn,
        $p,
        $NameIn
    )

    if (-not $URLIn) {
        $URLIn = Read-Host "Enter the URL of the video you want to download"
    }
    if (-not $p) {
        $p = Read-Host "Enter the path where you want to save the video"
    }
    if (-not $NameIn) {
        $NameIn = Read-Host "Enter a name for the saved video"
    }
    
    # Return to the menu if either $path or $name was not specified
    if (-not $path -or -not $name) {
        Invoke-Menu
    }
}