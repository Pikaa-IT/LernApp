param([long]$ThemaId = 1)
Write-Host "--- POST /fragen ---" -ForegroundColor Cyan
$body = "{`"text`":`"Was ist eine Variable?`",`"schwierigkeit`":`"SINGLE_CHOICE`",`"themaId`":$ThemaId}"
$response = Invoke-RestMethod -Uri "http://localhost:8080/fragen" -Method Post -ContentType "application/json" -Body $body
Write-Host ($response | ConvertTo-Json)
