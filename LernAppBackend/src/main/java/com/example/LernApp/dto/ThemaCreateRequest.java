package com.example.LernApp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, die toString()-Methode,
// sowie equals() und hashCode() für dieses Request-Objekt.
@Data
// Lombok-Annotation: Erzeugt einen leeren Standardkonstruktor.
// Unverzichtbar für das Framework (Jackson), um die eingehenden JSON-Daten in dieses Java-Objekt zu mappen.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder (name, beschreibung).
// Das erleichtert das Erstellen von Testobjekten in Unit-Tests ungemein.
@AllArgsConstructor
public class ThemaCreateRequest {

    // Jakarta Validation: Der Name des Themas darf weder null, noch leer sein,
    // noch nur aus Leerzeichen bestehen (z.B. "Geografie" oder "Java-Programmierung").
    // @Size begrenzt den Namen zum Schutz der Datenbankstruktur auf maximal 50 Zeichen.
    @NotBlank(message = "Themenname darf nicht leer sein")
    @Size(max = 50, message = "Themenname darf höchstens 50 Zeichen lang sein")
    private String name;

    // Jakarta Validation: Auch die Beschreibung ist ein Pflichtfeld.
    // Mit maximal 200 Zeichen wird hier sichergestellt, dass der Text kurz und prägnant bleibt,
    // was ideal für Übersichtsseiten im Frontend ist.
    @NotBlank(message = "Die Beschreibung darf nicht leer sein")
    @Size(max = 500, message = "Die Beschreibung darf höchstens 500 Zeichen lang sein")
    private String beschreibung;
}
