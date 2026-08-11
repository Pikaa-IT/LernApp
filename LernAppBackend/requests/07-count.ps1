#============================================================================
# Zeigt die Anzahl der aktuell gespeicherten Tasks.
# Nuetzlich, um schnell zu pruefen, ob Anlegen/Loeschen gewirkt hat.
#============================================================================

# Gibt eine Überschrift in der Konsole aus.
Write-Host "--- Anzahl Tasks ---" -ForegroundColor Cyan

# Sendet einen HTTP-GET-Request und holt alle Tasks als PowerShell-Objekt.
# Invoke-RestMethod = gibt die Antwort direkt als PowerShell-Objekt zurück,
# nicht als rohen Text – deshalb kann man danach .Count aufrufen
$response = Invoke-RestMethod -Uri "http://localhost:8080/tasks" -Method Get

# Gibt die Anzahl der Tasks aus.
# .Count = eingebaute Eigenschaft von PowerShell-Arrays – zählt die Elemente
# Beispiel: Aktuelle Anzahl: 3
# $( ) = Ausdruck innerhalb eines Strings auswerten
Write-Host "Aktuelle Anzahl: $($response.Count)"