package com.example.LernApp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, die toString()-Methode,
// sowie equals() und hashCode(). Da dieses Objekt meist nur gelesen wird (beim Serialisieren in JSON),
// sind vor allem die Getter entscheidend.
@Data
// Lombok-Annotation: Erzeugt den parameterlosen Standardkonstruktor.
// Jackson benötigt diesen, um beim automatischen Testen oder internen Verarbeiten flexibel zu sein.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder (id, benutzername, email).
// Das ist extrem praktisch, wenn du im Service ein Entity-Objekt schnell in dieses DTO umwandeln willst.
@AllArgsConstructor
public class BenutzerResponse {

    // Die eindeutige ID des Benutzers aus der Datenbank.
    // Der Client benötigt sie für zukünftige Requests (z.B. für GET /benutzer/{id} oder DELETE /benutzer/{id}).
    private Long id;

    // Der Benutzername, der im Frontend angezeigt werden soll.
    private String benutzername;

    // Die E-Mail-Adresse des Benutzers.
    private String email;

    // WICHTIG: Das Passwort-Feld fehlt hier absichtlich!
    // Ein Response-DTO filtert sensible Daten heraus, damit sie niemals das Backend verlassen.
}
