# Script to Audit Scheduled Tasks

function Get-ScheduledTasksInfo {
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.State -eq 'Ready' }

    foreach ($task in $scheduledTasks) {
        $taskName = $task.TaskName
        $taskPath = $task.TaskPath
        $lastRunTime = $task.LastRunTime
        $nextRunTime = $task.NextRunTime
        $actions = $task.Actions.Execute
        $principal = $task.Principal.UserId

        # Check for high privilege execution
        $isHighPrivilege = $task.Principal.RunLevel -eq 'Highest'

        [PSCustomObject]@{
            Name           = $taskName
            Path           = $taskPath
            LastRunTime    = $lastRunTime
            NextRunTime    = $nextRunTime
            Actions        = $actions -join "; "
            RunAsUser      = $principal
            HighPrivilege  = $isHighPrivilege
        }
    }
}

# Execute the Scheduled Task Audit
Write-Host "Auditing Scheduled Tasks..."
$tasksInfo = Get-ScheduledTasksInfo
$tasksInfo | Format-Table -AutoSize
