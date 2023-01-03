function Invoke-PingSweep() {
    # Define the script parameters
    param(
        $range,
        $port,
        $csv
    )

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
    # Return to the menu if either $path or $name was not specified
    if (-not $path -or -not $name) {
        Invoke-Menu
    }
}
