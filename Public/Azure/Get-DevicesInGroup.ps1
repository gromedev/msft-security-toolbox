function Get-GroupDeviceNames {
    $objectID = Read-Host "Enter ObjectID for Group"
    $path = Read-Host "Enter path where to save CSV"
    Write-Host "Getting group memebers"
    $groupMembers = Get-AzureADGroupMember -ObjectId $objectID -All $true
    Write-Host "Getting devices"
    $devices = Get-AzureADDevice -All $true
    Write-Host "Making array"
    $devicesInGroup = @()

    # Iterate through the group members and check if they are devices
    $counter = 1
    Write-Host "Looping"
    foreach ($member in $groupMembers) {
        if ($member.ObjectType -eq "Device") {
            # Check if the device exists in the list of all devices
            $device = $devices | Where-Object { $_.ObjectId -eq $member.ObjectId }
            if ($null -ne $device) {
                $devicesInGroup += $device
            }
            Write-Host "Next Device $counter"
            $counter++
        }
    }
    
    Write-host "Outputting devices"
    $devicesInGroup | Export-Csv -Path $path -NoTypeInformation
}
