package com.example.LernApp.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

// JPA-Annotation: Kennzeichnet diese Klasse als persistente Datenbank-Entität.
@Entity
// @Getter @Setter statt @Data = verhindert toString/equals/hashCode Probleme
// bei zirkulären Relationships (Thema -> Frage -> Thema)
@Getter
@Setter
// Lombok-Annotation: Erzeugt den für JPA zwingend erforderlichen parameterlosen Konstruktor.
@NoArgsConstructor
// JPA-Annotation: Definiert den Tabellennamen in der Datenbank.
// "themen" (Plural) passt perfekt zu deinem Schema ("benutzern", "fragen").
@Table(name = "themen")
public class Thema {

    // JPA-Annotation: Markiert das Feld als Primärschlüssel (Primary Key) der Tabelle.
    @Id
    // JPA-Annotation: Die Datenbank generiert die IDs automatisch per AUTO_INCREMENT.
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // JPA-Annotation: 'nullable = false' erzeugt einen NOT NULL Constraint.
    // 'unique = true' stellt sicher, dass kein Themenname (z. B. "Java", "Geschichte") doppelt existiert.
    // 'length = 50' reserviert exakt den gleichen Platz in der DB (VARCHAR(50)) wie in deinen DTOs definiert.
    @Column(nullable = false, unique = true, length = 50)
    private String name;

    // JPA-Annotation: Eine unmissverständliche Kurzbeschreibung des Themas.
    // 'length = 500' spiegelt die Validierung deines ThemaCreateRequests wider.
    @Column(nullable = false, length = 500)
    private String beschreibung;

    @OneToMany(mappedBy = "thema", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Frage> fragen = new ArrayList<>();
}
