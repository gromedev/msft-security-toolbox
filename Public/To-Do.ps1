# To-Do
#https://linuxhint.com/top-25-best-kali-linux-tools/

function Set-FileNamesByDate() {
    $month = 1..12
    foreach ($SingleMonth in $Month) {
        $Name = "2022-{0:d2}" -f $SingleMonth 
        new-Item -ItemType Directory -Name $Name -Path $env:temp
    }
}

function Set-StringInFiles() {
    $FindString = 'example'
    $ReplaceString = "$InfoSizeLimit = $VM | Select Value"
    $Filter = "*.txt"
    $path = "c:\temp"
    $files = get-ChildItem $path -recurse -filter $Filter

    foreach ($file in $files) {
        Write-Host "`n`nfixing file= $($file.Name)"
        $filetext = Get-Content $file.FullName -Raw   
        Write-Host "Old Text in file: $($file.Name)" 
        Write-Host $filetext

        #example of regular text 
        $filetextNew = $filetext -replace "$FindString", "$ReplaceString"

        Write-Host "NEW:" 
        Write-Host $filetext 
        Set-Content $file.FullName $filetextNew
    }
}


function Set-WindowsEdition() {
    $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
    $EditionID = "EditionID"
    $value = "Professional"
    $type = "STRING"
    
    $registryPathWow = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion"
    $EditionID = "EditionID"
    $ProductName = "Windows 10 Professional"
    $value = "Professional"
    $type = "STRING"
    
    function Test-RegistryValue {
    
        param (
    
            [parameter(Mandatory = $true)]
            [ValidateNotNullOrEmpty()]$Path,
    
            [parameter(Mandatory = $true)]
            [ValidateNotNullOrEmpty()]$Value
        )
    
        try {
            Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
            return $true
        }
    
        catch {
            return $false
        }
    }
    
    Test-RegistryValue -Path $registryPath -Value 'EditionID'
    Test-RegistryValue -Path $registryPathWow -Value 'EditionID'
    Test-RegistryValue -Path $registryPathWow -Value 'ProductName'
    
    write-output $registryPath
    write-output $registryPathWow
    
    
    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
    }
    else {
        write-host "noo"
    }
}

function Set-RegistryKey() {
    $registryPath = "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\General"
    $name = "DelegateWastebasketStyle"
    $value = "4"
    $type = "DWORD"

    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
    }

    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType $type -Force
}