# Enhanced BitLocker Configuration Audit Script with Recovery Key Retrieval

function Get-BitLockerConfiguration {
    Write-Host "Auditing BitLocker Configurations..."

    $volumes = Get-BitLockerVolume
    $systemWideSummary = @{
        TotalVolumes = $volumes.Count
        EncryptedVolumes = 0
        NonEncryptedVolumes = 0
    }

    foreach ($volume in $volumes) {
        $mountPoint = $volume.MountPoint
        $volumeType = $volume.VolumeType
        $protectionStatus = $volume.ProtectionStatus
        $encryptionMethod = $volume.EncryptionMethod
        $autoUnlock = $volume.AutoUnlockEnabled
        $AutoUnlockKeyStored = $volume.AutoUnlockKeyStored
        $volumeStatus = $volume.VolumeStatus
        $volumeSize = $volume.CapacityGB
        $encryptionPercentage = $volume.EncryptionPercentage
        $KeyProtector = $volume.KeyProtector
        $LockStatus = $volume.LockStatus

        # Collect key protector types
        $keyProtectorTypes = ($volume.KeyProtector | ForEach-Object { $_.KeyProtectorType }) -join ', '

        # Retrieve the recovery key using manage-bde
        $recoveryKeys = manage-bde -protectors -get $mountPoint -Type RecoveryPassword

        # Count encrypted and non-encrypted volumes
        if ($protectionStatus -eq 'On') {
            $systemWideSummary.EncryptedVolumes++
        } else {
            $systemWideSummary.NonEncryptedVolumes++
        }

        [PSCustomObject]@{
            Volume               = $mountPoint
            EncryptionMethod     = $encryptionMethod
            AutoUnlock           = $autoUnlock
            AutoUnlockKey        = $autoUnlockKeyStored
            VolumeStatus         = $volumeStatus
            ProtectionStatus     = if ($protectionStatus -eq 'On') { "On" } else { "Off" }
            LockStatus           = $lockstatus
            EncryptionPercentage = $encryptionPercentage
            #wipPercentage
            DriveType            = $volumeType
            VolumeSize           = $volumeSize
            KeyProtectorTypes    = $KeyProtector
            #
            RecoveryKeyDetails   = $recoveryKeys -join ' '

            TPMRecovery     = $KeyProtector.TPM

            ID = $KeyProtector.KeyProtector.KeyProtectorId 
            #Edit this so that it shows ID and Password
            PasswordRecovery     = $KeyProtector.RecoveryPassword
        }
    }

    # Display System-Wide Summary
    Write-Host "System-Wide Summary:"
    Write-Host "Total Volumes: $($systemWideSummary.TotalVolumes)"
    Write-Host "Encrypted Volumes: $($systemWideSummary.EncryptedVolumes)"
    Write-Host "Non-Encrypted Volumes: $($systemWideSummary.NonEncryptedVolumes)"
    #return $volumes
}
