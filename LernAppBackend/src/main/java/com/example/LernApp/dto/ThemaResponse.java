package com.example.LernApp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, die toString()-Methode,
// sowie equals() und hashCode(). Da dieses Objekt primär für die Serialisierung in JSON
// gelesen wird, stellt @Data sicher, dass alle benötigten Getter vorhanden sind.
@Data
// Lombok-Annotation: Erzeugt einen leeren Standardkonstruktor, den Jackson für interne
// Mechanismen oder beim automatischen Testen (z. B. Deserialisierung im Integrationstest) braucht.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder (id, name, beschreibung).
// Perfekt, um im ThemaService eine Datenbank-Entität direkt in dieses DTO umzuwandeln.
@AllArgsConstructor
public class ThemaResponse {

    // Die eindeutige ID des Themas aus der Datenbank.
    // Das Frontend benötigt diese ID, um das Thema z.B. bei einer Frage zu referenzieren (themaId)
    // oder um gezielt nach Fragen dieses Themas zu filtern (/fragen?themaId=X).
    private Long id;

    // Der Name des Themas (z. B. "Geschichte" oder "Informationstechnologie").
    private String name;

    // Die Kurzbeschreibung des Themas, die im Frontend angezeigt werden kann.
    private String beschreibung;
}
