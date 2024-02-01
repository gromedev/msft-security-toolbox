function Get-RDPConfiguration {
    $RDPRegPath = 'HKLM:\System\CurrentControlSet\Control\Terminal Server'
    $RDPNLARegPath = 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp'

    $RDPEnabled = (Get-ItemProperty -Path $RDPRegPath -Name "fDenyTSConnections").fDenyTSConnections -eq 0
    $NLAEnabled = (Get-ItemProperty -Path $RDPNLARegPath -Name "UserAuthentication").UserAuthentication -eq 1

    [PSCustomObject]@{
        RDPEnabled = $RDPEnabled
        NLAEnabled = $NLAEnabled
    }
    # Execute the RDP Configuration Check
    Write-Host "Auditing RDP Configurations..."
    $RDPConfig = Get-RDPConfiguration
    $RDPConfig | Format-Table -AutoSize

}

