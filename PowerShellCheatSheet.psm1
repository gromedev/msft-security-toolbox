#menu view description

# generate a README.md

#I am going to post each function alone. Just reply OK?

# examples: 
# Return to menu
<#

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


#>

# Gives user option to output results to a file
$Public  = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

foreach ($Import in @($Public + $Private)) {
    try {
        . $Import.Fullname -ErrorAction Stop
    }
    catch {
        Write-Error -Message "Failed to import function $($Import.Fullname): $_" -ErrorAction Continue
    }
}

Export-ModuleMember -Function $Public.Basename