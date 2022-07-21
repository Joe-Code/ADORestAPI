param (
    [string]$orgUrl,
    [string]$pat
)

# Create header with PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($pat)"))
$header = @{authorization = "Basic $token" }

$queryString = "api-version=6.0"

# Create new process named Super Special Process
$guid = [guid]::NewGuid()

$processName = "Super Special Process" + $guid
$processName = $processName.Replace("-", "")

$referenceName = "SuperSpecialProcess" + $guid
$referenceName = $referenceName.replace("-", "")

# TODO: Read this info from jsonsource/Process.json
$processJSON = 
[PSCustomObject]@{name                  = "$($processName)"
    parentProcessTypeId = "adcc42ab-9882-485e-a3ed-7678f01f66bc"
    referenceName       = "$($referenceName)"
    description         = "New Process From REST API Demo"
} | ConvertTo-Json

$createProcessURL = "$orgUrl/_apis/work/processes?$queryString"
$response = Invoke-RestMethod -Uri $createProcessURL -Method Post -ContentType "application/json" -Headers $header -Body ($processJSON )

# Returned Response
Write-Host "Response returned from Create Process : $response"
Write-Output $response

# Get detailed process information
# $processDetailsUrl = "$orgUrl/_apis/work/processes/$($response.typeId)?$queryString"
# $processDetails = Invoke-RestMethod -Uri $processDetailsUrl -Method Get -ContentType "application/json" -Headers $header
# #$projectId = $projectDetails.id
# Write-Host ($processDetails | ConvertTo-Json | ConvertFrom-Json)


# $confirmation = Read-Host "Are you sure you want to delete the project $($projectName) (y/n)"
# if ($confirmation.ToLower() -eq 'y') {
#     # Delete a project
#     $deleteURL = "$orgUrl/_apis/projects/$($projectId)?$queryString"
#     $response = Invoke-RestMethod -Uri $deleteURL -Method Delete -ContentType "application/json" -Headers $header
#     # Wait for 5 seconds
#     Start-Sleep -s 5
#     # Get Update Operation Status
#     $operationStatusUrl = "$orgUrl/_apis/operations/$($response.id)?$queryString"
#     $response = Invoke-RestMethod -Uri $operationStatusUrl -Method Get -ContentType "application/json" -Headers $header
#     Write-Host "Delete Project Status:" $response.status
# }
# else {
#     Write-Host "Project not deleted. Scipt completed."
# }