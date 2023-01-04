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