# PowerShellCheatSheet
Module containing a collection of simple yet useful functions. 

Import-Module .\PowerShellCheatSheet -Force; Show-Menu


![logo](https://github.com/gromedev/PowerShellCheatSheet/blob/main/Assets/logo.png)


# Functions
Search for a file: This function searches for a file with a specified name in a specified path and its subdirectories.

Search for a string within a file: This function searches for a specified string in a specified file and displays the lines containing the string.

Find process: This function prompts the user to enter a process name, retrieves information about the process using the Get-Process cmdlet, and displays the information in a table using the Format-Table cmdlet. If the user confirms that they want to kill the process, the function uses the Stop-Process cmdlet to stop the process.

# Usage

Import-Module .\PowerShellCheatSheet -Force

Run Show-Menu and select an option. 

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

Get-Whois example.com

Alternatively, you can pipe a list of domain names to the function: "example.com", "example.net", "example.org" | Get-Whois



# Contributing
We welcome contributions to the scripts. If you have an idea for a new feature or have found a bug, please open an issue on the repository's issue tracker.

# License
The scripts are licensed under the MIT License. See the LICENSE file for details.
