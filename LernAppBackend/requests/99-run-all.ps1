# Gibt eine Überschrift in Gelb aus – zur optischen Trennung in der Konsole
Write-Host "=== Komplettdurchlauf ===" -ForegroundColor Yellow

# Legt einen neuen Task an (POST /tasks).
# Wird zweimal aufgerufen um zwei Tasks zu erstellen.
# Erster Task bekommt ID 1, zweiter Task bekommt ID 2
.\requests\02-create.ps1
.\requests\02-create.ps1

# Holt alle Tasks (GET /tasks).
# Sollte jetzt zwei Tasks in der Liste anzeigen
.\requests\01-get-all.ps1

# Holt einen einzelnen Task per ID (GET /tasks/1).
# -Id 1 = wir suchen explizit den Task mit ID 1
.\requests\03-get-one.ps1 -Id 1

# Aktualisiert den Task mit ID 1 (PUT /tasks/1).
# Titel wird auf "Aktualisierter Task" geändert, done wird auf true gesetzt
.\requests\04-update.ps1 -Id 1

# Holt alle Tasks nochmal (GET /tasks).
# Sollte den aktualisierten Task mit done = true anzeigen
.\requests\01-get-all.ps1

# Löscht den Task mit ID 1 (DELETE /tasks/1).
# Erwartet: 204 No Content = erfolgreich gelöscht
.\requests\05-delete.ps1 -Id 1

# Holt alle Tasks ein letztes Mal (GET /tasks).
# Sollte nur noch einen Task anzeigen – ID 1 wurde gelöscht
.\requests\01-get-all.ps1