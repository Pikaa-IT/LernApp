# Definiert einen Parameter den man beim Aufruf mitgeben kann.
# [int] = der Parameter muss eine Zahl sein
# $Id = Name des Parameters
# = 1 = Standardwert wenn kein Parameter angegeben wird
# Aufruf mit ID: .\03-get-one.ps1 -Id 5
# Aufruf ohne ID: .\03-get-one.ps1 (nimmt dann Id = 1)
param(
    [int]$Id = 1
)

# Gibt eine Überschrift aus mit der aktuellen ID.
# $Id wird automatisch in den String eingesetzt
Write-Host "--- GET /tasks/$Id ---" -ForegroundColor Cyan

# try = versuche diesen Code auszuführen
# Wenn kein Fehler passiert, läuft alles normal durch
try {
    # Sendet einen HTTP-GET-Request für einen einzelnen Task per ID.
    # /tasks/$Id = z.B. /tasks/1 oder /tasks/5
    # -UseBasicParsing = verhindert HTML-Parsing damit Fehler-Body lesbar bleibt
    $response = Invoke-WebRequest -Uri "http://localhost:8080/tasks/$Id" -Method Get -UseBasicParsing

    # Gibt den HTTP-Statuscode aus – bei Erfolg 200 OK
    Write-Host "Statuscode: $($response.StatusCode)"

    # Gibt den Antwort-Body aus – also den gefundenen Task als JSON
    # Beispiel: {"id":1,"title":"Test Task","done":false}
    Write-Host "Antwort-Body:"
    Write-Host $response.Content

# catch = wird nur ausgeführt wenn im try-Block ein Fehler passiert
# z.B. wenn der Task nicht existiert (404) oder der Server nicht läuft
} catch {
    # Liest den HTTP-Statuscode aus der Fehler-Antwort.
    # $_ = das aktuelle Fehler-Objekt in PowerShell
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
        # StreamReader = Java-ähnliche Klasse zum Lesen von Streams
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
