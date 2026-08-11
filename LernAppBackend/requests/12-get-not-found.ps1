#============================================================================
# Holt einen Task mit garantiert nicht existenter ID.
# Erwartet: 404 mit sauberer ErrorResponse-JSON (kein Stack-Trace im Body).
#============================================================================

# Hilfsfunktion zum Lesen des Fehler-Bodys aus dem Exception-Stream.
# Bei Fehlern steckt die JSON-Antwort nicht in $response sondern
# im Stream der Exception – PowerShell macht das umständlich.
function Read-ErrorBody {
    # Öffnet den Antwort-Stream aus der aktuellen Exception.
    # $_ = das aktuelle Fehler-Objekt im catch-Block
    $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())

    # Setzt den Lesecursor an den Anfang des Streams.
    # Ohne diese Zeile könnte der Cursor mitten im Stream stehen
    # und man würde nur einen Teil des Bodys lesen
    $reader.BaseStream.Position = 0

    # Leert den internen Puffer des Readers.
    # Nötig nach dem Zurücksetzen der Position,
    # damit wirklich frisch vom Anfang gelesen wird
    $reader.DiscardBufferedData()

    # Liest den kompletten Fehler-Body als Text und gibt ihn zurück
    return $reader.ReadToEnd()
}

# Setzt die ID auf einen Wert der garantiert nicht in der Datenbank existiert.
# 999999 ist so hoch dass er in unserem Test-System nie vergeben wurde
$Id = 999999

# Gibt eine Überschrift aus mit der gesuchten ID.
Write-Host "--- GET /tasks/$Id (existiert nicht) ---" -ForegroundColor Cyan

# try = versuche den Request zu senden
try {
    # Sendet einen HTTP-GET-Request für eine nicht existente ID.
    # Der Service wirft TaskNotFoundException
    # -> GlobalExceptionHandler fängt sie ab -> 404 Not Found
    # -UseBasicParsing = verhindert HTML-Parsing damit Fehler-Body lesbar bleibt
    Invoke-WebRequest -Uri "http://localhost:8080/tasks/$Id" -Method Get -UseBasicParsing

    # Diese Zeile sollte NICHT erreicht werden.
    # Wenn doch, wurde ein Task mit ID 999999 gefunden – sehr unwahrscheinlich
    Write-Host "UNERWARTET: Kein Fehler" -ForegroundColor Yellow

# catch = wird ausgeführt wenn der Server einen Fehler zurückgibt (404)
} catch {
    # Gibt den Statuscode aus – sollte 404 sein.
    # .value__ = gibt die Zahl zurück, z.B. 404
    Write-Host "Statuscode: $($_.Exception.Response.StatusCode.value__) (wie erwartet)" -ForegroundColor Green

    # Ruft die Hilfsfunktion auf und gibt den Fehler-Body aus.
    # Wichtig: kein Stack-Trace im Body – nur die saubere ErrorResponse.
    # Das ist Security-Hygiene: interne Details gehören ins Server-Log,
    # nicht in die HTTP-Antwort an den Client.
    # Erwartete Ausgabe:
    # {"status":404,"message":"Task mit ID 999999 wurde nicht gefunden",
    #  "fieldErrors":null}
    Write-Host "Fehler-Body:" -ForegroundColor Red
    Write-Host (Read-ErrorBody)
}