<#
.SYNOPSIS
This function is used to extract and store Microsoft Defender logs on a local machine. It runs a command prompt command to extract the logs and stores the resulting cab file in a specified directory. 
#>
function New-AzResourceGroup {
    [CmdletBinding()]
    param (
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]$Name,
      [Parameter()]
      [ValidateNotNullOrEmpty()]
      [string]$Location,
      [Parameter()]
      [ValidateNotNullOrEmpty()]
      [string]$NewName,
      [Parameter()]
      [ValidateNotNullOrEmpty()]
      [string]$MoveResourceType,
      [Parameter()]
      [ValidateNotNullOrEmpty()]
      [string]$MoveResourceName,
      [Parameter()]
      [ValidateNotNullOrEmpty()]
      [string]$DestinationResourceGroupName
    )
  
    # Get resource group
    $resourceGroup = Get-AzResourceGroup -Name $Name
  
    # Get resource group and filter by name
    $filteredResourceGroups = Get-AzResourceGroup | Where-Object ResourceGroupName -like Production*
  
    # Sort resource groups by location and name
    $sortedResourceGroups = Get-AzResourceGroup | Sort-Object Location,ResourceGroupName | Format-Table -GroupBy Location ResourceGroupName,ProvisioningState,Tags
  
    # Get resources in resource group
    $resources = Get-AzResource -ResourceGroupName $Name
  
    # Create new resource group
    if ($NewName) {
      $newResourceGroup = New-AzResourceGroup -Name $NewName -Location $Location
    }
  
    # Move resource to another resource group
    if ($MoveResourceType -and $MoveResourceName -and $DestinationResourceGroupName) {
      # Retrieve existing resource
      $resource = Get-AzResource -ResourceType $MoveResourceType -ResourceName $MoveResourceName
  
      # Move the resource to the new group
      Move-AzResource -ResourceId $resource.ResourceId -DestinationResourceGroupName $DestinationResourceGroupName
    }
  
    # Delete resource group
    if ($Delete) {
      Remove-AzResourceGroup -Name $Name
    }
  }
  