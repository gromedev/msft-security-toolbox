<#
.SYNOPSIS
    Retrieves WHOIS information for a specified domain name. If the domain name is not specified, the user is prompted to enter it.
#>
function Get-DnsRecord {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$url,
        [ValidateSet("A", "AAAA", "CNAME", "MX", "NS", "PTR", "SOA", "TXT", "All")]
        [string[]]$Type,
        [string]$Server = "8.8.8.8"
    )
    # Set the type to all available types if the Type parameter was not specified
    if (-not $PSBoundParameters.ContainsKey('Type')) {
        $Type = "A", "AAAA", "CNAME", "MX", "NS", "PTR", "SOA", "TXT"
    }
    # Use the System.Net.Dns class to perform the DNS lookup
    foreach ($t in $Type) {
        $records = [System.Net.Dns]::GetHostAddresses($url)
        foreach ($record in $records) {
            Write-Output "$($record.IPAddressToString)`t$t`t$url"
        }
    }
}
