package com.example.LernApp.controller;

import com.example.LernApp.dto.ThemaCreateRequest;
import com.example.LernApp.dto.ThemaResponse;
import com.example.LernApp.dto.ThemaUpdateRequest;
import com.example.LernApp.service.ThemaService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// Kennzeichnet die Klasse als REST-Controller, damit sie HTTP-Requests verarbeiten kann
// und die Rückgabewerte automatisch in das JSON-Format umgewandelt werden.
@RestController
// Definiert den Basis-Pfad für alle Endpunkte in dieser Klasse.
// Alle URLs für diese Ressourcen starten mit http://localhost:8080/thema
@RequestMapping("/themen")
public class ThemaController {

    // Die Abhängigkeit zur Service-Schicht, die die eigentliche Business-Logik für "Thema" hält.
    private final ThemaService service;

    // Konstruktor-basierte Dependency Injection. Spring injiziert hier automatisch den passenden 'ThemaService'.
    public ThemaController(ThemaService service) {
        this.service = service;
    }

    // HTTP GET-Request auf den Basis-Pfad "/thema"
    // Liefert eine Liste aller vorhandenen Themen zurück.
    @GetMapping
    public List<ThemaResponse> getAllThema() {
        return service.findAll();
    }

    // HTTP GET-Request mit einer ID als Pfad-Variable, z.B. "/thema/3"
    // Bindet den Wert aus der URL an den Methoden-Parameter 'id'.
    @GetMapping("/{id}")
    public ThemaResponse getThemaById(@PathVariable Long id) {
        return service.findById(id);
    }

    // HTTP POST-Request auf "/thema", um ein neues Thema anzulegen.
    // @Valid stößt die Validierung des eingehenden Objekts an.
    // @RequestBody extrahiert das JSON aus dem HTTP-Body und wandelt es in ein 'ThemaCreateRequest'-Objekt um.
    @PostMapping
    public ResponseEntity<ThemaResponse> createThema(@Valid @RequestBody ThemaCreateRequest request) {
        ThemaResponse created = service.create(request);
        // Gibt die Antwort mit dem HTTP-Status 201 (Created) und dem erstellten Thema im Body zurück.
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    // HTTP PUT-Request auf "/thema/{id}", um ein bestehendes Thema komplett zu aktualisieren.
    // Identifiziert das Thema über die ID im Pfad und holt die neuen Daten aus dem JSON-Body.
    @PutMapping("/{id}")
    public ThemaResponse updateThema(@PathVariable Long id,
                                     @Valid @RequestBody ThemaUpdateRequest request) {
        return service.update(id, request);
    }

    // HTTP DELETE-Request auf "/thema/{id}", um ein Thema anhand seiner ID zu löschen.
    // Verwendet ResponseEntity<?>, um flexibel auf einen Body zu verzichten.
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteThema(@PathVariable Long id) {
        service.delete(id);
        // Gibt den HTTP-Status 204 (No Content) zurück – die Aktion war erfolgreich, es gibt aber nichts mehr zurückzusenden.
        return ResponseEntity.noContent().build();
    }
}