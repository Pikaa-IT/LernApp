# Gibt eine Überschrift in der Konsole aus.
# -ForegroundColor Cyan = Schriftfarbe Cyan zur besseren Lesbarkeit
Write-Host "--- POST /tasks ---" -ForegroundColor Cyan

# Erstellt den Request-Body als JSON-String.
# @{ } = eine Hashtable (Schlüssel-Wert-Paare) in PowerShell
# title = "Test Task" = der Titel des neuen Tasks
# done = $false = noch nicht erledigt ($false = false in Java)
# | ConvertTo-Json = wandelt die Hashtable in einen JSON-String um
# Ergebnis: {"title": "Test Task", "done": false}
$body = @{ title = "Test Task"; done = $false } | ConvertTo-Json

# Sendet einen HTTP-POST-Request an die API.
# Invoke-WebRequest = ähnlich wie Invoke-RestMethod, gibt aber mehr Details zurück
# -Uri = die URL die aufgerufen wird
# ` = Zeilenfortsetzungszeichen (Backtick) – Befehl geht in der nächsten Zeile weiter
# -Method Post = HTTP-Methode POST (neue Ressource erstellen)
# -ContentType "application/json" = sagt dem Server dass wir JSON schicken
# -Body $body = der JSON-String der mitgeschickt wird (der neue Task)
# -UseBasicParsing = verhindert HTML-Parsing, damit Fehler-Body lesbar bleibt
$response = Invoke-WebRequest -Uri "http://localhost:8080/tasks" `
    -Method Post -ContentType "application/json" -Body $body -UseBasicParsing

# Gibt den HTTP-Statuscode aus.
# 201 = Created (Task wurde erfolgreich angelegt)
# $( ) = Ausdruck innerhalb eines Strings auswerten
Write-Host "Statuscode: $($response.StatusCode)"

# Gibt den Antwort-Body aus – also den angelegten Task als JSON-String.
# Beispiel: {"id":1,"title":"Test Task","done":false}
Write-Host $response.Content