package com.example.LernApp.service;

import com.example.LernApp.dto.BenutzerCreateRequest;
import com.example.LernApp.dto.BenutzerResponse;
import com.example.LernApp.dto.BenutzerUpdateRequest;
import com.example.LernApp.exception.BenutzerNotFoundException;
import com.example.LernApp.mapper.BenutzerMapper;
import com.example.LernApp.model.Benutzer;
import com.example.LernApp.repository.BenutzerRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

// Spring-Annotation: Markiert die Klasse als Service-Komponente.
// Hier schlägt das logische Herz deiner Benutzerverwaltung. Zudem sorgt die Annotation dafür,
// dass Spring die Klasse als Singleton-Bean verwaltet und für die Controller bereitstellt.
@Service
public class BenutzerService {

    // Die Abhängigkeiten werden als 'final' deklariert, da sie sich nach der
    // Instanziierung des Services nicht mehr ändern dürfen (Immutability).
    private final BenutzerRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final BenutzerMapper mapper;

    // Konstruktor-basierte Dependency Injection (Best Practice in Spring).
    // Spring reicht das Repository und den Mapper beim Starten der Anwendung automatisch hinein.
    public BenutzerService(BenutzerRepository repository, PasswordEncoder passwordEncoder, BenutzerMapper mapper) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
        this.mapper = mapper;
    }

    /**
     * Holt alle Benutzer aus der Datenbank.
     * Nutzt Java-Streams, um jede gefundene 'Benutzer'-Entität über den Mapper
     * in ein sicheres 'BenutzerResponse'-DTO umzuwandeln.
     */
    public List<BenutzerResponse> findAll() {
        return repository.findAll().stream()
                .map(mapper::toResponse)
                .toList();
    }

    /**
     * Sucht einen spezifischen Benutzer anhand seiner ID.
     * Findet das Repository nichts, greift 'orElseThrow' und wirft deine Custom Exception.
     * Dein GlobalExceptionHandler fängt diese auf und macht daraus ein sauberes HTTP 404.
     */
    public BenutzerResponse findById(Long id) {
        Benutzer benutzer = repository.findById(id)
                .orElseThrow(() -> new BenutzerNotFoundException(id));
        return mapper.toResponse(benutzer);
    }

    /**
     * Legt einen neuen Benutzer in der Datenbank an.
     * Nimmt das Create-DTO entgegen, wandelt es in die Entität um (inklusive Passwort-Hashing im Mapper!),
     * speichert es ab und gibt das Ergebnis als Response-DTO zurück.
     */
    public BenutzerResponse create(BenutzerCreateRequest request) {
        // Service encodiert, Mapper bekommt fertigen Hash
        String hash = passwordEncoder.encode(request.getPassword());
        Benutzer saved = repository.save(mapper.toEntity(request, hash));
        return mapper.toResponse(saved);
    }

    /**
     * Aktualisiert die Daten eines bestehenden Benutzers.
     * Lädt zuerst die aktuelle Entität, modifiziert sie über den Mapper mit den Daten aus dem Update-DTO
     * (der Mapper prüft hierbei auch, ob ein neues Passwort gesetzt werden soll) und speichert die Änderungen.
     */
    public BenutzerResponse update(Long id, BenutzerUpdateRequest request) {
        // Prüfen, ob der Benutzer überhaupt existiert
        Benutzer benutzer = repository.findById(id)
                .orElseThrow(() -> new BenutzerNotFoundException(id));

        // Passwort nur hashen, wenn mitgeschickt, sonst null
        // StringUtils.hasText(request.getPassword()) --> überprüft, dass das neues Passwort nicht NULL, leer oder Leerezeichen enthält.
        // passwordEncoder.encode(request.getPassword()) --> Das Klartext-Passwort wird zu einem BCrypt-Hash verschlüsselt
        // null --> Kein neues Passwort mitgeschickt null zurückgeben.
        String hash = StringUtils.hasText(request.getPassword()) ? passwordEncoder.encode(request.getPassword()) : null;

        // Die bestehende Entität mit den neuen Werten aus dem Request füttern
        mapper.updateEntity(benutzer, request, hash);

        // Die geänderten Daten zurück in die DB schreiben und als Response zurückgeben
        return mapper.toResponse(repository.save(benutzer));
    }

    /**
     * Löscht einen Benutzer anhand seiner ID.
     * Es wird vorab explizit geprüft, ob die ID existiert, um dem Client eine
     * aussagekräftige 404-Meldung statt eines stillen Ignorierens zurückzugeben.
     */
    public void delete(Long id) {
        if (!repository.existsById(id)) {
            throw new BenutzerNotFoundException(id);
        }
        repository.deleteById(id);
    }
}
