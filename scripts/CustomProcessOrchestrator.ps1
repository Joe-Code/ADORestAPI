# Use this file to orchestrate the creation of a custom process.

# Preliminary Outline:

# Create Process
# Create Work item types
# Create custom Work item fields
# Create Project with new custom process

$orgUrl = "https://dev.azure.com/jfitzgerald-ms"
$pat = "aba7rlldires2dtmiotttt6mlcirafysjrds3ymkmofwzqggpzlq"

# Create Process
$processResult = &"C:\Repos\AzureDevOpsRestApiRepo\scripts\CreateProcess.ps1" -orgUrl $orgUrl -pat $pat

# Create Work Item Types
$workItemTypeResult = &"C:\Repos\AzureDevOpsRestApiRepo\scripts\CreateWorkItemTypes.ps1" -orgUrl $orgUrl -pat $pat -processId $processResult.typeId

#Create Work Item Tracking Field
&"C:\Repos\AzureDevOpsRestApiRepo\scripts\CreateWorkItemTrackingField.ps1" -orgUrl $orgUrl -pat $pat -processId $processResult.typeId -workItemTypeReferenceName $workItemTypeResult.referenceName