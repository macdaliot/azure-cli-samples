#Provide the subscription Id of the subscription where snapshot exists
sourceSubscriptionId=dd80b94e-0463-4a65-8d04-c94f403879dc

#Provide the name of your resource group where snapshot exists
sourceResourceGroupName=mySourceResourceGroupName

#Provide the name of the snapshot
managedDiskName=myDiskName

#Set the context to the subscription Id where snapshot exists
az account set --subscription $sourceSubscriptionId

#Get the managed disk Id 
managedDiskId=$(az disk show --name $managedDiskName --resource-group $sourceResourceGroupName --query [id] -o tsv)

#If managedDiskId is blank then it means that managed disk does not exist.
echo 'source managed disk Id is: ' $managedDiskId

#Provide the subscription Id of the subscription where managed disk will be copied to
#If managed disk is copied to the same subscription then you can skip this step
targetSubscriptionId=6492b1f7-f219-446b-b509-314e17e1efb0

#Name of the resource group where managed disk will be copied to
targetResourceGroupName=mytargetResourceGroupName

#Set the context to the subscription Id where managed disk will be copied to
#If managed disk is copied to the same subscription then you can skip this step
az account set --subscription $targetSubscriptionId

#Copy managed disk to different subscription using the snapshot Id
az disk create --resource-group $targetResourceGroupName --name $managedDiskName --source $managedDiskId
