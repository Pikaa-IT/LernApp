package com.example.LernApp.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch Getter, Setter, equals(), hashCode() und toString().
@Data
// Lombok-Annotation: Erstellt einen leeren Standardkonstruktor ohne Argumente (wichtig für Frameworks wie Jackson).
@NoArgsConstructor
// Lombok-Annotation: Erstellt einen Konstruktor, der alle Felder als Parameter entgegennimmt.
@AllArgsConstructor
public class BenutzerCreateRequest {

    // Validierung: Das Feld darf nicht null sein und muss mindestens ein Nicht-Leerzeichen enthalten.
    @NotBlank(message = "Benutzername darf nicht leer sein")
    // Validierung: Begrenzt die maximale Länge des Strings auf 50 Zeichen.
    @Size(max = 50, message = "Benutzername darf höchstens 50 Zeichen lang sein")
    private String benutzername;

    // Validierung: Darf ebenfalls nicht leer sein.
    @NotBlank(message = "E-Mail darf nicht leer sein")
    // Validierung: Überprüft, ob die Eingabe einem gültigen E-Mail-Format entspricht (z. B. text@domain.com).
    @Email(message = "E-Mail-Format ist ungültig")
    private String email;

    // Klartext-Passwort - lebt NUR in der Eingabe und wird vor dem Speichern gehasht.
    // Landet nie so in der Datenbank.
    // Validierung: Darf nicht leer sein.
    @NotBlank(message = "Passwort darf nicht leer sein")
    // Validierung: Erzwingt eine Mindestlänge von 8 Zeichen für das Passwort.
    @Size(min = 8, message = "Passwort muss mindestens 8 Zeichen lang sein")
    private String password;
}
