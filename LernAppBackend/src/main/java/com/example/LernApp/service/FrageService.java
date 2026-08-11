package com.example.LernApp.service;

import com.example.LernApp.dto.FrageCreateRequest;
import com.example.LernApp.dto.FrageResponse;
import com.example.LernApp.dto.FrageUpdateRequest;
import com.example.LernApp.exception.FrageNotFoundException;
import com.example.LernApp.exception.ThemaNotFoundException;
import com.example.LernApp.mapper.FrageMapper;
import com.example.LernApp.model.Frage;
import com.example.LernApp.model.Thema;
import com.example.LernApp.repository.FrageRepository;
import com.example.LernApp.repository.ThemaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

// Spring-Annotation: Kennzeichnet die Klasse als Service-Komponente.
// Hier wird die gesamte Business-Logik rund um deine Fragen verwaltet.
@Service
public class FrageService {

    // Die Abhängigkeiten sind 'final' deklariert, um Thread-Sicherheit
    // und Unveränderlichkeit (Immutability) zu garantieren.
    private final FrageRepository frageRepository;
    private final ThemaRepository themaRepository; // neu hinzufügen
    private final FrageMapper mapper;

    // Konstruktor-basierte Dependency Injection. Spring reicht das passende
    // Repository und den FrageMapper beim Anwendungsstart automatisch rein.
    public FrageService(FrageRepository frageRepository, ThemaRepository themaRepository, FrageMapper mapper) {
        this.frageRepository = frageRepository;
        this.themaRepository = themaRepository;
        this.mapper = mapper;
    }

    /**
     * Holt ausnahmslos alle Fragen aus der Datenbank.
     * Mappt jede Frage-Entität in ein flaches FrageResponse-DTO.
     */
    public List<FrageResponse> findAll() {
        return frageRepository.findAll().stream()
                .map(mapper::toResponse)
                .toList();
    }

    /**
     * Holt alle Fragen, die einem bestimmten Thema (Kategorie) zugeordnet sind.
     * Nutzt die benutzerdefinierte Methode aus deinem FrageRepository.
     * Perfekt, um im Frontend ein Quiz nach Themengebieten zu starten.
     */
    public List<FrageResponse> findByThema(Long themaId) {
        return frageRepository.findByThemaId(themaId).stream()
                .map(mapper::toResponse)
                .toList();
    }

    /**
     * Sucht eine einzelne Frage anhand ihrer ID.
     * Schlägt die Suche fehl, wird deine 'FrageNotFoundException' geworfen,
     * was durch den GlobalExceptionHandler in ein HTTP 404 umgewandelt wird.
     */
    public FrageResponse findById(Long id) {
        Frage frage = frageRepository.findById(id)
                .orElseThrow(() -> new FrageNotFoundException(id));
        return mapper.toResponse(frage);
    }

    /**
     * Erstellt eine neue Frage.
     * Lädt zuerst das Thema per themaId aus der Datenbank (404 wenn nicht vorhanden),
     * gibt es dann fertig an den Mapper weiter und speichert die neue Frage.
     */
    public FrageResponse create(FrageCreateRequest request) {
        // Thema hier laden, nicht im Mapper
        Thema thema = themaRepository.findById(request.getThemaId())
                .orElseThrow(() -> new ThemaNotFoundException(request.getThemaId()));

        Frage saved = frageRepository.save(mapper.toEntity(request, thema));
        return mapper.toResponse(saved);
    }

    /**
     * Aktualisiert eine bestehende Frage.
     * Lädt die Frage, aktualisiert Text, Typ und ggf. das Thema über den Mapper
     * und schreibt die Änderungen zurück in die Datenbank.
     */
    public FrageResponse update(Long id, FrageUpdateRequest request) {
        Frage frage = frageRepository.findById(id)
                .orElseThrow(() -> new FrageNotFoundException(id));

        // Thema hier laden, nicht im Mapper
        Thema thema = themaRepository.findById(request.getThemaId())
                .orElseThrow(() -> new ThemaNotFoundException(request.getThemaId()));

        // Aktualisiert die Werte der Entität (inklusive der relationalen Thema-Verknüpfung)
        mapper.updateEntity(frage, request, thema);
        return mapper.toResponse(frageRepository.save(frage));
    }

    /**
     * Löscht eine Frage inklusive aller dazugehörigen Antworten aus der Datenbank.
     * Da du in deiner Frage-Entität 'cascade = CascadeType.ALL' definiert hast,
     * musst du dich hier nicht um die Antwort-Tabelle kümmern – JPA löscht die Antworten automatisch mit!
     */
    public void delete(Long id) {
        // Defensive Programmierung: Fehler werfen, wenn die ID gar nicht existiert
        if (!frageRepository.existsById(id)) {
            throw new FrageNotFoundException(id);
        }
        frageRepository.deleteById(id);
    }
}
