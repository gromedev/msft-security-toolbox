function New-SelfSignedCert {
    param(
        $Subject,
        $DnsName
    )
    # Check if the subject was specified
    if (-not $Subject) {
        # If the subject was not specified, prompt the user for it
        $Subject = Read-Host "Enter the certificate subject"
    }

    # Check if the DNS name was specified
    if (-not $DnsName) {
        # If the DNS name was not specified, prompt the user for it
        $DnsName = Read-Host "Enter the certificate DNS name"
    }

    # Create the self-signed certificate
    $cert = New-SelfSignedCertificate -Subject $Subject -DnsName $DnsName

    # Display the new certificate properties
    $cert | Format-List -Property *

    # Prompt the user to save the certificate
    $save = Read-Host "Do you want to save the certificate? (Y/N)"
    if ($save -eq "Y") {
        # If the user wants to save the certificate, use the Export-Certificate cmdlet to save it
        $outputPath = Read-Host "Enter the output path (e.g. c:\temp\certificate.pfx)"
        Export-Certificate -Type PKCS12 -FilePath $outputPath -Cert $cert
        Write-Host "Certificate saved to '$outputPath'"
    }

    # Return to the menu if either $path or $name was not specified
    if (-not $path -or -not $name) {
        Show-Menu
    }
}