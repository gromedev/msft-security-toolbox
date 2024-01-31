function Get-NewToken {
    param(
        $tenantId,
        $appId,
        $appSecret
    )
    #$tenantId = '00000000-0000-0000-0000-000000000000' # Paste your own tenant ID here
    #$appId = '11111111-1111-1111-1111-111111111111' # Paste your own app ID here
    #$appSecret = '22222222-2222-2222-2222-222222222222' # Paste your own app secret here

    $resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
    $oAuthUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
    $body = [Ordered] @{
        resource      = "$resourceAppIdUri"
        client_id     = "$appId"
        client_secret = "$appSecret"
        grant_type    = 'client_credentials'
    }
    $response = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $body -ErrorAction Stop
    $aadToken = $response.access_token
}