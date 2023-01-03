function Get-Whois {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$DomainName
    )

    # Use the System.Net.WebClient class to perform the WHOIS lookup
    $client = New-Object System.Net.WebClient
    $results = $client.DownloadString("https://whois.domaintools.com/$DomainName")

    # Output the results
    Write-Output $results

    Show-Menu
}
