function Get-ProcessUsingFile {
    param([String] $name)

    # Get list of processes that have the file open
    $processes = Get-Process | Where-Object { $_.Modules | Where-Object { $_.name -eq $name } }

    if ($processes) {
        # Display list of processes that have the file open
        Write-Host "The following processes have the file open:"
        $processes | Format-Table Id, ProcessName

        # Prompt user to kill processes
        $choice = Read-Host "Kill these processes? (Y/N)"

        if ($choice -eq 'Y') {
            # Kill processes
            $processes | Kill-Process
        }
    }
    else {
        Write-Host "No processes found with the file open."
    }
    Show-Menu
}
