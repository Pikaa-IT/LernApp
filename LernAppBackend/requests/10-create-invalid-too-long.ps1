#============================================================================
# Versucht, einen Task mit >200 Zeichen Titel anzulegen.
# Erwartet: 400 Bad Request mit fieldErrors fuer 'title' (Size-Verletzung).
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
Write-Host "--- POST /tasks mit zu langem Titel ---" -ForegroundColor Cyan

# Erstellt den Request-Body mit einem absurd langen Titel.
# ("x" * 250) = der Buchstabe "x" wird 250 mal wiederholt
# Ergebnis: "xxxxxxxxx..." (250 Zeichen)
# Unsere Validierung erlaubt maximal 200 Zeichen (@Size(max = 200))
# also sollte das einen 400-Fehler auslösen
$body = @{ title = ("x" * 250); done = $false } | ConvertTo-Json

# try = versuche den Request zu senden
try {
    # Sendet den POST-Request mit dem zu langen Titel.
    # -UseBasicParsing = verhindert HTML-Parsing damit Fehler-Body lesbar bleibt
    Invoke-WebRequest -Uri "http://localhost:8080/tasks" -Method Post -ContentType "application/json" -Body $body -UseBasicParsing

    # Diese Zeile sollte NICHT erreicht werden.
    # Wenn doch, bedeutet das @Size(max = 200) funktioniert nicht –
    # der zu lange Titel wurde akzeptiert obwohl er nicht sein sollte
    Write-Host "UNERWARTET: Kein Fehler" -ForegroundColor Yellow

# catch = wird ausgeführt wenn der Server einen Fehler zurückgibt (400)
} catch {
    # Gibt den Statuscode aus – sollte 400 sein.
    # .value__ = gibt die Zahl zurück, z.B. 400
    Write-Host "Statuscode: $($_.Exception.Response.StatusCode.value__) (wie erwartet)" -ForegroundColor Green

    # Ruft die Hilfsfunktion auf und gibt den Fehler-Body aus.
    # Erwartete Ausgabe:
    # {"status":400,"message":"Validierung fehlgeschlagen",
    #  "fieldErrors":[{"field":"title","message":"Titel darf höchstens 200 Zeichen lang sein"}]}
    Write-Host "Fehler-Body:" -ForegroundColor Red
    Write-Host (Read-ErrorBody)
}