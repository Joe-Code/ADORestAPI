# Define organization base url, PAT and API version variables
$orgUrl = "https://dev.azure.com/jfitzgerald-ms"
$pat = "aba7rlldires2dtmiotttt6mlcirafysjrds3ymkmofwzqggpzlq"
$queryString = "api-version=6.0-preview.2"

# Create header with PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($pat)"))
$header = @{authorization = "Basic $token" }

# Get the list of all processes in the organization
$processUrl = "$orgUrl/_apis/work/processes/b8a3a935-7e91-48b8-a94c-606d37c3e9f2?$queryString"
$process = Invoke-RestMethod -Uri $processUrl -Method Get -ContentType "application/json" -Headers $header
Write-Host $process

#$process.value | ForEach-Object {
#    Write-Host $_.id $_.name
#}

