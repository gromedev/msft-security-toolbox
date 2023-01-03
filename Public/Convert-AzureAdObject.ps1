function Convert-AzureAdObject {
    param([String] $ObjectId)

    # Convert Azure AD object to SID
    function ConvertToSID {
        $bytes = [Guid]::Parse($ObjectId).ToByteArray()
        $array = New-Object 'UInt32[]' 4

        [Buffer]::BlockCopy($bytes, 0, $array, 0, 16)
        $sid = "S-1-12-1-$array".Replace(' ', '-')

        return $sid
    }

    # Convert SID to Azure AD object
    function ConvertToObjectId {
        $sid = $ObjectId -replace 'S-1-12-1-', '' -replace '-', ' '
        $array = [UInt32[]] $sid.Split()
        $bytes = New-Object 'Byte[]' 16
        [Buffer]::BlockCopy($array, 0, $bytes, 0, 16)
        $objectId = [Guid]::NewGuid($bytes).ToString()

        return $objectId
    }

    # Display menu options
    Write-Host "Choose a conversion:"
    Write-Host "1. Azure AD object to SID"
    Write-Host "2. SID to Azure AD object"
    Write-Host "q. Quit"
    Write-Host ""
    Write-Host "Enter a number or 'q' to quit:"

    # Read user input
    $choice = Read-Host
    Write-Host ""

    # Execute selected conversion
    switch ($choice) {
        '1' { ConvertToSID }
        '2' { ConvertToObjectId }
        'q' { return }
        default { Write-Host "Invalid option." }
    }
    # Return to the menu if either $path or $name was not specified
    if (-not $path -or -not $name) {
        Show-Menu
    }
}
