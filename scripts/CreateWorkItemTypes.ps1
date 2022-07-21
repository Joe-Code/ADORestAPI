param (
    [string]$orgUrl,
    [string]$pat,
    [string]$processId
)

# Create header with PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($pat)"))
$header = @{authorization = "Basic $token" }

$queryString = "api-version=6.0"
# TODO: Create a second work item type in a hierarchichy

# Read work item tracking field info from jsonsource/WorkItemTypes.json
$workItemTypeJSON = Get-Content -Path ./jsonsource/WorkItemTypes.json | ConvertFrom-Json
$workItemTypeJSON = $workItemTypeJSON | ConvertTo-Json

$createWorkItemTypeURL = "$orgUrl/_apis/work/processes/$processId/workitemtypes?$queryString"
$response = Invoke-RestMethod -Uri $createWorkItemTypeURL -Method Post -ContentType "application/json" -Headers $header -Body ($workItemTypeJSON )

# Returned Response
Write-Host "Response returned from Create Work Item Type : $response"
Write-Output $response