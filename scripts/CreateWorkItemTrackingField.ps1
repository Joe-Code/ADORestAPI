param (
    [string]$orgUrl,
    [string]$pat,
    [string]$processId,
    [string]$workItemTypeReferenceName
)

# Create header with PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($pat)"))
$header = @{authorization = "Basic $token" }

$queryString = "api-version=6.0"

# TODO: Read this info from jsonsource/WorkItemTypeField.json
$workItemTrackingFieldJSON = 
[PSCustomObject]@{
    name                = "New Work Item Tracking Field"
    referenceName       = "SupportedOperations.GreaterThanEquals"
    description         = "New Work Item Tracking Field From REST API Demo"
    type = "string"
    usage = "workItem"
    readOnly = "false"
    canSortBy = "true"
    isQueryable = "true"
    supportedOperations = @{
        referenceName = "SupportedOperations.Equals"
        name =  "="
    }
    isIdentity = "true"
    isPicklist = "false"
    isPicklistSuggested = "false"
} | ConvertTo-Json

capabilities = @{
                  versioncontrol = @{
                     sourceControlType = "Git"
                  }
                  processTemplate = @{
                     # Basic Project
                     templateTypeId = "b8a3a935-7e91-48b8-a94c-606d37c3e9f2"
                    
                  }
               }
               
$createWorkItemTrackingFieldURL = "$orgUrl/_apis/wit/fields?$queryString"
$response = Invoke-RestMethod -Uri $createWorkItemTrackingFieldURL -Method Post -ContentType "application/json" -Headers $header -Body ($workItemTrackingFieldJSON )

# Returned Response
Write-Host "Response returned from Create Work Item Tracking Field: $response"
Write-Output $response