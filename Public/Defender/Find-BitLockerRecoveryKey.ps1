<#
.SYNOPSIS
The function will retrieve the BitLocker volume for the specified drive using the Get-BitLockerVolume cmdlet, and check if it has a recovery password using the KeyProtector.RecoveryPassword property. If a recovery key is found, it will be output to the terminal and the user will be prompted to save it to a file. If the user chooses to save the key, they will be prompted to enter the file path, and the key will be saved to the specified file using the Out-File cmdlet. If the specified drive does not have a BitLocker recovery key, a message will be output to the terminal indicating this. 
#>
function Find-BitLockerRecoveryKey {
    param(
        $drive
    )
    # If a drive was not specified, prompt the user to enter one
    if (-not $drive) {
        $drive = Read-Host "Enter the drive letter (e.g. C:)"
    }
    Write-Output "`nFind-BitLockerRecoveryKey"
    # Get the BitLocker volume for the specified drive
    $bitlockerVolume = Get-BitLockerVolume -MountPoint $drive

    # Check if the volume has a recovery key
    if ($bitlockerVolume.KeyProtector.RecoveryPassword) {
        $recoveryKey = $bitlockerVolume.KeyProtector.RecoveryPassword
        Write-Output "The drive $drive has a BitLocker recovery key $recoveryKey."
    }
    else {
        Write-Output "The drive $drive does not have a BitLocker recovery key."
    }

    # Prompt the user to save the recovery key to a file
    $save = Read-Host "Do you want to save the recovery key to a file? (Y/N)"
    if ($save -eq "Y") {
        # If the user wants to save the recovery key, prompt them for the file path
        $filePath = Read-Host "Enter the file path (e.g. C:\temp\recoverykey.txt)"

        # Save the recovery key to the specified file
        $recoveryKey | Out-File -FilePath $filePath
        Write-Output "Recovery key saved to $filePath"
    }
}
