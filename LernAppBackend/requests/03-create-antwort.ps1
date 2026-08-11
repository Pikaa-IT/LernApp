param([long]$FrageId = 1)
Write-Host "--- POST /antworten ---" -ForegroundColor Cyan
$body1 = "{`"text`":`"Ein Behälter für Werte`",`"istRichtig`":true,`"frageId`":$FrageId}"
$body2 = "{`"text`":`"Ein fehlerhafter Begriff`",`"istRichtig`":false,`"frageId`":$FrageId}"
Invoke-RestMethod -Uri "http://localhost:8080/antworten" -Method Post -ContentType "application/json" -Body $body1
Invoke-RestMethod -Uri "http://localhost:8080/antworten" -Method Post -ContentType "application/json" -Body $body2
Write-Host "Antworten erstellt"
