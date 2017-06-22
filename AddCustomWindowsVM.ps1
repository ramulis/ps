Login-AzureRmAccount
Get-AzureRmSubscription

#Set-AzureRmContext -SubscriptionName "MSDN"
#Get-AzureRmVMSize $locationName | Out-GridView

$resourceGroupName = "RGName1"
$virtualNetworkName = "VnetName1"
$locationName = "westeurope"
$destinationVhd = "https://YourSTORAGEACCOUNT.blob.core.windows.net/vhds/YourPathtoVHD.vhd"

$VMName = "MyCustomServer1"
$VMSize = "Standard_D1_v2"

$addressrange = "10.0.0.0/16"
$subnet1name = "subnet1"
$subnet2name = "subnet2"
$subnet1range = "10.0.1.0/24"
$subnet2range = "10.0.2.0/24"

New-AzureRmResourceGroup -Name $resourceGroupName -Location $locationName
New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName -AddressPrefix $addressrange -Location $locationName
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName
Add-AzureRmVirtualNetworkSubnetConfig -Name $subnet1name -VirtualNetwork $vnet -AddressPrefix $subnet1range
Add-AzureRmVirtualNetworkSubnetConfig -Name $subnet2name -VirtualNetwork $vnet -AddressPrefix $subnet2range
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName

#$virtualNetwork = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName

$publicIp = New-AzureRmPublicIpAddress -Name "Server1-PIP" -ResourceGroupName $ResourceGroupName -Location $locationName -AllocationMethod Dynamic
$networkInterface = New-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName -Name "MyServerNIC1" -Location $locationName -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id

$vmConfig = New-AzureRmVMConfig -VMName $VMName -VMSize $VMSize
$vmConfig = Set-AzureRmVMOSDisk -VM $vmConfig -Name $VMName -VhdUri $destinationVhd -CreateOption Attach -Windows
$vmConfig = Add-AzureRmVMNetworkInterface -VM $vmConfig -Id $networkInterface.Id

$vm = New-AzureRmVM -VM $vmConfig -Location $locationName -ResourceGroupName $resourceGroupName



#Uncomment next line to remove resource group and it's components if it was just for testing
#Remove-AzureRmResourceGroup -Name $resourceGroupName
