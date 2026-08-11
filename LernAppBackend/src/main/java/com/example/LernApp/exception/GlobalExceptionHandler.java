package com.example.LernApp.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import com.example.LernApp.dto.ErrorResponse;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.List;

// Spring-Annotation: Macht diese Klasse zu einer globalen Schnittstelle für die Fehlerbehandlung.
// Sie fängt Exceptions ab, bevor Spring eine standardmäßige, unschöne HTML-Fehlerseite generiert.
@RestControllerAdvice
public class GlobalExceptionHandler {

    // -----------------------------------------------------------------
    // 404 - Ressourcen nicht gefunden (Benutzer, Thema, Frage, Antwort)
    // -----------------------------------------------------------------

    // Fängt die Exception ab, wenn ein gesuchter Benutzer nicht in der DB existiert.
    @ExceptionHandler(BenutzerNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleBenutzerNotFound(
            BenutzerNotFoundException ex, HttpServletRequest request) {
        // Erzeugt eine HTTP 404 Antwort mit der spezifischen Nachricht der Exception.
        return build(HttpStatus.NOT_FOUND, ex.getMessage(), request, null);
    }

    // Fängt die Exception ab, wenn ein Thema (z.B. bei der Fragen-Zuordnung) fehlt.
    @ExceptionHandler(ThemaNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleThemaNotFound(
            ThemaNotFoundException ex, HttpServletRequest request) {
        return build(HttpStatus.NOT_FOUND, ex.getMessage(), request, null);
    }

    // Fängt die Exception ab, wenn eine bestimmte Frage-ID ins Leere läuft.
    @ExceptionHandler(FrageNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleFrageNotFound(
            FrageNotFoundException ex, HttpServletRequest request) {
        return build(HttpStatus.NOT_FOUND, ex.getMessage(), request, null);
    }

    @ExceptionHandler(AntwortNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleAntwortNotFound(
            AntwortNotFoundException ex, HttpServletRequest request){
        return build(HttpStatus.NOT_FOUND, ex.getMessage(), request, null);
    }

    // -----------------------------------------------------------------
    // 400 - Validierungsfehler (@NotBlank, @Size, @Email verletzt)
    // -----------------------------------------------------------------

    // Wird automatisch ausgelöst, wenn ein DTO mit @Valid im Controller die Bedingungen nicht erfüllt.
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(
            MethodArgumentNotValidException ex, HttpServletRequest request) {

        // Holt die Liste aller verletzten Felder aus dem BindingResult von Spring
        // und transformiert (mappt) sie in deine strukturierte ErrorResponse.FieldError-Klasse.
        List<ErrorResponse.FieldError> fieldErrors = ex.getBindingResult()
                .getFieldErrors().stream()
                .map(fe -> new ErrorResponse.FieldError(fe.getField(), fe.getDefaultMessage()))
                .toList();

        // Gibt eine HTTP 400 (Bad Request) zurück – das Frontend sieht genau, welche Eingabe falsch war.
        return build(HttpStatus.BAD_REQUEST, "Validierung fehlgeschlagen", request, fieldErrors);
    }

    // -----------------------------------------------------------------
    // 400 - JSON kaputt oder fehlend
    // -----------------------------------------------------------------

    // Greift, wenn das JSON syntaktisch falsch ist (z.B. fehlendes Anführungszeichen)
    // oder wenn der POST/PUT-Body komplett leer ankommt.
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ErrorResponse> handleUnreadableBody(
            HttpMessageNotReadableException ex, HttpServletRequest request) {
        return build(HttpStatus.BAD_REQUEST, "Request-Body ist ungültig oder fehlt", request, null);
    }

    // -----------------------------------------------------------------
    // 500 - Auffangnetz für alles andere
    // -----------------------------------------------------------------

    // Das "Sicherheitsnetz": Fängt jede unvorhergesehene Java-Exception ab (z.B. NullPointerException).
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGeneric(
            Exception ex, HttpServletRequest request) {
        // Druckt den vollständigen Fehlerpfad in die Serverkonsole für dein lokales Debugging.
        ex.printStackTrace();

        // Verhindert das Ausleiten interner System-Details und gibt eine neutrale Fehlermeldung (HTTP 500) aus.
        return build(HttpStatus.INTERNAL_SERVER_ERROR, "Unerwarteter interner Fehler", request, null);
    }

    // -----------------------------------------------------------------
    // Private Hilfsmethode zur Vermeidung von redundantem Code
    // -----------------------------------------------------------------
    private ResponseEntity<ErrorResponse> build(HttpStatus status, String message,
                                                HttpServletRequest request,
                                                List<ErrorResponse.FieldError> fieldErrors) {
        // Baut das ErrorResponse-DTO über das Lombok-Builder-Pattern flexibel zusammen.
        ErrorResponse body = ErrorResponse.builder()
                .timestamp(LocalDateTime.now())          // Aktueller Server-Zeitstempel des Fehlers
                .status(status.value())                   // Der numerische HTTP-Statuscode (z.B. 404)
                .error(status.getReasonPhrase())          // Die offizielle HTTP-Bezeichnung (z.B. "Not Found")
                .message(message)                         // Die dynamische Fehlermeldung
                .path(request.getRequestURI())            // Der Pfad, der den Fehler verursacht hat
                .fieldErrors(fieldErrors)                 // Die Liste der Feldfehler (nur bei Validierungen relevant)
                .build();

        // Verpackt das DTO in eine ResponseEntity, die den passenden HTTP-Statuscode im Header trägt.
        return ResponseEntity.status(status).body(body);
    }
}