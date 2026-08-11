package com.example.LernApp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, die toString()-Methode,
// sowie equals() und hashCode() für dieses Update-Objekt.
@Data
// Lombok-Annotation: Erzeugt einen leeren Standardkonstruktor.
// Jackson benötigt diesen zwingend, um das eingehende JSON bei einem PUT-Request in dieses Objekt zu verwandeln.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder (name, beschreibung).
// Extrem nützlich, um in Unit-Tests schnell Daten für ein Update-Szenario zu übergeben.
@AllArgsConstructor
public class ThemaUpdateRequest {

    // Jakarta Validation: Auch beim Update darf der Themenname nicht einfach
    // gelöscht oder geleert werden. Das Limit von 50 Zeichen schützt die Datenbank.
    @NotBlank(message = "Themenname darf nicht leer sein")
    @Size(max = 50, message = "Themenname darf höchstens 50 Zeichen lang sein")
    private String name;

    // Jakarta Validation: Die Beschreibung bleibt ein Pflichtfeld und darf
    // beim Aktualisieren nicht komplett entfernt werden. Maximal sind 200 Zeichen erlaubt.
    @NotBlank(message = "Die Beschreibung darf nicht leer sein")
    @Size(max = 500, message = "Die Beschreibung darf höchstens 500 Zeichen lang sein")
    private String beschreibung;
}
