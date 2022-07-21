param (
    [string]$orgUrl,
    [string]$pat,
    [string]$processId,
    [string]$workItemTypeReferenceName
)

# Create header with PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($pat)"))
$header = @{authorization = "Basic $token" }

$queryString = "api-version=7.0"

# Read work item tracking field info from jsonsource/WorkItemTrackingField.json
$workItemTrackingFieldJSON = Get-Content -Path ./jsonsource/WorkItemTrackingField.json
               
$createWorkItemTrackingFieldURL = "$orgUrl/_apis/wit/fields?$queryString"
$response = Invoke-RestMethod -Uri $createWorkItemTrackingFieldURL -Method Post -ContentType "application/json" -Headers $header -Body ($workItemTrackingFieldJSON )

# Returned Response
Write-Host "Response returned from Create Work Item Tracking Field: $response"
Write-Output $response