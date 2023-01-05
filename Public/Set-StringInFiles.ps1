<#
.SYNOPSIS
    This function searches for a string ($FindString) in all files in a specified path ($path) that match a certain filter ($Filter) and replaces it with a new string ($ReplaceString). It reads the contents of each file, performs the replacement, and writes the modified contents back to the file. The function provides feedback to the user by displaying the old and new contents of each file.
#>
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
    Write-Host ""
    Read-Host -Prompt "Press any key to reurn to main menu."
    Write-Output "`n`n"
    Show-Menu
}