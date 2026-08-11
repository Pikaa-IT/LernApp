================================================================================
  LERNAPP – README
  Spring Boot 4 REST API | Quiz-System für Fachinformatiker-Prüfungsvorbereitung
================================================================================

INHALTSVERZEICHNIS
------------------
  1.  Projektbeschreibung
  2.  Technologie-Stack
  3.  Voraussetzungen
  4.  Projekt-Setup (Schritt für Schritt)
  5.  Datenbank-Setup (lernappdb.sql)
  6.  Anwendung starten
  7.  API-Endpunkte
  8.  Projektstruktur
  9.  Datenbankstruktur
  10. Datenimport (CSV -> SQL)
  11. PowerShell-Testskripte
  12. Häufige Fehler und Lösungen
  13. Geplante Erweiterungen (Phase 2)


================================================================================
  1. PROJEKTBESCHREIBUNG
================================================================================

Die LernApp ist eine REST API zur Verwaltung von Lernkarten fuer die
Prüfungsvorbereitung zum Fachinformatiker Anwendungsentwicklung.

Das System besteht aus:
  - 270 Lernfragen (aus lernkarten_1-270.csv importiert)
  - 270 Antworten (je eine pro Frage, ist_richtig = true)
  - 7 Themengebiete (nach IHK-Prüfungsstruktur)
  - Benutzerverwaltung mit BCrypt-Passwort-Hashing (vorbereitet für Phase 2)

PHASE 1 (aktuell): Lern-Modus
  -> Themen, Fragen und Antworten per REST API verwalten (CRUD)
  -> Fragen nach Thema filtern (GET /fragen?themaId=X)

PHASE 2 (geplant): Quiz-Modus
  -> Benutzer beantwortet Fragen
  -> Punktestand wird berechnet und gespeichert
  -> Statistiken pro Benutzer und Thema


================================================================================
  2. TECHNOLOGIE-STACK
================================================================================

  Backend:        Spring Boot 4.0.6
  Sprache:        Java 21 (LTS)
  Datenbank:      MariaDB 10.4.32 (via XAMPP)
  ORM:            Hibernate 6 (via spring-boot-starter-data-jpa)
  Validierung:    Jakarta Validation 3
  Sicherheit:     Spring Security 6 (konfiguriert: kein Login, kein CSRF)
  Codegenerierung:Lombok
  Build-Tool:     Maven 3 (mvnw-Wrapper enthalten)
  Testtools:      PowerShell 5/7 (Invoke-RestMethod)
  IDE:            IntelliJ IDEA


================================================================================
  3. VORAUSSETZUNGEN
================================================================================

  - Java 21 JDK installiert (oder höher)
  - XAMPP installiert und gestartet (Apache + MySQL/MariaDB)
  - IntelliJ IDEA (oder anderes IDE mit Maven-Unterstützung)
  - PowerShell 5 oder höher (für Testskripte)

  Java-Version prüfen:
    java -version

  XAMPP starten:
    XAMPP Control Panel -> Apache starten -> MySQL starten


================================================================================
  4. PROJEKT-SETUP (SCHRITT FUER SCHRITT)
================================================================================

  SCHRITT 1: Projekt klonen / entpacken
  ---------------------------------------
  Projektordner:
    C:\"eigene PFAD"\LernApp_Projekt\LernApp\

  SCHRITT 2: Datenbank erstellen (-> siehe Abschnitt 5)
  ------------------------------------------------------

  SCHRITT 3: application.properties prüfen
  ------------------------------------------
  Datei: src/main/resources/application.properties

    spring.datasource.url=jdbc:mariadb://localhost:3306/lernappdb
    spring.datasource.username=root
    spring.datasource.password=
    spring.jpa.hibernate.ddl-auto=update
    spring.jpa.show-sql=true

  SCHRITT 4: Anwendung starten
  -----------------------------
  In IntelliJ: Run-Button bei LernAppApplication.java
  Oder in PowerShell:
    .\mvnw.cmd spring-boot:run

  SCHRITT 5: API testen (-> siehe Abschnitt 11)
  -----------------------------------------------


================================================================================
  5. DATENBANK-SETUP (lernappdb.sql)
================================================================================

  DIE DATENBANK WIRD AUS DER BEILIEGENDEN DATEI lernappdb.sql IMPORTIERT.

  METHODE A: Über phpMyAdmin (empfohlen)
  ----------------------------------------
    1. Browser öffnen: http://localhost/phpmyadmin
    2. Links oben: "Neu" klicken
    3. Datenbankname: lernappdb
    4. Zeichensatz: utf8mb4_general_ci
    5. "Erstellen" klicken
    6. Reiter "Importieren" klicken
    7. "Datei auswählen" -> lernappdb.sql auswählen
    8. "OK" / "Importieren" klicken

  METHODE B: Über die Kommandozeile
  ------------------------------------
    mysql -u root -p < lernappdb.sql

  WAS WIRD IMPORTIERT:
    - Tabelle themen       (7 Einträge)
    - Tabelle fragen       (270 Einträge, Fragen 1-270)
    - Tabelle antworten    (270 Einträge, je eine Antwort pro Frage)
    - Tabelle benutzern    (leer, für Phase 2 vorbereitet)
    - Fremdschlüssel und Indizes
    - AUTO_INCREMENT-Werte (nächste ID startet bei 512)

  HINWEIS: Hibernate erstellt beim App-Start keine neuen Tabellen da
  ddl-auto=update nur ergänzt was fehlt. Die importierten Daten bleiben erhalten.


================================================================================
  6. ANWENDUNG STARTEN
================================================================================

  START:
    IntelliJ IDEA -> LernAppApplication.java -> Run (Shift+F10)
    Oder: .\mvnw.cmd spring-boot:run

  ERFOLGREICHER START erkennbar an:
    Started LernAppApplication in X.XXX seconds

  SERVER LAEUFT AUF:
    http://localhost:8080

  H2-KONSOLE (Datenbankansicht im Browser):
    http://localhost:8080/h2-console
    JDBC URL: jdbc:mariadb://localhost:3306/lernappdb
    Benutzername: root
    Passwort: (leer lassen)

  PORT BEREITS BELEGT? (Fehlermeldung: "Port 8080 already in use")
    In application.properties hinzufügen:
      server.port=8081
    Dann: http://localhost:8081


================================================================================
  7. API-ENDPUNKTE
================================================================================

  THEMEN  (/themen)
  ------------------
  GET    /themen             -> Alle 7 Themen abrufen
  GET    /themen/{id}        -> Ein Thema abrufen (z.B. /themen/1)
  POST   /themen             -> Neues Thema anlegen
  PUT    /themen/{id}        -> Thema aktualisieren
  DELETE /themen/{id}        -> Thema löschen (löscht alle Fragen mit!)

  FRAGEN  (/fragen)
  ------------------
  GET    /fragen             -> Alle 270 Fragen abrufen
  GET    /fragen?themaId=1   -> Nur Fragen von Thema 1 (z.B. Fragen 1-26)
  GET    /fragen/{id}        -> Eine Frage abrufen (z.B. /fragen/1)
  POST   /fragen             -> Neue Frage anlegen
  PUT    /fragen/{id}        -> Frage aktualisieren
  DELETE /fragen/{id}        -> Frage löschen (löscht alle Antworten mit!)

  ANTWORTEN  (/antworten)
  ------------------------
  GET    /antworten          -> Alle 270 Antworten abrufen
  GET    /antworten/{id}     -> Eine Antwort abrufen
  POST   /antworten          -> Neue Antwort anlegen
  PUT    /antworten/{id}     -> Antwort aktualisieren
  DELETE /antworten/{id}     -> Antwort löschen

  BENUTZER  (/benutzer)
  ----------------------
  GET    /benutzer           -> Alle Benutzer abrufen
  GET    /benutzer/{id}      -> Einen Benutzer abrufen
  POST   /benutzer           -> Neuen Benutzer anlegen (Passwort wird gehasht!)
  PUT    /benutzer/{id}      -> Benutzer aktualisieren
  DELETE /benutzer/{id}      -> Benutzer löschen

  FEHLER-ANTWORTEN (einheitliches Format):
  -----------------------------------------
  400 Bad Request  -> Validierungsfehler oder kaputtes JSON
  404 Not Found    -> Ressource mit der ID nicht gefunden
  500 Server Error -> Unerwarteter interner Fehler

  Beispiel Fehler-Response:
    {
      "timestamp": "2026-06-10T10:25:47",
      "status": 404,
      "error": "Not Found",
      "message": "Frage mit ID 999 wurde nicht gefunden",
      "path": "/fragen/999",
      "fieldErrors": null
    }


================================================================================
  8. PROJEKTSTRUKTUR
================================================================================

  LernApp/
  |-- src/main/java/com/example/LernApp/
  |   |-- LernAppApplication.java        <- Einstiegspunkt (@SpringBootApplication)
  |   |-- SecurityConfig.java            <- Alle Requests erlaubt, CSRF aus
  |   |-- H2ConsoleConfig.java           <- H2-Konsole (Spring Boot 4 Besonderheit)
  |   |
  |   |-- model/                         <- JPA-Entitäten (Datenbanktabellen)
  |   |   |-- Thema.java                 -> Tabelle: themen
  |   |   |-- Frage.java                 -> Tabelle: fragen
  |   |   |-- Antwort.java               -> Tabelle: antworten
  |   |   +-- Benutzer.java              -> Tabelle: benutzern
  |   |
  |   |-- dto/                           <- Data Transfer Objects (API-Schnittstelle)
  |   |   |-- ThemaCreateRequest.java / ThemaUpdateRequest.java / ThemaResponse.java
  |   |   |-- FrageCreateRequest.java / FrageUpdateRequest.java / FrageResponse.java
  |   |   |-- AntwortCreateRequest.java (Record) / AntwortUpdateRequest.java (Record)
  |   |   |-- AntwortResponse.java (Record)
  |   |   |-- BenutzerCreateRequest.java / BenutzerUpdateRequest.java
  |   |   |-- BenutzerResponse.java
  |   |   +-- ErrorResponse.java         <- Einheitliches Fehlerformat
  |   |
  |   |-- mapper/                        <- Konvertierung Entität <-> DTO
  |   |   |-- ThemaMapper.java
  |   |   |-- FrageMapper.java           <- Lädt Thema per ThemaRepository
  |   |   |-- AntwortMapper.java         <- Lädt Frage per FrageRepository
  |   |   +-- BenutzerMapper.java        <- Hasht Passwort per BCryptPasswordEncoder
  |   |
  |   |-- repository/                    <- Spring Data JPA Interfaces
  |   |   |-- ThemaRepository.java
  |   |   |-- FrageRepository.java       <- findByThemaId()
  |   |   |-- AntwortRepository.java     <- findByFrageId()
  |   |   +-- BenutzerRepository.java
  |   |
  |   |-- service/                       <- Geschäftslogik
  |   |   |-- ThemaService.java
  |   |   |-- FrageService.java          <- findByThema(Long themaId)
  |   |   |-- AntwortService.java
  |   |   +-- BenutzerService.java
  |   |
  |   |-- controller/                    <- HTTP-Endpunkte
  |   |   |-- ThemaController.java       -> /themen
  |   |   |-- FrageController.java       -> /fragen (mit ?themaId Filter)
  |   |   |-- AntwortController.java     -> /antworten
  |   |   +-- BenutzerController.java    -> /benutzer
  |   |
  |   +-- exception/                     <- Fehlerbehandlung
  |       |-- ThemaNotFoundException.java
  |       |-- FrageNotFoundException.java
  |       |-- AntwortNotFoundException.java
  |       |-- BenutzerNotFoundException.java
  |       +-- GlobalExceptionHandler.java  <- @RestControllerAdvice
  |
  |-- src/main/resources/
  |   +-- application.properties         <- Datenbank- und Hibernate-Konfiguration
  |
  |-- requests/                          <- PowerShell-Testskripte
  |   |-- 01-create-thema.ps1
  |   |-- 02-create-frage.ps1
  |   |-- 03-create-antwort.ps1
  |   |-- 04-get-thema.ps1
  |   |-- 05-get-frage.ps1
  |   +-- 99-run-all.ps1
  |
  |-- pom.xml                            <- Maven-Abhängigkeiten
  |-- lernappdb.sql                      <- Datenbankdump (Struktur + Daten)
  +-- README.txt                         <- Diese Datei


================================================================================
  9. DATENBANKSTRUKTUR
================================================================================

  DATENBANK: lernappdb
  Zeichensatz: utf8mb4_general_ci
  Server: MariaDB 10.4.32

  TABELLE: themen
  ----------------
  id           BIGINT       PRIMARY KEY, AUTO_INCREMENT
  name         VARCHAR(50)  NOT NULL, UNIQUE
  beschreibung VARCHAR(200) NOT NULL

  Eintraege (7 Themen nach IHK-Struktur):
    ID 1: Planen und Vorbereiten von Arbeitsaufgaben         (Fragen   1-26)
    ID 2: Informieren und Beraten von Kunden                 (Fragen  27-52)
    ID 3: Beurteilen marktgängiger IT-Systeme               (Fragen  53-136)
    ID 4: Entwickeln und Betreuen von IT-Lösungen           (Fragen 137-190)
    ID 5: Qualitätssichernde Massnahmen                     (Fragen 191-198)
    ID 6: IT-Sicherheit, Datenschutz und Ergonomie           (Fragen 199-236)
    ID 7: Auftragsabschluss und Leistungserbringung          (Fragen 237-270)

  TABELLE: fragen
  ----------------
  id           BIGINT  PRIMARY KEY, AUTO_INCREMENT
  text         TEXT    NOT NULL
  schwierigkeit VARCHAR(50) NOT NULL
  themen_id    BIGINT  NOT NULL, FOREIGN KEY -> themen(id)

  Anzahl: 270 Fragen (ID 1 bis 270, nächste AUTO_INCREMENT: 512)

  TABELLE: antworten
  -------------------
  id           BIGINT  PRIMARY KEY, AUTO_INCREMENT
  text         TEXT    NOT NULL
  ist_richtig  BIT(1)  NOT NULL   (1 = richtig, 0 = falsch)
  frage_id     BIGINT  NOT NULL, FOREIGN KEY -> fragen(id)

  Anzahl: 270 Antworten (je eine pro Frage, alle ist_richtig = 1)
  Nächste AUTO_INCREMENT: 512

  TABELLE: benutzern
  -------------------
  id              BIGINT       PRIMARY KEY, AUTO_INCREMENT
  benutzername    VARCHAR(50)  NOT NULL, UNIQUE
  email           VARCHAR(255) NOT NULL, UNIQUE
  passwort_hash   VARCHAR(255) NOT NULL   (BCrypt-Hash)

  Anzahl: 0 (leer, für Phase 2 vorbereitet)

  FREMDSCHLUESSEL:
  fragen.themen_id  -> themen.id   (FK: fk_fragen_themen)
  antworten.frage_id -> fragen.id  (FK: fk_antwort_fragen)

  KASKADIERUNG (in Hibernate konfiguriert):
  Thema löschen  -> alle Fragen des Themas werden gelöscht
  Frage löschen  -> alle Antworten der Frage werden gelöscht


================================================================================
  10. DATENIMPORT (CSV -> SQL)
================================================================================

  Die 270 Lernfragen wurden aus einer CSV-Datei importiert.
  Quelldatei: lernkarten_1-270.csv

  SCHRITT 1: Temporäre Importtabelle erstellen
  ----------------------------------------------
    CREATE TABLE csv_import_tmp (
        nummer INT,
        schwierigkeit VARCHAR(50),
        frage TEXT,
        antwort TEXT
    );

  SCHRITT 2: CSV-Daten einlesen
  ------------------------------
    LOAD DATA INFILE 'C:/Users/.../lernkarten_1-270.csv'
    INTO TABLE csv_import_tmp
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;

  SCHRITT 3: Daten in die echten Tabellen verteilen
  --------------------------------------------------
    -- Zuerst Fragen importieren:
    INSERT INTO fragen (text, schwierigkeit)
    SELECT DISTINCT frage, schwierigkeit FROM csv_import_tmp;

    -- Dann Antworten importieren (mit Verknüpfung zur Frage):
    INSERT INTO antworten (text, frage_id, ist_richtig)
    SELECT tmp.antwort, f.id, 1
    FROM csv_import_tmp tmp
    JOIN fragen f ON tmp.frage = f.text;

  SCHRITT 4: Themen zuweisen (UPDATE nach Import)
  -------------------------------------------------
    UPDATE fragen SET themen_id = 1;                        -- alle erstmal Thema 1
    UPDATE fragen SET themen_id = 2 WHERE id BETWEEN 27 AND 52;
    UPDATE fragen SET themen_id = 3 WHERE id BETWEEN 53 AND 136;
    UPDATE fragen SET themen_id = 4 WHERE id BETWEEN 137 AND 190;
    UPDATE fragen SET themen_id = 5 WHERE id BETWEEN 191 AND 198;
    UPDATE fragen SET themen_id = 6 WHERE id BETWEEN 199 AND 236;
    UPDATE fragen SET themen_id = 7 WHERE id BETWEEN 237 AND 270;

  SCHRITT 5: Fremdschlüssel aktivieren
  ---------------------------------------
    ALTER TABLE fragen
    ADD CONSTRAINT fk_fragen_themen
    FOREIGN KEY (themen_id) REFERENCES themen(id);

    ALTER TABLE antworten
    ADD CONSTRAINT fk_antwort_fragen
    FOREIGN KEY (frage_id) REFERENCES fragen(id);


================================================================================
  11. POWERSHELL-TESTSKRIPTE
================================================================================

  SPEICHERORT: .\requests\

  WICHTIG: Skripte im Projekt-Root ausführen (nicht im requests-Ordner!):
    cd C:\Users\rubik\Desktop\FI. Anwendungsentwicklung\Praktikum\LernApp_Projekt\LernApp
    .\requests\99-run-all.ps1

  SKRIPTE:
  ---------
  01-create-thema.ps1
    Legt alle 7 IHK-Themen an.
    Aufruf: .\requests\01-create-thema.ps1

  02-create-frage.ps1
    Erstellt eine Beispielfrage für ein Thema.
    Aufruf: .\requests\02-create-frage.ps1 -ThemaId 1

  03-create-antwort.ps1
    Erstellt zwei Antwortmöglichkeiten für eine Frage.
    Aufruf: .\requests\03-create-antwort.ps1 -FrageId 1

  04-get-thema.ps1
    Gibt ein Thema mit seiner ID aus.
    Aufruf: .\requests\04-get-thema.ps1 -ThemaId 1

  05-get-frage.ps1
    Gibt eine Frage mit allen Antworten aus.
    Aufruf: .\requests\05-get-frage.ps1 -FrageId 1

  99-run-all.ps1
    Führt alle Skripte nacheinander aus.
    Aufruf: .\requests\99-run-all.ps1

  SCHNELLTEST (direkt in PowerShell eingeben):
  ---------------------------------------------
    # Alle Themen anzeigen
    Invoke-RestMethod -Uri "http://localhost:8080/themen" | ConvertTo-Json

    # Fragen von Thema 1 anzeigen
    Invoke-RestMethod -Uri "http://localhost:8080/fragen?themaId=1" | ConvertTo-Json -Depth 3

    # Eine einzelne Frage anzeigen
    Invoke-RestMethod -Uri "http://localhost:8080/fragen/1" | ConvertTo-Json

    # Alle Antworten einer Frage anzeigen
    Invoke-RestMethod -Uri "http://localhost:8080/antworten" | ConvertTo-Json -Depth 3

  ENCODING-HINWEIS:
    Für Umlaute (ä, ö, ü) immer -ContentType "application/json; charset=utf-8" verwenden:
    Invoke-RestMethod -Uri "..." -Method Post -ContentType "application/json; charset=utf-8" -Body $json


================================================================================
  12. HAEUFIGE FEHLER UND LOESUNGEN
================================================================================

  FEHLER: "Port 8080 is already in use"
  LOESUNG: Entweder alten Prozess beenden oder server.port=8081 in
           application.properties setzen.

  FEHLER: HTTP 404 auf allen Endpoints
  LOESUNG: Prüfen ob @RequestMapping-Annotation im Controller stimmt.
           Prüfen ob App wirklich gestartet ist.
           Prüfen ob Pfad korrekt ist (/themen nicht /thema).

  FEHLER: "Access denied for user 'root'" beim Start
  LOESUNG: XAMPP MySQL-Service starten. Passwort in application.properties pruefen.

  FEHLER: "Unknown database 'lernappdb'"
  LOESUNG: Datenbank lernappdb in phpMyAdmin erstellen und lernappdb.sql importieren.

  FEHLER: JSON parse error: Invalid UTF-8
  LOESUNG: Im PowerShell-Skript -ContentType "application/json; charset=utf-8" verwenden.
           Keine Hashtabellen mit ConvertTo-Json ohne Encoding-Angabe verwenden.

  FEHLER: "Table 'lernappdb.antwort' doesn't exist"
  LOESUNG: Die Tabelle heißt "antworten" (mit n am Ende).
           In Antwort.java prüfen: @Table(name = "antworten")

  FEHLER: MethodArgumentNotValidException (HTTP 400)
  LOESUNG: Pflichtfelder im Request-Body prüfen.
           Bei FrageCreateRequest: text, schwierigkeit und themaId sind Pflicht.
           Bei AntwortCreateRequest: text und frageId sind Pflicht.


================================================================================
  13. GEPLANTE ERWEITERUNGEN (PHASE 2)
================================================================================

  QUIZ-MODUS:
    - Benutzer wählt ein Thema
    - Fragen werden zufällig ausgegeben
    - Benutzer gibt Antwort (frageId + antwortId)
    - System prüft ob Antwort korrekt ist
    - Punktestand wird berechnet

  NEUE ENDPOINTS (geplant):
    POST /quiz/start?themaId=X    -> Quiz starten, Fragen zurückgeben
    POST /quiz/antwort             -> Antwort einreichen, Ergebnis zurückbekommen
    GET  /quiz/ergebnis/{userId}   -> Gesamtpunktestand eines Benutzers

  NEUE ENTITAETEN (geplant):
    QuizSession  -> Verbindet Benutzer mit Quiz-Versuch
    QuizAntwort  -> Speichert welche Antwort der Benutzer gewählt hat

  SICHERHEIT (geplant):
    - JWT-Token-basierte Authentifizierung
    - Benutzer-Login per POST /auth/login
    - Geschützte Endpoints nur mit gültigem Token erreichbar


================================================================================
  DATEIUEBERSICHT DES PROJEKTS
================================================================================

  LernApp.zip              -> Kompletter Quellcode des Spring-Boot-Projekts
  lernappdb.sql            -> Datenbankdump (Struktur + 270 Fragen + Antworten)
  README.txt               -> Diese Datei

  DATENBANK-INHALT (lernappdb.sql):
    - 4 Tabellen (themen, fragen, antworten, benutzern)
    - 7 Themengebiete
    - 270 Prüfungsfragen (Fachinformatiker Anwendungsentwicklung)
    - 270 Antworten (je eine richtige Antwort pro Frage)
    - Fremdschlüssel und Indizes

================================================================================
  Erstellt: Juni 2026
  Projekt:  Fachinformatiker Anwendungsentwicklung – Praktikum
  Version:  1.0 (Phase 1 abgeschlossen)
================================================================================
