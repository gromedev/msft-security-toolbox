function Get-AllSubKeys {
    # Registry path where the rules reside
    $regPath = "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender"

    # Get all subkeys
    $subKeys = Get-ChildItem -Path $regPath -Recurse -ErrorAction SilentlyContinue -UseTransaction

    # Loop through all subkeys and print out their name and data
    foreach ($subKey in $subKeys) {
        Write-Output "Subkey: $($subKey.PSChildName)"
        $properties = Get-ItemProperty -Path $subKey.PSPath -ErrorAction SilentlyContinue
        foreach ($property in $properties.PSObject.Properties) {
            Write-Output "`tProperty: $($property.Name), Value: $($property.Value)"
        }
    }
}
