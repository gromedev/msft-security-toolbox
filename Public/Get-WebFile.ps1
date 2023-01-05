function Get-WebFile {
    param(
        $userAgent,
        $url,
        $path
    )

    if (-not $userAgent) {
        # Prompt the user to enter the user agent
        $userAgent = Read-Host "Enter the user agent (leave blank to use Edge User Agent)"

        # If the user did not enter a user agent, set the user agent to a default value
        if ($userAgent -eq "") {
            $userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.54"
        }
    }
    if (-not $url) {
        # Prompt the user to enter the file source
        $url = Read-Host "Enter the file source"
    }
    if (-not $path) {
        # Prompt the user to enter the file destination
        $path = Read-Host "Enter the file destination"
    }

    Try {
        $cli = New-Object System.Net.WebClient;
        $cli.Headers['User-Agent'] = $userAgent;
        $cli.DownloadFile($url, $path)
    }
    Catch {
        Write-Output "An error occurred: $_"
    }        
    # Return to the menu if either $path or $name was not specified
    #if (-not $url -or -not $path) {
        Write-Output "`n`n"
        Show-Menu
    #}
}
