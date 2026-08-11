package com.example.LernApp.model;

import jakarta.persistence.*;
import lombok.*;

// JPA-Annotation: Kennzeichnet diese Klasse als persistente Datenbank-Entität.
@Entity
// @Getter @Setter statt @Data = verhindert toString/equals/hashCode Probleme
// bei zirkulären Relationships (Thema -> Frage -> Thema)
@Getter
@Setter
// Lombok-Annotation: Erzeugt den für JPA zwingend erforderlichen parameterlosen Konstruktor.
@NoArgsConstructor
// JPA-Annotation: Definiert den Tabellennamen in der Datenbank.
// TIPP: Im SQL-Umfeld nutzt man meist den Singular ("benutzer") oder das englische Plural ("users").
// "benutzern" (mit 'n' am Ende) ist grammatikalisch im Deutschen der Dativ – "benutzer" wäre sauberer.
@Table(name = "benutzern")
public class Benutzer {

    // JPA-Annotation: Markiert das Feld als Primärschlüssel (Primary Key).
    @Id
    // JPA-Annotation: Überlässt der Datenbank die ID-Vergabe (z.B. AUTO_INCREMENT).
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // JPA-Annotation: 'nullable = false' erzeugt einen NOT NULL Constraint.
    // 'unique = true' sorgt dafür, dass kein Benutzername doppelt vergeben werden kann.
    // 'length = 50' begrenzt die Spalte in der DB (VARCHAR(50)) – das passt perfekt zu deinem DTO!
    @Column(nullable = false, unique = true, length = 50)
    private String benutzername;

    // JPA-Annotation: Auch die E-Mail ist Pflicht und muss absolut eindeutig (unique) sein.
    // 'length = 255' ist der Standard für E-Mail-Spalten in Datenbanken.
    @Column(nullable = false, unique = true, length = 255)
    private String email;

    // JPA-Annotation: 'name' definiert den physischen Spaltennamen in der DB (Snake_Case).
    // Da hier BCrypt- oder Argon2-Hashes landen, ist 'length = 255' absolut sicher und ausreichend.
    @Column(name = "passwort_hash", nullable = false, length = 255)
    private String passwortHash;
}
