# PowerShellCheatSheet
Module containing a collection of simple yet useful functions. 

NOTE: Disable-Defender.ps1 triggers a Virus warning in Defender. 

Import-Module .\PowerShellCheatSheet -Force; Show-Menu


![logo](https://github.com/gromedev/PowerShellCheatSheet/blob/main/Assets/logo.png)


## Functions (So far...)

Use Get-Help for more details:

###### String and File manipulation:
-----------------------------
```
Find-File
Find-String
Set-StringInFiles
Set-FileNamesByDate
Invoke-Base64
Get-SHA1
```


###### Azure and Defender:
-----------------------------
```
Enable-Defender
Disable-Defender
Get-DefenderLogs
Find-BitLockerRecoveryKey
Convert-AzureAdObject
Invoke-ForceIntuneSync
```


###### Networking:
-----------------------------
```
Invoke-PingSweep
Invoke-PortScan
Get-Whois
Set-MacAddress
Invoke-FirewallRule
Get-WebFile
Save-Video
```


###### Windows:
-----------------------------
```
Find-Process
Get-ProcessUsingFile
Find-Service
Get-UninstallKey
New-SelfSignedCert
Set-ChangeWindowsEdition
Set-RegistryKeyValue
Start-RemoteConnection
```


###### Linux WSL
-----------------------------
```
Install-WSL
```



## Usage

Import-Module .\PowerShellCheatSheet -Force

Run Show-Menu and select an option. 

![usage](https://github.com/gromedev/PowerShellCheatSheet/blob/main/Assets/usage.png)

OR

Alternatively, you can invoke the functions by typing the function name followed by any required arguments.

For example:
```
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
```

## Task list
- [x] Sub-menus
- [ ] Sub-menu (Get-Help and Return fixes)
- [ ] Hyper-V function
- [ ] Develop Linux WSL
- [ ] Password spray
- [ ] Bruteforce (w/ rockyou.txt)
- [ ] SmartScreen enable/disable
- [ ] OEM/SLP locked device (https://blog.grome.dev/2021/09/windows-servertroubleshootingwindowshom.html)

## Contributing
We welcome contributions to the scripts. If you have an idea for a new feature or have found a bug, please open an issue on the repository's issue tracker.

## License
The scripts are licensed under the MIT License. See the LICENSE file for details.
