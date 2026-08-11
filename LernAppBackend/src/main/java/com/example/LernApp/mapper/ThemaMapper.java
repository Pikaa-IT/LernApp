package com.example.LernApp.mapper;

import com.example.LernApp.dto.*;
import com.example.LernApp.model.Thema;
import org.springframework.stereotype.Component;

// Spring-Annotation: Registriert die Klasse als Spring-Bean (@Component).
// Dadurch weiß das Framework, dass es diesen Mapper verwalten und bei Bedarf
// (z. B. im ThemaService) per Dependency Injection bereitstellen soll.
@Component
public class ThemaMapper {

    /**
     * Wandelt ein eingehendes Erstellungs-DTO (ThemaCreateRequest) in eine neue Thema-Entität um.
     * Kommt zum Einsatz, wenn ein ganz neues Thema über POST /thema angelegt wird.
     */
    public Thema toEntity(ThemaCreateRequest request) {
        Thema thema = new Thema();
        // Die validierten Daten aus dem Request-DTO werden auf die neue Entität übertragen
        thema.setName(request.getName());
        thema.setBeschreibung(request.getBeschreibung());
        return thema;
    }

    /**
     * Aktualisiert eine bereits existierende Thema-Entität mit den neuen Daten aus dem Update-DTO.
     * Kommt zum Einsatz, wenn ein bestehendes Thema über PUT /thema/{id} modifiziert wird.
     * * @param target Die bestehende Entität aus der Datenbank (wird direkt verändert).
     * @param request Das DTO mit den neuen Werten vom Client.
     */
    public void updateEntity(Thema target, ThemaUpdateRequest request) {
        target.setName(request.getName());
        target.setBeschreibung(request.getBeschreibung());
        // WICHTIG: Die ID des 'target'-Objekts wird hier nicht angefasst,
        // da Primärschlüssel niemals durch einen User-Request verändert werden sollten.
    }

    /**
     * Wandelt eine Thema-Entität in ein sicheres, flaches Response-DTO (ThemaResponse) um.
     * Dies ist die Repräsentation, die das Frontend als JSON-Antwort erhält.
     */
    public ThemaResponse toResponse(Thema thema) {
        // Nutzt den AllArgsConstructor von 'ThemaResponse', um ID, Name und Beschreibung zu übergeben
        return new ThemaResponse(
                thema.getId(),
                thema.getName(),
                thema.getBeschreibung()
        );
    }
}
