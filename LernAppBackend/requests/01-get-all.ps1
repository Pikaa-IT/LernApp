# Gibt eine Überschrift in der Konsole aus.
# -ForegroundColor Cyan = Schriftfarbe Cyan, damit man die Ausgabe besser liest
Write-Host "--- GET /benutzer ---" -ForegroundColor Cyan

# Sendet einen HTTP-GET-Request an die API und speichert die Antwort in $response.
# Invoke-RestMethod = PowerShell-Befehl für HTTP-Requests
# -Uri = die URL die aufgerufen wird
# -Method Get = HTTP-Methode GET (Daten abrufen, nichts ändern)
# Die Antwort kommt als PowerShell-Objekt zurück, nicht als reiner Text
$response = Invoke-RestMethod -Uri "http://localhost:8080/benutzer" -Method Get

# Wandelt das PowerShell-Objekt in lesbares JSON um und gibt es aus.
# Ohne ConvertTo-Json würde PowerShell die Daten in seinem eigenen Format anzeigen.
# Das Pipe-Symbol | bedeutet: nimm die Ausgabe von links und gib sie rechts rein
$response | ConvertTo-Json