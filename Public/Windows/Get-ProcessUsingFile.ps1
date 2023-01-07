<#
.SYNOPSIS
    The Get-ProcessUsingFile function in PowerShell takes a file name as input and searches for processes that have the file open. If any are found, the function displays a list of the processes along with their ID and name, and prompts the user to confirm whether they want to kill the processes. If the user confirms, the function kills the processes. If no processes are found with the file open, the function displays a message stating this. 
#>
function Get-ProcessUsingFile {
    param([String] $name)

    # Get list of processes that have the file open
    $processes = Get-Process | Where-Object { $_.Modules | Where-Object { $_.name -eq $name } }

    if ($processes) {
        # Display list of processes that have the file open
        Write-Output "`nGet-ProcessUsingFile"
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
    Write-Output "`n`n"
    Show-Menu
}
