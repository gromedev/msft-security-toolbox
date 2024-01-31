<#
.SYNOPSIS
This function retrieves the 'PushLaunch' scheduled task using the Get-ScheduledTask cmdlet and starts the task using the Start-ScheduledTask cmdlet. The 'PushLaunch' task is a scheduled task that is typically used to synchronize with the Intune service. Starting this task initiates a synchronization with Intune, allowing changes made in the Intune console to be reflected on the device.
#>
function Invoke-ForceIntuneSync() {
    Write-Output "`nInvoke-ForceIntuneSync"
    Get-ScheduledTask | Where-Object { $_.TaskName -eq "PushLaunch" } | Start-ScheduledTask
}