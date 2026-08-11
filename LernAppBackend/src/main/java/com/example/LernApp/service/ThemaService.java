package com.example.LernApp.service;

import com.example.LernApp.dto.ThemaCreateRequest;
import com.example.LernApp.dto.ThemaResponse;
import com.example.LernApp.dto.ThemaUpdateRequest;
import com.example.LernApp.exception.ThemaNotFoundException;
import com.example.LernApp.mapper.ThemaMapper;
import com.example.LernApp.model.Thema;
import com.example.LernApp.repository.ThemaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

// Spring-Annotation: Kennzeichnet die Klasse als Service-Komponente.
// Sie kapselt die Geschäftslogik für die Verwaltung von Themen (Kategorien)
// und stellt diese Schicht für die Controller bereit.
@Service
public class ThemaService {

    // Final deklarierte Abhängigkeiten sorgen für Unveränderlichkeit (Immutability).
    private final ThemaRepository repository;
    private final ThemaMapper mapper;

    // Konstruktor-basierte Dependency Injection (Best Practice).
    // Spring löst die Abhängigkeiten beim Starten automatisch auf.
    public ThemaService(ThemaRepository repository, ThemaMapper mapper) {
        this.repository = repository;
        this.mapper = mapper;
    }

    /**
     * Ruft alle verfügbaren Themen aus der Datenbank ab.
     * Konvertiert die Liste der Entitäten mittels Java-Streams in eine Liste von 'ThemaResponse'-DTOs.
     */
    public List<ThemaResponse> findAll() {
        return repository.findAll().stream()
                .map(mapper::toResponse)
                .toList();
    }

    /**
     * Sucht ein bestimmtes Thema über seine ID.
     * Existiert die ID nicht, wird die 'ThemaNotFoundException' ausgelöst.
     */
    public ThemaResponse findById(Long id) {
        Thema thema = repository.findById(id)
                .orElseThrow(() -> new ThemaNotFoundException(id));
        return mapper.toResponse(thema);
    }

    /**
     * Speichert ein neues Thema in der Datenbank.
     * Das übergebene 'ThemaCreateRequest'-DTO wird transformiert, persistiert
     * und als sicheres Response-DTO an den Controller zurückgegeben.
     */
    public ThemaResponse create(ThemaCreateRequest request) {
        Thema saved = repository.save(mapper.toEntity(request));
        return mapper.toResponse(saved);
    }

    /**
     * Aktualisiert Name und Beschreibung eines bestehenden Themas.
     * Liest die Entität ein, modifiziert sie über den Mapper und speichert den neuen Zustand.
     */
    public ThemaResponse update(Long id, ThemaUpdateRequest request) {
        Thema thema = repository.findById(id)
                .orElseThrow(() -> new ThemaNotFoundException(id));

        // Die geladene Entität wird im Speicher mit den neuen Werten aktualisiert
        mapper.updateEntity(thema, request);

        // Das Repository führt hier ein SQL-UPDATE aus, da das Objekt bereits eine ID besitzt
        return mapper.toResponse(repository.save(thema));
    }

    /**
     * Löscht ein Thema permanent aus der Datenbank.
     * Vor dem Löschen wird explizit geprüft, ob das Thema existiert, um saubere 404-Fehler zu ermöglichen.
     */
    public void delete(Long id) {
        if (!repository.existsById(id)) {
            throw new ThemaNotFoundException(id);
        }
        repository.deleteById(id);
    }
}
