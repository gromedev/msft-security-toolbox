<#
.SYNOPSIS
    This function allows the user to download a video from a specified URL and save it to a specified path with a specified name. If the URL, path, or name are not provided as parameters, the user will be prompted to enter them.
#>
function Save-Video() {
    
    param(
        $url,
        $path,
        $name
    )

    if (-not $url) {
        $url = Read-Host "Enter the URL of the video you want to download"
    }
    if (-not $path) {
        $path = Read-Host "Enter the path where you want to save the video"
    }
    if (-not $name) {
        $name = Read-Host "Enter a name for the saved video"
    }
    
    # Return to the menu if either $path or $name was not specified
    #if (-not $path -or -not $name) {
        Write-Output "`n`n"
        Show-Menu
    #}
}