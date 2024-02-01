function Get-AllSubKeys {
    # Registry path where the rules reside
    $regPath = "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Defender"

    # Get the 'Defender' subkey
    $subKey = Get-Item -Path $regPath -ErrorAction SilentlyContinue 

    # Print out its name and data
    Write-Output "Subkey: $($subKey.PSChildName)"
    $properties = Get-ItemProperty -Path $subKey.PSPath -ErrorAction SilentlyContinue
    foreach ($property in $properties.PSObject.Properties) {
        if ($property.Name -notmatch "PSPath|PSParentPath|PSChildName|PSProvider") {
            Write-Output "`tProperty: $($property.Name), Value: $($property.Value)"
        }
    }
}