# Definiert zwei Parameter die man beim Aufruf mitgeben kann.
# [string] = der Parameter muss ein Text sein
# $Title = Name des ersten Parameters, Standardwert "Neuer Task"
# [bool] = der Parameter muss true oder false sein
# $Done = Name des zweiten Parameters, Standardwert $false
# Aufruf: .\06-create-custom.ps1 -Title "Einkaufen" -Done $true
# Aufruf ohne Parameter: .\06-create-custom.ps1 (nimmt Standardwerte)
param(
    [string]$Title = "Neuer Task",
    [bool]$Done = $false
)

# Gibt eine Überschrift aus mit dem aktuellen Titel.
# $Title wird automatisch in den String eingesetzt
Write-Host "--- POST /tasks (Titel: $Title) ---" -ForegroundColor Cyan

# Erstellt den Request-Body als JSON-String.
# @{ } = eine Hashtable (Schlüssel-Wert-Paare) in PowerShell
# title = $Title = der Titel kommt vom Parameter oben
# done = $Done = der Erledigt-Status kommt vom Parameter oben
# | ConvertTo-Json = wandelt die Hashtable in einen JSON-String um
# Ergebnis z.B.: {"title": "Einkaufen", "done": false}
$body = @{
    title = $Title
    done = $Done
} | ConvertTo-Json

# Sendet einen HTTP-POST-Request an die API.
# -Method Post = HTTP-Methode POST (neue Ressource erstellen)
# -ContentType "application/json" = sagt dem Server dass wir JSON schicken
# -Body $body = der JSON-String der mitgeschickt wird
# -UseBasicParsing = verhindert HTML-Parsing damit Fehler-Body lesbar bleibt
# Kein try/catch hier – bei einem Fehler bricht das Skript einfach ab
$response = Invoke-WebRequest -Uri "http://localhost:8080/tasks" -Method Post -ContentType "application/json" -Body $body -UseBasicParsing

# Gibt den HTTP-Statuscode aus.
# Bei Erfolg 201 Created = neuer Task wurde angelegt
Write-Host "Statuscode: $($response.StatusCode)"

# Gibt den Antwort-Body aus – also den angelegten Task als JSON.
# Beispiel: {"id":1,"title":"Einkaufen","done":false}
# Die ID wurde von der Datenbank automatisch vergeben
Write-Host "Antwort-Body:"
Write-Host $response.Content