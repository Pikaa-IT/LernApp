$OutputEncoding = [System.Text.Encoding]::UTF8
$themen = @(
    @{ name = "Planen und Vorbereiten von Arbeitsaufgaben"; beschreibung = "Projektmanagement, Zeitplanung und Kundenanforderungen." },
    @{ name = "Informieren und Beraten von Kunden"; beschreibung = "Kundengespräche, Bedarfsanalyse und Service Level Agreements." },
    @{ name = "Beurteilen marktgängiger IT-Systeme"; beschreibung = "Hardware-Architekturen, Betriebssysteme und Netzwerkkomponenten." },
    @{ name = "Entwickeln und Betreuen von IT-Lösungen"; beschreibung = "Softwareentwicklung, Algorithmen, Pseudocode und SQL-Datenbanken." },
    @{ name = "Qualitätssichernde Maßnahmen"; beschreibung = "Testmethoden wie Blackbox- und Whitebox-Tests und Testprotokolle." },
    @{ name = "IT-Sicherheit, Datenschutz und Ergonomie"; beschreibung = "DSGVO, Verschlüsselung, Firewalls, Backups und Arbeitsschutz." },
    @{ name = "Auftragsabschluss und Leistungserbringung"; beschreibung = "Abnahmetests, Übergabeprotokolle und Rechnungsstellung." }
)

foreach ($thema in $themen) {
    Write-Host "--- POST /themen: $($thema.name) ---" -ForegroundColor Cyan
    $bodyJson = $thema | ConvertTo-Json -Compress
    try {
        $response = Invoke-RestMethod -Uri "http://localhost:8080/themen" -Method Post -ContentType "application/json; charset=utf-8" -Body $bodyJson
        Write-Host ($response | ConvertTo-Json)
    } catch {
        Write-Error $_
    }
}
