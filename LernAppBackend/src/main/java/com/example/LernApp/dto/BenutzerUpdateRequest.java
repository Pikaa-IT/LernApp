package com.example.LernApp.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, toString(),
// sowie equals() und hashCode() für die Update-Daten.
@Data
// Lombok-Annotation: Erzeugt einen leeren Standardkonstruktor, den Jackson
// für das Einlesen des JSON-Requests (Deserialisierung) benötigt.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder, nützlich für Unit-Tests.
@AllArgsConstructor
public class BenutzerUpdateRequest {

    // Jakarta Validation: Auch beim Update darf der Benutzername nicht leer sein
    // und wird auf maximal 50 Zeichen begrenzt.
    @NotBlank(message = "Benutzername darf nicht leer sein")
    @Size(max = 50, message = "Benutzername darf höchstens 50 Zeichen lang sein")
    private String benutzername;

    // Jakarta Validation: Die E-Mail-Adresse bleibt ein Pflichtfeld
    // und muss syntaktisch korrekt sein.
    @NotBlank(message = "E-Mail darf nicht leer sein")
    @Email(message = "E-Mail-Format ist ungültig")
    private String email;

    // Optional: Feld weglassen (null) = Passwort bleibt unverändert.

    // Jakarta Validation: Hier fehlt @NotBlank absichtlich!
    // Wenn der Client das Passwort im JSON weglässt, ist der Wert 'null'.
    // Die @Size-Annotation springt standardmäßig NUR an, wenn der Wert NICHT null ist.
    // Schickt der Client ein Passwort mit, MUSS es mindestens 8 Zeichen lang sein.
    @Size(min = 8, message = "Passwort muss mindestens 8 Zeichen lang sein")
    private String password;
}