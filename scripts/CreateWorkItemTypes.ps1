param (
    [string]$orgUrl,
    [string]$pat,
    [string]$processId
)

# Create header with PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($pat)"))
$header = @{authorization = "Basic $token" }

$queryString = "api-version=6.0"

# TODO: Read this info from jsonsource/WorkItemTypes.json
$workItemTypeJSON = 
[PSCustomObject]@{name  = "Change Request"
    description         = "New Work Item Type From REST API Demo"
    color               = "f6546a"
    icon                = "icon_airplane"
    isDisabled          = "false"
} | ConvertTo-Json

$createWorkItemTypeURL = "$orgUrl/_apis/work/processes/$processId/workitemtypes?$queryString"
$response = Invoke-RestMethod -Uri $createWorkItemTypeURL -Method Post -ContentType "application/json" -Headers $header -Body ($workItemTypeJSON )

# Returned Response
Write-Host "Response returned from Create Work Item Type : $response"
Write-Output $response