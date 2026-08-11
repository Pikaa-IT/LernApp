package com.example.LernApp.mapper;

import com.example.LernApp.dto.FrageCreateRequest;
import com.example.LernApp.dto.FrageResponse;
import com.example.LernApp.dto.FrageUpdateRequest;
import com.example.LernApp.exception.ThemaNotFoundException;
import com.example.LernApp.model.Frage;
import com.example.LernApp.model.Thema;
import com.example.LernApp.repository.ThemaRepository;
import org.springframework.stereotype.Component;

/**
 * Mapper für die Konvertierung zwischen Frage-DTOs und der Frage-Entität.
 *
 * DESIGN-ENTSCHEIDUNG:
 * Der Mapper lädt das Thema-Objekt NICHT mehr selbst aus der Datenbank.
 * Stattdessen bekommt er das fertige Thema-Objekt vom FrageService übergeben.
 *
 * Vorher (Mapper lädt selbst):
 *   Mapper = Konvertieren + Datenbankzugriff  --> verletzt Single Responsibility
 *
 * Jetzt (Service lädt, Mapper konvertiert):
 *   Mapper  = nur konvertieren                --> eine Aufgabe
 *   Service = Thema laden + Mapper aufrufen   --> eine Aufgabe
 *
 * Vorteil: Mapper ist ohne Spring-Kontext testbar --> new FrageMapper()
 */

// Spring-Annotation: Registriert die Klasse als Spring-Bean (@Component).
// Dadurch kann Spring das 'ThemaRepository' automatisch hineinstecken (injizieren)
// und den Mapper selbst für deine Services bereitstellen.
@Component
public class FrageMapper {

    // -------------------------------------------------------------------------
    // ENTFERNT: Konstruktor-Injection von ThemaRepository.
    // Das ThemaRepository liegt jetzt im FrageService.
    //
    // Der Mapper braucht das ThemaRepository, um aus der themaId
    // das echte Thema-Objekt zu laden -> per Konstruktor-Injection.
    // private final ThemaRepository themaRepository;

    // Konstruktor-basierte Dependency Injection (Best Practice)
    // public FrageMapper(ThemaRepository themaRepository) {
    //     this.themaRepository = themaRepository;
    // }
    // -------------------------------------------------------------------------

    /**
     * Wandelt ein eingehendes Erstellungs-DTO in eine neue Frage-Entität um.
     * Nutzt die 'themaId' aus dem Request, um die echte Datenbank-Beziehung zu knüpfen.
     */
    public Frage toEntity(FrageCreateRequest request,Thema thema) {
        Frage frage = new Frage();
        frage.setText(request.getText());
        frage.setSchwierigkeit(request.getSchwierigkeit());
        frage.setThema(thema);  // kommt fertig rein
        return frage;

        // ENTFERNT: Thema wurde früher hier direkt aus der DB geladen.
        // Thema thema = themaRepository.findById(request.getThemaId())
        //         .orElseThrow(() -> new ThemaNotFoundException(request.getThemaId()));
        // frage.setThema(thema);
        //
        // return frage;

    }

    /**
     * Aktualisiert eine bestehende Frage-Entität mit den Daten aus einem Update-DTO.
     * Erlaubt es auch, die Frage nachträglich einem anderen Thema zuzuordnen.
     */
    public void updateEntity(Frage target, FrageUpdateRequest request, Thema thema) {
        target.setText(request.getText());
        target.setSchwierigkeit(request.getSchwierigkeit());
        target.setThema(thema); // kommt fertig rein

        // ENTFERNT: Thema wurde früher hier direkt aus der DB geladen.
        // Thema thema = themaRepository.findById(request.getThemaId())
        //         .orElseThrow(() -> new ThemaNotFoundException(request.getThemaId()));
        // frage.setThema(thema);
    }

    /**
     * Wandelt die Frage-Entität in ein flaches Response-DTO um.
     * Verhindert durch die Reduzierung auf 'thema.getId()' die unendliche JSON-Schleife.
     */
    public FrageResponse toResponse(Frage frage) {
        return new FrageResponse(
                frage.getId(),
                frage.getText(),
                frage.getSchwierigkeit(),
                frage.getThema().getId() // nur die ID, kein verschachteltes Objekt
        );
    }

    // -------------------------------------------------------------------------
    // ENTFERNT: resolveThema() wird nicht mehr benötigt, da die
    // Thema-Auflösung jetzt vollständig im FrageService stattfindet.
    // /**
     // * Hilfsmethode: Holt aus der themaId das echte Thema aus der Datenbank.
     // * Gibt es das Thema nicht, wirft sie deine Custom Exception.
     // * Das führt später zu einem sauberen 404 statt zu einem 500er-Serverfehler.
     // */
    // private Thema resolveThema(Long themaId) {
    //     return themaRepository.findById(themaId)
    //             .orElseThrow(() -> new ThemaNotFoundException(themaId));
    // }
    // -------------------------------------------------------------------------
}