#menu view description

# generate a README.md

# Gives user option to output results to a file

#Search for a file name
function findFile() {
    $filePath = Read-Host "Enter the path to search for the file"
    $fileName = Read-Host "Enter the name of the file you are looking for"  
    Get-ChildItem -Path $filePath -Filter $fileName -Recurse  
}

#Find text within a file:
function findString() {
    Select-String –path c:\users\*.txt –pattern password
    $filePath = Read-Host "Enter the path to search for the file"
    $fileString = Read-Host "Enter the name of the file you are looking for"
    Get-ChildItem -Path $filePath -r | Select-String –pattern $fileString
}

# Finds processes
function findProcess() {
    $processName = Read-Host "Enter the name of the process you want to query (or enter 'all' to query all processes)"

    if ($processName -eq "all") {
        Get-Process | Format-Table Name, Id, CPU, WorkingSet
    }
    else {
        Get-Process -Name $processName | Format-Table Name, Id, CPU, WorkingSet
    }

    $confirm = Read-Host "Do you want to kill this process? (y/n)"
    if ($confirm -eq "y") {
        Stop-Process -Name $processName
    }
}

#findService
function findService() {
    $serviceName = Read-Host "Enter the name of the service you want to query (or enter 'all' to query all services)"

    if ($serviceName -eq "all") {
        Get-Service | Format-Table Name, Status, DisplayName, StartType
    }
    else {
        Get-Service -Name $serviceName | Format-Table Name, Status, DisplayName, StartType
    }

    $confirm = Read-Host "Do you want to stop this service? (y/n)"
    if ($confirm -eq "y") {
        Stop-Service -Name $serviceName
    }
}

# Get file names in a directory
function getFiles() {
Get-ChildItem | Format-List –property name | Format-List –property name
}

# Get the SHA1 hash of a file
function xxxx() {
    $filePath = Read-Host "Enter the path of the file"
    Get-FileHash -Algorithm SHA1 $filePath
}

# Conduct a ping sweep
function xxxx() {

}

# Conduct a port scan
function xxxx() {

}


function xxxx() {

}

function xxxx() {

}

function xxxx() {

}

function xxxx() {

}

function xxxx() {

}

function xxxx() {

}
function invokeWget() {
    $userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.54"
    $fileSource = "https://images.contentstack.io/v3/assets/blt36c2e63521272fdc/blt0fae63251ce094b9/611bce1d1da1da13cddbfd8b/GCWN.png"
    $fileDestination = "c:\temp\GCWN.png"

    Try {
        $cli = New-Object System.Net.WebClient;
        $cli.Headers['User-Agent'] = $userAgent;
        $cli.DownloadFile($fileSource, $fileDestination)
    }
    Catch {
        Write-Output "An error occurred: $_"
    }        

}
############################################################################
# DISPLAYS FUNCTION SELECTION MENU.                                        #
############################################################################
function Invoke-Menu {
    while ($true) {
        # Displays a menu to the user
        Write-Output ""
        Write-Output "Select an option:"
        Write-Output ""
        Write-Output "1. Search for a file. "
        Write-Output "2. Search for a string within a file."
        Write-Output "3. QueryProcess"


        Write-Output "q. Enter q and return to Exit."
        Write-Output "Enter man and a function number or name to display a description (e.g. man 1)."
        Write-Output ""
        Write-Output "Enter selection: "

        $selection = Read-Host

        # Check if user wants to display a function description
        if ($selection -like "man*") {
            $function = $selection.Split()[1]
            switch ($function) {
                "1" {
                    Clear-Host
                    Write-Output "1. Search for a file: This function searches for a file with a specified name in a specified path and its subdirectories."
                }
                "2" {
                    Clear-Host
                    Write-Output "2. Search for a string within a file: This function searches for a specified string in a specified file and displays the lines containing the string."
                }
                "3" {
                    Clear-Host
                    Write-Output "3. This function prompts the user to enter a process name, retrieves information about the process using the Get-Process cmdlet, and displays the information in a table using the Format-Table cmdlet. If the user confirms that they want to kill the process, the function uses the Stop-Process cmdlet to stop the process."
                }
                "4" {
                    Clear-Host
                    Write-Output "This function prompts the user to enter a process name, retrieves information about the process using the Get-Process cmdlet, and displays the information in a table using the Format-Table cmdlet. If the user confirms that they want to kill the process, the function uses the Stop-Process cmdlet to stop the process."
                }

                "5" {
                    Clear-Host
                    Write-Output "Gets the items in the current location, formats the output as a list of properties with only the name property included, and pipes the output to the Format-List cmdlet. This results in a list of the names of the items in the current location, with each name appearing on a new line."
                }

                "6" {
                    Clear-Host
                    Write-Output ""
                }

                "7" {
                    Clear-Host
                    Write-Output ""
                }

                "8" {
                    Clear-Host
                    Write-Output ""
                }

                "9" {
                    Clear-Host
                    Write-Output ""
                }

                "10" {
                    Clear-Host
                    Write-Output ""
                }

                "4" {
                    Clear-Host
                    Write-Output ""
                }

                # 
            }
            Clear-History
        } else {
            # Run the selected function
            switch ($selection) {
                1 { $findFile }
                2 { $findString }
                3 { $findProcess }
                4 { $findService }
                5 { $getFiles }
                6 {  }
                7 {  }
                8 {  }
                9 {  }
                10 {  }
                11 {  }
                12 {  }

            }
            if ($selection -eq "q") {
                break
            }
        }
    }
}
Invoke-Menu