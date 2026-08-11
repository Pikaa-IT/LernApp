# $PSScriptRoot = der Ordner in dem dieses Skript liegt.
# Wird gespeichert damit die anderen Skripte relativ dazu aufgerufen werden.
# Ohne $here müsste man den kompletten Pfad hardcoden –
# mit $here funktioniert es egal wo der requests-Ordner liegt.
$here = $PSScriptRoot

# Gibt eine Überschrift in Gelb aus – zur optischen Trennung in der Konsole
Write-Host "=========================================" -ForegroundColor Yellow
Write-Host " Fehlerfaelle durchspielen" -ForegroundColor Yellow
Write-Host "=========================================" -ForegroundColor Yellow

# & = Aufruf-Operator in PowerShell – führt ein anderes Skript aus.
# "$here\08-..." = vollständiger Pfad zum Skript
# Testet: POST mit leerem Titel -> erwartet 400
& "$here\08-create-invalid-empty.ps1"

# Leerzeile zur besseren Lesbarkeit zwischen den Tests
Write-Host ""

# Testet: POST ohne title-Feld -> erwartet 400
& "$here\09-create-invalid-null.ps1"
Write-Host ""

# Testet: POST mit Titel länger als 200 Zeichen -> erwartet 400
& "$here\10-create-invalid-too-long.ps1"
Write-Host ""

# Testet: POST mit ungültigem JSON -> erwartet 400
& "$here\11-create-invalid-json.ps1"
Write-Host ""

# Testet: GET mit nicht existenter ID (999999) -> erwartet 404
& "$here\12-get-not-found.ps1"