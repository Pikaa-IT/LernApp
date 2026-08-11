#============================================================================
# Versucht, einen Task ohne title-Feld anzulegen.
# Erwartet: 400 Bad Request mit fieldErrors fuer 'title'.
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

# Gibt eine Überschrift in der Konsole aus.
Write-Host "--- POST /tasks ohne title-Feld ---" -ForegroundColor Cyan

# Erstellt den Request-Body OHNE title-Feld.
# Der Unterschied zu 08: dort war title leer (""),
# hier fehlt das title-Feld komplett.
# Ergebnis: {"done": false}
# @NotBlank erkennt null genauso als Fehler wie einen leeren String
$body = @{ done = $false } | ConvertTo-Json

# Gibt den Body vor dem Senden aus – zur Kontrolle was wir schicken
Write-Host "Sende Body:"; Write-Host $body

# try = versuche den Request zu senden
try {
    # Sendet den POST-Request ohne title-Feld.
    # -UseBasicParsing = verhindert HTML-Parsing damit Fehler-Body lesbar bleibt
    Invoke-WebRequest -Uri "http://localhost:8080/tasks" -Method Post -ContentType "application/json" -Body $body -UseBasicParsing

    # Diese Zeile sollte NICHT erreicht werden.
    # Wenn doch, bedeutet das die Validierung funktioniert nicht –
    # der fehlende Titel wurde akzeptiert obwohl er nicht sein sollte
    Write-Host "UNERWARTET: Kein Fehler" -ForegroundColor Yellow

# catch = wird ausgeführt wenn der Server einen Fehler zurückgibt (400)
} catch {
    # Gibt den Statuscode aus – sollte 400 sein.
    # .value__ = gibt die Zahl zurück, z.B. 400
    Write-Host "Statuscode: $($_.Exception.Response.StatusCode.value__) (wie erwartet)" -ForegroundColor Green

    # Ruft die Hilfsfunktion auf und gibt den Fehler-Body aus.
    # Erwartete Ausgabe:
    # {"status":400,"message":"Validierung fehlgeschlagen",
    #  "fieldErrors":[{"field":"title","message":"Titel darf nicht leer sein"}]}
    Write-Host "Fehler-Body:" -ForegroundColor Red
    Write-Host (Read-ErrorBody)
}
