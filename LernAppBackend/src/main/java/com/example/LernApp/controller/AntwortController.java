package com.example.LernApp.controller;

import com.example.LernApp.dto.AntwortCreateRequest;
import com.example.LernApp.dto.AntwortResponse;
import com.example.LernApp.dto.AntwortUpdateRequest;
import com.example.LernApp.service.AntwortService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/antworten")
public class AntwortController {

    private final AntwortService service;

    public AntwortController(AntwortService service) {
        this.service = service;
    }

    @GetMapping
    public List<AntwortResponse> getAllAntworten(@RequestParam(required = false) Long frageId) {
        if (frageId != null) {
            return service.findByFrage(frageId);
        }
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<AntwortResponse> getAntwortById(@PathVariable Long id) {
        return ResponseEntity.ok(service.findById(id));
    }

    /*
    // Wird kein JSON-Objekt erstellt. Reiner String wird weitergegeben
    @GetMapping("/{id}/text")
    public ResponseEntity<String> getAntwortTextById(@PathVariable Long id) {
        AntwortResponse antwort = service.findById(id);
        return ResponseEntity.ok(antwort.text()); // Record → .text() ohne "get"
    }
    */

    @GetMapping("/{id}/text")
    public ResponseEntity<Map<String, String>> getFrageText(@PathVariable Long id) {
        AntwortResponse antwort = service.findById(id);
        return ResponseEntity.ok(Map.of("text", antwort.text()));
    }

    @PostMapping
    public ResponseEntity<AntwortResponse> createAntwort(
            @Valid @RequestBody AntwortCreateRequest request) {
        AntwortResponse created = service.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public AntwortResponse updateAntwort(
            @PathVariable Long id,
            @Valid @RequestBody AntwortUpdateRequest request) {
        return service.update(id, request);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAntwort(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}
