package com.example.LernApp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, toString(),
// sowie equals() und hashCode(). Wichtig für Jackson, um das Objekt in ein JSON umzuwandeln.
@Data
// Lombok-Annotation: Erzeugt den parameterlosen Standardkonstruktor.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder (id, text, typ, themaId).
// Wird im Service genutzt, um die geladenen Daten schnell in dieses DTO zu mappen.
@AllArgsConstructor
public class FrageResponse {

    // Die eindeutige ID der Frage aus der Datenbank.
    private Long id;

    // Der eigentliche Text der Frage (z. B. "Wie lautet die Antwort auf alles?").
    private String text;

    // Der Typ der Frage (z. B. "SINGLE_CHOICE", "FREE_TEXT").
    private String schwierigkeit;

    // Das verknuepfte Thema wird NUR ueber die ID ausgegeben.
    // Damit gibt es keine Endlos-Rekursion bei der JSON-Serialisierung
    // (Thema -> Fragen -> Thema -> ...).

    // Anstatt das komplette 'ThemaResponse'-Objekt einzubetten, wird hier
    // nur die ID des Themas mitgegeben. Das hält das JSON flach und performant.
    private Long themaId;
}
