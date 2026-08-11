package com.example.LernApp.controller;

import com.example.LernApp.dto.FrageCreateRequest;
import com.example.LernApp.dto.FrageResponse;
import com.example.LernApp.dto.FrageUpdateRequest;
import com.example.LernApp.service.FrageService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

// Markiert die Klasse als REST-Controller, der HTTP-Anfragen verarbeitet und JSON-Antworten liefert.
@RestController
// Der Basis-Pfad für diesen Controller lautet "/fragen" (z.B. http://localhost:8080/fragen)
@RequestMapping("/fragen")
public class FrageController {

    // Die Abhängigkeit zur Business-Logik (Service-Schicht). Wird über Constructor-Injection befüllt.
    private final FrageService service;

    public FrageController(FrageService service) {
        this.service = service;
    }

    // HTTP GET-Request auf "/fragen"
    // Erlaubt optional das Filtern per Query-Parameter, z.B. "/fragen?themaId=5"
    @GetMapping
    public List<FrageResponse> getAll(@RequestParam(required = false) Long themaId) {
        // Wenn der Parameter ?themaId=X in der URL übergeben wurde, filtere danach
        if (themaId != null) {
            return service.findByThema(themaId);
        }
        // Falls kein Parameter übergeben wurde, gib einfach alle Fragen zurück
        return service.findAll();
    }

    // HTTP GET-Request für eine spezifische Frage über die ID im Pfad, z.B. "/fragen/12"
    // @PathVariable zieht den Wert aus der URL und übergibt ihn an die Methode.
    @GetMapping("/{id}")
    public FrageResponse getById(@PathVariable Long id) {
        return service.findById(id);
    }

    /*
    // Wird kein JSON-Objekt erstellt. Reiner String wird weitergegeben
    @GetMapping("/{id}/text")
    public ResponseEntity<String> getFrageText(@PathVariable Long id) {
        FrageResponse frage = service.findById(id);
        return ResponseEntity.ok(frage.getText()); // Frage Klassen sind nicht record, deswegen getText nötig
    }
     */

    // mit JSON-Objekt
    @GetMapping("/{id}/text")
    public ResponseEntity<Map<String, String>> getFrageText(@PathVariable Long id) {
        FrageResponse frage = service.findById(id);
        return ResponseEntity.ok(Map.of("text", frage.getText())); // Frage Klassen sind nicht record, deswegen getText nötig
    }

    // HTTP POST-Request auf "/fragen", um eine neue Frage zu erstellen.
    // @Valid prüft die Validierungsregeln im DTO, @RequestBody wandelt das eingehende JSON in ein Java-Objekt um.
    @PostMapping
    public ResponseEntity<FrageResponse> create(@Valid @RequestBody FrageCreateRequest request) {
        FrageResponse created = service.create(request);
        // Gibt den HTTP-Status 201 (Created) und das neu erstellte Objekt im Body zurück.
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    // HTTP PUT-Request auf "/fragen/{id}", um eine bestehende Frage komplett zu aktualisieren.
    // Kombiniert die ID aus dem Pfad mit den neuen Daten aus dem JSON-Body.
    @PutMapping("/{id}")
    public FrageResponse update(@PathVariable Long id,
                                @Valid @RequestBody FrageUpdateRequest request) {
        return service.update(id, request);
    }

    // HTTP DELETE-Request auf "/fragen/{id}", um eine Frage zu löschen.
    // ResponseEntity<Void> bedeutet, dass die Antwort absichtlich keinen Inhalt (Body) hat.
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        service.delete(id);
        // Gibt den Status 204 (No Content) zurück – die sauberste Art zu sagen: "Erfolgreich gelöscht, nichts mehr da zum Anzeigen."
        return ResponseEntity.noContent().build();
    }
}