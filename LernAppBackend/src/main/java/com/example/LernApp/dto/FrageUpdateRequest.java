package com.example.LernApp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, die toString()-Methode,
// sowie equals() und hashCode() für dieses Update-Objekt.
@Data
// Lombok-Annotation: Erzeugt einen leeren Standardkonstruktor.
// Zwingend notwendig, damit der Jackson-Parser das eingehende JSON-Update verarbeiten kann.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder (text, typ, themaId).
// Sehr nützlich, um in Unit-Tests schnell Update-Szenarien zu konstruieren.
@AllArgsConstructor
public class FrageUpdateRequest {

    // Jakarta Validation: Auch beim Aktualisieren darf der Fragetext nicht einfach
    // gelöscht oder geleert werden.
    @NotBlank(message = "Fragetext darf nicht leer sein")
    private String text;

    // Jakarta Validation: Der Typ der Frage (z.B. "MULTIPLE_CHOICE") bleibt ein Pflichtfeld
    // und wird auf maximal 50 Zeichen begrenzt.
    @NotBlank(message = "Schwierigkeitsfeld darf nicht leer sein")
    @Size(max = 50, message = "Schwierigkeitsfeld darf höchstens 50 Zeichen lang sein")
    private String schwierigkeit;

    // Jakarta Validation: Die themaId darf auch beim Update nicht null sein.
    // Das ermöglicht es dem Client, die Frage bei Bedarf einem ANDEREN Thema zuzuordnen (Themenwechsel).
    @NotNull(message = "themaId darf nicht null sein")
    private Long themaId;
}
