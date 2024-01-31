<#
.SYNOPSIS
This function performs a ping sweep over a specified IP range and port, displaying the results and saving them to a CSV file if specified. If the IP range or port are not provided as parameters, the user will be prompted to enter them. The function pings each IP address in the range and stores the results in an array. If the ping was successful, the result is added to the array. The function then displays the results and, if a CSV file path was specified, saves the results to the file.
#>
function Invoke-PingSweep() {
    # Define the script parameters
    param(
        $range,
        $port,
        $csv
    )
    Write-Output "`nInvoke-PingSweep"
    # Prompt user for IP range and port if they were not specified
    if (-not $range) {
        $range = Read-Host "Enter IP range (e.g. 10.10.10.1-10.10.10.255): "
    }
    if (-not $port) {
        $port = Read-Host "Enter port number: "
    }

    # Split IP range into start and end components
    $start, $end = $range -split '-'

    # Initialize array to store ping results
    $results = @()

    # Iterate over IP range
    for ($i = $start; $i -le $end; $i++) {
        # Ping the current IP address and store the result
        $pingResult = Test-Connection -ComputerName $i -Count 1 -ErrorAction SilentlyContinue

        # If ping was successful, add the result to the results array
        if ($pingResult) {
            $results += $pingResult
        }
    }

    # Display results
    $results | Select-Object -Property IPAddress, ResponseTime

    # Save results to CSV file if specified
    if ($csv) {
        $results | Export-Csv -Path $csv -NoTypeInformation -Delimiter "`t"
    }
}
