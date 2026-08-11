package com.example.LernApp.mapper;

import com.example.LernApp.dto.BenutzerCreateRequest;
import com.example.LernApp.dto.BenutzerResponse;
import com.example.LernApp.dto.BenutzerUpdateRequest;
import com.example.LernApp.model.Benutzer;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

// Spring-Annotation: Markiert die Klasse als Spring-Bean (@Component).
// Dadurch wird sie in den Spring-Anwendungskontext aufgenommen und kann
// überall dort, wo du sie brauchst (z.B. im BenutzerService), via Dependency Injection injiziert werden.
@Component
public class BenutzerMapper {

    /*
    // Da der Mapper sensible Daten verarbeitet (das Passwort aus dem Create- oder Update-Request),
    // injizieren wir den PasswordEncoder direkt hier. So bleibt die Hashing-Logik im Mapping-Prozess gekapselt.
    private final PasswordEncoder passwordEncoder;

    // Konstruktor-basierte Dependency Injection (Best Practice)
    public BenutzerMapper(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

     */

    /**
     * Wandelt einen eingehenden Registrierungs-Request (DTO) in eine neue Datenbank-Entität um.
     * Kommt beim HTTP POST /benutzer zum Einsatz.
     */
    // toEntity bekommt den fertigen Hash
    public Benutzer toEntity(BenutzerCreateRequest request, String passwortHash) {
        Benutzer benutzer = new Benutzer();
        benutzer.setBenutzername(request.getBenutzername());
        benutzer.setEmail(request.getEmail());
        benutzer.setPasswortHash(passwortHash);
        return benutzer;

        /*
        // Das Klartext-Passwort wird gehasht, BEVOR es in die Entität geschrieben wird.
        // Es verlässt diesen Mapper niemals unverschlüsselt!
        benutzer.setPasswortHash(passwordEncoder.encode(request.getPassword()));

        return benutzer;
         */
    }

    /**
     * Aktualisiert eine bereits bestehende Datenbank-Entität mit den Daten aus einem Update-Request.
     * Kommt beim HTTP PUT /benutzer/{id} zum Einsatz.
     */
    // updateEntity bekommt Hash oder null (null = Passwort nicht ändern)
    public void updateEntity(Benutzer target, BenutzerUpdateRequest request, String passwortHash ) {
        target.setBenutzername(request.getBenutzername());
        target.setEmail(request.getEmail());
        if (passwortHash != null) {
            target.setPasswortHash(passwortHash);
        }

        /*
        // Nutzt StringUtils von Spring. 'hasText' prüft, ob der String nicht null,
        // nicht leer ist und nicht nur aus Leerzeichen besteht.
        // Das setzt deine Logik perfekt um: Wird kein Passwort geschickt, bleibt das alte aktiv.
        if (StringUtils.hasText(request.getPassword())) {
            target.setPasswortHash(passwordEncoder.encode(request.getPassword()));
        }
         */
    }

    /**
     * Wandelt eine Datenbank-Entität in ein flaches, sicheres Response-DTO für den Client um.
     * Filtert sensible Daten wie den Passwort-Hash automatisch heraus.
     */
    public BenutzerResponse toResponse(Benutzer benutzer) {
        // Nutzt den AllArgsConstructor deiner 'BenutzerResponse'-Klasse.
        return new BenutzerResponse(
                benutzer.getId(),
                benutzer.getBenutzername(),
                benutzer.getEmail()
        );
    }
}
