param([long]$ThemaId = 1)
Write-Host "--- GET /themen/$ThemaId (mit Fragen) ---" -ForegroundColor Cyan
$response = Invoke-RestMethod -Uri "http://localhost:8080/themen/$ThemaId" -Method Get
Write-Host ($response | ConvertTo-Json -Depth 10)
