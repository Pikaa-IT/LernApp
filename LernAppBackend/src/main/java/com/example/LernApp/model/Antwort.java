package com.example.LernApp.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// JPA-Annotation: Kennzeichnet die Klasse als persistente Entität.
// Hibernate weiß nun, dass für diese Klasse eine Tabelle existieren muss.
@Entity
// JPA-Annotation: Definiert den genauen Namen der Tabelle in der Datenbank ("antwort").
@Table(name = "antworten")
// Lombok-Annotation: Generiert automatisch alle Getter-Methoden für die Felder.
@Getter
// Lombok-Annotation: Generiert automatisch alle Setter-Methoden für die Felder.
@Setter
// Lombok-Annotation: Erzeugt einen parameterlosen Standardkonstruktor.
// Dieser ist für JPA/Hibernate zwingend erforderlich, um Objekte aus der Datenbank zu laden.
@NoArgsConstructor
public class Antwort {

    // JPA-Annotation: Kennzeichnet dieses Feld als den Primärschlüssel (Primary Key) der Tabelle.
    @Id
    // JPA-Annotation: Aktiviert die automatische ID-Generierung durch die Datenbank
    // (nutzt z. B. AUTO_INCREMENT in MySQL/PostgreSQL).
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // JPA-Annotation: Konfiguriert die Tabellenspalte.
    // nullable = false sorgt für einen NOT NULL Constraint in der DB.
    // columnDefinition = "TEXT" erlaubt unbegrenzt langen Text (wichtig für lange Antwortoptionen).
    @Column(nullable = false, columnDefinition = "TEXT")
    private String text;

    // JPA-Annotation: Definiert den Spaltennamen in der DB als "ist_richtig" (Snake_Case ist SQL-Standard).
    // nullable = false stellt sicher, dass immer true oder false gespeichert sein muss.
    @Column(name = "ist_richtig", nullable = false)
    private boolean istRichtig;

    // JPA-Annotation: Definiert eine Many-to-One-Beziehung (Viele Antworten gehören zu einer Frage).
    // optional = false bedeutet: Eine Antwort darf niemals ohne eine zugehörige Frage existieren.
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    // JPA-Annotation: Definiert den Namen der Fremdschlüssel-Spalte (Foreign Key) in der Tabelle "antwort".
    @JoinColumn(name = "frage_id", nullable = false)
    private Frage frage;
}
