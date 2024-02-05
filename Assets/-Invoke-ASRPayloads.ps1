# Set error preference to stop on errors
$ErrorActionPreference = "Stop"

# Introduction and ASR rules description
Write-Host "This script tests specific Attack Surface Reduction (ASR) rules by executing demo payloads. It aims to demonstrate ASR's effectiveness against:"
Write-Host "1. Block Win32 imports from Macro code in Office (92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B)"
Write-Host "2. Block Office applications from creating executable content (3B576869-A4EC-4529-8536-B80A7769E899)"
Write-Host "3. Impede JavaScript and VBScript from launching executables (D3E037E1-3EB8-44C8-A917-57927947596D)"
Write-Host "4. Block Office applications from creating child processes (D4F940AB-401B-4EFC-AADC-AD5F3C50688A)"
Write-Host "5. Block process creations originating from PSExec & WMI commands (D1E49AAC-8F56-4280-B9BA-993A6D77406C)"
Write-Host "`nEach executed file is designed to trigger a specific ASR rule, showcasing the rule's capability to block typical malicious behaviors exploited by malware, such as running or downloading files via Office apps, creating executable content, and process injection. Expected results include 'Action blocked' notifications for each test case, demonstrating the rule's enforcement."
Write-Host "`nProceed with testing? Y/N"

$response = Read-Host
if ($response -ne 'Y') {
    Write-Host "Testing aborted by user. Exiting script."
    return
}

# Define the source and destination paths
$sourceZip = "C:\Users\tmg\OneDrive - VENZO GROUP\---- PERSONAL\GitHub\msft-security-toolbox\Public\Assets\DefenderDemo.zip"
$destinationZip = "C:\temp\DefenderDemo.zip"
$destinationFolder = "C:\temp\DefenderDemo"

try {
    # a) Copy the zip file to c:\temp\DefenderDemo.zip
    Copy-Item -Path $sourceZip -Destination $destinationZip -ErrorAction Stop

    # Ensure the temp directory exists
    if (-not (Test-Path -Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder
    }

    # b) Unzip the file to c:\temp\DefenderDemo
    Expand-Archive -Path $destinationZip -DestinationPath $destinationFolder -ErrorAction Stop

    # c) Execute all the files in c:\temp\DefenderDemo with specified extensions
    Get-ChildItem -Path $destinationFolder -Include @("*.docm", "*.js", "*.vbs") -Recurse | ForEach-Object {
        $extension = $_.Extension
        switch ($extension) {
            ".docm" {
                # Launch .docm files in Microsoft Word
                Start-Process "WINWORD.EXE" $_.FullName
            }
            ".vbs" {
                # Execute .vbs scripts using cscript.exe directly
                Start-Process "cscript.exe" "//B //Nologo $_.FullName"
            }
            ".js" {
                # Execute .js files through Windows Script Host for consistency
                Start-Process "cscript.exe" "//B //Nologo $_.FullName"
            }
        }
    }

    # e) Delete the zip file and directory afterwards
    Remove-Item -Path $destinationZip -Force
    Remove-Item -Path $destinationFolder -Recurse -Force
}
catch {
    Write-Host "An error occurred: $_"
    # Consider whether to exit or clean up partially completed actions
}
