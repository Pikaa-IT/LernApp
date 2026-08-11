================================================================================
  LERNAPP BACKEND – README
  Spring Boot 4 REST API | Lernkarten für die IHK-Prüfungsvorbereitung
================================================================================

  1. Was ist das
  2. WICHTIG: Dieses Projekt ist zum Lernen kommentiert
  3. Technologie-Stack
  4. Setup und Start
  5. API-Endpunkte
  6. Aufbau des Codes
  7. Tests
  8. Häufige Fehler

  Eine ausführliche Dokumentation (Datenbank-Import, CSV-Verarbeitung,
  Projekthistorie) liegt eine Ebene höher: ..\README.txt


================================================================================
  1. WAS IST DAS
================================================================================

REST API zur Verwaltung von Lernkarten für die Prüfungsvorbereitung zum
Fachinformatiker Anwendungsentwicklung.

Vier Entitäten, jede mit vollständigem CRUD:

  Thema     Themengebiet nach IHK-Prüfungsstruktur
  Frage     gehört zu genau einem Thema
  Antwort   gehört zu genau einer Frage, mit Kennzeichen "ist richtig"
  Benutzer  Benutzerverwaltung mit BCrypt-Passwort-Hashing

Zum Projekt gehört zusätzlich ein Android-Client (..\LernAppFrontend,
Gradle, Retrofit + Gson), der diese API anspricht. Dieses README beschreibt
nur das Backend.


================================================================================
  2. WICHTIG: DIESES PROJEKT IST ZUM LERNEN KOMMENTIERT
================================================================================

DER CODE ENTHÄLT SEHR VIELE KOMMENTARE – DEUTLICH MEHR ALS ÜBLICH.

Das ist Absicht. Fast jede Annotation und jede Konfigurationszeile ist
erklärt: was sie macht, warum sie da steht und was ohne sie passieren würde.
In Produktivcode wäre das falsch – hier ist es der eigentliche Lernstoff.

Besonders lehrreich sind:

  pom.xml                        die Spring-Boot-4-Fallstricke, an denen
                                 dieses Projekt tatsächlich hängengeblieben
                                 ist (springdoc muss 3.x sein, Test-Slices
                                 sind eigene Starter, Jackson-2-Brücke)
  application.properties         Datenbankanbindung und ddl-auto
  exception/GlobalExceptionHandler.java   zentrale Fehlerbehandlung
  mapper/FrageMapper.java        wie ein Mapper Fremdschlüssel selbst auflöst
  mapper/BenutzerMapper.java     Passwort-Hashing mit BCrypt
  requests/*.ps1                 Zeile für Zeile kommentierte Testskripte


================================================================================
  3. TECHNOLOGIE-STACK
================================================================================

  Spring Boot 4.0.6, Java 21, Maven (Wrapper mvnw.cmd liegt bei)
  MariaDB über XAMPP, Hibernate/JPA, Jakarta Validation, Lombok
  Spring Security
  springdoc-openapi 3.0.0 für Swagger UI
  JUnit 5 für die Tests, PowerShell für manuelle API-Tests


================================================================================
  4. SETUP UND START
================================================================================

  1. XAMPP Control Panel -> MySQL starten
  2. http://localhost/phpmyadmin -> Datenbank "lernappdb" anlegen
     (Zeichensatz utf8mb4_general_ci) und ..\lernappdb.sql importieren
     -> 7 Themen, 270 Fragen, 270 Antworten
  3. Starten:

       .\mvnw.cmd spring-boot:run

     Oder in IntelliJ: LernAppApplication.java -> Run

  Die API läuft danach auf http://localhost:8080

  Nützliche Adressen im Browser:

    http://localhost:8080/themen           erste Prüfung, ob Daten kommen
    http://localhost:8080/swagger-ui.html  Endpunkte interaktiv ausprobieren
    http://localhost:8080/v3/api-docs      OpenAPI-Beschreibung als JSON
    http://localhost:8080/h2-console       H2-Konsole (nur bei H2-Betrieb)

  Zugangsdaten stehen in src/main/resources/application.properties:
  Benutzer root ohne Passwort – XAMPP-Standard, nur lokal vertretbar.
  Die Tabellen ergänzt Hibernate bei Bedarf selbst (ddl-auto=update),
  importierte Daten bleiben dabei erhalten.


================================================================================
  5. API-ENDPUNKTE
================================================================================

  Basis-URL: http://localhost:8080

  THEMEN
    GET     /themen                  alle Themen
    GET     /themen/{id}             ein Thema
    POST    /themen                  anlegen
    PUT     /themen/{id}             ändern
    DELETE  /themen/{id}             löschen (löscht auch dessen Fragen)

  FRAGEN
    GET     /fragen                  alle Fragen
    GET     /fragen?themaId=3        nur Fragen eines Themas
    GET     /fragen/{id}             eine Frage
    GET     /fragen/{id}/text        nur der Fragetext als JSON
    POST    /fragen                  anlegen
    PUT     /fragen/{id}             ändern
    DELETE  /fragen/{id}             löschen (löscht auch deren Antworten)

  ANTWORTEN
    GET     /antworten               alle Antworten
    GET     /antworten?frageId=12    nur Antworten einer Frage
    GET     /antworten/{id}          eine Antwort
    GET     /antworten/{id}/text     nur der Antworttext als JSON
    POST    /antworten               anlegen
    PUT     /antworten/{id}          ändern
    DELETE  /antworten/{id}          löschen

  BENUTZER
    GET     /benutzer                alle Benutzer
    GET     /benutzer/{id}           ein Benutzer
    POST    /benutzer                anlegen (Passwort wird BCrypt-gehasht)
    PUT     /benutzer/{id}           ändern
    DELETE  /benutzer/{id}           löschen

  Statuscodes: 200 lesen, 201 angelegt, 204 gelöscht,
               400 Validierungsfehler, 404 nicht gefunden, 500 intern.

  Fehler kommen immer im gleichen Format (ErrorResponse) zurück:
  timestamp, status, error, message, path – bei Validierungsfehlern
  zusätzlich fieldErrors mit Feldname und Meldung.


================================================================================
  6. AUFBAU DES CODES
================================================================================

  Klassische Spring-Boot-Schichtung, für alle vier Entitäten identisch:

    Controller  ->  Service  ->  Repository  ->  Entity (Datenbank)
                      <-  Mapper  ->  DTO

  Wichtigste Regeln in diesem Projekt:

  - Entitäten verlassen die API nie. Jede Entität hat drei DTOs
    (…CreateRequest, …UpdateRequest, …Response) und einen Mapper.
    Ein neues Feld muss also in Entity, DTOs UND Mapper ergänzt werden.
  - Die Mapper lösen Fremdschlüssel selbst auf: FrageMapper lädt das Thema
    über das ThemaRepository, AntwortMapper die Frage über FrageRepository.
  - Fehlerbehandlung ist zentral: pro Entität eine …NotFoundException,
    alle gefangen vom GlobalExceptionHandler.
  - Kaskadierung ist scharf: Thema löschen löscht dessen Fragen,
    Frage löschen deren Antworten.
  - Die Tabelle heißt "antworten" (Plural mit n) – häufige Fehlerquelle,
    siehe @Table in Antwort.java.

  Ordner unter src/main/java/com/example/LernApp/:
    controller/  service/  repository/  model/  dto/  mapper/  exception/
    dazu LernAppApplication.java, SecurityConfig.java, H2ConsoleConfig.java


================================================================================
  7. TESTS
================================================================================

  Automatisierte Tests:

    .\mvnw.cmd test                          alle Tests
    .\mvnw.cmd test -Dtest=FrageMapperTest   eine Testklasse

  Stand: 14 Tests, alle grün.
    ThemaMapperTest 3, FrageMapperTest 3, AntwortMapperTest 3,
    BenutzerMapperTest 4 (reine Unit-Tests, ohne Datenbank),
    LernAppApplicationTests 1 (prüft nur, ob der Kontext hochfährt).

  ACHTUNG: LernAppApplicationTests ist mit @SpringBootTest annotiert, aber
  ohne @ActiveProfiles("test") – der Test verbindet sich deshalb mit der
  echten MariaDB. Für "mvnw.cmd test" muss XAMPP also laufen, obwohl mit
  application-test.properties eine H2-Konfiguration bereitliegt. Wer die
  Suite unabhängig von XAMPP haben will, ergänzt dort @ActiveProfiles("test").
  FrageCreateRequestTest enthält aktuell keine aktiven Testmethoden.

  Manuelle API-Tests mit PowerShell (Anwendung muss laufen),
  aufgerufen vom Projekt-Root aus:

    .\requests\99-run-all.ps1          Happy Path: anlegen, lesen,
                                       ändern, löschen
    .\requests\98-run-error-tests.ps1  Fehlerfälle: leere, zu lange und
                                       ungültige Eingaben, 404
    .\requests\01-create-thema.ps1     einzelne Schritte, ebenso
    .\requests\02-create-frage.ps1     02, 03, 04, 05 …
    .\requests\03-create-antwort.ps1

  Bei Umlauten im Request zwingend den Zeichensatz mitgeben:
    -ContentType "application/json; charset=utf-8"


================================================================================
  8. HÄUFIGE FEHLER
================================================================================

  "Could not create connection to database" / Connection refused
      XAMPP bzw. MySQL läuft nicht -> im Control Panel starten.

  "Unknown database 'lernappdb'"
      Datenbank fehlt -> in phpMyAdmin anlegen und lernappdb.sql importieren.

  "Table 'antwort' doesn't exist"
      Die Tabelle heißt "antworten" mit n. Siehe @Table in Antwort.java.

  "Port 8080 was already in use"
      Alte Instanz läuft noch -> beenden, oder server.port=8081 setzen.

  Umlaute kommen als "?" in der Datenbank an
      -ContentType "application/json; charset=utf-8" verwenden.

  Anwendung stürzt beim Start ab, sobald springdoc dabei ist
      springdoc 2.x ist mit Spring Boot 4 unverträglich -> Version 3.0.0
      verwenden (steht schon so in der pom.xml).

  Compile-Fehler "Package org.springframework.boot.data.jpa.test
  .autoconfigure ist nicht vorhanden"
      Seit Spring Boot 4 sind die Test-Slices eigene Starter:
      spring-boot-starter-data-jpa-test und spring-boot-starter-webmvc-test.
      Beide stehen bereits in der pom.xml.
