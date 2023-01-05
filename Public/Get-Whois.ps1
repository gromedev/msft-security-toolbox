<#
.SYNOPSIS
    Retrieves WHOIS information for a specified domain name. If the domain name is not specified, the user is prompted to enter it.
#>
function Get-Whois {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$DomainName
    )
    Write-Output "`nGet-Whois"
    if (-not $DomainName) {
        $DomainName = Read-Host "Enter the domain name:"
    }

    # Use the System.Net.WebClient class to perform the WHOIS lookup
    $client = New-Object System.Net.WebClient
    $results = $client.DownloadString("https://whois.domaintools.com/$DomainName")

    # Output the results
    Write-Output $results

    Write-Output "`n`n"
    Show-Menu
}
