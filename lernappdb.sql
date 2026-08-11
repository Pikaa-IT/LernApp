-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 10. Jun 2026 um 20:54
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `lernappdb`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `antworten`
--

CREATE TABLE `antworten` (
  `id` bigint(20) NOT NULL,
  `ist_richtig` bit(1) NOT NULL,
  `text` text NOT NULL,
  `frage_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `antworten`
--

INSERT INTO `antworten` (`id`, `ist_richtig`, `text`, `frage_id`) VALUES
(1, b'1', 'Einmaligkeit: wird nur einmal ausgeführt; Klares Ziel: bestimmtes Ergebnis wird verfolgt; Zeitliche Befristung: festgelegter Start- und Endzeitpunkt; Interdisziplinär: Zusammenarbeit mit verschiedenen Fachbereichen; Risikobehaftet: verbunden mit Unsicherheiten und Risiken; Rahmenbedingungen: begrenzte Ressourcen (Geld, Personal, Zeit), klare Abgrenzungen zu anderen Projekten', 1),
(2, b'1', 'Netzplan, Gantt-Diagramm, Projektstrukturplan', 2),
(3, b'1', 'Der Netzplan hilft bei der Terminplanung von Projekten und stellt die Dauer von Vorgängen grafisch dar. Zeitliche Anordnung und logische Abhängigkeiten werden mit Rechtecken dargestellt, alle Vorgänge als Pfad mit Pfeilen verbunden. Kritische Pfade, Pufferzeiten und Gesamtpufferzeiten sind gekennzeichnet.', 3),
(4, b'1', 'Stellt alle Aktivitäten eines Projekts mit einer horizontalen Zeitachse dar. Aktivitäten werden als waagerechte Balken dargestellt – Länge zeigt Dauer, Beginn und Ende. Überschneidungen = überlappende Balken. Kritischer Pfad visualisierbar. Abhängigkeiten per Pfeile. Vorteil: übersichtlich bei kleinen/mittleren Projekten. Nachteil: unübersichtlich bei vielen Aktivitäten.', 4),
(5, b'1', 'Weg vom Ganzen zum Detail: Gesamtprojekt wird in Teilaufgaben zerlegt. Schritte: Benennung des Gesamtprojekts → Zerlegung in Arbeitspakete/Teilaufgaben → Benennung der Teilaufgaben → weitere Zerlegung bis Arbeitspakete vorliegen. Wird gewählt wenn Erfahrungen mit ähnlichen Projekten vorliegen.', 5),
(6, b'1', 'Weg vom Detail zum Ganzen: Detaillierte Teilprobleme werden gelöst, um damit größere Probleme zu lösen. Einsatz bei sehr innovativen Lösungen. Punkte: Festlegung der Aufgaben, Klärung der Beziehungen in der Baumstruktur, Errichtung einer Baumstruktur, Überprüfung auf Vollständigkeit und Einmaligkeit aller Teilaufgaben.', 6),
(7, b'1', 'Gliedert ein Projekt in: 1. Projektdefinition, 2. Projektplanung, 3. Projektdurchführung und Controlling, 4. Projektabschluss. Als Alternative existiert das 5-Phasen-Modell, bei dem die 1. Phase die Initiierung des Projekts darstellt.', 7),
(8, b'1', 'Der Weg von Anfang bis Ende aller Aktivitäten, auf dem die Summe aller Pufferzeiten minimal oder Null wird. Die Gesamtprojektdauer wird durch den kritischen Pfad bestimmt. Einzelne Aktivitäten können im Rahmen ihrer Pufferzeit verschoben werden, ohne die Gesamtprojektdauer zu gefährden. Merke: Beim kritischen Pfad ist der Gesamtpuffer = Null.', 8),
(9, b'1', 'FAZ = frühester Anfangszeitpunkt (oben links); FEZ = frühester Endzeitpunkt (oben rechts); SAZ = spätester Anfangszeitpunkt (unten links); SEZ = spätester Endzeitpunkt (unten rechts); Dauer (innen links); GP = Gesamtpuffer (innen mitte); FP = freier Puffer (innen rechts)', 9),
(10, b'1', 'Forming: Orientierungsphase – Kennenlernen, Rollen und Ziele noch unklar. Storming: Nahkampfphase – Ziele klarer, Rollenverteilung bildet sich, erste Machtkämpfe, Projektleiter als Schlichter und Antreiber. Norming: Organisationsphase – klare Strukturen und Regeln, Aufgaben werden übertragen, Erfolge sichtbar gemacht. Performing: Hochleistungsphase – Selbstorganisation, Team arbeitet effizient und eigenständig.', 10),
(11, b'1', 'Laut DIN-69901-5: Das Kick-Off-Meeting findet nach erfolgter Projektplanung und vor dem Start der eigentlichen Durchführung statt. Mindestens alle Mitglieder des Projektteams nehmen teil. Auftraggeber und weitere Stakeholder können einbezogen werden.', 11),
(12, b'1', 'Form der Projektplanung mit Zielen: grobe Terminplanung für das Gesamtprojekt, essenzielle Ereignisse (Meilensteine) transparent machen, Übersicht über Verzögerungen und Auswirkungen, Leistungsfortschrittsorientierung zur Bewertung des Projektverlaufs, Schaffen von Zwischenzielen zur Motivation der Mitarbeitenden.', 12),
(13, b'1', 'Klassische Modelle: Wasserfallmodell, V-Modell, Spiralmodell. Agile Modelle: Scrum, Kanban, Inkrementelles Vorgehensmodell, Extreme Programming.', 13),
(14, b'1', 'Der kritische Pfad ist der Pfad ohne Gesamtpufferzeiten. Im Beispiel: Vorgang A → Vorgang C → Vorgang E → Vorgang F (alle mit GP = 0). Vorgang B und D haben Pufferzeit (GP > 0) und liegen nicht auf dem kritischen Pfad.', 14),
(15, b'1', 'Vorteile: Abfolge der Projektschritte klar erkenntlich, einfache Nachverfolgung, einfache Planung und Kontrolle, leichte Einarbeitung für neue Teammitglieder. Nachteile: keine Iterationsschritte möglich, bei großen Projekten schwierig alles zu Beginn festzulegen, unflexibel bei sich ändernden Anforderungen, Risiko bei unklaren Anforderungen.', 15),
(16, b'1', 'Risikoanalyse ist Bestandteil des Risikomanagements. Bestandteile: Risikobeurteilung, Risikokommunikation, Risikoklassifizierung, Risikoprävention. Anwendungsbereiche: IT-Systeme und IT-Dienstleistungen, Großveranstaltungen, Produktentwicklung, Pharmaindustrie, Arbeitsschutz.', 16),
(17, b'1', 'Stakeholder gehören zu internen und externen Anspruchsgruppen, die gewisse Ziele und Interessen vertreten. Der Begriff stammt aus dem Englischen (Teilhaber/Anspruchsberechtigter). Umfasst alle, die ein Interesse am Verlauf oder Ergebnis eines Prozesses, Projektes oder Investments haben – z. B. auch Kunden oder Mitarbeitende.', 17),
(18, b'1', 'Vertraulichkeit: Daten nur für befugte Personen zugänglich. Integrität: Daten/Systeme sind korrekt, unverändert und verlässlich. Verfügbarkeit: Erreichbarkeit aller Systeme und Verhinderung von Systemausfällen der IuK-Systeme.', 18),
(19, b'1', 'Gewinn = Erlös – Kosten. Erlöse = alle Einnahmen durch Verkauf von Waren und Dienstleistungen. Kosten = variable und fixe Kosten wie Rohstoffkosten, Mietkosten, Personalkosten.', 19),
(20, b'1', 'Erweiterte Machbarkeitsprüfung mit technisch-wissenschaftlichen Analysen, Tests/Simulationen und Expertenhinzuziehung. Wird durchgeführt wenn Misserfolg wahrscheinlich oder Risiken unkalkulierbar sind. Wesentliche Punkte: organisatorische Umsetzung, wirtschaftliche Machbarkeit, technische Machbarkeit, Ressourcen und Verfügbarkeit, zeitliche Umsetzung, rechtliche Umsetzung.', 20),
(21, b'1', 'Ist das Projekt technisch machbar? Ist die organisatorische Umsetzung möglich? Ist es rechtlich umsetzbar (Lizenzkosten und Patente)? Wie sieht es mit der Wirtschaftlichkeit aus (Budget, Finanzierung)? Sind genug Ressourcen vorhanden (Material, Menschen, Maschinen, Zeit)? Ist es zeitlich umsetzbar? Dazu gehören auch Pilottests, Computersimulationen und Expertenmeinungen.', 21),
(22, b'1', 'Deckungsbeitrag = Erlös – variable Kosten. Ist eine Teilkostenberechnung und zeigt den Betrag, der zur Deckung der Fixkosten zur Verfügung steht.', 22),
(23, b'1', 'Belehrungen, Killerphrasen (z. B. \"Das können nur wir!\"), Erzeugen von Druck, Termindruck auf Kunden ausüben, Konkurrenz diskreditieren.', 23),
(24, b'1', 'Ticketing-System (auch: User-Helpdesk-System, Support-Ticketing-System, Service-Ticket-System, Task-Tracking-System, Request-Tracking-System/RTS). Funktionen: Empfang, Bestätigung, Klassifizierung, Bearbeitung und Pflege von Kundenanfragen als Tickets/Cases.', 24),
(25, b'1', 'Alle Bearbeiter können auf Service- und Fehlerhistorie zurückgreifen; dient der Weiterentwicklung von Produkten/Service; Kategorisierung in Level ermöglicht bessere Koordination von Expertengruppen; Wissensdatenbank unterstützt Fehleranalyse und Lösung; Online-Ticketsysteme ermöglichen gezieltes Sammeln und Auswerten von Kundenerfahrungen.', 25),
(26, b'1', 'Netzwerkmanagement, Cybersicherheit, Predictive Maintenance, Datenanalysen, Intelligente Suche bei Problemlösungen, Automatisierung von Prozessen.', 26),
(27, b'1', 'Die volkswirtschaftliche Produktion wird nach der Drei-Sektoren-Hypothese in 3 Sektoren unterteilt. 1. Sektor (Primärsektor): Land- und Forstwirtschaft, Fischerei, Bergbau. 2. Sektor (Sekundärsektor): Industrie und verarbeitendes Gewerbe/Handwerk. 3. Sektor (Tertiärsektor): alle Dienstleistungen von Unternehmen und öffentlichen Einrichtungen. Zusätzlich gibt es den Quartärsektor (Informationssektor).', 27),
(28, b'1', 'Ein Monopol ist eine Marktform in der Marktwirtschaft, bei welcher nur ein Anbieter vielen Nachfragern gegenübersteht (Angebotsmonopol) oder nur ein Nachfrager vielen Anbietern (Nachfragemonopol). Der Monopolist hat eine marktbeherrschende Stellung und kann Angebot und Preis weitgehend bestimmen. Sonderform: zweiseitiges Monopol (genau ein Anbieter und ein Nachfrager).', 28),
(29, b'1', 'Ein Angebotsoligopol ist eine Marktform in der Marktwirtschaft, die durch wenige Anbieter auf der einen Seite und viele Nachfrager auf der anderen Seite gekennzeichnet ist. Beispiele: Energiemarkt, Mobilfunkmarkt.', 29),
(30, b'1', 'IT-Benchmarking (auch Betriebsvergleich) ist eine strategische IT-Management-Methode, bei der die Performance der IT-Dienstleistungen eines Unternehmens mit denen eines anderen Unternehmens verglichen wird. Durch Vergleich von Angeboten, Verträgen, Dienstleistungen und Preisen lässt sich die Qualität der Dienstleister ermitteln. Da es keine standardisierten Verfahren gibt, müssen allgemeine Funktionen und Kostenarten (z. B. Support-Kosten, Personalkosten) verglichen werden.', 30),
(31, b'1', 'Das Marktgleichgewicht herrscht, wenn die angebotene Menge und die nachgefragte Menge nach Gütern übereinstimmen. Durch den Gleichgewichtspreis und die entsprechende Gleichgewichtsmenge kommt der größtmögliche Umsatz im Markt zustande.', 31),
(32, b'1', 'Als Käufermarkt wird eine Marktsituation beschrieben, in der sich die Käuferseite in der besseren Position gegenüber der Verkäuferseite befindet. Typisch ist ein Angebotsüberhang (Überangebot), der entsteht wenn das Angebot die Nachfrage deutlich übersteigt. Folge: sinkende Preise und sinkende Umsätze für Verkäufer.', 32),
(33, b'1', 'Zu den betrieblichen Grundfunktionen zählen: Beschaffung (Einkauf von Roh-, Hilfs- und Betriebsstoffen sowie Fertigerzeugnissen), Produktion (Herstellen von materiellen und immateriellen Gütern/Waren und/oder Dienstleistungen), Absatz/Vertrieb (Verkauf der produzierten Güter am Markt), Finanzierung (alle Prozesse der finanziellen Versorgung, Steuerung und Kontrolle zwischen Kapitalbeschaffung und Kapitalverwendung).', 33),
(34, b'1', 'Merkmale einer SE: eigene Rechtspersönlichkeit; Kapitalgesellschaft; Mindestkapital 120.000 Euro; Haftung jedes Aktionärs nur bis zur Höhe des gezeichneten Kapitals; Geschäftsführung entweder im monistischen oder im dualistischen System.', 34),
(35, b'1', 'Das Polypol gilt als die bestmögliche Marktform der Marktwirtschaft, da hier von einem vollkommenen Markt die Rede ist. Es gibt regen Wettbewerb: viele Anbieter und viele Nachfrager stehen sich gegenüber und treten miteinander in Konkurrenz.', 35),
(36, b'1', 'Die Personengesellschaft ist ein Zusammenschluss mindestens zweier Personen zur Erreichung eines gemeinsamen Unternehmensziels. Personengesellschaften: GbR (Gesellschaft bürgerlichen Rechts). Personenhandelsgesellschaften: oHG (Offene Handelsgesellschaft, auch GmbH & Co. oHG), KG (Kommanditgesellschaft, auch GmbH & Co. KG).', 36),
(37, b'1', 'Eine OHG kann gegründet werden, wenn sich mindestens zwei oder mehr Personen zum Zweck eines vollkaufmännischen Handelsgewerbes im Sinne von § 1 Abs. 1 HGB zusammenschließen. Alle Gesellschafter haften persönlich, unbegrenzt und unbeschränkt für alle Verbindlichkeiten der Gesellschaft.', 37),
(38, b'1', 'Möglichkeiten zur positiven Beeinflussung des Betriebsergebnisses: Wareneinkauf optimieren (Rabatte aushandeln); Herstellungskosten senken (günstige Vorprodukte); Verwaltungskosten minimieren (Softwareeinsatz); Werbekosten reduzieren (Social Media); Personalkosten reduzieren (Produktivitätssteigerung); Fixkosten mindern (z. B. Fahrzeug-Leasing statt Kauf).', 38),
(39, b'1', 'Durch Kundenbefragungen können zentrale Punkte beantwortet werden wie: Kundenzufriedenheit, Trends, Image des Unternehmens, Marktposition, Kundenbindung sowie der Erfolg von Werbemaßnahmen.', 39),
(40, b'1', 'Geschlossene Fragen: Ja-oder-Nein-Fragen, z. B. \'Haben Sie den PC schon einmal neu gestartet?\' Offene Fragen: W-Fragen (Wer, Wie, Was, Wieso, Warum, Wo, Weshalb, Wann...), z. B. \'Welche Fehlermeldung wurde Ihnen beim Programmabbruch angezeigt?\'', 40),
(41, b'1', 'Die ABC-Analyse ist ein betriebswirtschaftliches Analyseverfahren, das Prozesse oder Objekte in Klassen A, B und C einstuft (absteigend nach Bedeutung). Klasse A: Kunden/Objekte mit dem größten Umsatzbeitrag; Klasse B: durchschnittlicher Umsatzbeitrag; Klasse C: geringster Umsatzbeitrag. Ergebnis: Ranking ähnlich dem Pareto-Prinzip (80/20-Regel).', 41),
(42, b'1', 'Als Cross-Selling (Querverkauf) wird im Marketing das Bemühen eines Händlers bezeichnet, zusätzlich zu einem nachgefragten oder angebotenen Artikel weitere passende Produkte oder Services anzubieten. Ziel: höherer Umsatz sowie gesteigerte Kundenbindung und Kundenzufriedenheit.', 42),
(43, b'1', 'Appell: 1. Sie müssen pünktlich liefern! Beziehung: 2. Ich bin mit Ihnen nicht zufrieden. Sachebene: 3. Sie haben nicht pünktlich geliefert. Selbstoffenbarung: 4. Ich kontrolliere Ihre Leistungen sehr genau.', 43),
(44, b'1', 'Allgemeine Regeln im telefonischen Support: Vermeide Worte und Ausdrücke, die den Kunden reizen könnten; Höre dem Gesprächspartner aktiv zu; Lass Kunden immer ausreden und unterbrich sie nicht; Widersprich nie bei einem Einwand oder einer Beschwerde; Hinterfrage mit den W-Fragen (wann, wie, wo, warum ...).', 44),
(45, b'1', 'Unter Pre-Sales-Angebot versteht man alle Dienstleistungen, die dem potenziellen Kunden im Rahmen der Geschäftsanbahnung oder beim Vertragsabschluss angeboten werden. Dieser Service ist in der Regel unentgeltlich und dient der Kunden- und Auftragsgewinnung. Beispiele: kostenlose Probefahrt beim Fahrzeugkauf; kostenlose Informationsveranstaltungen; kostenlose Kataloge oder Probeprodukte.', 45),
(46, b'1', 'Vorteile: keine Reisekosten; individuell kurzfristig planbar; viele Teilnehmer erreichbar; Trainingsumgebung optimal anpassbar; können aufgezeichnet werden. Nachteile: setzt funktionierende Technik und Internetverbindung voraus; praxisbezogene Übungen nicht immer möglich; Stimmung der Teilnehmer schwer erfassbar; keine gemeinsamen Aktivitäten (Pausen, Essen); hohe Zeitverschiebung kann zu ungünstigen Webinarzeiten führen.', 46),
(47, b'1', 'Layer 7 – Anwendungsschicht: Application Layer; Layer 6 – Darstellungsschicht: Presentation Layer; Layer 5 – Sitzungsschicht: Session Layer; Layer 4 – Transportschicht: Transport Layer; Layer 3 – Vermittlungsschicht: Network Layer; Layer 2 – Sicherungsschicht: Data Link Layer; Layer 1 – Bitübertragungsschicht: Physical Layer.', 47),
(48, b'1', 'Die Nutzwertanalyse ist eine Entscheidungshilfe bei komplexen Handlungsalternativen. Mittels eines Punktwertverfahrens, Punktbewertungsverfahrens oder Scoring-Modells werden Bewertungskriterien erstellt und mehrere Produkte oder Services verglichen. Der Bewertungsmaßstab kann individuell festgelegt werden, z. B. als 4-Punkte-Skala: 1 = gering, 2 = mittel, 3 = hoch, 4 = sehr hoch.', 48),
(49, b'1', 'Beim direkten Vertrieb bietet der Anbieter Produkte/Dienstleistungen unmittelbar an Endabnehmer an. Vorteile: höhere Gewinnspanne (keine Händlerprovisionen); kurze Kommunikations- und Vertriebswege; eigene Mitarbeitende können schnell neue Produkte anbieten; engere Kundenbindung. Nachteile: eigenes Vertriebsnetz bindet viel Kapital; personalintensiv, hohe Fixkosten; Massendistribution nur bedingt umsetzbar. Gegensatz: indirekter Vertrieb (Unternehmen → Zwischenhändler → Kunde).', 49),
(50, b'1', 'Kundenzufriedenheit erhöht Kundenbindung und Umsatz. Maßnahmen: Gewährung von Rabatten (im Rahmen von Aktionen); Teilnahme an Sonderaktionen (Lotterie); Einladung zu Hausmessen oder Festen; Feedback einholen durch Umfragen; Social Media und Bewertungsportale einrichten; Qualitätsversprechen unbedingt einhalten; Verbesserung der Customer Experience.', 50),
(51, b'1', 'Der Angebotsvergleich bildet die wesentliche Grundlage für eine Kaufentscheidung. Man vergleicht mindestens 2 oder mehr Angebote verschiedener Lieferanten/Dienstleister. Verglichene Kriterien: niedrigster Preis, Qualität, Finanzierungsangebote, Kundenservice, Garantie und Gewährleistung, Rabattangebote, Lieferservice, Liefertreue, Lieferzeit, Liefermenge.', 51),
(52, b'1', 'Vor der Außerbetriebnahme ist zu beachten: rechtzeitige Ankündigung an Personal oder Kunden; Bereitstellung von Alternativ- und Backupsystemen; Datenarchivierung unter Beachtung des Datenschutzes (Aufbewahrungsfristen); mögliche Migration der Kundendaten auf neues IT-System; Schulung des Personals/Kunden bei Neuerungen; Validierung der migrierten Daten vor Abschaltung; fachgerechte Vernichtung und Entsorgung der Datenträger durch zertifiziertes Unternehmen (z. B. DoD 5220.22-M-Standard); fachgerechte Entsorgung oder Wiederaufbereitung der IT-Hardware.', 52),
(53, b'1', 'Hypervisor Typ 1 (native/bare-metal): setzt direkt auf der Hardware des Hostsystems auf, keine vorherige Betriebssystem-Installation notwendig. Hypervisor Typ 2 (hosted): benötigt ein lauffähiges vollwertiges Betriebssystem, um auf Gerätetreiber bzw. Hardware zuzugreifen. Bei beiden gilt: Hardware/BIOS/UEFI muss Virtualisierung unterstützen (Intel: intel-VT, AMD: AMD-V).', 53),
(54, b'1', 'Eine Dockingstation wird verwendet, um mobile Geräte (Notebooks, PDAs) mit einem festen Netz zu verbinden. Sie dient als Portreplikator (vorhandene Ports werden durchgereicht) und stellt zusätzliche Schnittstellen bereit, die am mobilen Gerät fehlen: PS/2, Seriell-/Parallelport, DVI, DisplayPort, HDMI, Sound, Firewire. Moderne Dockingstationen unterstützen häufig 2x HDMI, 2x DVI oder 2x DisplayPort.', 54),
(55, b'1', 'Nicht geeignet: HDMI 1.4 (max. 10,2 GBit/s, max. Full-HD). Geeignet für 4K: HDMI 2.0 (18,0 GBit/s). Geeignet für 8K: HDMI 2.1 (38,4 GBit/s), DisplayPort 1.3 (25,9 GBit/s), DisplayPort 1.4 (32,4 GBit/s).', 55),
(56, b'1', 'Ein Notebook hat: teilweise Anschluss für Dockingstation, teilweise Mini-PCI-Express Slot, teilweise 4-in-1 Kartenlesegerät, teilweise integriertes Bluetooth/WLAN/WWAN, eigenes Display, externe Schnittstellen (USB, HDMI, DisplayPort/mini DisplayPort, VGA, Firewire), integrierte Lautsprecher und Mikrofone, teilweise Videokamera, Akku, externes Netzteil, interne Netzwerkkarte.', 56),
(57, b'1', 'Als logische Prozessoren werden virtuelle Prozessoren bezeichnet, die durch Technologien wie Hyper-Threading (HTT) oder Simultaneous Multithreading (SMT) unterstützt werden. Eine CPU kann mehrere logische Prozessoren haben, die parallele Operationen ausführen, um CPU-Auslastung zu verbessern und Leistungsfähigkeit zu steigern. Anwendungen müssen Multithreading unterstützen, um die Vorteile nutzen zu können.', 57),
(58, b'1', 'Mithilfe der Dual-Channel-Technik kann der Speichercontroller des Prozessors Daten auf zwei Arbeitsspeichermodule gleichzeitig aufteilen und parallel schreiben und lesen – dadurch verdoppelt sich die Datenrate. Voraussetzung: Die eingebauten Speichermodule müssen baugleich sein, identische Modulkapazität besitzen und paarweise verteilt werden.', 58),
(59, b'1', 'UHD (Ultra High Definition) 4K bezeichnet ein digitales Videoformat der International Telecommunication Union (ITU) für UHDTV. UHD 4K (auch UHD-1) lehnt sich an Cinema 4K (4096x2160 Pixel) an. Hersteller spezifizieren ihre Geräte häufig mit 3840x2160 Pixeln als UHD 4K.', 59),
(60, b'1', 'Ein Thin-Client ist ein Computer, der über ein Netzwerk Ressourcen nutzt, die ihm ein Server bereitstellt. In der virtuellen Desktop-Infrastruktur (VDI) werden Thin-Clients (auch Zero-Clients) eingesetzt: lüfterlose Geräte mit USB, Netzwerkanschluss, Audio- und Displayanschlüssen. Benutzeroberfläche, Konfiguration, Verzeichniszugriffe und Programme werden vom Server bereitgestellt. Thin-Clients sind umwelt- und ressourcenschonend mit geringer Leistungsaufnahme.', 60),
(61, b'1', 'Eingabegeräte: b) Scanner, c) Maus, e) Touchpad. Ausgabegeräte: a) Drucker, d) Display.', 61),
(62, b'1', 'Folgende Schnittstellen sind zu sehen: DisplayPort, DVI, VGA, USB-Typ B und 2x USB Typ A.', 62),
(63, b'1', 'Vorteile von USB-C: reversible Steckrichtung; höhere Leistungsfähigkeit; kompaktes Design; schnellere Ladezeiten; bidirektionale Stromversorgung; Zukunftssicherheit.', 63),
(64, b'1', 'Public Cloud: Zugang zu IT-Infrastrukturen für die breite Öffentlichkeit via Internet. Private Cloud: ausschließlich für eine Organisation/ein Unternehmen. Hybrid Cloud: Kombination aus Public und Private Cloud. Community Cloud: wie Public Cloud, aber nur für bestimmte Nutzergruppen (Behörden, Universitäten, etc.). Mischformen: Virtual Private Cloud (private Cloud auf öffentlicher Infrastruktur), Multi Cloud (bündelt verschiedene Cloud-Dienste).', 64),
(65, b'1', 'Green-IT umfasst alle Bestrebungen, die Nutzung von IuK-Technik über den gesamten Lebenszyklus hinweg umwelt- und ressourcenschonend zu gestalten. Aspekte: Optimierung des Ressourcenverbrauchs bei Herstellung, Betrieb und Entsorgung; Ressourceneinsparung durch Virtualisierung; Einsatz von Videokonferenzen (weniger Dienstreisen); Einsatz von Stromsparmodi.', 65),
(66, b'1', 'Infrastructure as a Service (IaaS), auch Foundation genannt, ist im Wesentlichen ein Ersatz für traditionelle Rechenzentren. Der Benutzer greift auf bestehende Dienste innerhalb seiner Cloud zu, verwaltet aber seine eigenen Recheninstanzen selbst.', 66),
(67, b'1', 'Vorteile von PaaS: reduzierter Programmieraufwand durch Entwicklungstools; zusätzliche Entwicklungsmöglichkeiten ohne neue Mitarbeitende; einfachere Entwicklung für mehrere Plattformen (Computer, Mobile, Browser); kostengünstige Nutzung der Tools; effiziente Verwaltung des Anwendungslebenszyklus.', 67),
(68, b'1', 'Software as a Service (SaaS) beschreibt ein Cloud-Konzept, bei dem Software nicht als Lizenz verkauft, sondern als Service in der Cloud bereitgestellt wird. Der Zugriff erfolgt bei vielen Cloudanbietern via Webbrowser.', 68),
(69, b'1', 'Als Host-Bus-Adapter (HBA) bezeichnet man eine Netzwerkhardware, die in einem Server installiert ist, um damit ein oder mehrere Datenspeichergeräte (Storage) zu erreichen. Der Begriff wird oft mit SCSI, ATA (IDE), SATA und Fibre Channel verwendet. Im Datenspeicher-Umfeld kommuniziert der HBA via SCSI, iSCSI, Fibre Channel oder Ethernet mit dem Host-System.', 69),
(70, b'1', 'Klasse 1: VFI (Voltage and Frequency Independent) – schützt vor Stromausfall, Unter-/Überspannung, Frequenzschwankungen und Oberschwingungen. Klasse 2: VI (Voltage Independent) – schützt vor Stromausfall, Unter- und Überspannung. Klasse 3: VFD (Voltage and Frequency Dependent) – schützt vor Stromausfall, jedoch mit Verzögerung von bis zu 10 ms.', 70),
(71, b'1', 'Eine USV soll die elektrische Versorgung systemrelevanter IT-Komponenten 24/7 sicherstellen sowie Störungen im Stromnetz überbrücken. Je nach Klassifizierung schützt sie vor: komplettem Stromausfall, Unterspannung, Überspannung, Frequenzabweichung und Oberschwingungen.', 71),
(72, b'1', 'Ein DBMS übernimmt: Speicherung, Veränderung und Löschung von Daten; Verwaltung der Metadaten; Gewährleistung von Datensicherheit und Datenschutz; Sicherstellung der Datenintegrität; Mehrbenutzerbetrieb durch Transaktionskonzept; Optimierung von Abfragen; Triggern und Stored Procedures; Bereitstellung von Informationen über Technik und Betrieb.', 72),
(73, b'1', 'Eine DMZ (Demilitarisierte Zone) trennt durch ein Subnetz mit Hilfe von Firewall-Routern das interne Netzwerk vom externen Netzwerk ab. Der gesamte Datenverkehr unterliegt Firewall-Regeln. In der DMZ befinden sich normalerweise Mail-, Datei-, Proxy- und Webserver. Es gibt die einstufige und zweistufige DMZ.', 73),
(74, b'1', 'Ein Router (Netzwerkrouter) ist ein Netzwerkgerät auf OSI-Schicht 3 (Vermittlungsschicht/Network Layer), das Netzwerkpakete zwischen mehreren Netzwerken weiterleitet. Er wird zur sicheren Kopplung mehrerer Standorte über VPN oder zur direkten Verbindung lokaler Netzwerksegmente eingesetzt. Router können unterschiedliche Netzwerktechniken (Ethernet, DSL, PPPoE, ISDN etc.) miteinander verbinden.', 74),
(75, b'1', 'Schicht 1 – Bitübertragungsschicht (Physical Layer): stellt physische Verbindungen her, überträgt Datenbits; Hardware: Verstärker, Hub, Netzwerkkabel. Schicht 2 – Sicherungsschicht (Data Link Layer): zuverlässige fehlerfreie Übertragung, Aufteilung in Frames mit Prüfsummen; Hardware: Switches, Access Points, Bridges. Schicht 3 – Vermittlungsschicht (Network Layer): netzwerkübergreifende Adressen (IPv4/IPv6), Routing, Routingtabellen, Fragmentierung. Schicht 4 – Transportschicht (Transport Layer): fehlerfreie Übertragung, Datensegmentierung, Datenkapselung, Adressierung via UDP/TCP-Port.', 75),
(76, b'1', 'Layer 7 Anwendung / Layer 6 Darstellung / Layer 5 Sitzung: DNS, DHCP, IMAPS, SMTPS, HTTPS – Komponente: Switch Layer 4-7 (Content-Switch). Layer 4 Transport: TCP, UDP. Layer 3 Vermittlung: IP, ICMP – Komponente: Router, Switch Layer 3. Layer 2 Sicherung: IEEE 802.3 – Komponente: Switch. Layer 1 Bitübertragung: 1000BASE-T – Komponente: Netzwerkkabel, Hub.', 76),
(77, b'1', 'Der Begriff Broadcast-Domäne bezeichnet ein Netzwerk aus Geräten auf OSI-Schicht 2. Innerhalb einer Broadcast-Domäne gibt es eine oder mehrere Kollisionsdomänen. Sie ist über Hubs, Switches oder Bridges verbunden und erreicht alle Teilnehmer mit der Ethernet-Broadcast-Adresse ff:ff:ff:ff:ff:ff. Zur Unterteilung kommen VLANs, Subnetze oder Router (Schicht 3) zum Einsatz.', 77),
(78, b'1', 'NAS (netzgebundener Speicher) ist ein einfach zu verwaltender Dateiserver mit eigenem Dateisystem (Ext4/Btrfs) und Managementoberfläche (via Webbrowser HTTP/HTTPS). Einsatz im Heimbereich und bei KMUs. Verwaltung von Benutzern, Active Directory-Integration, Services, Sync-Funktionen und Protokollzugriffen (iSCSI, CIFS/SMB/NFS). Ein NAS hat einen oder mehrere Netzwerkanschlüsse (Ethernet/Fibre Channel) und existiert in verschiedenen Bauformen.', 78),
(79, b'1', 'Ein SAN bietet blockbasierten Speicher über logische Festplatteneinheiten (LUNs) an und besitzt kein eigenes Dateisystem. Mehrfachzugriffe verschiedener Server sind möglich (z. B. VMFS). Implementierungen: SCSI, Fibre-Channel, ATA over Ethernet, InfiniBand. Die Festplattensubsysteme bieten über RAID-Level (1, 5, 6, 10, 50, 60) und proprietäre Lösungen Datenredundanz.', 79),
(80, b'1', '8 Subnetze = 2³. Subnetzmaske: 255.255.255.224 (/27). Nutzbare Host-IP-Adressen: 240 (8 Subnetze × 30 Hosts = 240; je Subnetz 32 Adressen minus Netz-ID und Broadcast = 30).', 80),
(81, b'1', 'Power over Ethernet (PoE) ist ein IEEE-standardisiertes Verfahren, mit dem Netzwerkgeräte über das Ethernet-Kabel mit Strom versorgt werden können. Standards: IEEE 802.3af (PoE), 802.3at (PoE+), 802.3bt (4PPoE), 802.3bu (PoDL). Typische PoE-Verbraucher: IP-Telefonie, Wireless Access Points (WAP), IP-Kameras, Zeiterfassungsterminals.', 81),
(82, b'1', 'Eine iSCSI-Verbindung zwischen Target und Initiator benötigt jeweils einen iSCSI Qualified Name (IQN). Format: iqn.yyyy-mm.naming-authority:unique. Dabei ist iqn = iSCSI Qualified Name, yyyy-mm = Jahr und Monat der Erstellung der Naming Authority, naming-authority:unique = eindeutiger Name (z. B. Hostname). Beispiel: iqn.2005-01.com.microsoft.iscsi:name1', 82),
(83, b'1', 'Beim Fibre Channel hat jedes Gerät einen weltweit eindeutigen WWNN (World Wide Node Name / WWN) sowie jeder Port einen WWPN (World Wide Port Name). Es handelt sich um einen 64-Bit-Wert (hexadezimal), der jedes FC-Gerät eindeutig identifiziert – das Äquivalent zur MAC-Adresse bei Ethernet. Beispiel: 20:00:05:45:E4:67:A3:88', 83),
(84, b'1', 'Unicast wird verwendet, wenn eine direkte Punkt-zu-Punkt-Verbindung zwischen Sender und Empfänger hergestellt werden soll. Der Sender kommuniziert gezielt mit nur einer IP-Adresse des Empfängers im Netzwerk.', 84),
(85, b'1', 'Wenn der Sender zu einer definierten Empfängergruppe zeitgleich Daten überträgt, spricht man von Multicast. Wie viele Empfänger die Daten empfangen, ist dabei irrelevant. In IPv6 werden MAC-Adressen mithilfe von Multicast aufgelöst.', 85),
(86, b'1', 'Das Broadcast-Prinzip ist bekannt aus Fernseh- und Rundfunkübertragung. Datenpakete werden vom Sender ungefragt an alle Empfänger gesendet.', 86),
(87, b'1', 'Mit einer Broadcast-Adresse werden alle Netzwerkgeräte eines lokalen Netzwerkes erreicht, ohne sie dediziert anzugeben. Broadcasts sind auf das eigene lokale Netzwerk beschränkt und werden nicht über Router weitergeleitet. Die Broadcast-IP-Adresse ist immer die letzte IP-Adresse des Subnetzes.', 87),
(88, b'1', 'Eine IPv6-Adresse ist binär 128 Bit lang und besteht aus zwei Teilen: Network Prefix (Netzwerk Präfix, 64 Bit) und Network Interface (Netzwerk Schnittstelle, 64 Bit). Darstellung erfolgt hexadezimal in jeweils 16-Bit-Gruppen, durch Doppelpunkte getrennt. Beispiel: 2003:00dc:075a:dd00:e130:c353:3188:afb6', 88),
(89, b'1', 'Gekürzte Schreibweise: 2003:dc:75a:dd00:e130:c353:3188:afb6 (führende Nullen in jeder Gruppe weglassen). Der 64-bit Interface-Anteil lautet: e130:c353:3188:afb6.', 89),
(90, b'1', '::1/128 = Loopback-Adresse (entspricht 127.0.0.1 bei IPv4). fe80::/10 = Link-Local-Adresse (nur im lokalen Netzwerksegment gültig). 2000::/3 = Global Unicast-Adresse (öffentlich routbarer Adressbereich). ff00::/8 = Multicast-Adresse.', 90),
(91, b'1', 'SLAAC (Stateless Address Autoconfiguration) ist das IPv6-Äquivalent zu APIPA bei IPv4. Zustandslos bedeutet: jeder IPv6-Stack bekommt per Autokonfiguration automatisch eine link-lokale IPv6-Adresse zugewiesen. Die link-lokale Adresse beginnt immer mit FE80:.', 91),
(92, b'1', 'Singlemode: Faserkern-Durchmesser 9 µm, Mantelglas 125 µm. Multimode: Faserkern 50 µm bzw. 62,5 µm, Mantelglas 125 µm. Reichweite: Multimode bis 2.000 m, Singlemode bis 10.000 m.', 92),
(93, b'1', 'Vorteile: geringe Signaldämpfung; kaum Laufzeitverschiebungen; große Distanzen überbrückbar; hohe Bandbreiten. Nachteile: teurere Laser zur Einspeisung; größerer Herstellungsaufwand wegen kleiner Faserkerne; hohe Präzision beim Verbinden (Stecker/Spleißen) notwendig.', 93),
(94, b'1', 'Vorteile: geringerer Herstellungsaufwand; einfachere Verbindungstechnik dank größerem Kerndurchmesser; Fasern mit Stufenindex- und Gradientenindexprofil verfügbar. Nachteile: größere Signaldämpfung und Laufzeitverschiebung; geringere maximale Bandbreiten; nur kürzere Distanzen überbrückbar; Verstärker bei größeren Distanzen notwendig.', 94),
(95, b'1', 'SNMP ist ein von der IETF entwickeltes Netzwerkprotokoll, mit dem Netzwerkelemente (Router, Server, Switches, Drucker, Sensoren etc.) über eine zentrale Management Konsole überwacht und gesteuert werden können. SNMP-Agenten kommunizieren über SNMP-Traps oder GET-REQUEST über Port 161/UDP bzw. Port 162/UDP (Trap). Aktuelle Version: SNMPv3.', 95),
(96, b'1', 'DHCP ermöglicht Netzwerkgeräten ohne manuelle Konfiguration eine automatische Netzwerkkonfiguration. Ablauf: DHCPDISCOVER (Client-Broadcast) → DHCPOFFER (Server-Antwort) → DHCPREQUEST (Client fordert IP an) → DHCPACK. Vergabe: statisch, automatisch oder dynamisch, über UDP-Ports 67/68. DHCP kann liefern: IP-Adresse/Maske, Default-Gateway, DNS-Server, NTP-Server, WINS-Server, Proxy-Konfiguration (WPAD), PXE-Boot-Optionen u. v. m.', 96),
(97, b'1', 'DHCP stellt bereit: IP-Adresse (eindeutige Netzwerkidentifikation), Subnetzmaske, Standard-Gateway (Router-IP für externe Netzwerke), DNS-Server (für Namensauflösung), Lease-Time (Gültigkeitsdauer der IP). Weitere Optionen: Zeitserver (NTP), TFTP-Server (für PXE-Boot), Domain-Name.', 97),
(98, b'1', 'UDP (User Datagram Protocol): Headergröße 8 Byte, hohe Geschwindigkeit, keine Paketverlusterkennung, keine Ende-zu-Ende-Kontrolle, keine Fehlerbehebung, keine Duplikaterkennung, keine Flusskontrolle, keine Zeitüberwachung. TCP (Transmission Control Protocol): Headergröße 20 Byte, geringere Geschwindigkeit, Paketverlusterkennung ja, Ende-zu-Ende-Kontrolle ja, Fehlerbehebung ja, Duplikaterkennung ja, Flusskontrolle ja, Zeitüberwachung ja.', 98),
(99, b'1', 'Erlaubt: 2. 2001:db8:f3c:d7:7dab:3d0:0:ff (führende Nullen je Gruppe weglassen) und 3. 2001:db8:f3c:d7:7dab:3d0::ff (eine aufeinanderfolgende Gruppe aus Nullen als :: abkürzen). Nicht erlaubt: 1. 2001:db8:f3c:d7:7dab:3d:0:ff (03d0 falsch auf 3d gekürzt) und 4. 2001:0db8:0f3c:00d7:7dab:03d::00ff (führende Nullen nicht vollständig entfernt).', 99),
(100, b'1', 'Quality of Service (QoS) bezeichnet die Güte/Qualität eines Dienstes über IP-Netzwerke. Echtzeitanwendungen (Video-/Sprachkommunikation) leiden unter Latenz, Jitter und Paketverlust. QoS-Maßnahmen: Priorisierung des Datenverkehrs, Datenratenreservierung, Datenratenlimitierung, Paketoptimierung. Das Type of Service (ToS)-Feld im IPv4-Header (1 Byte) ermöglicht die Priorisierung von IP-Datenpaketen.', 100),
(101, b'1', 'Das tagged VLAN kommt zum Einsatz, wenn sich VLANs über mehrere Switches hinweg erstrecken (z. B. über Trunk Ports). Ethernet-Frames werden mit einer Markierung (Tag/Etikett) versehen, die die VLAN-Zugehörigkeit kennzeichnet. VLAN-fähige Switches werten diese Tags aus.', 101),
(102, b'1', 'Das Client-Server-Modell beschreibt die Verteilung von Aufgaben/Services innerhalb eines Netzwerks. Merkmale: Server stellen Dienste bereit (Webservices, Datei-, Mailingservices); Clients fragen Dienste bei Servern an; Protokolle regeln Kommunikation und Informationsaustausch; ein Server bedient einen oder mehrere Clients; Server-/Clientfunktionen sind nicht an physische Hardware gebunden; physische/virtuelle Server können gleichzeitig Client- und Serveraufgaben ausführen.', 102),
(103, b'1', 'DNS stellt einen der wichtigsten Dienste in IP-basierten Netzwerken dar und beantwortet Anfragen zur Namensauflösung: angefragte Namen werden in IP-Adressen übersetzt. In Windows-Domänen übernimmt DNS zusätzlich den Reverse Lookup (IP-Adresse → Name) über PTR Ressource Records in der Reverse Lookup Zone des Active Directory.', 103),
(104, b'1', 'SMTPS (Simple Mail Transfer Protocol Secure): Postausgang, SMTP über SSL/TLS, Port 465. IMAPS (Internet Message Access Protocol Secure): Posteingang, SSL/TLS, Port 993; Mails, Ordnerstrukturen und Einstellungen werden auf dem Server gespeichert und lokal synchronisiert. POP3/S (Post Office Protocol Secure): Posteingang, SSL/TLS, Port 995; Mails werden heruntergeladen und anschließend bei Bedarf gelöscht.', 104),
(105, b'1', 'Switch: arbeitet auf OSI-Schicht 2 (Layer-2-Switch), verarbeitet Ethernet Frames nach IEEE 802.3, MAC-adressbasiert, hat in der Regel bis zu 48/50 physikalische Ports. Router: arbeitet auf OSI-Schicht 3, routet Netzwerke, verarbeitet Routing-Protokolle wie OSPF, RIP, IS-IS und BGP.', 105),
(106, b'1', 'Die Offline-USV (USV-Klasse 3) schützt generell nur gegen Stromausfälle und kurzzeitige Spannungsschwankungen. Unter- und Überspannungen können nicht ausgeglichen werden. Umschaltdauer vom Netz- auf Batteriebetrieb: 4–10 Millisekunden; Störungen unterhalb dieser Zeit werden nicht erkannt.', 106),
(107, b'1', 'Die Online-USV (USV-Klasse 1) ist die teuerste Variante, bietet aber den umfassendsten Schutz durch permanente Erzeugung einer Sinusspannung. Alle Verbraucher werden dauerhaft mit Netzspannung versorgt, während zeitgleich die Batterie aufgeladen wird. Bei Netzausfall erfolgt ein unterbrechungsfreier Übergang auf Batteriebetrieb. Eingangsspannung kann zwischen 160 V und 290 V schwanken, Ausgangssspannung nahezu sinusförmig, frei von Störspannungen und Frequenzstörungen.', 107),
(108, b'1', 'Netzinteraktive USVs (USV-Klasse 2) funktionieren ähnlich wie Standby-USVs, schützen jedoch zusätzlich vor kurzzeitigen Spannungsspitzen und können durch Filter Spannungsschwankungen ausgleichen. Umschaltzeit vom Netz- auf Batteriebetrieb: 2–4 ms; vom Batterie- auf Netzbetrieb nahezu verzögerungsfrei.', 108),
(109, b'1', 'Die SSID ist laut IEEE 802.11 der frei wählbare Name eines drahtlosen Funknetzwerks (Netzwerkname). Darf bis zu 32 Byte ASCII-Zeichen lang sein (Groß-/Kleinschreibung beachten). Stellt auch eine Art Broadcastdomäne für Funknetze dar. Multi-SSID kann mehrere Broadcastdomänen verwalten.', 109),
(110, b'1', 'CMS (Content Management System): Verwaltung, Konfiguration und redaktionelle Bearbeitung von Inhalten (z. B. für Webseiten). ERP (Enterprise Resource Planning System): umfangreiches Werkzeug zur Ressourcenplanung aller Unternehmensprozesse (Produktion, Materialwirtschaft, Vertrieb). CRM (Customer Relationship Management System): Werkzeug zur Planung, Steuerung und Durchführung aller interaktiven Prozesse mit Kunden.', 110),
(111, b'1', 'Maßnahmen: Austausch von SATA-HDDs mit geringer Drehzahl gegen HDDs mit 10K/rpm; Einsatz von SSD/M.2 statt SATA-HDDs; Aufteilung von OS und Anwendungen auf unterschiedliche Datenträger (OS auf M.2, Daten auf SSD); Austausch der 100-Mbit/s-Netzwerkkarte gegen 1-Gbit/s-Netzwerkkarte.', 111),
(112, b'1', 'Vorteile: Lesegeschwindigkeiten bis zu 7.450 MB/s; kleines kompaktes Design ohne zusätzlichen Platz; keine Verkabelung, direkt auf Motherboard; NVMe-Unterstützung. Nachteile: teurer als SATA-SSDs; nicht alle Motherboards unterstützen M.2; kann bei intensiver Nutzung heiß werden; geringere maximale Speicherkapazitäten als SATA-SSDs.', 112),
(113, b'1', 'Vorteile: kostengünstiger als M.2-SSDs; Standard-SATA-Anschlüsse auf den meisten Mainboards vorhanden; breit einsetzbar (24/7 und Notebook-Bereich). Nachteile: geringere Geschwindigkeit gegenüber NVMe-SSDs; begrenzte Bandbreite durch max. SATA-Datenübertragungsrate; ungeeignet für High-End-Anwendungen wie Foto-/Videobearbeitung.', 113),
(114, b'1', 'Der CPU-Cache ist ein zusätzlicher Zwischenspeicher auf dem Prozessor, der Zugriffszeiten auf Daten verkürzt. Es gibt drei Level: L1-Cache (First-Level): schnellster und kleinster. L2-Cache (Second-Level): etwas langsamer, aber größer. L3-Cache (Third-Level): langsamster, aber größter. Alle drei Cache-Level entlasten den Arbeitsspeicher und ermöglichen der CPU schnellen Zugriff auf Daten und Befehle.', 114),
(115, b'1', 'Die Wärmeleitpaste sorgt für effiziente Wärmeableitung von der CPU zum Kühler. Da die Kontaktflächen nicht überall einen perfekten Übergang haben, gleicht die Paste Unebenheiten aus. Dadurch verhindert sie Leistungseinbußen, Systemabstürze oder dauerhafte Schäden. Auftrag: als Wärmepad oder erbsengroßer Klecks.', 115),
(116, b'1', '10 Server × 800 W = 8.000 W = 8,0 kW; 25 PCs × 350 W = 8.750 W = 8,75 kW; 2 Switches × 200 W = 400 W = 0,4 kW; Gesamt: 17,15 kW. Jahresenergie: 17,15 kW × 8.760 h = 150.234 kWh.', 116),
(117, b'1', 'Die elektrische Wirkleistung P ergibt sich als Produkt von Spannung U und Stromstärke I: P = U × I. Einheit: Watt. Die Leistungsangaben gelten für die Dauer von 60 Minuten (1 Stunde).', 117),
(118, b'1', 'Formel: P = U × I = 230 V × 16 A = 3.680 W (3,68 kW). Eine 16-A-Mehrfachsteckdose ist für maximal 3.680 Watt ausgelegt.', 118),
(119, b'1', 'Vor Zusatzbelastung: 20 × 12V × 4,5 Ah / 1.200 VA = 0,9 h = 54 min. Nach Zusatzbelastung: 20 × 12V × 4,5 Ah / 1.600 VA = 0,675 h ≈ 40 min. Zeitdifferenz: 54 min − 40 min = 14 Minuten.', 119),
(120, b'1', 'Maßnahmen: Einsatz von Repeatern (Verstärkern); Sendeleistung durch größere Funkantennen erhöhen; Standort des WLAN Access Points verändern; anderen WLAN-Standard wählen; weitere WLAN Access Points installieren; Abstrahlcharakteristik der Antennen ändern.', 120),
(121, b'1', 'Im Infrastructure Modus können Clients über den WLAN Access Point ein weiteres Netzwerk erreichen (z. B. Unternehmensnetzwerk). Clients melden sich mit Zugangsdaten und MAC-Adresse an. Authentifizierungsmöglichkeiten: WPA2, WPA3, RADIUS, WPS.', 121),
(122, b'1', 'MIMO (Multiple Input Multiple Output) ist ein Verfahren der drahtlosen Übertragung, bei dem mehrere Sende- und Empfangsantennen parallel eingesetzt werden (z. B. MIMO 2×2, 3×3, 4×4). Durch den MIMO-Signalalgorithmus wird ein optimales Signal-Rausch-Verhältnis erreicht, was den Datendurchsatz erhöht.', 122),
(123, b'1', 'Arbeitsstationen: 25 × 300 W × 9 h × 206 d = 13.905 kWh. Drucker: 3 × 200 W × 24 h × 365 d = 5.256 kWh. Server: 2 × 500 W × 8.750 h = 8.750 kWh. Gesamt: 27.911 kWh × 0,30 € = 8.373,30 €.', 123),
(124, b'1', 'Multi-SSID (Multi Service Set Identifier) ermöglicht es WLAN Access Points, mehrere virtuelle voneinander getrennte WLAN-Bereiche anzubieten. Einsatzgebiete: Schulungsbereiche oder KMUs, die sich einen Access Point teilen. Die WLAN-Bereiche sind durch verschiedene Netzwerksegmente und Zugangsmöglichkeiten voneinander getrennt.', 124),
(125, b'1', '2,4 GHz: Vorteile: weit verbreiteter Funkstandard, bis zu 13 Kanäle (DE), größere Ausbreitung (bis 300 m im Freien/in Gebäuden). Nachteile: veraltet, max. Geschwindigkeit bis 600 Mbit/s (MIMO), Frequenz wird mit anderen Geräten geteilt, Channel Overlapping (nur 3 störungsfreie Kanäle). 5 GHz: Vorteile: deutlich höhere Übertragungsraten, kein Channel Overlapping, höhere Reichweite möglich (802.11h bis 1000 mW in DE). Nachteile: Funksignal stärker durch Gebäude eingeschränkt, Beschränkungen durch TPC und DFS, Ad-hoc-Modus oft nicht unterstützt.', 125),
(126, b'1', 'Links: DDR3-SDRAM (für Desktop-Computer), rechts: SO-DIMM (für Notebooks). DDR3-SDRAM und DDR4-SDRAM werden in Desktops, SO-DIMM-Module in Notebooks eingesetzt.', 126),
(127, b'1', 'Auf dem Bild ist eine NVMe (Nonvolatile Memory Express) SSD im M.2-Formfaktor zu erkennen. Lesegeschwindigkeiten bis zu 7.450 MB/s und Schreibgeschwindigkeiten bis zu 6.900 MB/s, da sie direkt mit dem PCIe-Bus (PCI Express) verbunden wird.', 127),
(128, b'1', 'Die größere Karte ist eine SD-Karte (Secure Digital), die kleinere ist eine microSD-Karte. MicroSD-Karten werden häufig in Smartphones und Kameras eingesetzt und können mit einem Adapter in SD-Kartensteckplätze eingesetzt werden.', 128),
(129, b'1', 'Auf dem Bild ist eine SATA-Schnittstelle (Serial AT Attachment / SerialATA) zu sehen. SATA III kann bis zu 6 Gbit/s Bruttotransferrate übertragen. Die Schnittstelle besteht aus 2 Teilen: dem 15-poligen Stromstecker und der 7-poligen Datenleitung.', 129),
(130, b'1', 'Reichweite nach Klassen: Klasse 1: 100 mW, ~200 m; Klasse 2: 2,5 mW, ~20 m; Klasse 3: 1 mW, ~10 m. Datentransferraten: Basic Rate und Enhanced Data Rate (2–3 Mbit/s). Frequenzbereich: ISM-Band 2,402–2,480 GHz (lizenzfrei). Unterscheidung: Bluetooth Classic (Version 1.x–3.0) und Bluetooth Low Energy (Version 4.x/5).', 130),
(131, b'1', 'Vorteile: Stromersparnis; Skalierbarkeit; redundante Systeme (Ausfallsicherheit); schnellere Server-Provisionierung; kaum Kapazitätsbeschränkungen; kostengünstige Angebote; keine Investitionskosten bei Cloudanbietern (pay-as-you-go); Lebensverlängerung alter Software. Nachteile: nicht jede Lösung ist für 24/7 kostengünstig; eventuell höhere Latenzzeiten; Hardware/Software nicht zu 100% selbst administrierbar; Individuallösungen nicht immer möglich; nicht in allen Regionen verfügbar.', 131),
(132, b'1', 'Serverkonsolidierung ist eine Form der Konsolidierung von Serverressourcen durch Virtualisierung. Mit virtuellen Maschinen (VM) oder Virtual Environments (VE) soll durch Reduktion physikalischer Serversysteme Energie und Raum gespart werden. Beispiel: 10 physische Server werden durch einen leistungsstarken Server ersetzt und die 10 Server virtualisiert.', 132),
(133, b'1', 'Geschäftsanforderungen: aus Geschäftstätigkeit und Marktanforderungen, festgelegt durch Management und Marketing. Benutzeranforderungen: für Benutzer des Softwaresystems, definiert durch Geschäftsanalysten, Benutzer/Vertreter und Produktmanager. Funktionale Anforderungen: beschreiben das Verhalten der Software, definiert durch Geschäftsanalysten und Produktmanager in Absprache mit Softwareentwicklung und Testabteilung. Projektanforderungen: sichern den Projekterfolg und ermöglichen die Umsetzung aller Anforderungen im Rahmen des Application Lifecycle Managements (ALM).', 133),
(134, b'1', 'Zu berücksichtigende Kosten: Kauf/Miete für Gebäude/Raum; Anschaffungskosten (IT-Hardware, Software, Kühlung); Miet-/Leasinggebühren (Hardware/Software); Lizenzgebühren (Betriebssystem/Anwendersoftware); Energiekosten (Hardware/Kühlung/Sicherheitstechnik); Wartung/Instandhaltung; Brandschutz; Sicherheitstechnik; Versicherungen.', 134),
(135, b'1', 'Leasing: 36 × 3.500 € + 30.000 € = 126.000 € + 30.000 € = 156.000 €. Kauf: 100.000 € + 30.000 € = 130.000 €. Pay-per-use: 3,22 €/h × 24 h × 365 d × 3 Jahre = 3,22 € × 26.280 h = 84.621,60 €. Günstigste Variante: Pay-per-use (Rang 1), gefolgt von Kauf (Rang 2) und Leasing (Rang 3).', 135),
(136, b'1', 'Handelskalkulation: Listeneinkaufspreis − Lieferer-Rabatt = Zieleinkaufspreis − Lieferer-Skonto = Bareinkaufspreis + Bezugskosten = Bezugspreis + Handlungskosten = Selbstkosten + Gewinn = Barverkaufspreis + Kundenskonto = Zielverkaufspreis + Kundenrabatt = Listenverkaufspreis. Zuschlagskalkulation (Vorkalkulation): Materialeinzelkosten + Materialgemeinkosten + Lohneinzelkosten + Lohngemeinkosten = Herstellkosten + Verwaltungsgemeinkosten + Vertriebsgemeinkosten = Selbstkosten.', 136),
(137, b'1', 'Unter Bedarfsanalyse versteht man eine Analyseart zur Feststellung des Bedarfs an Waren, Dienstleistungen, Gütern oder Personal für eine bestimmte Region/Land, Personengruppen oder einen bestimmten Zeitraum. Zweck: zukünftige Beschaffungsprozesse oder Projekte besser zu planen.', 137),
(138, b'1', 'Vorteile: Der Vertrieb kann Wünsche, Motive und Ziele des Kunden ermitteln; Entscheider und Kundentypen können ermittelt werden; Vertrauen des Kunden wird gestärkt; individuelle Lösungen können angeboten werden; das Unternehmen hebt sich von der Konkurrenz ab; Umsatz kann gesteigert werden; langfristige Kundenbindung wird unterstützt.', 138),
(139, b'1', 'UEFI (Unified Extensible Firmware Interface): kann von Laufwerken mit mehr als 2,2 TB booten; grafische Benutzeroberfläche mit Mausbedienung; unterstützt 64-Bit-Prozessoren nativ; Treiber als Modul nachladen; nutzt GPT-Partitionierungsschema; kann von VM-Container starten. BIOS (Basic Input Output System): keine Mausbedienung; kann nur vom Master-Boot-Record starten; kann nur von Laufwerken bis 2 TB booten.', 139),
(140, b'1', 'Eine Remote Desktop Verbindung stellt über das proprietäre Microsoft-Netzwerkprotokoll RDP einen Fernzugriff auf entfernte Computer her. Kommunikation über TCP/UDP-Port 3389. Es werden grafische Bildschirminhalte angezeigt sowie lokale Ressourcen genutzt (Tastatur, Maus, Audio, Dateisystem, Laufwerke, Drucker, Zwischenablage). RDP wird auch für den Microsoft Windows Remote Desktop Service (früher: Terminal Services) genutzt.', 140),
(141, b'1', 'Zur Überprüfung der Namensauflösung dient das Werkzeug nslookup. Damit lassen sich DNS-Anfragen manuell stellen und die Antworten des DNS-Servers überprüfen (z. B. nslookup www.google.de). Weitere nützliche Tools: ping (Erreichbarkeit prüfen), ipconfig /all (DNS-Serverkonfiguration anzeigen).', 141),
(142, b'1', 'Konfiguration Netzwerkadapter: ipconfig, netsh. MAC-Adresse (IPv4) auslesen: arp, getmac, ipconfig. Firewall-Regel hinzufügen: netsh. Erreichbarkeit prüfen: nslookup, ping. Status Netzwerkverbindung: ping, ipconfig. IPv4/IPv6 ermitteln: ipconfig, netsh. DHCP-Anzeige: ipconfig, netsh. Hostname anzeigen: nslookup. IPv6-MAC-Adressen im Segment: netsh.', 142),
(143, b'1', '1. Sicherer Start: UEFI+TPM-Konfiguration lässt nur vertrauenswürdige Startladeprogramme zu. 2. Vertrauenswürdiger Start: Windows prüft Integrität jeder Komponente vor dem Laden in den Arbeitsspeicher. 3. Antischadsoftware-Frühstart (ELAM – Early Launch Antimalware): Alle Treiber werden vor dem Laden getestet, nicht zertifizierte Treiber werden blockiert. 4. Kontrollierter Start: Firmware protokolliert den Startvorgang, Windows kann die Informationen an einen vertrauenswürdigen Server zur Integritätsprüfung senden.', 143),
(144, b'1', 'Partitionierung: physische und logische Einteilung des Speichermediums in Volumes, die zusammenhängende Datenblöcke logisch zusammenfassen. Formatierung: logische Einteilung der Partitionsstruktur mit einem Dateisystem (z. B. NTFS, Ext4, Btrfs) durch das Betriebssystem oder eine entsprechende Software.', 144),
(145, b'1', 'Asset-Tags/Service-Tags identifizieren Geräte mit einer eindeutigen Seriennummer oder einem Bar-/QR-Code. In der Regel Etiketten mit selbstklebender Rückseite. Verwendungszweck: Bestandskontrolle, Inventarisierung und Nachverfolgung von Hardware.', 145),
(146, b'1', 'Vorteile: geringerer Stromverbrauch; geräuschloser Arbeitsplatzcomputer; geringer Platzbedarf; leicht austauschbar; flexibel einsetzbar (kein OS-Install notwendig); geringes Gewicht; umweltfreundlich (weniger Material und Abwärme); dank Read-only-Betriebssystem keine Angriffsfläche für Viren, Würmer und Trojaner.', 146),
(147, b'1', 'Im Projektmanagement beschreibt das Pflichtenheft detailliert, wie der Auftragnehmer die Anforderungen des Auftraggebers umsetzen möchte (\'Wie und Womit\'). Der Inhalt ist für beide Parteien rechtlich bindend. Mit der Umsetzung wird erst begonnen, wenn der Auftraggeber das Pflichtenheft akzeptiert hat. In agilen Entwicklungsmodellen können weitere Änderungen einfließen.', 147),
(148, b'1', 'Beim Pay-per-use Lizenzmodell bezahlt man nur für tatsächlich genutzte Dienstleistungen. Vorteile: keine Kapitalbindung; individuelle Leistungen skalierbar; kein finanzielles Risiko. Nachteile: für 24/7-Einsatz nicht immer die kostengünstigste Variante; Risiko bei Ausfall der Dienstleistung (Service nicht selbst betrieben); keine Spezialdienstleistungen oder sehr teuer.', 148),
(149, b'1', 'Das Lastenheft (Anforderungs- oder Kundenspezifikation) beschreibt die Gesamtheit der Anforderungen und Spezifikationen des Auftraggebers an Lieferungen und Leistungen des Auftragnehmers. Es enthält funktionale und nicht-funktionale Anforderungen (Gesetze/Vorschriften) und dient als Basis für Ausschreibung und Vertragsgestaltung. Angaben wie Lieferzeit, Lieferumfang und Kosten sind enthalten. Das akzeptierte Lastenheft ist für beide Parteien rechtlich bindend.', 149),
(150, b'1', 'Ein Convertible (auch Hybrid-PC, Two-in-One oder Detachable) ist ein Notebook mit einem Klapp-, Dreh-, Schiebe- oder Klickmechanismus, das in zwei Modi betrieben werden kann: als Notebook (Tastatur und Touchpad) oder als Tablet (Touchscreen, Digitizer oder Eingabestift). Convertibles sind besonders auf Mobilität ausgelegt.', 150);
INSERT INTO `antworten` (`id`, `ist_richtig`, `text`, `frage_id`) VALUES
(151, b'1', 'Vorteile: leichte Handhabung; lange Akkulaufzeit; Touchbedienung oder mit Stift; WLAN/WWAN-Verbindung; platzsparend; geringes Gewicht. Nachteile: Schreiben auf virtueller Tastatur mit der Zeit anstrengend; geringere Speicherkapazität als Notebooks; wenige Anschluss- und Verbindungsmöglichkeiten; in der Regel nicht aufrüstbar.', 151),
(152, b'1', 'Vorteile: netzunabhängiges Arbeiten durch Akku; Netzwerkzugriff über WWAN/WLAN; integrierte Tastatur und Touchpad; bei stationärer Nutzung wenig Stellfläche; geringerer Stromverbrauch als Desktop-PC; arbeitet leiser; durch Dockingstation erweiterbar. Nachteile: hohes Gewicht gegenüber Tablet; proprietäres Netzteil; geringe Festplatten-Speicherkapazitäten; technische Aufrüstung oft umständlich oder nicht möglich; Display oft kleiner als beim Desktop; oft kein separater Ziffernblock.', 152),
(153, b'1', 'DisplayPort: genormte, universelle und lizenzfreie digitale Verbindungsschnittstelle für Bild- und Tonübertragung. Es gibt den klassischen DisplayPort-Steckverbinder und den Mini-DisplayPort-Steckverbinder.', 153),
(154, b'1', 'Anforderungen: redundantes Netzteil; redundanter Netzwerkzugriff; redundantes Plattensystem (RAID-Verbund); granulares Dateiberechtigungssystem; kollaboratives Arbeiten ohne Versionskonflikte; Ordner-Freigaben (SMB/NFS); geringe Netzwerklatenz; geringe Zugriffszeiten; Backup oder Snapshots; Fernzugriff via WebDAV oder (S)FTP; dynamische Speicherplatzanpassung.', 154),
(155, b'1', 'ADSL (Asymmetric Digital Subscriber Line): am meisten genutzte Technik; Download-Geschwindigkeit höher als Upload. VDSL (Very High Speed Digital Subscriber Line): aktuell angebotene Technik; ebenfalls asymmetrisch (Download > Upload), aber höhere Geschwindigkeiten als ADSL. SDSL (Symmetric Digital Subscriber Line): Upload- und Downloadgeschwindigkeit gleich hoch; wird verwendet wenn Echtzeitübertragung nötig ist (Videoübertragung, VoIP).', 155),
(156, b'1', 'Rechenweg: 2 GiB × 1.024 = 2.048 MiB × 1.024 = 2.097.152 KiB × 1.024 = 2.147.483.648 Byte × 8 = 17.179.869.184 Bit. 17.179.869.184 Bit / 50.000.000 Bit/s = 343,6 Sekunden. Ergebnis: ca. 5 Minuten und 44 Sekunden.', 156),
(157, b'1', 'Kriterien: Langlebigkeit (mind. 5 Jahre Herstellersupport); Skalierbarkeit auf Basis vorhandener Hardware; kostengünstiger Support; geringer Stromverbrauch und geringe Abwärme; umweltfreundliches Produkt; Remote Management; leicht austauschbar; schnelle Ersatzbeschaffung.', 157),
(158, b'1', 'Standardsoftware ist Software, die auf dem freien Markt angeboten wird. Im Gegensatz zu Individualsoftware ist sie vorgefertigt und muss vom Anwender selbst installiert bzw. individuell angepasst werden. Standardsoftware kann On-Premise und als Software as a Service (SaaS) angeboten werden.', 158),
(159, b'1', 'Individualsoftware ist Software, die bestimmte Hardware- oder individuelle Geschäftsanforderungen erfüllen muss – also für einen bestimmten Anwender und/oder einen spezialisierten Verwendungszweck angefertigt wurde.', 159),
(160, b'1', 'Eine IDE (Integrierte Entwicklungsumgebung / integrated development environment) ist eine Sammlung der wichtigsten Werkzeuge zur Softwareentwicklung unter einer einheitlichen Oberfläche. Wichtige Werkzeuge: Compiler, Debugger, Interpreter, Editor mit Syntaxhervorhebung, Linker, GUI-Builder, Versionsverwaltung u. v. m.', 160),
(161, b'1', 'Unter proprietärer Software versteht man Software, deren Nutzung durch Dritte, Veränderung und Weitergabe aus patent- oder lizenzrechtlichen Gründen eingeschränkt oder verboten ist. Sie enthält teilweise nicht-öffentliche Standards oder nicht dokumentierte Schnittstellen, sodass eine Anpassung ohne Quellcode-Offenlegung schwer möglich ist. Beispiele: Microsoft Windows, Adobe-Produkte.', 161),
(162, b'1', '1. Quelltext liegt in für Menschen lesbarer und verständlicher Form vor. 2. Open Source Software darf beliebig kopiert, verbreitet und genutzt werden. 3. Open Source Software darf verändert und in der veränderten Form weitergegeben werden.', 162),
(163, b'1', 'OEM (Original Equipment Manufacturer) = Originalausrüstungshersteller. OEM-Software/-Hardware wird vom Hersteller nicht direkt vertrieben, sondern an ein anderes Unternehmen ausgeliefert und in Verbindung mit weiterer Software/Hardware vermarktet. OEM-Software kann eine Vollversion mit geringerem Lieferumfang, eingeschränkter Funktionalität oder anderem Nutzungsrecht sein. OEM-Hardware wird für ein anderes Unternehmen produziert, das sie unter eigenem Markennamen anbietet (z. B. IT-Produkte bei Discountern).', 163),
(164, b'1', 'Skalierbarkeit bezeichnet die Fähigkeit von Hard- oder Software, im laufenden Betrieb weiter zu funktionieren, wenn Größe, Anzahl oder Volumen verändert wird – zur Aufrechterhaltung des 24/7-Betriebs. Beispiele: Volumenanpassung bei Storages, Anpassung von CPU-Kernen oder Arbeitsspeicher einer VM. Ressourcen können bedarfsgerecht oder automatisch bereitgestellt werden.', 164),
(165, b'1', 'EULA steht für Endbenutzer-Lizenzvereinbarung (End User License Agreement). Sie enthält Regelungen für die allgemeine Benutzung einer Software. Die EULA wird häufig zu Beginn des Installationsprozesses angezeigt und muss akzeptiert werden – andernfalls kann der Installationsprozess nicht fortgesetzt werden.', 165),
(166, b'1', 'Das Pay-per-use-Modell beschreibt ein Finanzierungsmodell für Hard- und Software: Bezahlung nur für die tatsächliche Nutzung. Vorteile: keine Anschaffungskosten, keine Kapitalbindung, keine Softwarepflege, keine Lizenzierungskosten, immer aktuelle Version, Skalierbarkeit, Flexibilität, hohe Ausfallsicherheit (bei Cloud-Anbieter). Abrechnung stunden- oder minutengenau nach Nutzungsdauer.', 166),
(167, b'1', 'Maßnahmen: Einsatz von Authentifizierungsmethoden (WPA2/WPA3); Einsatz eines RADIUS-Servers; Aktivierung von MAC-Filtern mit einer White List; Einsatz eines Client-Zertifikats; Nutzung von VPN-Verbindungen.', 167),
(168, b'1', '1. End-to-Site-VPN (auch: Host-to-LAN-VPN, Host-to-Gateway-VPN, Remote-Access-VPN). 2. Site-to-Site-VPN (auch: LAN-to-LAN-VPN, Gateway-to-Gateway-VPN). 3. End-to-End-VPN (auch: Host-to-Host-VPN, Remote-Desktop-VPN).', 168),
(169, b'1', 'Ein VPN ist ein logisches Netzwerk, das eine geschützte Verbindung über öffentliche Netzwerke herstellt. Mittels Verschlüsselungstechnologien werden Authentizität, Vertraulichkeit und Integrität der Daten sichergestellt. Protokolle/Lösungen: L2TP over IPsec, SSL-VPN, OpenVPN, Layer-2-VPN. VPN wird in 3 Verbindungsarten unterteilt: End-to-Site, Site-to-Site und End-to-End.', 169),
(170, b'1', 'Sicherheitsmethoden: WPA (gilt als unsicher), WPA2-Personal/Enterprise, WPA3-Personal/Enterprise mit RADIUS. Verschlüsselungsstandards: AES (Advanced Encryption Standard), TKIP (Temporal Key Integrity Protocol), SAE (Simultaneous Authentication of Equals).', 170),
(171, b'1', 'Es handelt sich um den Befehl arp -a. Das ARP (Address Resolution Protocol) ist ein Netzwerkprotokoll, das zu einer Netzwerkadresse (OSI-Schicht 3) die physische MAC-Adresse des Netzwerkinterfaces (OSI-Schicht 2) ermittelt und im ARP-Cache zwischenspeichert.', 171),
(172, b'1', 'VLAN-Vorteile: physikalische Netztopologie kann in logische Gruppen unterteilt werden; Priorisierung des Datenverkehrs möglich; bessere Lastverteilung; Unterteilung in Broadcast-Domänen (weniger Kollisionsbereiche); flexiblere Anpassung von Gruppenzugehörigkeiten; Trennung des Datenverkehrs nach spezifischen Anwendungen.', 172),
(173, b'1', 'Es handelt sich um den Befehl tracert (Windows) bzw. traceroute (Linux). Er verfolgt den Weg von Datenpaketen über alle Zwischenstationen (Hops) bis zum Zielhost und zeigt dabei die Latenz je Hop an.', 173),
(174, b'1', 'Es handelt sich um den Befehl nslookup. Er wird zur DNS-Namensauflösung verwendet – sowohl vorwärts (Name → IP) als auch rückwärts (IP → Name/Hostname).', 174),
(175, b'1', 'Es handelt sich um den Befehl getmac -v. Er zeigt Verbindungsname, Netzwerkadapter, physische Adresse (MAC-Adresse) und Transportname aller Netzwerkadapter an.', 175),
(176, b'1', 'Es handelt sich um den Befehl ipconfig /all. Er zeigt die vollständige Netzwerkkonfiguration aller Adapter an: physische Adresse, IPv4-/IPv6-Adresse, Subnetzmaske, Standard-Gateway, DHCP-Status, DNS-Server, DHCPv6-Informationen u. v. m.', 176),
(177, b'1', 'Mithilfe des Address Resolution Protocols (ARP) wird zur IP-Adresse die zugehörige MAC-Adresse eines Hosts ermittelt. Der Host sendet einen ARP-Request per Broadcast (MAC FF-FF-FF-FF-FF-FF) auf Schicht 2. Via ARP-Reply wird die MAC-Adresse zurückgesendet und im lokalen ARP-Cache gespeichert für schnellere zukünftige Auflösungen.', 177),
(178, b'1', 'chmod (change mode) ist ein Linux/Unix-Kommandozeilenprogramm zur Anpassung von Dateirechten. Rechte sind in 3 Gruppen unterteilt: User, Group, Others. Symbole: r = lesen, w = schreiben, x = ausführen. Neben der symbolischen Notation gibt es die oktale Notation (z. B. 7=rwx=111, 6=rw=110, 5=rx=101, 4=r=100). Änderungen können nur der Dateibesitzer oder root vornehmen. Beispiel: chmod 770 test.txt', 178),
(179, b'1', 'S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology) ist ein standardisiertes Überwachungswerkzeug für Datenträger (HDD/SSD). Es dient zur frühzeitigen Vorhersage von möglichen Ausfällen des gesamten Datenträgers oder einzelner Speicherblöcke. Über SMART-Attribute können Werte wie Temperatur, Einschaltzeit, Laufzeit und Bad Blocks ausgelesen werden.', 179),
(180, b'1', 'Richtige Reihenfolge: 1. b) POST, 2. a) Bootreihenfolge für Installationsmedium festlegen, 3. h) Installationsmedium einlegen, 4. d) EULA lesen und akzeptieren, 5. f) Filesystem anlegen, 6. e) Filesystem formatieren, 7. c) Benutzer + Passwort anlegen, 8. g) Benutzerprofile für das 1. Login erzeugen.', 180),
(181, b'1', 'Grafische Werkzeuge: Netzwerkmanager (Debian, Rocky Linux, SUSE), nmtui (Rocky Linux), Wicd (Debian), YaST (SUSE). Konsole: ifconfig, ip addr show, ip a.', 181),
(182, b'1', 'PowerShell oder Eingabeaufforderung als Administrator öffnen und eingeben: netsh interface ip set address name=\"LAN-Verbindung\" address=192.168.0.1 mask=255.255.255.0 gateway=192.168.0.254', 182),
(183, b'1', 'Bedingungen: Speichermodule müssen baugleich sein; identische Speicherkapazität; vom Hersteller für das Motherboard/den Prozessor zertifiziert sein; immer paarweise ergänzen bzw. entfernen.', 183),
(184, b'1', 'Zutreffende Aussagen: Windows-basiertes Betriebssystem; kein statische IPv4-Adresse; IP-Adresse soll automatisch (DHCP) bezogen werden; DHCP-Request wurde nicht beantwortet; DHCP-Server zurzeit nicht erreichbar; APIPA (Automatic Private IP Addressing) laut IANA aktiviert; im Bereich 169.254.1.0–169.254.254.255 wurde eine zufällige IPv4-Adresse mit /16-Subnetzmaske erzeugt.', 184),
(185, b'1', 'UML steht für Unified Modeling Language (Vereinheitlichte Modellierungssprache). Es ist eine standardisierte grafische Modellierungssprache für Softwareentwicklung und Systemmodellierung. Ziel: komplexe Systeme visualisieren, spezifizieren, konstruieren und dokumentieren.', 185),
(186, b'1', 'Aktivitätsdiagramm: zeigt Ablauf von Aktivitäten und Prozessen. Zustandsdiagramm: bildet Zustände und Zustandsübergänge eines Objekts ab. Use-Case-Diagramm: stellt Anwendungsfälle und deren Beziehungen zu Akteuren dar. Sequenzdiagramm: stellt Interaktionen zwischen Objekten in zeitlicher Abfolge dar. Kommunikationsdiagramm: stellt Interaktionen zwischen Objekten dar mit Fokus auf Beziehungen. Interaktionsübersichtsdiagramm: modelliert Abläufe, kombiniert Aktivitäts- und Interaktionsdiagramme. Zeitverlaufsdiagramm: visualisiert Zustandsänderungen über die Zeit.', 186),
(187, b'1', 'Eine Klasse definiert mithilfe von Kategorien Objekte, die gleiche Attribute haben und gleiche Methoden benutzen. Durch Vererbung können neue Subklassen mit Erweiterungen oder Einschränkungen geschaffen werden. Ein Objekt ist eine Instanz einer Klasse, die nach dem Bauplan der zugeordneten Klasse erstellt wurde und damit über die in der Klasse festgelegten Attribute und Methoden verfügt.', 187),
(188, b'1', 'Allgemeine Anforderungen: Datenunabhängigkeit; effizienter Speicherzugriff; paralleler Datenzugriff; Datenkonsistenz; gemeinsame Datenbasis; Datenintegrität; Datensicherheit; Wiederherstellungsverfahren; Abfragesprache; keine/kontrollierte Redundanz.', 188),
(189, b'1', 'Allgemein: Normalisierung verhindert Datenredundanzen. 1. Normalform (1NF): alle Informationen in einer Tabelle liegen atomar vor. 2. Normalform (2NF): Tabelle ist in 1NF und jedes Nichtschlüsselattribut ist von jedem Schlüsselkandidaten voll funktional abhängig. 3. Normalform (3NF): Tabelle ist in 2NF und kein Nichtschlüsselattribut hängt transitiv von einem Kandidatenschlüssel ab.', 189),
(190, b'1', 'DDL (Data Definition Language): CREATE, ALTER, DROP, TRUNCATE. DML (Data Manipulation Language): INSERT, UPDATE, DELETE. DCL (Data Control Language): GRANT, REVOKE. TCL (Transaction Control Language): COMMIT, ROLLBACK, SAVEPOINT. DQL (Data Query Language): SELECT.', 190),
(191, b'1', 'Die ISO 9001 Norm legt die Anforderungen für Qualitätsmanagementsysteme fest. Ziel ist die Qualitätssicherung durch stetige Optimierung der Prozesse. Diese Zertifizierung ist weltweit anerkannt. ISO 9001 orientiert sich an folgenden Grundprinzipien: Kundenorientierung, Prozessorientierung, stetige Verbesserung, Risikomanagement.', 191),
(192, b'1', 'Die vier Phasen des PDCA-Zyklus sind: P – Plan (Planen): Probleme identifizieren, aktuellen Zustand analysieren, Ziele und Kennzahlen festlegen. D – Do (Umsetzen): den Plan ausführen, geplante Aktivitäten durchführen, relevante Daten sammeln. C – Check (Überprüfen): erzielte Ergebnisse mit den geplanten Zielen vergleichen, Erfolg der Maßnahmen prüfen. A – Act (Handeln): erfolgreiche Maßnahmen standardisieren oder den Plan für zukünftige Verbesserungen anpassen.', 192),
(193, b'1', 'Der Energy Star bescheinigt elektrischen Geräten, dass sie die Stromsparkriterien der US-Umweltschutzbehörde EPA (Environmental Protection Agency) und des US-Energieministeriums erfüllen. Ein wichtiges Kriterium: Ein eingeschaltetes Gerät muss sich nach einiger Zeit selbstständig ausschalten oder in den Stromsparmodus wechseln. Bei Computern muss die Prozessorleistung heruntergefahren und der Datenträger abgeschaltet werden, was einen sehr niedrigen Stromverbrauch zur Folge hat.', 193),
(194, b'1', 'In einem Audit wird untersucht, ob Prozesse, Anforderungen, Normen und Richtlinien die geforderten Standards erfüllen. Audits werden im Rahmen des Qualitätsmanagements turnusmäßig durchgeführt (z. B. zur Zertifizierung/Re-Zertifizierung nach ISO 9001 oder ISO 27001). Sie werden von speziell geschulten Auditoren durchgeführt und stellen oft die finale Phase beim Zertifizierungsprozess dar. Im statischen Qualitätsmanagement haben Audits Prüfungscharakter; in der dynamischen Qualitätssicherung dienen sie der Erkennung von Entwicklungstrends und der Überprüfung der Wirksamkeit von Maßnahmen.', 194),
(195, b'1', 'Die Softwarequalitätskriterien werden u. a. in der Norm ISO/IEC 9126 dargestellt. Die Qualitätssicherung (QS) stellt sicher, dass die Software den vereinbarten Anforderungen entspricht. Allgemeine Kriterien: Funktionalität, Benutzbarkeit, Zuverlässigkeit, Effizienz, Übertragbarkeit, Änderbarkeit.', 195),
(196, b'1', 'Das Gütesiegel GS (Geprüfte Sicherheit) wird seit 1977 von der Deutschen Gesetzlichen Unfallversicherung e.V. (DGUV) für Produkte ausgestellt, die die Anforderungen des Produktsicherheitsgesetzes (ProdSG) erfüllen. Es stellt sicher, dass Produkte einer Prüfung durch eine zugelassene, unabhängige Prüf- und Zertifizierungsstelle unterzogen wurden.', 196),
(197, b'1', 'Der Blaue Engel ist das Umweltzeichen der Bundesregierung. Er setzt anspruchsvolle Maßstäbe für umweltfreundliche Produkte und Dienstleistungen und ist die Orientierung beim nachhaltigen Einkauf. Das Zeichen wird verliehen, wenn Produkte und Dienstleistungen umweltfreundlicher sind als vergleichbare konventionelle Produkte. Die Vergaberegeln legt das Bundesministerium für Umwelt, Naturschutz und nukleare Sicherheit (BMU) als Zeicheninhaber fest.', 197),
(198, b'1', 'Laut der WEEE-Richtlinie (Waste Electrical and Electronic Equipment) sind Hersteller in der abfallwirtschaftlichen Verantwortung für ihre Produkte während der gesamten Lebensdauer verantwortlich. Kategorien: IuK-Geräte (Computer, Notebooks, Tablets, Datenspeicher, Monitore, Drucker, Handys, Telefone, Netzteile, TK-Anlagen) und Unterhaltungselektronik/braune Ware (Fernseher, Videorecorder, Digitalkameras, Konsolen, HiFi-Anlagen, Radios, CD-/DVD-/Blu-ray-Player). Merke: Elektronische Geräte gehören nicht in den Hausmüll und müssen fachgerecht sowie umweltgerecht entsorgt werden.', 198),
(199, b'1', 'Alle Daten sind vor der Verschrottung eines Datenträgers durch technische Verfahren, wie zum Beispiel durch mechanische, magnetische oder thermische Verfahren nach DIN 66399 sicher zu löschen. Anschließend sind die Datenträger umwelt- und fachgerecht durch ein zertifiziertes Entsorgungsunternehmen zu entsorgen.', 199),
(200, b'1', 'Die Multi-Factor-Authentication (MFA) ist eine erweiterte Form der Zugangsberechtigung, die durch mehrere unabhängige Merkmale (Faktoren) überprüft wird und erst nach Eingabe eines starken Passworts sowie der Eingabe einer Nummer (via SMS oder App) oder Angabe einer Zertifikatsdatei erteilt wird. Einsatzbereiche sind: Online-Banking; Debit- oder Kreditkartenzahlung; Online-Ausweisfunktion des Personalausweises; Absicherung jeglicher öffentlich zugänglicher Onlinezugänge', 200),
(201, b'1', 'Datensicherheit, oftmals auch Informationssicherheit genannt, beinhaltet alle technischen und nicht-technischen Maßnahmen zur Sicherstellung der 3 Schutzziele Vertraulichkeit, Verfügbarkeit und Integrität. Ein weiteres Schutzziel ist noch die Authentizität. Hier geht es um die Eigenschaften der Echtheit, Überprüfbarkeit und Vertrauenswürdigkeit eines Objekts. Datensicherheit oder Informationssicherheit unterscheidet nicht nach Art der Daten (siehe Datenschutz, wo es um personenbezogene Daten geht). Es geht hier in erster Linie um den Schutz vor Gefahren/Bedrohungen bzw. der Vermeidung von wirtschaftlichen Schäden sowie der Minimierung von Risiken im IT-Bereich.', 201),
(202, b'1', 'Die Datensicherheit bzw. Informationssicherheit verfolgt die 3 Schutzziele Vertraulichkeit, Verfügbarkeit und Integrität sowie außerdem die Authentizität. Hier wird nicht nach der Art der Daten (z. B. personenbezogen o. Ä.) unterschieden. Der Datenschutz verfolgt das Ziel, personenbezogene Daten zu schützen sowie die Informationspflichten und Rechte der Personen, von denen Daten erhoben werden, zu gewährleisten.', 202),
(203, b'1', '§ 25 Abs. 2 DSGVO: Der Verantwortliche trifft geeignete technische und organisatorische Maßnahmen, die sicherstellen, dass durch Voreinstellung grundsätzlich nur personenbezogene Daten, deren Verarbeitung für den jeweiligen bestimmten Verarbeitungszweck erforderlich ist, verarbeitet werden. Diese Verpflichtung gilt für die Menge der erhobenen personenbezogenen Daten, den Umfang ihrer Verarbeitung, ihre Speicherfrist und ihre Zugänglichkeit. Solche Maßnahmen müssen insbesondere sicherstellen, dass personenbezogene Daten durch Voreinstellungen nicht ohne Eingreifen der Person einer unbestimmten Zahl von natürlichen Personen zugänglich gemacht werden.', 203),
(204, b'1', 'Zutrittskontrolle: Unbefugten ist der Zutritt zu DV-Anlagen zu verwehren. Zugangskontrolle: Unbefugte sollen keinen Zugang zu DV-Anlagen haben. Zugriffskontrolle/Zugriffsberechtigung: Durch ein Rechte- und Rollenmanagement können nur berechtigte Nutzer personenbezogene Daten einsehen. Der Zugriff wird protokolliert. Unbefugte Dritte werden ausgeschlossen und können sensible Daten nicht lesen, kopieren, verändern oder löschen. Weitergabekontrolle: Sicherstellung, dass personenbezogene Daten beim Transport oder bei der Speicherung nicht durch Dritte gelesen, kopiert, verändert oder entfernt werden können. Eingabekontrolle: Gewährleistung, dass nachträglich überprüft und festgestellt werden kann, ob Daten verändert oder entfernt worden sind. Auftragskontrolle: Personenbezogene Daten werden nur nach der vertraglichen Regel der Auftragsverarbeitung verarbeitet. Verfügbarkeitskontrolle: Personenbezogene Daten werden vor Verlust oder Zerstörung geschützt. Trennungsgebot: Personenbezogene Daten werden ihrem Zweck nach getrennt verarbeitet und gespeichert.', 204),
(205, b'1', 'Die internationale Norm ISO/IEC 27001 beschreibt die Anforderungen an ein funktionsfähiges Informationssicherheits-Managementsystem (ISMS). Die Anforderungen geben vor, wie ein ISMS in Unternehmen zu errichten, umzusetzen und kontinuierlich weiterzuentwickeln ist. Eine erfolgreiche Zertifizierung trägt dazu bei, IT-Risiken zu minimieren, IT-Sicherheitsverfahren zu etablieren sowie die Qualität der IT-Systeme nachhaltig zu optimieren. Weitere Vorteile: IT-Risiken/Schäden/Folgekosten abschätzen bzw. minimieren; Wettbewerbsvorteil durch anerkannten internationalen Standard; Steigerung des Vertrauens gegenüber Partnern, Kunden und der Öffentlichkeit; Compliance-Anforderungen werden sichergestellt; Systematisches Aufdecken von Schwachstellen', 205),
(206, b'1', 'Datenminimierung und Datensparsamkeit sind grundlegende Regeln im Bereich des Datenschutzes. Diese Regel besagt, dass bei der Datenverarbeitung nur so viele personenbezogene Daten gesammelt werden, wie für die jeweiligen Verarbeitungszwecke unbedingt notwendig sind. Es gilt der Grundsatz: So viele Daten wie nötig, so wenige Daten wie möglich. Betroffene sollen dadurch vor einer übermäßigen Speicherung personenbezogener Daten geschützt werden.', 206),
(207, b'1', 'In Kapitel 3 der DSGVO sind folgende Vorschriften enthalten: Informationspflicht und Recht auf Auskunft zu personenbezogenen Daten (Informationspflicht bei Erhebung, Informationspflicht wenn Daten nicht bei der Person erhoben wurden, Auskunftsrecht der betroffenen Person); Recht auf Berichtigung und Löschung (Recht auf Berichtigung, Recht auf Löschung/Recht auf Vergessenwerden, Recht auf Einschränkung der Verarbeitung, Mitteilungspflicht, Recht auf Datenübertragbarkeit); Widerspruchsrecht und automatisierte Entscheidungsfindung im Einzelfall', 207),
(208, b'1', 'Mit einer Public-Key-Infrastruktur (PKI) wird ein kryptologisches System bezeichnet, welches innerhalb einer Infrastruktur digitale Zertifikate ausstellen, verteilen und prüfen kann. Zum Einsatz kommt ein Asymmetrisches Kryptosystem, welches zur Absicherung des Datenverkehrs innerhalb eines Netzwerks dient und die Daten digital signiert und verschlüsselt. Zu den Bestandteilen einer PKI gehören unter anderem die Zertifizierungsstellen (CAs), untergeordnete Registrierungsstellen, digitale Zertifikate, Verzeichnisdienste für Zertifikate, Zertifikatssperrlisten sowie Validierungsservices. Es gibt einstufige und mehrstufige Modelle einer PKI.', 208),
(209, b'1', 'Als digitales Zertifikat wird ein digitaler Datensatz bezeichnet, der mit Hilfe von kryptografischen Schlüsselpaaren beispielsweise die Authentizität von Webseiten, Einzelpersonen oder Organisationen überprüfen kann. Ein typisches digitales Zertifikat basiert in der Regel auf dem X.509 Standard (Public-Key-Zertifikat). Das digitale Zertifikat besteht unter anderem aus einem öffentlichen Schlüssel und einem privaten Schlüssel und soll die Schutzziele der Datensicherheit, wie Vertraulichkeit sowie Authentizität gewährleisten.', 209),
(210, b'1', 'Im Gegensatz zur klassischen Firewall (paketorientiert), nutzt eine Stateful Packet Inspection Firewall eine zustandsorientierte Paketüberprüfung, bei der jedes Datenpaket auf der Vermittlungsschicht (3. Schicht des OSI-Modells) einer bestimmten aktiven Sitzung zugeordnet wird und der Verbindungsstatus in dynamischen Zustandstabellen zwischengespeichert wird. Mit Hilfe des Zustands der Verbindungen werden bei TCP die SYN-, ACK-, FIN- und RST-Bits ausgewertet und über die Weiterleitung von Datenpaketen entschieden. Die eigentlich zustandslosen Datenpakete UDP (User Datagram Protocol) können auch stateful behandelt werden.', 210),
(211, b'1', 'Als Endpoint-Security-Management werden alle Maßnahmen und Richtlinien bezeichnet, bei denen Endgeräte, die auf ein Netzwerk zugreifen, vor schädlichen Angriffen bzw. Zugriffen seitens Dritter geschützt werden. Zu den Maßnahmen zählen unter anderem sowohl die Anwendungsisolation von E-Mail- und Office-Programmen als auch Überwachung bzw. Verwaltung von externen Datenträgern, die über eine Art Whitelist geregelt wird.', 211),
(212, b'1', 'Bei folgenden Anwendungen oder Verfahren kommt es zum Einsatz von kryptografischen Hashfunktionen: Integritätsprüfungen; Erzeugung von Prüfsummen; Erzeugung von Sitzungsschlüsseln; Generatoren für Einmal-Passwörter; Verfahren zur Authentifizierung mit digitalen Signaturen; Speichern von Passwörtern', 212),
(213, b'1', 'Einsatzbereiche und zugehörige Verfahren symmetrischer Schlüssel: Wireless LAN (WPA2), WiMAX, SSH, IPsec, SRTP → AES (Advanced Encryption Standard); Wireless LAN → Triple-DES; VPN-Software (z.B. OpenVPN) → Blowfish; Wireless LAN (WPA3) → SHA-2 (Secure Hash Algorithm 2)', 213),
(214, b'1', 'Symmetrische Verschlüsselung: Anzahl der Schlüssel: ein Schlüssel; Geschwindigkeit: schnell und effizient; Schlüsselaustausch: problematischer Schlüsselaustausch; Anwendungsfälle: Verschlüsselung großer Datenmengen, Verschlüsselung von Dateien, Absicherung von VPNs; Algorithmen: AES, DES, 3DES. Asymmetrische Verschlüsselung: Anzahl der Schlüssel: zwei Schlüssel (öffentlich und privat); Geschwindigkeit: langsam und rechenintensiv; Schlüsselaustausch: der öffentliche Schlüssel kann frei verteilt werden; Anwendungsfälle: Schlüsselaustausch, digitale Signaturen, digitale Zertifikate für SSL/TLS für Webseiten; Algorithmen: RSA, ECC, DSA', 214),
(215, b'1', 'Differentielles Backup: Ausgehend von einem Vollbackup werden alle Dateien kopiert, die seit der letzten vollständigen Sicherung verändert wurden oder neu hinzugekommen sind. Beim Wiederherstellen benötigt man das letzte Vollbackup + das letzte differentielle Backup. Inkrementelles Backup: Ausgehend von einem Vollbackup werden nur die Dateien kopiert, die seit der letzten inkrementellen Sicherung verändert wurden oder neu hinzugekommen sind. Beim Wiederherstellen benötigt man das letzte Vollbackup + alle inkrementellen Backups in der richtigen Reihenfolge.', 215),
(216, b'1', 'Beim Großvater-Vater-Sohn-Prinzip handelt es sich um ein Rotationsschema zur Datensicherung auf Speichermedien. Im Rahmen einer 5-Tage-Woche kommen dabei 20 Speichermedien zum Einsatz: 4x Sohn-Medien → tägliche Datensicherung (inkrementelles Backup); 4x Vater-Medien → wöchentliche Datensicherung (Vollbackup); 12x Großvater-Medien → monatliche Datensicherung (Vollbackup)', 216),
(217, b'1', 'Malware = Schadsoftware oder Schadprogramme. Oberbegriff für Adware, Spyware, Viren, Botnets, Trojaner, Würmer, Rootkits und Ransomware. Ransomware = Erpressersoftware. Daten werden auf einem Computer verschlüsselt und es wird zur Zahlung eines Lösegelds (z. B. via Bitcoin) aufgefordert, wenn man diese Daten wieder entschlüsselt haben möchte. Trojaner = Harmlos wirkendes Computerprogramm, welches im Hintergrund ohne Wissen des Anwenders weitere Schadsoftware nachlädt und beispielsweise Backdoorprogramme oder Rootkits installiert.', 217),
(218, b'1', 'Das IT-Sicherheitsmanagement beschreibt den permanenten Prozess innerhalb einer Unternehmung oder Organisation zur Gewährleistung der IT-Sicherheit und des Datenschutzes. Es sollen Gefahren oder Bedrohungen für die Informationssicherheit sowie den Datenschutz eines Unternehmens oder einer Organisation verhindert oder abgewehrt werden.', 218),
(219, b'1', 'Zur Absicherung der Daten bzw. zur Absicherung der Zugriffe auf IT-gestützte Systeme muss eine sichere Passwortrichtlinie folgende Kriterien erfüllen: Mindestlänge des Passworts (z.B. 10-15 Zeichen); Das Passwort muss aus mindestens einem Groß- und Kleinbuchstaben, einem Sonderzeichen und einer Ziffer bestehen; Es dürfen keine Logindatenbestandteile im Passwort enthalten sein; Passwortänderung alle 30-90 Tage; Das wiederholte Benutzen von alten Passwörtern ist eingeschränkt; Loginversuche werden auf maximal 3 Versuche innerhalb einer Minute begrenzt; Es wird optional eine MFA angeboten; Bei mehr Loginversuchen als zulässig wird das Zugangskonto für 24 Stunden gesperrt; Wörter aus dem Duden oder ähnlichen Werken sind nicht zugelassen', 219),
(220, b'1', 'Der Begriff Security by Design bedeutet, dass die allgemeinen Sicherheitsanforderungen an Soft- und Hardware bereits während der Entwicklungsphase eines Produktes berücksichtigt werden sollen, um spätere Sicherheitslücken auszuschließen. Die nachträgliche Beseitigung von Sicherheitslücken würde den Projektfortschritt behindern und die Kosten dafür in die Höhe treiben.', 220),
(221, b'1', 'WPA2-Personal (PSK): Vorteile: leicht zu implementieren, sehr verbreiteter Sicherheitstyp in Geräten. Nachteile: unsicherer Einsatz in größeren Unternehmen da das Passwort häufig bekannt ist, Passwortwechsel wird bei großer Anzahl von Geräten sehr arbeitsintensiv. WPA2-Enterprise: Vorteile: Einsatz in großen Unternehmen sehr viel sicherer, Wechsel der Passwörter und Geräte sehr einfach da zentral verwaltet. Nachteile: hoher technischer Aufwand, Einsatz eines RADIUS Servers notwendig', 221),
(222, b'1', 'Beim Einsatz eines Mailsystems sind folgende Sicherheitsmaßnahmen zu beachten: E-Mails sollten zentral verschlüsselt und digital signiert werden; Einsatz von TLS/SSL-Zertifikaten; POP3 Verbindungen nur über SSL/TLS Port 995 zulassen; IMAP Verbindungen nur über SSL/TLS Port 993 zulassen; SMTP Verbindungen nur über SSL/TLS Port 465/587 zulassen', 222),
(223, b'1', 'Allgemeine Ergonomie-Richtlinien sind in der Richtlinie 90/270/EWG geregelt. Folgende Bedingungen muss ein ergonomischer PC-Arbeitsplatz erfüllen: Die oberste Bildschirmzeile des Monitors ist leicht unterhalb der Sehachse; Der Mindestabstand von 50 cm zum Bildschirm ist zu gewährleisten; Der Bildschirm sollte frei von störenden Reflexionen und Blendungen sein; Der Bildschirm muss frei stehen und leicht drehbar sowie neigbar sein; Arbeitshöhe und Sitzhöhe müssen sich an die Körperhöhe anpassen lassen; Ein Winkel von 90° zwischen Ober- und Unterarm sowie Ober- und Unterschenkel ist optimal; Genug Bewegungsspielraum für die Beine; Eine natürliche Körperhaltung muss möglich sein. Des Weiteren gelten die Bestimmungen der Arbeitsstättenverordnung (ArbStättV).', 223),
(224, b'1', 'Die Arbeitsstättenverordnung (ArbStättV) enthält im Anhang wesentliche Regelungen zum Einrichten eines Bildschirmarbeitsplatzes: Die Zeichen auf dem Bildschirm müssen scharf, deutlich und ausreichend groß dargestellt sein; Das Bild muss stabil, flimmerfrei und ohne Verzerrungen dargestellt werden; Die Helligkeit sowie der Kontrast des Bildschirms müssen einstellbar sein; Der Bildschirmarbeitsplatz muss frei von störenden Reflexionen und Blendungen sein; Das Bildschirmgerät muss frei stehen und leicht drehbar sowie neigbar sein; Die Tastatur muss vom Bildschirmgerät getrennt und neigbar sein; Die Tastatur muss eine Auflagemöglichkeit für die Hände bieten; Die PC-Tastatur muss eine reflexionsarme Oberfläche besitzen; Die Tastaturbeschriftung muss sich vom Untergrund deutlich abheben und bei normaler Arbeitshaltung lesbar sein.', 224),
(225, b'1', 'Es handelt sich um eine Vorgehensweise im kontinuierlichen Verbesserungsprozess im Qualitätsmanagement. Folgende Schritte gehören zum Zyklus: PLAN (Analyse/Planen/Ziele formulieren); DO (Tun/Durchführen); CHECK (Überprüfen/Soll-Ist-Vergleich); ACT (Aktion/Reagieren/Verbessern)', 225),
(226, b'1', 'Im Projektmanagement wird die SMART-Methode eingesetzt, um Zielsetzungen des Projekts zu definieren. S – Spezifisch: Die Projektziele sind so konkret wie möglich zu formulieren. M – Messbar: Die Projektziele müssen messbar sein. A – Aktivierend/Attraktiv: Projektziele müssen auch Motivation zur Umsetzung machen. R – Realistisch: Die Projektziele müssen innerhalb des gesetzten Zeitrahmens auch umsetzbar sein. T – Terminiert: Die Projektziele müssen zeitlich bindend sein. Welche Aufgaben sind bis wann zu erledigen?', 226),
(227, b'1', 'Um die Arbeitsqualität und Mitarbeiterzufriedenheit im Unternehmen zu erhöhen, sind folgende Maßnahmen hilfreich: Einsatz flexibler Arbeitszeitmodelle; Ermöglichen von Homeoffice; Weiterbildungs- und Fortbildungsmöglichkeiten anbieten; variable Zusatzvergütung für das Erreichen von vereinbarten Zielen; Gewinnbeteiligung am Erfolg des Unternehmens; Altersteilzeitangebote für ältere Arbeitnehmer', 227),
(228, b'1', 'Folgende Maßnahmen können zur Verbesserung der Produktqualität beitragen: Einführung einer permanenten Qualitätssicherung, um gleichbleibend hohe Qualität der Produkte zu gewährleisten; wiederkehrende Kundenbefragungen zur Qualität der Produkte; Produktionsprozesse kontinuierlich verbessern; Mitarbeiterschulungen zum Thema Produktqualität anbieten; qualitativ hochwertige Ausgangsmaterialien nutzen; Prozessfehler ermitteln und für Abhilfe sorgen', 228),
(229, b'1', 'Folgende Kriterien sind für eine Schutzbedarfsanalyse wichtig: Wie hoch ist das Risiko, dass IT-Infrastrukturen angegriffen werden? Welche Objekte müssen in der IT-Infrastruktur besonders abgesichert werden? Welchen konkreten Bedrohungsszenarien ist die IT-Infrastruktur ausgesetzt? Wie groß sind mögliche Schäden durch Angriffe auf produktive IT-Infrastrukturen? Wie hoch ist das aktuelle Gefährdungspotenzial? Welche Maßnahmen sind geeignet, die IT-Infrastruktur gegen interne und externe Bedrohungen zu schützen? Wie sieht die Kosten-Nutzen Betrachtung bzw. Risikoberechnung aus?', 229),
(230, b'1', 'Normal: Bei Verstößen gegen Gesetze/Vorschriften/Verträge drohen nur geringfügige juristische Konsequenzen; Missbrauch personenbezogener Daten hätte nur minimale Auswirkungen; finanzieller Schaden liegt unter 50.000 Euro. Hoch: Bei Verstößen drohen schwerwiegende juristische Konsequenzen; Missbrauch personenbezogener Daten hätte massive Auswirkungen; finanzieller Schaden liegt zwischen 50.000 € und 500.000 €. Sehr hoch: Bei Verstößen drohen existenzbedrohende juristische Konsequenzen; Missbrauch personenbezogener Daten hätte existenzbedrohende Auswirkungen; finanzieller Schaden liegt über 500.000 €.', 230),
(231, b'1', 'Router – Schutzziele und Schutzbedarf: Vertraulichkeit: hoch (über eine externe Verbindung werden auch vertrauliche Daten übertragen, wenn eine unverschlüsselte Kommunikation zustande kommt); Integrität: normal (fehlerhafte Daten können normalerweise leicht vom Router erkannt werden und beeinträchtigen nicht die Integrität der Daten); Verfügbarkeit: normal (der Ausfall des Internet-Routers kann für eine kurze Zeit toleriert werden, wenn die Verfügbarkeit danach wieder hergestellt wird).', 231),
(232, b'1', 'Die folgenden Maßnahmen sind geeignet: Datenverschlüsselung der Datenträger; Konzept für Netzwerksegmentierung im Unternehmen/Einsatz von VLANs; mehrstufiges Firewallkonzept sowie Regeln für die Endpoint-Security auf den Clientsystemen; Rechtekonzept für Mitarbeitende und Administratoren; regelmäßiges Patchen der IT-Systeme; permanentes Logging und Auditing (Penetrationtest/Pentest); Einsatz einer Passwortrichtlinie sowie einer Multi-Factor-Authentication; Verfahrensanweisung oder Vier-Augen-Prinzip; regelmäßige Schulungen der Mitarbeitenden, um das Bewusstsein zu erhöhen bzw. Bedrohungen zu erkennen', 232),
(233, b'1', 'Im Rahmen des IT-Grundschutzes (BSI-Standard 100-2) besteht der Sicherheitsprozess aus folgenden Phasen: 1. Initiierung des Sicherheitsprozesses (1.1 Übernahme der Verantwortung durch die Leitungsebene; 1.2 Konzeption und Planung des Sicherheitsprozesses; 1.3 Erstellung der Leitlinie zur Informationssicherheit; 1.4 Aufbau einer geeigneten Organisationsstruktur für das Informationssicherheitsmanagement; 1.5 Bereitstellung von finanziellen, personellen und zeitlichen Ressourcen; 1.6 Einbindung aller Mitarbeitenden in den Sicherheitsprozess); 2. Erstellung einer Sicherheitskonzeption; 3. Umsetzung der Sicherheitskonzeption; 4. Aufrechterhaltung der Informationssicherheit im laufenden Betrieb und kontinuierliche Verbesserung', 233),
(234, b'1', 'Als TÜV geprüfter IT-Sicherheitsbeauftragter (Information Security-Officer) sind folgende Themen von Bedeutung: Informationssicherheit und Informationssicherheitsmanagement; IS-Management-System nach ISO 27001; IS-Management-System nach BSI IT-Grundschutz; Konzepte der Informationssicherheit; Aktuelle Themenbereiche und Konzepte der Informationssicherheit; Sicherheitsmaßnahmen/Konzepte im Hinblick auf Organisation, Infrastruktur, Netzwerksicherheit, Systemsicherheit und Anwendungssicherheit', 234),
(235, b'1', 'Gesetzliche, regulatorische und vertragliche Regelungen eingeschlossen, definiert die ISO 27001 die Anforderungen, die an den Aufbau, die Einführung, Umsetzung, betriebliche Überwachung und Dokumentation des Information Security Management Systems gestellt werden. Dabei werden vorhandene Risiken eines Unternehmens identifiziert, analysiert und durch qualifizierte Maßnahmen behoben. Die ISO 27001 ist nicht auf IT-Prozesse beschränkt. Sie berücksichtigt auch Aspekte der Infrastruktur, wie Organisation, Personal und Gebäude. Das gilt insbesondere für Betreiber Kritischer Infrastrukturen (KRITIS), die laut BSI-Gesetz dazu verpflichtet sind, ein Mindestmaß an IT-Sicherheit zu gewährleisten.', 235),
(236, b'1', 'Folgende Vorteile ergeben sich für ein nach ISO 27001 zertifiziertes Unternehmen: Ein wirksamer Schutz von Informationen, Daten und Geschäftsprozessen des Unternehmens wird gewährleistet; Die Zertifizierung ist ein Vertrauensnachweis gegenüber Kunden, Geschäftspartnern und Investoren; Die IT-Prozesse und Geschäftsprozesse werden kontinuierlich verbessert (PDCA-Zyklus); Durch die Vermeidung von Sicherheitsvorfällen werden die Kosten gemindert; Durch die Beseitigung von Schwachstellen beim Umgang mit Daten wird eine Risiko- und Chancenoptimierung erreicht; Das Sicherheitsbewusstsein der Mitarbeiter kann gefördert werden.', 236),
(237, b'1', 'Jeder kann die Annahme einer Sendung verweigern, wenn: diese nicht richtig adressiert wurde; das Paket Transportschäden aufweist; oder die Anzahl der zu liefernden Packstücke mit der Bestellung nicht übereinstimmt. Bei Transportschäden oder Falschlieferungen ist der Händler verpflichtet, kostenneutral die Ware erneut in einwandfreier und richtiger Anzahl zu liefern. Wichtig: Wenn jemand im Auftrag eines Unternehmens Ware aufgrund von Mängeln ablehnt, muss der Mangel sofort beim Lieferanten angezeigt werden.', 237),
(238, b'1', 'Eskalationsstufen im IT-Kundensupport werden definiert anhand des Schweregrads eines Falls und deren Eskalationsansprechpartner. Auslöser von Eskalationen sind: Schweregrad eines Supportfalls; Zeit (eine Eskalation erfolgt, wenn der Supportfall nicht innerhalb der in einem Service Level Agreement vereinbarten maximalen Lösungszeit gelöst werden kann); Supportfälle aufgrund hinterlegter Regeln. Eskalationsansprechpartner in einer Eskalationshierarchie: 1st Level Support (erste Anlaufstelle für Probleme); 2nd Level Support (Incident Manager, Einsatz von IT-Spezialisten); 3rd Level Support (Einsatz von Produktexperten oder Entwicklern).', 238),
(239, b'1', 'Mit den Service Level Agreements (SLAs) werden die Prioritäten bei der Bearbeitung von Service-Fällen zwischen Kunden und Anbieter definiert. Service Level Agreements dienen der Qualitätssicherung und werden in einer Vereinbarung anhand von Leistungseigenschaften und Gütestufen der Dienstleistung oder der Produkte vertraglich festgelegt. Zu diesen Vereinbarungen zählen beispielsweise: Vertragslaufzeit; Vertragsziel, z. B. Gewährleistung von minimalen Ausfallzeiten; Servicezeiten, z. B. Mo-Fr in der Zeit 07:00-18:00 Uhr; Verantwortlichkeiten von Auftraggeber und -nehmer, z. B. Meldepflichten; Kommunikation zwischen Auftraggeber und Auftragnehmer, z. B. Mail, Fax, vor Ort Einsatz; Supportlevel nach Kategorien; Reaktionszeit, z. B. Fallbearbeitung innerhalb von 24 Stunden; Sanktionen bei Nichterfüllung des Vertrages.', 239),
(240, b'1', 'In einem Kaufvertrag können abweichend der Regelungen des Bürgerlichen Gesetzbuchs (BGB) oder des Handelsgesetzbuchs (HGB) verschiedene Inhalte vertraglich festgelegt werden. Grundsätzlich sind in §§ 433 bis 453 BGB (Allgemeine Vorschriften zum Kaufvertrag) Dinge geregelt wie: Vertragstypische Pflichten beim Kaufvertrag, z. B. Eigentumsübertragung, Zahlung des Kaufpreises; Rechte des Käufers bei Mängeln, z. B. Nacherfüllung, Minderung; Garantie, z. B. Garantiedauer über der gesetzlichen Mängelhaftung (Gewährleistung); Haftungsausschluss, z. B. Ausschließung bestimmter Sacheigenschaften.', 240),
(241, b'1', 'First-Level-Support: gilt als erste Anlaufstelle für alle Supportanfragen. Die Mitarbeiter erfassen dort alle vollständigen Daten zur Person und zum Fall sowie alle zusätzlichen Informationen, die nützlich sind, um den Fall schnell zu lösen. Im Normalfall versuchen die Mitarbeiter den Fall weitestgehend selbstständig zu lösen, um ihn andernfalls weiter zu eskalieren. Second-Level-Support: kommt zum Einsatz, wenn der Fall nicht durch den First-Level-Support gelöst werden konnte oder zu komplex ist. Neue Erkenntnisse oder Ergebnisse werden in eine Wissensdatenbank zur Unterstützung des First-Level-Supports eingetragen. Third-Level-Support: ist die höchste Eskalationsstufe, in der sich Spezialisten des Falls annehmen, um auf Hersteller- oder Entwicklungsebene eine Lösung zu finden bzw. zu erarbeiten. Das Ergebnis eines Support-Falls bzw. dieser Lösungsfindung kann bis hin zur Produktveränderung führen oder zu einem Re-Design.', 241),
(242, b'1', 'In einem Vertrag zur Softwareerstellung sollten beispielsweise folgende Inhalte geregelt sein: Vertragsgegenstand (Lastenheft); Entwicklung und Herstellung (Pflichtenheft); Qualitätsstandard; Fertigstellungstermin; Nutzungsrechte; Haftung; Abnahme; Vergütung.', 242),
(243, b'1', 'IT-Serviceverträge werden individuell zwischen dem Auftragnehmer und dem Kunden geschlossen. Sie enthalten in der Regel folgende Angaben: Angaben zum Wartungsgegenstand, z. B. Anzahl der IT-Systeme, Standorte; Informationen zur Erbringung der Dienstleistungen und Einsatzzeiten, z. B. Mo-Fr in der Zeit 08:00-16:00 Uhr; Klärung der Mitwirkung des Kunden, Hinweise zur Erreichbarkeit des Ansprechpartners, z. B. Mobilfunknummer des Kunden; Angaben zur Mängelgewährleistung; Informationen zum Datenschutz und zur Datensicherheit; Regelungen zur Haftung bei Datenverlust; Höhe der Vergütungen; Laufzeit und Kündigung des IT-Servicevertrages; Informationen zu Nebenabreden; Salvatorische Klausel.', 243),
(244, b'1', 'Durch den Kauf von Green-IT Komponenten, Nutzung von Standby-Regeln für Monitor und Desktops, Nutzung von SSD- anstatt HDD-Datenträgern, Einsatz von Abschaltautomatiken sowie der Virtualisierung von Servern und Applikationen kann effektiv zum Umweltschutz beigetragen werden.', 244),
(245, b'1', 'Die Ertragsziele, die Marktziele sowie die Leistungsziele zählen zu den ökonomischen Zielen eines Unternehmens. Zu den Ertragszielen zählt alles, was mit den Begriffen Umsatz, Gewinn und Kapital zusammenhängt. Marktziele definiert der Unternehmer selbst, indem er festlegt, welchen gewünschten Marktanteil er haben möchte bzw. welche Steigerung des Marktanteils er für sich in Aussicht stellt. Als Leistungsziel werden gewisse Qualitätsstandards sowie die Sicherstellung der Arbeitsplätze definiert.', 245),
(246, b'1', 'Beim Cloud-Computing unterscheidet man drei Cloud-Service-Ebenen, die wie bei einer Pyramide aufeinander aufbauen: Infrastructure as a Service (IaaS) ist im Wesentlichen der Ersatz für traditionelle Rechenzentren. Platform as a Service (PaaS) beschreibt eine Architektur, in der die Entwicklungs- und Laufzeitumgebungen für Software bereitgestellt werden. Software as a Service (SaaS) beschreibt ein Konzept, bei dem Software nicht länger als Lizenz an einen Benutzer verkauft wird, sondern ihm gleich als Service zur Verfügung gestellt wird.', 246),
(247, b'1', 'Ein Organigramm ist eine Art Übersichtsbild der Organisation eines Unternehmens, auch Organisationsschaubild genannt, welches in grafischer Form die interne Struktur bzw. Aufbauorganisation des Unternehmens abbildet. Der Begriff Organigramm ist zusammengesetzt aus Organisation und Diagramm. Folgende Informationen über die interne Struktur sind im Organigramm enthalten: Übersicht der Standorte und Leitungen beim Unternehmensverbund; Aufteilung der betrieblichen Aufgaben auf Stellen und Abteilungen; Namentliche und personelle Besetzung (Stäbe, Abteilungen, Stellen); Struktur der Aufbau- bzw. Leitungsorganisation; Abbildung der Weisungsbeziehungen; Leitungshilfsstellen.', 247),
(248, b'1', 'Eine Aufbauorganisation ist eine Art hierarchische Struktur eines Unternehmens, einer Behörde oder einer Organisation. Sie gliedert ein Unternehmen in Aufgabenbereiche und bestimmt dabei Abteilungen, Leitungsebenen sowie Stabsstellen. Das Ergebnis dieser Struktur wird in der Regel in Form eines Organigramms visualisiert. Es gibt zur Darstellung verschiedene Organisationsformen, wie das Einliniensystem, das Mehrliniensystem, die Stablinienorganisation sowie die Matrixorganisation.', 248),
(249, b'1', 'Das Mehrliniensystem ist ein Begriff aus der klassischen Aufbauorganisation der Leitungssysteme. In einem Mehrliniensystem erhält die untergeordnete Stelle von mehreren übergeordneten Stellen Weisungen. Es gilt das Prinzip der kürzesten Wege.', 249),
(250, b'1', 'Eine Stabsstelle stellt in der Aufbauorganisation ein Element der Organisationseinheit dar. In einem Stabliniensystem bzw. Stablinienorganisation unterstützt die Stabsstelle andere Stellen oder Abteilungen und trägt zur Lösung einer Aufgabe bei. Stabsstellen dienen der Entscheidungsfindung und zur Lösung verschiedener Aufgaben im Unternehmen, sie treffen jedoch selbst keine Entscheidungen.', 250),
(251, b'1', 'Das Stabliniensystem ist eine Form der Leitungssysteme und ergänzt das Einliniensystem durch Stabsstellen. Die Stabsstellen sollen andere Stellen/Abteilungen bei ihren Aufgaben entlasten und unterstützen. Stabsstellen können auch dem gesamten Unternehmen bzw. der Leitung zur Verfügung stehen und unterstützend wirken.', 251),
(252, b'1', 'Die Matrixorganisation stellt die Erweiterung des Mehrliniensystems dar. In einer Matrixorganisation wird jede Stelle von zwei Entscheidungslinien der vertikalen Linie und der horizontalen Linie beeinflusst. Zu den Vorteilen der Matrixorganisation zählen die Förderung der Teamarbeit und flexible Berücksichtigung von Anforderungen. Nachteilig wirken sich der erhöhte Kommunikationsaufwand bzw. unklare Kompetenzregeln auf diese Form der Organisation aus.', 252),
(253, b'1', 'ppa. – per procura autoritate. Gemäß § 49 Abs. 1 HGB ermächtigt die Prokura „zu allen Arten von gerichtlichen und außergerichtlichen Geschäften und Rechtshandlungen, die der Betrieb eines Handelsgewerbes mit sich bringt\". Die Prokura muss mittels ausdrücklicher Erklärung erteilt werden (vgl. § 48 Abs. 1 HGB) und muss ins Handelsregister eingetragen werden (vgl. § 53 Abs. 1 HGB). i. V. – in Vollmacht. Vollmacht nach BGB bzw. Handlungsvollmacht nach HGB; benötigt wird hier vom Arbeitgeber/Inhaber eine Bevollmächtigung. i. A. – im Auftrag. Vollmacht nach BGB bzw. Handlungsvollmacht nach HGB, ist nicht klar geregelt. HGB – Handelsgesetzbuch; BGB – Bürgerliches Gesetzbuch.', 253),
(254, b'1', 'Die Prokura (handelsrechtliche Vollmacht) ermächtigt gemäß § 49 Abs. 1 HGB „zu allen Arten von gerichtlichen und außergerichtlichen Geschäften und Rechtshandlungen, die der Betrieb eines Handelsgewerbes mit sich bringt\". Die Prokura ist eine Art Handlungsvollmacht für Personen im Unternehmen. Sie kann nur vom Inhaber eines Handelsgewerbes oder dessen gesetzlichen Vertreter erteilt werden. Die Prokura ist ab Erteilung rechtskräftig, muss jedoch ins Handelsregister eingetragen werden. Erlischt die Prokura, muss auch das im Handelsregister vermerkt werden. Von der Prokura ausgenommen sind Unterzeichnung von Bilanzen und Steuererklärung, Beantragung von Einträgen ins Handelsregister, Erteilung der Prokura, Insolvenzantrag, Auflösung des Handelsgeschäfts, Verkauf oder Belastung von Grundstücken. Letzteres ist zulässig, wenn diese Befugnis besonders erteilt wurde. Formen der Prokura: Einzelprokura, Filialprokura, Gesamtprokura (vgl. §§ 48 ff. Handelsgesetzbuch).', 254),
(255, b'1', 'Die doppelte Buchführung, auch Soll- und Haben-Buchung genannt, ist eine Methode der Buchhaltung, bei der jeder Geschäftsvorfall doppelt gebucht wird. Sie dient dem kaufmännischen Zweck, Mittelherkunft und Mittelverwendung nachvollziehbar zu machen. Es existieren zwei grundlegende Kontoarten, die Bestandskonten und die Erfolgskonten. Bestandskonten gliedern sich in Aktivkonten und Passivkonten (jeweils mit Soll und Haben) und münden in die Bilanz. Erfolgskonten gliedern sich in Aufwandskonten und Ertragskonten (jeweils mit Soll und Haben) und münden in die Gewinn- und Verlustrechnung.', 255),
(256, b'1', 'Der Begriff berufliche Fortbildung ist ein Teilbereich der Berufsbildung und im Berufsbildungsgesetz (BBiG) geregelt, um die berufliche Handlungsfähigkeit zu erhalten, anzupassen oder eine höherqualifizierte Berufsbildung zu erlangen oder beruflich aufzusteigen. Anders ist es bei der beruflichen Umschulung. In § 1 Ziele und Begriffe der Berufsbildung des BBiG Abs. 5 heißt es: „Die berufliche Umschulung soll zu einer anderen beruflichen Tätigkeit befähigen\". (vgl. § 1 BBiG)', 256),
(257, b'1', 'Die berufliche Weiterbildung ist die klassische Form der Vertiefung oder der Ergänzung der erlangten beruflichen Kenntnisse. Das können zum Beispiel sein: weiterführende Kurse und Seminare; Erlangung von Zertifikaten und Zusatzqualifikationen; Fachwirt-, Meister- oder Betriebswirtkurse; Sprachunterricht, der die berufliche Tätigkeit unterstützt.', 257);
INSERT INTO `antworten` (`id`, `ist_richtig`, `text`, `frage_id`) VALUES
(258, b'1', 'Folgende Testverfahren werden in der Anwendungsentwicklung angewendet: Black-Box-Test/White-Box-Test; Komponententest; Unittest; Modultest; Integrationstest; Systemtest; Abnahmetest; Lasttest.', 258),
(259, b'1', 'Als Black-Box-Test wird eine Methode des Softwaretests bezeichnet. Bei diesem Testverfahren geht es darum, dass der Tester ohne Kenntnisse über die innere Funktionsweise bzw. Implementierung des Systems das Verhalten bzw. die Funktionen testet. Es wird nur das sichtbare Verhalten der Funktion oder des Gesamtsystems betrachtet und getestet. Der White-Box-Test hingegen richtet den Blick auf den implementierten Algorithmus und überprüft die Korrektheit des Quellcodes.', 259),
(260, b'1', 'Mit Nachhaltigkeit ist generell ein bewusstes, verantwortungsvolles Handeln gemeint, welches die vorhandenen Ressourcen unserer Umwelt schont. Dazu gehören im Besonderen in der Informationstechnologie folgende Punkte: Einsparung an Energie durch Einsatz von Virtualisierungstechnologien; Erhöhung der Energieeffizienz durch Nutzung von Standby-Technologien; Nutzung regenerativer Energien zum Betreiben von Rechenzentren; Einschränkung des Verbrauchs von Papier, Kunststoff, Druckerfarbe usw.; Free Cooling (Nutzung von Kaltluft und kaltem Wasser aus der Umwelt).', 260),
(261, b'1', 'Zu den wesentlichen Bestandteilen eines Abnahmeprotokolls gehören: Gegenstand der Abnahme; beteiligte Personen/Firmen; Ort, Datum und Uhrzeit der Abnahme des Produkts; Abnahmekriterien, wie Vollständigkeit der vereinbarten Liefergegenstände und Leistungen sowie Qualität der Liefergegenstände und Leistungen; Erfüllung der technischen Anforderungen, wie der Nachweis der funktionellen und nicht-funktionellen Anforderungen; Unterschriften von je einem autorisierten Vertreter des Auftraggebers und des Auftragnehmers; Umgang mit offenen Punkten.', 261),
(262, b'1', 'Nach erbrachter Leistungserbringung muss der Auftraggeber mit dem Auftragnehmer eine Teil- oder Vollabnahme vereinbaren. Der Auftragnehmer überprüft alle Positionen des Auftrages auf korrekte und funktionelle Umsetzung und beide Parteien fertigen zu diesem Zweck gemeinsam ein Abnahmeprotokoll an. In diesem Abnahmeprotokoll werden folgende Dinge protokolliert: Ort, Datum und Uhrzeit der Abnahme; Namen der autorisierten Personen des Auftraggebers sowie Auftragnehmers; qualitative sowie quantitative Mängelfreiheit; bei Mängeln die Fristen für deren Beseitigung bzw. Ersatzlieferungen; Unterschriften des Auftraggebers sowie des Auftragnehmers; Hinweis auf Gewährleistung und Garantien.', 262),
(263, b'1', 'Zur Einweisung in die Benutzung eines IT-Arbeitsplatzes gibt es folgende Methoden: Handbücher und Dokumentationen, welche dem Kunden dabei helfen, die Funktionen des IT-Arbeitsplatzes zu verstehen und anzuwenden; Persönliche Schulung durch IT-Fachpersonal, welches dem Kunden die Funktionalitäten des IT-Arbeitsplatzes entweder individuell oder spezifisch erklärt; Online-Schulung über Webportale oder virtuelle Schulungen ermöglichen dem Kunden weltweit, ohne Anreise, daran teilzunehmen. Ein Trainer, der diese Schulungen begleitet, kann auf individuelle Fragen des Kunden eingehen; Online Videos oder Tutorials sind geeignet, Kunden schrittweise anzuleiten und Funktionen eines IT-Arbeitsplatzes zu erläutern. Diese Videos können öffentlich oder im firmeneigenen Netzwerk zur Verfügung gestellt werden; Im Seminar werden in der Regel mehrere Kunden gleichzeitig auf einer Testumgebung im Umgang mit dem IT-Arbeitsplatz durch einen Trainer geschult. Diese Schulungsform ist geeignet, um sich mit allen Funktionen auf einer nicht produktiven Umgebung vertraut zu machen.', 263),
(264, b'1', 'Blended Learning (integriertes Lernen oder hybrides Lernen) ist eine Lernform, bei der traditionelle Präsenzveranstaltungen mit digitalen Lernmethoden kombiniert werden. Ziel des Blended Learnings ist es, die Vorteile beider Lernformen zu nutzen, um ein flexibleres und effektiveres Lernen zu ermöglichen. Die Präsenzveranstaltungen finden in einem Klassenzimmer oder Seminarraum statt, während das Online-Lernen über Lernplattformen wie Moodle oder Canvas erfolgt, die Inhalte und Aufgaben bereitstellen. Zu den digitalen Lernmethoden gehören auch Webinare, Online-Videos und E-Books. Ein weiterer positiver Aspekt ist die Kosteneffizienz, die durch die Reduzierung von Reisetätigkeiten und Seminarkosten erreicht wird.', 264),
(265, b'1', 'Der Begriff Rollout kommt aus dem Englischen und bedeutet so viel wie „herausrollen\" oder „ausrollen\". Damit ist eine Art Prozess der Einführung von neuer Hard- und Software, aber auch die Markteinführung von neuen Produkten im Allgemeinen, gemeint. Bei einem IT-Hardware Rolloutprozess unterscheidet man zwischen einem Austausch alter Hardware gegen neue Hardware oder der Einführung komplett neuer Hardware in einem neuen Standort. Der Begriff Rollout wird auch im Bereich der Softwareverteilung in Unternehmen genutzt.', 265),
(266, b'1', 'Bei einem Software-Rollout bzw. einer Softwareverteilung im Unternehmen muss die Software, die es zu veröffentlichen und zu verteilen gilt, hinsichtlich der Kompatibilität gegenüber der eingesetzten Hardware geprüft werden. Wenn die Software automatisch verteilt werden soll, dann muss die Software, die neu installiert oder als Update verteilt werden soll, mit Hilfe einer Paketierungssoftware für das Verteilen vorbereitet werden. In Abhängigkeit der Paketierung kommt eine entsprechende Verteilungssoftware zum Einsatz, welche die Veröffentlichung, auch deployen genannt, übernimmt.', 266),
(267, b'1', 'Folgende Dinge müssen bei einem IT-Hardware-Rollout beachtet werden: Einsatz eines Rollout-Managers, der die Prozesse koordiniert und überwacht; Datenmigration bei Austausch von alter gegen neue Hardware; Ermittlung der Asset-Tags bzw. Dokumentation der Asset-Tags; Kompatibilität der Software zur Hardware klären; Backupkonzept zur Datensicherung der Systeme abstimmen; Terminüberwachung des Rolloutprozesses durch den Rollout Manager; Terminabstimmung mit Kunden wie, wo und wann der Rolloutprozess gestartet wird.', 267),
(268, b'1', 'Kauf: Der Käufer erwirbt ein Wirtschaftsgut. Er ist zur Zahlung des vereinbarten Kaufpreises verpflichtet. Der Verkäufer ist verpflichtet, dem Käufer das Eigentum an diesem Wirtschaftsgut zu übertragen und ihm die Ware zu übergeben (falls nicht anders vereinbart). Miete: Der Vermieter ist Eigentümer eines Objekts. Dieses überlässt er dem Mieter gegen regelmäßige Zahlung zur Nutzung. Die Nutzungsdauer wird meist vertraglich im Vorfeld festgelegt. Der Vermieter sichert zu, dass das Objekt die vereinbarten Eigenschaften aufweist. Er bleibt Eigentümer der Sache und trägt alle Rechte, Risiken und Pflichten. Leasing: Besondere Form des Mietvertrags. Der Leasing-Nehmer least ein Wirtschaftsgut für eine bestimmte Laufzeit und übernimmt alle Rechte, Risiken und Pflichten des Leasing-Objektes, wie z. B. Abnutzung, Wartung und Reparatur. Ausnahmen bilden sogenannte Full-Service Verträge. Während der Leasinglaufzeit bleibt das Leasing-Objekt in der Regel juristisch und wirtschaftlich das Eigentum des Leasing-Gebers.', 268),
(269, b'1', 'Vorteile beim Kauf sind: Wirtschaftsobjekt wird nach dem Erwerb sofort juristisch und wirtschaftlich Eigentum; volle Verfügungsgewalt über das erworbene Wirtschaftsobjekt; Wiederverkauf ist jederzeit möglich; Einsatz des Wirtschaftsobjekts ist an keine Laufzeiten gebunden; Anschaffung von IT-Hardware kann steuerlich als Betriebsausgaben geltend gemacht werden. Nachteile beim Kauf sind: Kauf von IT-Hardware bindet Unternehmensvermögen und kann die Liquidität des Unternehmens mindern oder sogar gefährden; Nutzungsdauer von IT-Hardware ist oft länger als bei Leasing oder Miete (Überalterung der Hardware).', 269),
(270, b'1', 'Leasing Vorteile sind: Leasing ist eine Art Fremdfinanzierung, während jeder Kauf oft Eigenmittel erfordert; Leasing führt nicht zu einer sofortigen Belastung der Liquidität. Stattdessen sind die monatlichen Raten gut planbar; Leasing-Gegenstand gehört nicht zum Anlagevermögen. Leasing ist bilanzneutral; Leasing-Geber (Hersteller) kümmert sich um Reparatur oder Ersatz; Immer neue Technik. Leasing Nachteile sind: Leasingobjekt bleibt Eigentum des Leasinggebers; Verträge sind normalerweise nicht kündbar und haben eine feste Laufzeit (oft 1-5 Jahre); Gesamtkosten sind gegenüber einem Kauf oft höher.', 270);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `benutzern`
--

CREATE TABLE `benutzern` (
  `id` bigint(20) NOT NULL,
  `benutzername` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `passwort_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fragen`
--

CREATE TABLE `fragen` (
  `id` bigint(20) NOT NULL,
  `schwierigkeit` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `themen_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `fragen`
--

INSERT INTO `fragen` (`id`, `schwierigkeit`, `text`, `themen_id`) VALUES
(1, 'leicht', 'Nenne Merkmale eines Projekts.', 1),
(2, 'leicht', 'Mit welchen Werkzeugen kann man ein Projekt planen und überwachen?', 1),
(3, 'leicht', 'Was ist ein Netzplan im Projektmanagement?', 1),
(4, 'leicht', 'Was ist ein Gantt-Diagramm?', 1),
(5, 'mittel', 'Was versteht man unter dem Top-Down-Ansatz beim Projektstrukturplan?', 1),
(6, 'mittel', 'Was versteht man unter dem Begriff Bottom-Up-Ansatz beim Projektstrukturplan?', 1),
(7, 'mittel', 'Was versteht man unter dem 4-Phasen-Modell beim Projektmanagement?', 1),
(8, 'mittel', 'Was bezeichnet man als kritischen Pfad beim Netzplan?', 1),
(9, 'leicht', 'Bitte ergänze die fehlenden Elemente und Bezeichnungen eines Vorgangs des Netzplans.', 1),
(10, 'mittel', 'Was versteht man unter Forming/Storming/Norming/Performing im Teambildungsprozess?', 1),
(11, 'schwer', 'Was bezeichnet man als Kick-Off-Meeting?', 1),
(12, 'mittel', 'Was versteht man unter einer Meilenstein-Planung?', 1),
(13, 'mittel', 'Welche Vorgehensmodelle solltest du im Projektmanagement / in der Anwendungsentwicklung kennen?', 1),
(14, 'mittel', 'Wähle anhand der Darstellung den kritischen Pfad aus.', 1),
(15, 'mittel', 'Erläutere die Vor- und Nachteile des Wasserfallmodells.', 1),
(16, 'schwer', 'Was sind Bestandteile einer Risikoanalyse?', 1),
(17, 'mittel', 'Was versteht man unter dem Begriff Stakeholder?', 1),
(18, 'mittel', 'Welches sind die Hauptziele der Datensicherheit?', 1),
(19, 'mittel', 'Wie errechnet sich der Gewinn eines Unternehmens?', 1),
(20, 'leicht', 'Was versteht man unter einer Machbarkeitsanalyse?', 1),
(21, 'mittel', 'Was sind Ziele einer Machbarkeitsanalyse?', 1),
(22, 'mittel', 'Wie berechnet sich der Deckungsbeitrag bei Unternehmen?', 1),
(23, 'schwer', 'Welche Arten von Äußerungen sind in einem Kundengespräch nicht förderlich?', 1),
(24, 'mittel', 'In welchem Softwaresystem werden in der Regel Supportanfragen verarbeitet?', 1),
(25, 'mittel', 'Nenne die Vorteile für ein User-Helpdesk-Ticketsystem.', 1),
(26, 'leicht', 'Wie können KI-Systeme in der Informations- und Kommunikationstechnologie (IuK) unterstützen?', 1),
(27, 'mittel', 'Was versteht man unter dem Begriff volkswirtschaftliche Sektoren?', 2),
(28, 'leicht', 'Was versteht man unter der Marktform des Monopols?', 2),
(29, 'mittel', 'Wann spricht man in der Wirtschaft von einem Angebotsoligopol?', 2),
(30, 'leicht', 'Was versteht man unter dem Begriff IT-Benchmarking?', 2),
(31, 'leicht', 'Welche Kriterien müssen erfüllt sein für ein Marktgleichgewicht?', 2),
(32, 'leicht', 'Wann spricht man von einem Käufermarkt?', 2),
(33, 'leicht', 'Welche Aufgaben und Ziele verfolgen die betrieblichen Grundfunktionen?', 2),
(34, 'schwer', 'Welche Merkmale besitzt eine Europäische Gesellschaft (lateinisch Societas Europaea, kurz SE genannt)?', 2),
(35, 'mittel', 'Welche Kriterien müssen für die Marktform des Polypols erfüllt sein?', 2),
(36, 'mittel', 'Welche Unternehmensformen sind in Deutschland Personengesellschaften?', 2),
(37, 'mittel', 'Welche Bedingungen und welche Haftungsregeln gelten bei einer offenen Handelsgesellschaft – OHG?', 2),
(38, 'mittel', 'Ein Betriebsergebnis errechnet sich aus den Umsatzerlösen minus den Umsatzkosten. Welche Sachverhalte können das Betriebsergebnis positiv beeinflussen?', 2),
(39, 'leicht', 'Unternehmen richten ihre Produkte und Dienstleistungen mit Hilfe von Marketingmaßnahmen nach den Kundenwünschen aus. Welchem Zweck dienen in diesem Zusammenhang Kundenbefragungen?', 2),
(40, 'leicht', 'In der Kundenkommunikation, im Speziellen während der Fehleranalyse im Telefonsupport, sind Fragen von besonderer Bedeutung. Unterscheide bitte geschlossene und offene Fragen.', 2),
(41, 'schwer', 'Das Controlling im Unternehmen wird als eine Funktion des Managements gesehen, dessen zentrale Aufgabe die Planung, Steuerung sowie die Kontrolle aller Unternehmensbereiche ist. Wozu dient dabei eine ABC-Analyse?', 2),
(42, 'leicht', 'Was versteht man unter dem Begriff Cross-Selling?', 2),
(43, 'mittel', 'Ergänze nach dem Vier-Ohren-Modell (Sachebene, Appell, Selbstoffenbarung und Beziehung) die folgenden Aussagen eines Kunden gegenüber eines Vertriebsmitarbeiters. 1. Sie müssen pünktlich liefern! 2. Ich bin mit Ihnen nicht zufrieden. 3. Sie haben nicht pünktlich geliefert. 4. Ich kontrolliere Ihre Leistungen sehr genau.', 2),
(44, 'leicht', 'Welche Regeln sollte man im telefonischen Kundensupport beachten?', 2),
(45, 'leicht', 'Beschreibe den Begriff Pre-Sales-Angebot und nenne 3 Beispiele.', 2),
(46, 'mittel', 'Webinare, auch Online-Schulungen genannt, werden in zunehmendem Maße genutzt. Welche Vor- und Nachteile bieten Webinare?', 2),
(47, 'leicht', 'Nenne die englischen Bezeichnungen der einzelnen Schichten im OSI-Referenzmodell.', 2),
(48, 'schwer', 'Was ist eine Nutzwertanalyse?', 2),
(49, 'mittel', 'Unternehmen müssen ihre Produkte am Markt anbieten. Nenne Vor- und Nachteile eines direkten Vertriebs.', 2),
(50, 'schwer', 'Mit welchen Maßnahmen kann man die Kundenzufriedenheit erhöhen?', 2),
(51, 'schwer', 'Welchem Zweck dient ein Angebotsvergleich?', 2),
(52, 'schwer', 'Was ist bei der Außerbetriebnahme von IT-Systemen zu beachten?', 2),
(53, 'mittel', 'Worin besteht in der Virtualisierung von Hostsystemen der Unterschied zwischen dem Hypervisor Typ 1 und Typ 2?', 3),
(54, 'leicht', 'Welche Funktionen bietet eine Dockingstation für Notebooks?', 3),
(55, 'mittel', 'Welche Video-Schnittstellen sind für 4K und 8K Auflösung geeignet?', 3),
(56, 'leicht', 'Welche technischen Merkmale hat ein Notebook?', 3),
(57, 'mittel', 'Erläutern Sie den Begriff \'Logische Prozessoren\'.', 3),
(58, 'leicht', 'Welchen Vorteil bringt der Einsatz von Dual-Channel-Technik bei Speichermodulen?', 3),
(59, 'leicht', 'Was verbirgt sich hinter der Bezeichnung UHD 4K?', 3),
(60, 'leicht', 'Was versteht man unter einem Thin-Client?', 3),
(61, 'leicht', 'Welche IT-Komponenten sind Ein- oder Ausgabegeräte? (a) Drucker b) Scanner c) Maus d) Display e) Touchpad)', 3),
(62, 'leicht', 'Welche Schnittstellen sind auf dem Bild zu sehen? (Schnittstellen-Karte)', 3),
(63, 'leicht', 'Nenne Vorteile des USB-C Anschlusses gegenüber den USB-Typen A und B.', 3),
(64, 'mittel', 'Nenne die verschiedenen Cloud-Formen, die durch Cloud Computing angeboten werden.', 3),
(65, 'leicht', 'Was versteht man unter dem Begriff Green-IT?', 3),
(66, 'leicht', 'Erkläre den Begriff des Servicemodells Infrastructure as a Service (IaaS).', 3),
(67, 'mittel', 'Nenne die Vorteile des Servicemodells PaaS (Platform as a Service).', 3),
(68, 'leicht', 'Erkläre den Cloud Computing Begriff Software as a Service (SaaS).', 3),
(69, 'leicht', 'Was ist ein Host-Bus-Adapter?', 3),
(70, 'schwer', 'Eine USV wird nach IEC 62040-3 in 3 Klassen unterteilt. Nenne die 3 Klassen und erkläre deren Wirkungsweise.', 3),
(71, 'mittel', 'Welche Aufgabe übernimmt eine USV (unterbrechungsfreie Stromversorgung)?', 3),
(72, 'mittel', 'Welche Aufgabe übernimmt ein Datenbankmanagementsystem (DBMS)?', 3),
(73, 'mittel', 'Was ist eine DMZ?', 3),
(74, 'mittel', 'Welche Aufgabe hat ein Netzwerk-Router?', 3),
(75, 'schwer', 'Nenne die 4 transportorientierten Schichten des OSI-Modells und erläutere deren Aufgaben.', 3),
(76, 'schwer', 'Sortiere folgende Begriffe in das OSI-Modell ein: Switch Layer 4-7, IP/ICMP, IEEE 802.3, Netzwerkkabel/Hub, Switch, 1000BASE-T, DNS/DHCP/IMAPS/SMTPS/HTTPS.', 3),
(77, 'mittel', 'Was ist eine Broadcast-Domäne?', 3),
(78, 'mittel', 'Was ist ein Network Attached Storage (NAS)?', 3),
(79, 'mittel', 'Was ist ein Storage Area Network (SAN)?', 3),
(80, 'schwer', 'Ein Netzwerk (192.168.30.0/24) soll in 8 Subnetze unterteilt werden. Wie lautet die korrekte Subnetzmaske und wie viele Host-IP-Adressen stehen in allen 8 Subnetzen zur Verfügung?', 3),
(81, 'leicht', 'Was bedeutet in der Netzwerktechnologie der Begriff PoE?', 3),
(82, 'schwer', 'Wie lautet die Notation einer iSCSI-Verbindung?', 3),
(83, 'schwer', 'Wie wird eine Fibre Channel Verbindung adressiert?', 3),
(84, 'leicht', 'Erläutere den Begriff Unicast aus dem Bereich der Netzwerkkommunikation.', 3),
(85, 'leicht', 'Was versteht man unter dem Begriff Multicast?', 3),
(86, 'leicht', 'Erläutere bitte den Begriff Broadcast.', 3),
(87, 'leicht', 'Welche Aufgabe hat bei IPv4 eine Broadcast-Adresse?', 3),
(88, 'mittel', 'Beschreibe die Bestandteile einer IPv6-Adresse.', 3),
(89, 'schwer', 'Kürze die IPv6-Adresse 2003:00dc:075a:dd00:e130:c353:3188:afb6 und definiere den 64-bit Interface-Anteil.', 3),
(90, 'schwer', 'Benenne die IPv6-Adressbereiche: ::1/128, fe80::/10, 2000::/3, ff00::/8.', 3),
(91, 'mittel', 'Was versteht man bei IPv6 unter einer Stateless Address Autoconfiguration?', 3),
(92, 'mittel', 'Worin unterscheiden sich die Lichtwellenleiter der Single- und Multimodefasern?', 3),
(93, 'mittel', 'Nenne Vor- und Nachteile von Singlemode-Glasfasern.', 3),
(94, 'mittel', 'Nenne Vor- und Nachteile von Multimodefasern.', 3),
(95, 'mittel', 'Welche Aufgabe hat das Simple Network Management Protocol (SNMP)?', 3),
(96, 'mittel', 'Welche Aufgaben hat ein DHCP-Server innerhalb der IT-Infrastruktur?', 3),
(97, 'mittel', 'Welche Informationen stellt der DHCP-Dienst zur Verfügung?', 3),
(98, 'schwer', 'Vergleiche die Protokolle UDP und TCP miteinander.', 3),
(99, 'mittel', 'Welche verkürzten Schreibweisen der IPv6-Adresse 2001:0db8:0f3c:00d7:7dab:03d0:0000:00ff sind erlaubt?', 3),
(100, 'mittel', 'Was versteht man im Netzwerkbereich unter dem Quality of Service?', 3),
(101, 'leicht', 'Wann kommt ein tagged VLAN zum Einsatz?', 3),
(102, 'mittel', 'Beschreibe typische Merkmale des Client-Server-Modells.', 3),
(103, 'mittel', 'Welche Aufgaben hat ein Domain Name System (DNS) in einer Windows-Domänenlandschaft bzw. Active Directory?', 3),
(104, 'schwer', 'Unterscheide die Mailingprotokolle IMAPS, SMTPS sowie POP3/S nach ihren Eigenschaften.', 3),
(105, 'mittel', 'Erläutere den Unterschied zwischen einem Switch und einem Router.', 3),
(106, 'mittel', 'Was bedeutet der Begriff Standby- oder Offline-USV?', 3),
(107, 'mittel', 'Was versteht man unter einer Online-USV?', 3),
(108, 'mittel', 'Was versteht man unter der Bezeichnung Netzinteraktive USV?', 3),
(109, 'leicht', 'Was bedeutet der Begriff SSID (Service Set Identifier)?', 3),
(110, 'leicht', 'Was versteht man unter den Begriffen CMS-, ERP- und CRM-System?', 3),
(111, 'mittel', 'Welche Maßnahmen sind geeignet, um die Verarbeitungsgeschwindigkeit eines PCs zu verbessern?', 3),
(112, 'mittel', 'Ermittle Vor- und Nachteile einer M.2-SSD.', 3),
(113, 'mittel', 'Nenne Vor- und Nachteile einer SATA-SSD.', 3),
(114, 'mittel', 'Erläutere den Begriff des CPU-Caches.', 3),
(115, 'leicht', 'Erläutere, welche Aufgabe die Wärmeleitpaste zwischen der CPU und dem Kühler hat.', 3),
(116, 'schwer', 'Berechne die Gesamtleistungsaufnahme für 10 Server (800 W), 25 Desktop-PCs (350 W) und 2 Switches (200 W) für ein Jahr im 24/7-Betrieb. Ergebnis in Kilowatt.', 3),
(117, 'leicht', 'Wie berechnet man die Wirkleistung von elektrischen Geräten?', 3),
(118, 'mittel', 'Berechne die maximale Leistungsaufnahme an einer Mehrfachsteckdose mit maximal 16 A.', 3),
(119, 'schwer', 'Eine USV (20 Batterien je 12V/4,5 Ah) versorgt 4 Server mit 1,2 kW. Ein Datenspeicher (400 W) kommt hinzu. Berechne die Zeitdifferenz in Minuten, um die sich die Versorgung verkürzt.', 3),
(120, 'mittel', 'Nenne 3 Maßnahmen zur Verbesserung der WLAN-Empfangsqualität in Räumen mit schwachem Empfang.', 3),
(121, 'leicht', 'Was bedeutet es, wenn ein WLAN Access Point im Infrastructure Modus arbeitet?', 3),
(122, 'mittel', 'Was bedeutet der Begriff MIMO im Bereich der Nachrichtentechnik?', 3),
(123, 'schwer', 'Berechne die Energiekosten für 25 Arbeitsstationen (300 W je 9h/206 Arbeitstage), 3 Drucker (200 W je 24/7) und 2 Server (500 W je 24/7 minus 10h Wartung). Preis: 0,30 €/kWh.', 3),
(124, 'leicht', 'Was versteht man unter dem Begriff Multi-SSID?', 3),
(125, 'mittel', 'Nenne Vor- und Nachteile beim Einsatz eines 2,4-GHz- sowie eines 5-GHz-WLANs.', 3),
(126, 'leicht', 'Welche Speichermodule sind auf dem Bild zu erkennen? (DDR3 und SO-DIMM)', 3),
(127, 'leicht', 'Welches Modul ist auf dem Bild zu erkennen? (M.2-Modul)', 3),
(128, 'leicht', 'Welche Speicherkarte ist eine SD-Karte und welche ist eine microSD-Karte?', 3),
(129, 'leicht', 'Um welche Schnittstelle handelt es sich auf dem Bild? (SATA)', 3),
(130, 'mittel', 'Welche technischen Spezifikationen hat Bluetooth bezüglich Reichweite, Datentransferrate und Frequenzbereich?', 3),
(131, 'mittel', 'Nenne Vor- und Nachteile der Virtualisierung von Servern und Desktops.', 3),
(132, 'leicht', 'Was bedeutet der Begriff Serverkonsolidierung?', 3),
(133, 'schwer', 'Welche Arten von Anforderungen gibt es an Software?', 3),
(134, 'mittel', 'Welche Kosten entstehen für ein Rechenzentrum (on-Premises) mit einer Server-Client-Struktur?', 3),
(135, 'schwer', 'Vergleiche Leasing, Kauf und Pay-per-use für Server über 3 Jahre (Leasing: 36 Raten à 3.500 €, Service 30.000 €; Kauf: 100.000 €, Service 30.000 €; Pay-per-use: 3,22 €/h). Welches ist die kostengünstigste Variante?', 3),
(136, 'schwer', 'Aus welchen Bestandteilen besteht eine Handelskalkulation? Wie unterscheidet sie sich von der Zuschlagskalkulation?', 3),
(137, 'leicht', 'Was versteht man unter dem Begriff der Bedarfsanalyse?', 4),
(138, 'leicht', 'Nenne die Vorteile einer Bedarfsanalyse.', 4),
(139, 'mittel', 'Vergleiche BIOS mit UEFI.', 4),
(140, 'mittel', 'Beschreibe die Funktionsweise einer Remote Desktop Verbindung (RDP).', 4),
(141, 'mittel', 'Wie kann man mit Kommandozeilen-Werkzeugen in einer Windows-Umgebung die Namensauflösung überprüfen?', 4),
(142, 'mittel', 'Wähle die richtigen Kommandozeilenwerkzeuge für folgende Aufgaben: Netzwerkadapter konfigurieren, MAC-Adresse auslesen, Firewall-Regel hinzufügen, Erreichbarkeit prüfen, Status der Netzwerkverbindung, IPv4/IPv6 ermitteln, DHCP-Anzeige, Hostname, IPv6-MAC-Adressen.', 4),
(143, 'schwer', 'Nenne die 4 Features, die verhindern, dass während des Windows-Startvorgangs Schadsoftware (Rootkits, Bootkits) geladen wird.', 4),
(144, 'mittel', 'Erläutere den Unterschied zwischen Partitionierung und Formatierung eines Datenträgers.', 4),
(145, 'leicht', 'Was versteht man unter einem Service-Tag oder Asset-Tag?', 4),
(146, 'leicht', 'Welche Vorteile bringt der Einsatz von Thin-Clients in einer auf Desktop-Virtualisierung ausgerichteten IT-Landschaft?', 4),
(147, 'mittel', 'Was versteht man unter einem Pflichtenheft?', 4),
(148, 'mittel', 'Erläutere die Vor- und Nachteile beim Lizenzmodell Pay-per-use.', 4),
(149, 'mittel', 'Was wird in einem Lastenheft beschrieben?', 4),
(150, 'leicht', 'Was versteht man unter einem Convertible?', 4),
(151, 'leicht', 'Nenne einige Vor- und Nachteile von Tablets.', 4),
(152, 'leicht', 'Welche Vor- und Nachteile hat ein Notebook?', 4),
(153, 'leicht', 'Welcher digitale Anschluss ist auf dem Bild zu erkennen? (DisplayPort)', 4),
(154, 'mittel', 'Welche Hard- und Softwareanforderungen werden an einen Dateiserver im Unternehmen gestellt?', 4),
(155, 'mittel', 'Erläutere die Unterschiede zwischen ADSL, VDSL und SDSL.', 4),
(156, 'schwer', 'Berechne die Download-Zeit einer 2 GiB großen Datei über eine 50 Mbit/s ADSL-Verbindung.', 4),
(157, 'mittel', 'Worauf sollte man bei der Beschaffung von IT-Hardware achten?', 4),
(158, 'leicht', 'Was versteht man unter Standardsoftware?', 4),
(159, 'leicht', 'Was versteht man unter Individualsoftware?', 4),
(160, 'leicht', 'Was versteht man in der Anwendungsentwicklung unter dem Begriff IDE?', 4),
(161, 'leicht', 'Was bedeutet der Begriff \'Proprietäre Software\'?', 4),
(162, 'leicht', 'Nenne 3 charakteristische Eigenschaften von Open Source Software.', 4),
(163, 'mittel', 'Was ist unter den Begriffen OEM-Software und OEM-Hardware zu verstehen?', 4),
(164, 'mittel', 'Was versteht man bei Rechenzentrumsbetrieb unter Skalierbarkeit?', 4),
(165, 'leicht', 'Was beschreibt eine EULA (End User License Agreement)?', 4),
(166, 'mittel', 'Beschreibe das Modell Pay-per-use in der Informationstechnologie.', 4),
(167, 'mittel', 'Mit welchen Maßnahmen kann eine drahtlose Netzwerkverbindung (WLAN/WiFi) abgesichert werden?', 4),
(168, 'mittel', 'Welche 3 VPN-Verbindungsarten gibt es?', 4),
(169, 'mittel', 'Welche Merkmale hat ein Virtual Private Network (VPN)?', 4),
(170, 'mittel', 'Welche Sicherheitsmethoden und Verschlüsselungsstandards können beim Einsatz von WLAN im Unternehmen zum Einsatz kommen?', 4),
(171, 'mittel', 'Welches Befehlszeilenkommando zeigt IP-zu-MAC-Zuordnungen? Erläutere die Funktion des Protokolls.', 4),
(172, 'mittel', 'Welche Vorteile ergeben sich durch den Einsatz eines VLANs?', 4),
(173, 'leicht', 'Welches Befehlszeilenkommando wurde hier ausgeführt? (Routenverfolgung zu www.google.de)', 4),
(174, 'leicht', 'Welches Befehlszeilenkommando wurde hier ausgeführt? (DNS-Auflösung einer IP-Adresse)', 4),
(175, 'leicht', 'Welches Befehlszeilenkommando wurde hier ausgeführt? (Anzeige von Verbindungsname, Netzwerkadapter und physischer Adresse)', 4),
(176, 'leicht', 'Welches Befehlszeilenkommando wurde hier ausgeführt? (Ausführliche Netzwerkadapter-Konfiguration mit IPv4, DHCP, DNS)', 4),
(177, 'mittel', 'Welche Aufgabe erfüllt das Befehlszeilenkommando ARP?', 4),
(178, 'mittel', 'Beschreibe die Aufgabe und Funktionsweise des Befehls chmod in Linux.', 4),
(179, 'mittel', 'Was bedeutet im Zusammenhang mit Datenträgern S.M.A.R.T.?', 4),
(180, 'mittel', 'Bringe die Schritte einer Windows-Installation in die richtige Reihenfolge: a) Bootreihenfolge festlegen, b) POST, c) Benutzer+Passwort anlegen, d) EULA akzeptieren, e) Filesystem formatieren, f) Filesystem anlegen, g) Benutzerprofile erzeugen, h) Installationsmedium einlegen.', 4),
(181, 'leicht', 'Welche Kommandos oder Werkzeuge gibt es, um unter Linux eine IPv4-Adresse eines Netzwerkadapters anzuzeigen?', 4),
(182, 'mittel', 'Wie lautet das netsh-Kommando zum Einrichten einer IPv4-Adresse 192.168.0.1/24 mit Gateway 192.168.0.254 für den Adapter \'LAN-Verbindung\'?', 4),
(183, 'leicht', 'Welche Bedingungen müssen beim Einsatz von Arbeitsspeichern im Dual-Channel-Mode erfüllt sein?', 4),
(184, 'mittel', 'Welche Aussagen sind zutreffend, wenn ein Netzwerkadapter eine automatisch konfigurierte IP-Adresse im Bereich 169.254.x.x anzeigt?', 4),
(185, 'leicht', 'Was bedeutet der Begriff UML?', 4),
(186, 'mittel', 'Nenne einige UML-Verhaltensdiagramme sowie deren Zweck.', 4),
(187, 'mittel', 'Erkläre den Unterschied zwischen einem Objekt und einer Klasse.', 4),
(188, 'mittel', 'Welche allgemeinen Anforderungen werden an ein Datenbanksystem gestellt?', 4),
(189, 'schwer', 'Nenne die ersten drei Normalformen der Datenbank-Normalisierung und deren Zweck.', 4),
(190, 'schwer', 'Es gibt 5 Typen von SQL-Kommandos: DDL, DML, DCL, TCL und DQL. Nenne jeweils mindestens einen ausführbaren SQL-Befehl.', 4),
(191, 'schwer', 'Dein Ausbildungsbetrieb ist ISO 9001 zertifiziert. Was bedeutet diese Norm für deinen Ausbildungsbetrieb?', 5),
(192, 'schwer', 'Beschreibe den PDCA-Zyklus im Bereich des Qualitätsmanagements.', 5),
(193, 'schwer', 'Was bedeutet das Label \'Energy Star\'?', 5),
(194, 'mittel', 'Im Qualitätsmanagement spricht man oftmals, im Zusammenhang einer Zertifizierung, von einem Audit. Was versteht man unter einem Audit?', 5),
(195, 'leicht', 'Welchen Qualitätskriterien unterliegt Software?', 5),
(196, 'leicht', 'Was bedeutet das Gütesiegel \'Geprüfte Sicherheit\' (GS)?', 5),
(197, 'mittel', 'Was steckt hinter dem Zeichen \'Blauer Engel\'?', 5),
(198, 'mittel', 'Was sollte beim Recyceln von IT-Produkten beachtet werden?', 5),
(199, 'mittel', 'Was sollte man beim Verschrotten von Datenträgern unbedingt beachten?', 6),
(200, 'leicht', 'Was bedeutet der Begriff MFA (Multi-Factor-Authentication) und wo kommt sie zum Einsatz?', 6),
(201, 'mittel', 'Beschreibe den Begriff Datensicherheit und nenne deren Schutzziele.', 6),
(202, 'schwer', 'Worin unterscheiden sich Datensicherheit und Datenschutz?', 6),
(203, 'mittel', 'Was versteht man im Datenschutz unter technisch-organisatorischen Maßnahmen, kurz TOM?', 6),
(204, 'schwer', 'Durch welche konkreten Maßnahmen können technisch-organisatorische Maßnahmen (TOM) DSGVO-konform umgesetzt werden?', 6),
(205, 'mittel', 'Nenne die wesentlichen Vorteile einer ISO/IEC 27001 Zertifizierung für Unternehmen.', 6),
(206, 'leicht', 'Welches sind die Ziele bei der Datenminimierung?', 6),
(207, 'mittel', 'Welche Rechte hat eine Person betreffend ihrer personenbezogenen Daten laut DSGVO?', 6),
(208, 'schwer', 'Was ist eine PKI (Public Key Infrastructure)?', 6),
(209, 'mittel', 'Was versteht man unter einem digitalen Zertifikat?', 6),
(210, 'leicht', 'Was ist eine SPI (Stateful Packet Inspection) Firewall?', 6),
(211, 'leicht', 'Was versteht man unter dem Begriff Endpoint-Security?', 6),
(212, 'leicht', 'Welche Anwendungen oder Verfahren verwenden kryptografische Hashfunktionen?', 6),
(213, 'leicht', 'Nenne Einsatzbereiche und Verfahren von symmetrischen Schlüsseln.', 6),
(214, 'schwer', 'Ergänze die fehlenden Werte in der Tabelle symmetrischer und asymmetrischer Verschlüsselung.', 6),
(215, 'mittel', 'Erläutere den Unterschied zwischen einem differentiellen und inkrementellen Backup.', 6),
(216, 'schwer', 'Wie gestaltet sich ein vollständiger Backup-Plan nach dem Großvater-Vater-Sohn-Prinzip?', 6),
(217, 'mittel', 'Unterscheide die Begriffe Malware, Ransomware und Trojaner.', 6),
(218, 'mittel', 'Welchem Zweck dient das IT-Sicherheitsmanagement?', 6),
(219, 'leicht', 'Welche Kriterien muss eine sichere Passwortrichtlinie erfüllen?', 6),
(220, 'leicht', 'Erläutere, bezogen auf den Bereich der Entwicklung, den Begriff Security by Design.', 6),
(221, 'mittel', 'Benenne je 2 Vor- und Nachteile des Sicherheitstyps WPA2-Personal und WPA2-Enterprise.', 6),
(222, 'mittel', 'Welche Sicherheitsmaßnahmen sind beim Einsatz eines E-Mail-Systems zu beachten?', 6),
(223, 'mittel', 'Welche Bedingungen muss ein ergonomischer PC-Arbeitsplatz erfüllen?', 6),
(224, 'schwer', 'Welche Aussagen trifft die Arbeitsstättenverordnung (ArbStättV) in Bezug auf Bildschirm und Tastatur?', 6),
(225, 'mittel', 'Was ist der PDCA-Zyklus und aus welchen Schritten besteht er?', 6),
(226, 'mittel', 'Beschreibe die fünf Punkte der SMART-Methode im Projektmanagement.', 6),
(227, 'leicht', 'Welche Maßnahmen im Unternehmen haben einen positiven Effekt auf die Arbeitsqualität?', 6),
(228, 'mittel', 'Mit welchen Maßnahmen kann man im Unternehmen die Produktqualität entscheidend verbessern?', 6),
(229, 'mittel', 'Welches sind die allgemeinen Kriterien einer Schutzbedarfsanalyse von IT-Systemen?', 6),
(230, 'mittel', 'Beschreibe die Schutzbedarfskategorien (normal, hoch, sehr hoch) lt. BSI IT-Grundschutz.', 6),
(231, 'mittel', 'Welcher Schutzbedarf bzw. welche Schutzziele gelten für einen Router nach BSI IT-Grundschutz?', 6),
(232, 'mittel', 'Welche Maßnahmen sind geeignet, um Schäden an der IT-Infrastruktur zu vermeiden bzw. die Sicherheit der IT-Systeme zu erhöhen?', 6),
(233, 'schwer', 'Aus welchen Phasen besteht der Sicherheitsprozess laut BSI IT-Grundschutz?', 6),
(234, 'mittel', 'Welche Themen sind für einen TÜV geprüften IT-Sicherheitsbeauftragten für die IT-Sicherheit im Unternehmen von Bedeutung?', 6),
(235, 'mittel', 'Welches sind die Inhalte einer Zertifizierung nach ISO 27001?', 6),
(236, 'mittel', 'Was sind die Vorteile einer Zertifizierung nach ISO 27001?', 6),
(237, 'mittel', 'Welche Kriterien müssen erfüllt sein, um die Warenannahme zu verweigern?', 5),
(238, 'mittel', 'Was versteht man unter dem Begriff Eskalationsstufe im 3-stufigen IT-Kundensupport-Modell?', 5),
(239, 'schwer', 'Was versteht man in der Informationstechnologie unter dem Begriff Service Level Agreement (SLA)?', 5),
(240, 'mittel', 'Nenne die wesentlichen Bestandteile eines Kaufvertrags.', 5),
(241, 'schwer', 'Erläutere das mehrstufige Prinzip des First-Level-, Second-Level- und Third-Level-Supports.', 5),
(242, 'mittel', 'Welche Vertragsbestandteile sollten in einem Vertrag zur Softwareerstellung geregelt sein?', 5),
(243, 'mittel', 'Welche Bestandteile hat in der Regel ein IT-Servicevertrag?', 5),
(244, 'mittel', 'Mit welchen Maßnahmen kann der Umweltschutz im IT-Betrieb verstärkt berücksichtigt werden?', 5),
(245, 'mittel', 'Welches sind die ökonomischen Ziele eines Unternehmens?', 5),
(246, 'mittel', 'Unterscheide die 3 Cloud-Computing Begriffe IaaS, SaaS und PaaS.', 5),
(247, 'mittel', 'Was ist ein Organigramm?', 5),
(248, 'mittel', 'Was versteht man unter einer Aufbauorganisation?', 5),
(249, 'mittel', 'Was versteht man bei den Leitungssystemen unter einem Mehrliniensystem?', 5),
(250, 'mittel', 'Was versteht man bei Aufbauorganisationen unter einer Stabsstelle?', 5),
(251, 'schwer', 'Wie ist eine Stablinienorganisation aufgebaut?', 5),
(252, 'schwer', 'Was versteht man bei den Leitungssystemen unter dem Begriff Matrixorganisation?', 5),
(253, 'schwer', 'Welche Bedeutung haben bei Unterschriften die Abkürzungen i. V., i. A. sowie ppa.?', 5),
(254, 'mittel', 'Was versteht man unter dem Begriff Prokura?', 5),
(255, 'schwer', 'Erläutere den Begriff der doppelten Buchführung.', 5),
(256, 'leicht', 'Was versteht man unter den Begriffen berufliche Fortbildung und berufliche Umschulung?', 5),
(257, 'leicht', 'Was versteht man unter einer beruflichen Weiterbildung?', 5),
(258, 'mittel', 'In der Anwendungsentwicklung sind Testverfahren unerlässlich. Welche Testverfahren kennst du?', 5),
(259, 'mittel', 'Was bedeuten in der Anwendungsentwicklung die Begriffe Black-Box-Test und White-Box-Test?', 5),
(260, 'schwer', 'Was versteht man unter dem Begriff Nachhaltigkeit in der Informationstechnologie-Branche?', 5),
(261, 'mittel', 'Nenne die wesentlichen Bestandteile eines Abnahmeprotokolls für ein IT-Projekt.', 5),
(262, 'mittel', 'Welche Schritte sind notwendig nach Abschluss erfolgter Leistungserbringung?', 5),
(263, 'mittel', 'Nenne 3 Methoden, mit der ein Kunde oder eine Kundin am IT-Arbeitsplatz eingewiesen werden kann.', 5),
(264, 'leicht', 'Welche Bedeutung hat der Begriff Blended Learning?', 5),
(265, 'mittel', 'Was verbirgt sich hinter dem Begriff Rollout?', 5),
(266, 'schwer', 'Welche Prozesse müssen bei einem Software-Rollout beachtet werden?', 5),
(267, 'mittel', 'Welche Dinge müssen bei einem IT-Hardware-Rollout beachtet werden?', 5),
(268, 'mittel', 'Welche Unterscheidungsmerkmale haben Kauf, Miete und Leasing?', 5),
(269, 'mittel', 'Welche Vor- und Nachteile hat der Kauf von IT-Hardware für Unternehmen?', 5),
(270, 'mittel', 'Welche Vor- und Nachteile hat ein Unternehmen beim Leasing von IT-Hardware?', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `themen`
--

CREATE TABLE `themen` (
  `id` bigint(20) NOT NULL,
  `beschreibung` varchar(200) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `themen`
--

INSERT INTO `themen` (`id`, `beschreibung`, `name`) VALUES
(1, 'Projektmanagement, Zeitplanung und Kundenanforderungen.', 'Planen und Vorbereiten von Arbeitsaufgaben'),
(2, 'Kundengespräche, Bedarfsanalyse und Service Level Agreements.', 'Informieren und Beraten von Kunden'),
(3, 'Hardware-Architekturen, Betriebssysteme und Netzwerkkomponenten.', 'Beurteilen marktgängiger IT-Systeme'),
(4, 'Softwareentwicklung, Algorithmen, Pseudocode und SQL-Datenbanken.', 'Entwickeln und Betreuen von IT-Lösungen'),
(5, 'Testmethoden wie Blackbox- und Whitebox-Tests und Testprotokolle.', 'Qualitätssichernde Maßnahmen'),
(6, 'DSGVO, Verschlüsselung, Firewalls, Backups und Arbeitsschutz.', 'IT-Sicherheit, Datenschutz und Ergonomie'),
(7, 'Abnahmetests, Übergabeprotokolle und Rechnungsstellung.', 'Auftragsabschluss und Leistungserbringung');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `antworten`
--
ALTER TABLE `antworten`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_antwort_fragen` (`frage_id`);

--
-- Indizes für die Tabelle `benutzern`
--
ALTER TABLE `benutzern`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `fragen`
--
ALTER TABLE `fragen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fragen_themen` (`themen_id`);

--
-- Indizes für die Tabelle `themen`
--
ALTER TABLE `themen`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `antworten`
--
ALTER TABLE `antworten`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=512;

--
-- AUTO_INCREMENT für Tabelle `benutzern`
--
ALTER TABLE `benutzern`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `fragen`
--
ALTER TABLE `fragen`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=512;

--
-- AUTO_INCREMENT für Tabelle `themen`
--
ALTER TABLE `themen`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `antworten`
--
ALTER TABLE `antworten`
  ADD CONSTRAINT `fk_antwort_fragen` FOREIGN KEY (`frage_id`) REFERENCES `fragen` (`id`);

--
-- Constraints der Tabelle `fragen`
--
ALTER TABLE `fragen`
  ADD CONSTRAINT `fk_fragen_themen` FOREIGN KEY (`themen_id`) REFERENCES `themen` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
