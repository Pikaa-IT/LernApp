package com.example.LernApp.controller;

import com.example.LernApp.dto.BenutzerCreateRequest;
import com.example.LernApp.dto.BenutzerResponse;
import com.example.LernApp.dto.BenutzerUpdateRequest;
import com.example.LernApp.service.BenutzerService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// Kennzeichnet die Klasse als REST-Controller.
// Kombiniert @Controller und @ResponseBody, sodass Rückgabewerte automatisch in JSON umgewandelt werden.
@RestController
// Definiert den Basis-Pfad für alle Endpunkte in dieser Klasse.
// Alle URLs starten hier mit http://localhost:8080/benutzer
@RequestMapping("/benutzer")
public class BenutzerController {

    // Dependency Injection: Der Service, der die eigentliche Business-Logik enthält.
    // 'final' stellt sicher, dass die Abhängigkeit nach der Initialisierung nicht mehr verändert wird.
    private final BenutzerService service;

    // Konstruktor-basierte Dependency Injection. Spring setzt den 'BenutzerService' hier automatisch ein.
    public BenutzerController(BenutzerService service) {
        this.service = service;
    }

    // HTTP GET-Request auf den Basis-Pfad "/benutzer"
    // Gibt eine Liste aller Benutzer zurück.
    @GetMapping
    public List<BenutzerResponse> getAllBenutzer() {
        return service.findAll();
    }

    // HTTP GET-Request mit einer ID als Pfad-Variable, z.B. "/benutzer/5"
    // @PathVariable verknüpft das {id} aus der URL mit dem Methoden-Parameter 'id'.
    @GetMapping("/{id}")
    public BenutzerResponse getBenutzerById(@PathVariable Long id) {
        return service.findById(id);
    }

    // HTTP POST-Request auf "/benutzer", um einen neuen Benutzer zu erstellen.
    // @Valid: Überprüft, ob die Validierungs-Regeln im Request-DTO (z.B. @NotNull, @Size) eingehalten wurden.
    // @RequestBody: Liest das JSON aus dem HTTP-Body und wandelt es in das 'BenutzerCreateRequest'-Objekt um.
    @PostMapping
    public ResponseEntity<BenutzerResponse> createBenutzer(@Valid @RequestBody BenutzerCreateRequest request) {
        BenutzerResponse created = service.create(request);
        // Gibt den HTTP-Status 201 (Created) zusammen mit dem neu erstellten Benutzer im Body zurück.
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    // HTTP PUT-Request, um einen bestehenden Benutzer komplett zu aktualisieren, z.B. "/benutzer/5"
    // Nutzt sowohl die ID aus dem Pfad als auch die neuen Daten aus dem HTTP-Body.
    @PutMapping("/{id}")
    public BenutzerResponse updateBenutzer(@PathVariable Long id,
                                           @Valid @RequestBody BenutzerUpdateRequest request) {
        return service.update(id, request);
    }

    // HTTP DELETE-Request, um einen Benutzer anhand seiner ID zu löschen, z.B. "/benutzer/5"
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBenutzer(@PathVariable Long id) {
        service.delete(id);
        // Gibt den HTTP-Status 204 (No Content) zurück, da das Löschen erfolgreich war,
        // aber keine Daten im Body zurückgegeben werden müssen.
        return ResponseEntity.noContent().build();
    }
}
