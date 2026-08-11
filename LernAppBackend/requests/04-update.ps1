# Definiert einen Parameter den man beim Aufruf mitgeben kann.
# [int] = der Parameter muss eine ganze Zahl sein
# $Id = Name des Parameters
# = 1 = Standardwert wenn kein Parameter angegeben wird
# Aufruf mit ID:  .\04-update.ps1 -Id 5
# Aufruf ohne ID: .\04-update.ps1 (nimmt dann Id = 1)
param(
    [int]$Id = 1
)

# Gibt eine Überschrift aus mit der aktuellen ID.
# $Id wird automatisch in den String eingesetzt
Write-Host "--- PUT /tasks/$Id ---" -ForegroundColor Cyan

# Erstellt den Request-Body als JSON-String.
# title = neuer Titel des Tasks
# done = true = Task wird als erledigt markiert
# | ConvertTo-Json = wandelt die Hashtable in einen JSON-String um
# Ergebnis: {"title": "Aktualisierter Task", "done": true}
$body = @{ title = "Aktualisierter Task"; done = $true } | ConvertTo-Json

# try = versuche diesen Code auszuführen
try {
    # Sendet einen HTTP-PUT-Request um einen vorhandenen Task zu aktualisieren.
    # -Method Put = HTTP-Methode PUT (vorhandene Ressource ersetzen)
    # -ContentType "application/json" = sagt dem Server dass wir JSON schicken
    # -Body $body = der neue Inhalt des Tasks
    # -UseBasicParsing = verhindert HTML-Parsing damit Fehler-Body lesbar bleibt
    $response = Invoke-WebRequest -Uri "http://localhost:8080/tasks/$Id" `
        -Method Put -ContentType "application/json" -Body $body -UseBasicParsing

    # Gibt den HTTP-Statuscode aus – bei Erfolg 200 OK
    Write-Host "Statuscode: $($response.StatusCode)"

    # Gibt den aktualisierten Task als JSON aus
    # Beispiel: {"id":1,"title":"Aktualisierter Task","done":true}
    Write-Host $response.Content

# catch = wird nur ausgeführt wenn im try-Block ein Fehler passiert
# z.B. wenn der Task nicht existiert (404)
} catch {
    # Liest den HTTP-Statuscode aus der Fehler-Antwort.
    # .value__ = gibt die Zahl zurück, z.B. 404
    $statusCode = $_.Exception.Response.StatusCode.value__

    # Liest den Namen des Statuscodes aus.
    # z.B. "NotFound" statt 404
    $statusName = $_.Exception.Response.StatusCode

    # Gibt Statuscode und Name in Rot aus
    Write-Host "Statuscode: $statusCode $statusName" -ForegroundColor Red

    # Öffnet den Antwort-Stream um den Fehler-Body zu lesen.
    # Bei Fehlern steckt der Body nicht in $response sondern im Exception-Stream
    $stream = $_.Exception.Response.GetResponseStream()

    # Prüft ob der Stream überhaupt vorhanden ist
    if ($stream) {
        # StreamReader = Klasse zum Lesen von Streams (Zeichenweise)
        $reader = New-Object System.IO.StreamReader($stream)

        # Liest den kompletten Fehler-Body als Text
        $errorBody = $reader.ReadToEnd()

        # Schließt den Reader um Ressourcen freizugeben
        $reader.Close()

        # Gibt den Fehler-Body in Rot aus
        # Beispiel: {"status":404,"message":"Task mit ID 5 wurde nicht gefunden"}
        Write-Host "Fehler-Body:" -ForegroundColor Red
        Write-Host $errorBody
    }
}