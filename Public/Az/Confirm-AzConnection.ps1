function Confirm-AzConnection {
    
    # Check if connected to Azure tenant
    if (!(Get-AzContext)) {
        Read-Host "Not connected to an Azure tenant. Connect?"

        $choice = Read-Host "Do you want to continue? (Y/N)"
        if ($choice -eq "Y") {
            Login-AzAccount -Credential $cred -Authentication Prompt

        }
    }
}