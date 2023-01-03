function Get-DefenderLogs() {
$ver = Get-ChildItem "C:\ProgramData\Microsoft\Windows Defender\Platform\" -Recurse -Force -Include 4*
$temp = "C:\temp\MpSupportFiles"
#Set-Location $ver
Write-Host "Extracting MpSupport Logs..."
cmd.exe /c "$ver\mpcmdrun.exe" -GetFiles
If (!(Test-Path -Path $temp)) 
    {
    New-Item -Path $temp -ItemType "Directory"
    } 
Move-Item "$cab\MpSupportFiles.cab" -Destination $temp
If (Test-Path -Path "$temp\MpSupportFiles.cab")
    {
    Invoke-Item $temp
    }
Else
    {
    Write-Host "Something Went Wrong"
    }
Show-Menu
}