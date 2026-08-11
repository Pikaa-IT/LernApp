package com.example.LernApp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Lombok-Annotation: Generiert automatisch alle Getter, Setter, die toString()-Methode,
// sowie equals() und hashCode() für dieses Request-Objekt.
@Data
// Lombok-Annotation: Erzeugt einen leeren Standardkonstruktor, damit der Jackson-Parser
// das eingehende JSON in dieses Java-Objekt konvertieren kann.
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor, der alle Felder als Argumente akzeptiert
// (text, schwierigkeit, themaId), was besonders für Unit-Tests praktisch ist.
@AllArgsConstructor
public class FrageCreateRequest {

    // Jakarta Validation: Stellt sicher, dass der Fragetext nicht null ist, nicht leer ist
    // und nicht nur aus Leerzeichen besteht.
    @NotBlank(message = "Fragetext darf nicht leer sein")
    private String text;

    // Jakarta Validation: Die Schwierigkeit (z. B. "leicht", "mittel", "schwer") darf nicht
    // leer sein und wird auf maximal 50 Zeichen begrenzt.
    @NotBlank(message = "Schwierigkeitsfeld darf nicht leer sein")
    @Size(max = 50, message = "Schwierigkeitsfeld darf höchstens 50 Zeichen lang sein")
    private String schwierigkeit;

    // Statt das ganze Thema-Objekt zu schicken, referenziert der Client
    // es nur über die ID. Das ist das DTO-Prinzip, sobald Beziehungen
    // im Spiel sind.

    // Jakarta Validation: Da es sich um ein 'Long' (Objekt) und nicht um einen 'String' handelt,
    // verwendet man hier @NotNull statt @NotBlank. Verhindert, dass das Feld weggelassen wird.
    @NotNull(message = "themaId darf nicht null sein")
    private Long themaId;
}
