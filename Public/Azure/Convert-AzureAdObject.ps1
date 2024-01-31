<#
.SYNOPSIS
The Convert-AzureAdObject function is a command that allows you to convert between Azure AD object IDs and SIDs (Security Identifiers). It takes a single parameter, $ObjectId, which should be a string containing either an Azure AD object ID or an SID. The function displays a menu to the user, asking them to choose between converting an Azure AD object to an SID or an SID to an Azure AD object. The user can then enter the appropriate choice and the function will execute the selected conversion. If the user enters 'q', the function will return. The function also has two nested functions, ConvertToSID and ConvertToObjectId, which perform the actual conversion.
#>
function Convert-AzureAdObject {
    param([String] $ObjectId)
    Write-Output "`nConvert-AzureAdObject"

    # Display menu options
    Write-Output "Convert-AzureAdObject"
    Write-Host "Choose a conversion:"
    Write-Host "1. AzureAD object to SID"
    Write-Host "2. SID to AzureAD object"
    Write-Host "q. Quit"
    Write-Host ""

    # Read user input
    $choice = Read-Host
    Write-Host ""

    # Execute selected conversion
    switch ($choice) {
        '1' { Convert-AzureAdObjectToSID }
        '2' { Convert-AzureAdSIDToObject }
        'q' { return }
        default { Write-Host "Invalid option." }
    }
}
