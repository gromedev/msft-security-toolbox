# PowerShellCheatSheet
Module containing a collection of simple yet useful functions. 

Import-Module .\PowerShellCheatSheet -Force; Show-Menu


![logo](https://github.com/gromedev/PowerShellCheatSheet/blob/main/Assets/logo.png)


# Functions (So far...)

Use Get-Help for more details:

Convert-AzureAdObject

Disable-Defender     

Enable-Defender      

Find-BitLockerRecoveryKey

Find-File

Find-Process

Find-Service

Find-String

Get-DefenderLogs

Get-ProcessUsingFile

Get-SHA1

Get-UninstallKey

Get-WebFile

Get-Whois

Install-WSL

Invoke-Base64

Invoke-FirewallRule

Invoke-ForceIntuneSync

Invoke-PingSweep

Invoke-PortScan

New-KeyLockedOEMSLPEDevice

New-SelfSignedCert

Save-Video

Set-ChangeWindowsEdition

Set-FileNamesByDate

Set-MacAddress

Set-RegistryValue

Set-StringInFiles

Set-WindowsEdition

Set-WindowsSelectedEdition

Show-Menu

Show-MenuDefender

Show-MenuLinuxWSL

Show-MenuNetworking

Show-MenuStringManipulation

Show-MenuWindows

Start-RemoteConnection

Stop-Process

Test-WindowsRegistryValue


# Usage

Import-Module .\PowerShellCheatSheet -Force

Run Show-Menu and select an option. 

![usage](https://github.com/gromedev/PowerShellCheatSheet/blob/main/Assets/usage.png)

OR

Alternatively, you can invoke the functions by typing the function name followed by any required arguments.

For example:

  Find-String -path "C:\temp" -file "foo.txt" -csvPath "C:\temp\results.csv"
  
  Find-String -path "C:\temp" -file "foo.txt" -csvPath "C:\temp\results.csv"
  
Get-WebFile -UserAgent "" -url "http://example.com/foo.txt" $path "C:\temp\foo.txt"

Find-Process -name "foo"

Find-Service -name "foo"

Get-SHA1 -path "C:\temp\foo.txt"

Invoke-PingSweep -range "10.10.10.1-10.10.10.255" -port 80 -csv "C:\temp\results.csv"

Invoke-PortScan -ip "10.10.10.10" -range "1-1024"

Find-BitLockerRecoveryKey 

Invoke-FirewallRule 

Convert-AzureAdObject -ObjectId "8defd89d-7ce3-4050-9aa9-1f8eb60c4c2c"

Get-Whois example.com --> Alternatively, you can pipe a list of domain names to the function: "example.com", "example.net", "example.org" | Get-Whois



# Contributing
We welcome contributions to the scripts. If you have an idea for a new feature or have found a bug, please open an issue on the repository's issue tracker.

# License
The scripts are licensed under the MIT License. See the LICENSE file for details.
