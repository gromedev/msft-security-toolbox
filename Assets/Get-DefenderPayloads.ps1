
#    Fetches a collection of non-malignant ASR and Defender payloads to C:\temp\Fetch-DefenderPayloadTests
function Get-DefenderPayloadTests
{
    $Path = "C:\temp\DefenderPayloadTests.zip"
    $Payloads  = Invoke-WebRequest -uri "https://github.com/gromedev/PowerShellTrollTool/blob/main/Assets/Get-DefenderPaylodTests.zip" -Outfile $Path 

    $result = [System.Windows.Forms.MessageBox]::Show('Extracting these files WILL set your A/V off. Continue?' , "Extract zip?" , 4)
    if ($result -eq 'Yes') 
    {
        Expand-Archive -LiteralPath $Path -DestinationPath "C:\Temp\Get-DefenderPayloadTests"
        explorer.exe "C:\Temp\"
    }
    else 
    {
        explorer.exe "C:\Temp\"
    }     
}