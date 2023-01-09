function New-DefenderQuery {
    #https://github.com/MicrosoftDocs/microsoft-365-docs/blob/public/microsoft-365/security/defender-endpoint/run-advanced-query-sample-powershell.md
    #param(
    #)
    $query = 'DeviceRegistryEvents | limit 10' # Paste your own query here

    #$query @({
    #    Query":"DeviceProcessEvents
    #    | where InitiatingProcessFileName =~ 'powershell.exe'
    #    | where ProcessCommandLine contains 'appdata'
    #    | project Timestamp, FileName, InitiatingProcessFileName, DeviceId
    #    | limit 2"
    #}
    #)@


    $url = "https://api.securitycenter.microsoft.com/api/advancedqueries/run"
    $headers = @{ 
        'Content-Type' = 'application/json'
        Accept         = 'application/json'
        Authorization  = "Bearer $aadToken" 
    }
    $body = ConvertTo-Json -InputObject @{ 'Query' = $query }
    $webResponse = Invoke-WebRequest -Method Post -Uri $url -Headers $headers -Body $body -ErrorAction Stop
    $response = $webResponse | ConvertFrom-Json
    $results = $response.Results
    $schema = $response.Schema

    #$results | ConvertTo-Csv -NoTypeInformation | Set-Content file1.csv
    #$results | ConvertTo-Json | Set-Content file1.json
}