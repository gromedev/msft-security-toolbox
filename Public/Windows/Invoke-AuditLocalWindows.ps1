# Define the main function to gather and display local device information
function Get-LocalDeviceInfo {
    # General System Information
    Write-Host "General System Info..." -ForegroundColor Yellow
    Systeminfo

    # MachineID
    Write-Host "`nMachineID" -ForegroundColor Yellow
    Get-ItemProperty HKLM:SOFTWARE\Microsoft\SQMClient | Select -ExpandProperty MachineID | Format-Table -AutoSize

    # Serial Number
    Write-Host "`nSerial Number" -ForegroundColor Yellow
    Get-WmiObject win32_bios | Select -ExpandProperty Serialnumber | Format-Table -AutoSize

    # Current User Profile
    Write-Host "`nCurrent User Profile" -ForegroundColor Yellow
    Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.Special -eq $false } | Select -ExpandProperty LocalPath | Format-Table -AutoSize

    # Network Configuration
    Write-Host "`nNetwork Configuration" -ForegroundColor Yellow
    Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true } | Select IPAddress, IPSubnet, DefaultIPGateway | Format-Table -AutoSize

    # Installed Programs
    Write-Host "`nInstalled Programs" -ForegroundColor Yellow
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | 
    Select DisplayName, DisplayVersion, Publisher | 
    Where-Object { $_.DisplayName -ne $null } |
    Format-Table -AutoSize | Out-String | Write-Output

    # System Uptime
    Write-Host "`nSystem Uptime" -ForegroundColor Yellow
    $uptime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    $now = Get-Date
    $uptimeSpan = $now - $uptime
    Write-Host "$($uptimeSpan.Days) days, $($uptimeSpan.Hours) hours, $($uptimeSpan.Minutes) minutes"

    # Windows Security Updates
    Write-Host "`nWindows Security Updates" -ForegroundColor Yellow
    Get-HotFix | Where-Object { $_.Description -eq "Security Update" } | Format-Table -AutoSize

    # Running Services
    Write-Host "`nRunning Services" -ForegroundColor Yellow
    Get-Service | Where-Object { $_.Status -eq "Running" } | Format-Table Name, DisplayName, StartType -AutoSize

    # Open Ports
    Write-Host "`nOpen Ports" -ForegroundColor Yellow
    Get-NetTCPConnection | Where-Object { $_.State -eq "Listen" } | Format-Table LocalAddress, LocalPort -AutoSize

    # Scheduled Tasks
    Write-Host "`nScheduled Tasks" -ForegroundColor Yellow
    Get-ScheduledTask | Where-Object { $_.State -eq "Ready" } | Format-Table TaskName, TaskPath, State -AutoSize
}
function Invoke-AuditLocalWindows {
    # Invoke the main function to display local device information
    Get-LocalDeviceInfo

    # Additional Information Gathering Scripts

    # List all user accounts with their groups
    Write-Host "`nUser Accounts and Groups" -ForegroundColor Yellow
    Get-LocalUser | ForEach-Object {
        $user = $_
        $groups = $_ | Get-LocalGroup | Select-Object -ExpandProperty Name
        [PSCustomObject]@{
            Username    = $user.Name
            Description = $user.Description
            Enabled     = $user.Enabled
            Groups      = $groups -join ', '
        }
    } | Format-Table -AutoSize

    # Display users currently logged on
    Write-Host "`nCurrently Logged On Users" -ForegroundColor Yellow
    quser | ForEach-Object {
        if ($_ -match '^\s*(\S+)\s+(\d+)\s+(\S+)\s+(\S+\s+\S+\s+\S+)\s+(.*)$') {
            [PSCustomObject]@{
                Username    = $matches[1]
                SessionName = $matches[3]
                LogonTime   = $matches[5]
            }
        }
    } | Format-Table -AutoSize

    # List startup programs from the registry
    Write-Host "`nStartup Programs" -ForegroundColor Yellow
    Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run', 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' | 
    ForEach-Object {
        $_.PSObject.Properties | Where-Object { $_.Name -ne "PSPath" } | Select-Object @{
            Name       = 'Program'
            Expression = { $_.Name }
        }, @{
            Name       = 'Command'
            Expression = { $_.Value }
        }
    } | Format-Table -AutoSize

    # Export local security policy
    Write-Host "`nLocal Security Policy" -ForegroundColor Yellow
    secedit /export /cfg "$env:TEMP\secpol.cfg" > $null
    Get-Content "$env:TEMP\secpol.cfg" | Where-Object { $_ -match "=" } | ForEach-Object {
        $policy, $value = $_ -split "=", 2
        [PSCustomObject]@{
            Policy = $policy.Trim()
            Value  = $value.Trim()
        }
    } | Format-Table -AutoSize
    Remove-Item "$env:TEMP\secpol.cfg" # Cleanup

    # List services and their start mode
    Write-Host "`nServices and Start Mode" -ForegroundColor Yellow
    Get-WmiObject Win32_Service | Where-Object { $_.StartMode -eq 'Auto' } | Select-Object Name, DisplayName, StartMode, State | Format-Table -AutoSize

    # Check for missing updates (Requires PSWindowsUpdate module)
    # This section is commented out as it requires external module installation and execution
    # Install-Module -Name PSWindowsUpdate
    # Import-Module PSWindowsUpdate
    # Get-WindowsUpdate
}