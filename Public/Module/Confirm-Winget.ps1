function Confirm-Winget {
    # Install winget if it is not already installed
    if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
        Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v0.2.2224-beta/winget-cli-0.2.2224-beta-windows-x64.zip -OutFile winget.zip
        Expand-Archive -Path winget.zip -DestinationPath .
        winget.exe install winget
    }
}
