package com.example.LernApp.mapper;

import com.example.LernApp.dto.AntwortCreateRequest;
import com.example.LernApp.dto.AntwortResponse;
import com.example.LernApp.dto.AntwortUpdateRequest;
import com.example.LernApp.exception.FrageNotFoundException;
import com.example.LernApp.model.Antwort;
import com.example.LernApp.model.Frage;
import com.example.LernApp.repository.FrageRepository;
import org.springframework.stereotype.Component;

@Component
public class AntwortMapper {
    /*
    private final FrageRepository frageRepository;

    public AntwortMapper(FrageRepository frageRepository) {
        this.frageRepository = frageRepository;
    }
    */

    // Wandelt den Request beim Erstellen in eine Entität um
    public Antwort toEntity(AntwortCreateRequest request, Frage frage) {
        Antwort antwort = new Antwort();
        antwort.setText(request.text()); // Bei Records ruft man request.text() statt request.getText() auf
        antwort.setIstRichtig(request.istRichtig());
        antwort.setFrage(frage);
        return antwort;

        /*
        Frage frage = frageRepository.findById(request.frageId()).orElseThrow(() -> new FrageNotFoundException(request.frageId()));
        antwort.setFrage(frage);

        return antwort;
         */
    }

    public void updateEntity(Antwort target, AntwortUpdateRequest request, Frage frage) {
        target.setIstRichtig(request.istRichtig());
        target.setText(request.text());
        target.setFrage(frage);

        /*
        Frage frage = frageRepository.findById(request.frageId()).orElseThrow(() -> new FrageNotFoundException(request.frageId()));
        target.setFrage(frage);
         */
    }

    // Wandelt die Entität aus der DB in die offene  Response um
    public AntwortResponse toResponse(Antwort antwort) {
        return new AntwortResponse(
                antwort.getId(),
                antwort.getText(),
                antwort.isIstRichtig(),
                antwort.getFrage().getId()
        );
    }
}