param([long]$FrageId = 1)
Write-Host "--- GET /fragen/$FrageId (mit Antworten) ---" -ForegroundColor Cyan
$response = Invoke-RestMethod -Uri "http://localhost:8080/fragen/$FrageId" -Method Get
Write-Host ($response | ConvertTo-Json -Depth 10)
