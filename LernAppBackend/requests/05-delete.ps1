# Definiert einen Parameter den man beim Aufruf mitgeben kann.
# [int] = der Parameter muss eine ganze Zahl sein
# $Id = Name des Parameters
# = 1 = Standardwert wenn kein Parameter angegeben wird
# Aufruf mit ID:  .\05-delete.ps1 -Id 5
# Aufruf ohne ID: .\05-delete.ps1 (nimmt dann Id = 1)
param(
    [int]$Id = 1
)

# Gibt eine Überschrift aus mit der aktuellen ID.
# $Id wird automatisch in den String eingesetzt
Write-Host "--- DELETE /tasks/$Id ---" -ForegroundColor Cyan

# try = versuche diesen Code auszuführen
try {
    # Sendet einen HTTP-DELETE-Request um einen Task zu löschen.
    # -Method Delete = HTTP-Methode DELETE (Ressource löschen)
    # -UseBasicParsing = verhindert HTML-Parsing damit Fehler-Body lesbar bleibt
    # Kein -Body nötig – beim Löschen schickt man nur die ID in der URL mit
    $response = Invoke-WebRequest -Uri "http://localhost:8080/tasks/$Id" `
        -Method Delete -UseBasicParsing

    # Gibt den HTTP-Statuscode aus.
    # Bei Erfolg 204 No Content = gelöscht, kein Body in der Antwort
    Write-Host "Statuscode: $($response.StatusCode)"

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
        # StreamReader = Klasse zum Lesen von Streams
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
