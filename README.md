# msft-security-toolbox
Module containing a collection of simple yet useful functions. 
- All functions are authored by thomas@grome.dev 
- Unless otherwise specified in the comments.

```
Set-ExecutionPolicy -executionpolicy Bypass
Import-Module .\msft-security-toolbox -Force; Show-Menu
```

#![logo](https://github.com/gromedev/msft-security-toolbox/blob/main/Assets/img/logo.png)


## Functions 
(Incomplete list.. this module is a major WIP and I can't always be bothered to update its README)
Use Get-Help for more details:


## Usage

Import-Module .\msft-security-toolbox -Force

Run Show-Menu and select an option. 


OR

Alternatively, you can invoke the functions by typing the function name followed by any required arguments.

Examples:
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
  Get-Whois example.com
  "example.com", "example.net", "example.org" | Get-Whois
```

## Task list
- [ ] CIS-CAT Stuff)




## Contributing
We welcome contributions to the scripts. If you have an idea for a new feature or have found a bug, please open an issue on the repository's issue tracker.



## License
The scripts are licensed under the MIT License. See the LICENSE file for details.
