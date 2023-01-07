<#
Login-AzAccount 
Logout-AzAccount 
Get-AzSubscription
Get-AzSubscription -TenantId $TenantId
Select-AzSubscription –SubscriptionID $SubscriptionID


Get-AzResourceGroup 
Get-AzResourceGroup -Name $ResourceGroup
Get-AzResourceGroup | Where-Object ResourceGroupName -like Production*
Get-AzResourceGroup | Sort-Object Location,ResourceGroupName | Format-Table -GroupBy Location ResourceGroupName,ProvisioningState,Tags


Get-AzResource -ResourceGroupName $ResourceGroup

$Location = "westeurope"
New-AzResourceGroup -Name $NewResourceGroup -Location $Location

Remove-AzResourceGroup -Name $DeleteResourceGroup

<# Moving Resources from One Resource Group to Another

#Step 1: Retrieve existing Resource
$Resource = Get-AzResource -ResourceType
"Microsoft.ClassicCompute/storageAccounts" - #Retrieves a storage account called  "myStorageAccount"
ResourceName "myStorageAccount" 

#Step 2: Move the Resource to the New Group
Move-AzResource -ResourceId
$Resource.ResourceId -DestinationResourceGroupName - #Moves the resource from Step 1 into the destination resource group "NewResourceGroup"
"NewResourceGroup" 


#https://github.com/andreipintica/Azure-PowerShell-CheatSheet
#>

#>