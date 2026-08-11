package com.example.LernApp.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

// Lombok-Annotation: Generiert automatisch Getter, Setter, toString(), equals() und hashCode().
@Data
// Lombok-Annotation: Erzeugt einen parameterlosen Standardkonstruktor (wichtig für JSON-Mapper).
@NoArgsConstructor
// Lombok-Annotation: Erzeugt einen Konstruktor für alle Felder der äußeren Klasse.
@AllArgsConstructor
// Lombok-Annotation: Aktiviert das Builder-Pattern. Ermöglicht ein sauberes Erstellen des Objekts,
// z.B.: ErrorResponse.builder().status(400).message("Fehler").build();
@Builder
public class ErrorResponse {

    // Der genaue Zeitpunkt, zu dem der Fehler aufgetreten ist (wichtig für das Logging und Debugging).
    private LocalDateTime timestamp;

    // Der numerische HTTP-Statuscode (z. B. 400 für Bad Request, 404 für Not Found, 500 für Internal Server Error).
    private int status;

    // Eine benutzerfreundliche oder allgemeine Fehlermeldung (z. B. "Validierung fehlgeschlagen").
    private String message;

    // Der API-Endpunkt (die URI), der aufgerufen wurde und den Fehler verursacht hat (z. B. "/benutzer").
    private String path;

    // Der standardmäßige HTTP-Fehlertext passend zum Statuscode (z. B. "Bad Request" oder "Not Found").
    private String error;

    // Eine Liste für spezifische Validierungsfehler (z. B. wenn Felder in einem CreateRequest ungültig waren).
    // Wenn es keine Feldfehler gibt (z.B. bei einem 404-Fehler), kann diese Liste null oder leer sein.
    private List<FieldError> fieldErrors;

    // Eine statische, innere Klasse (Kompaktes DTO), die genau beschreibt, WELCHES Feld WELCHEN Fehler hat.
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class FieldError {
        // Der Name des betroffenen Feldes (z. B. "email" oder "password").
        private String field;

        // Die spezifische Validierungsmeldung (z. B. "E-Mail-Format ist ungültig" – genau der Text aus deinen Requests!).
        private String message;
    }
}
