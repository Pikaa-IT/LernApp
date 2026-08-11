package com.example.LernApp.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

// JPA-Annotation: Kennzeichnet die Klasse als persistente Datenbank-Entität.
@Entity
// JPA-Annotation: Definiert den Tabellennamen in der Datenbank.
// "fragen" (Plural) passt hier zu deiner "benutzern"-Tabelle.
@Table(name = "fragen")
// Lombok-Annotationen: Generieren sauber Getter und Setter.
// Hervorragend gelöst: Durch den Verzicht auf @Data verhinderst du hier
// gefährliche Endlosschleifen in der toString() oder hashCode() Methode,
// die wegen der zyklischen Beziehung zu 'Antwort' auftreten könnten!
@Getter
@Setter
// Lombok-Annotation: Erzeugt den zwingend erforderlichen parameterlosen Konstruktor für JPA.
@NoArgsConstructor
public class Frage {

    // JPA-Annotation: Kennzeichnet das Feld als Primärschlüssel (Primary Key).
    @Id
    // JPA-Annotation: Die Datenbank übernimmt die ID-Vergabe per AUTO_INCREMENT.
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // JPA-Annotation: TEXT erlaubt unbegrenzt lange Fragetexte in der DB.
    @Column(nullable = false, columnDefinition = "TEXT")
    private String text;

    // JPA-Annotation: Begrenzt den Typen-String (z. B. "leicht") auf 50 Zeichen.
    @Column(nullable = false, length = 50)
    private String schwierigkeit;

    // Viele Fragen gehören zu genau einem Thema (n:1).
    // fetch = LAZY: Das Thema wird erst aus der DB geladen, wenn du frage.getThema() aufrufst.
    // optional = false: Eine Frage MUSS zwingend ein Thema besitzen.
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    // Definiert den Namen der Fremdschlüssel-Spalte (Foreign Key) in der Tabelle "fragen".
    @JoinColumn(name = "themen_id", nullable = false)
    private Thema thema;

    // Eine Frage hat viele Antwortmöglichkeiten (1:n).
    // mappedBy = "frage": Zeigt auf das Feld 'frage' in der Antwort-Klasse. Dort liegt die Verantwortung.
    // cascade = CascadeType.ALL: Wenn eine Frage gespeichert, aktualisiert oder gelöscht wird,
    // werden alle zugehörigen Antworten automatisch mitgespeichert/gelöscht.
    // orphanRemoval = true: Wenn eine Antwort aus dieser Liste entfernt wird,
    // löscht Hibernate sie automatisch physisch aus der Datenbank (keine "Leichen").
    @OneToMany(mappedBy = "frage", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Antwort> antworten = new ArrayList<>();
}
