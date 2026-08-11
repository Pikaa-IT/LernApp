package com.example.LernApp.mapper;

import com.example.LernApp.dto.AntwortCreateRequest;
import com.example.LernApp.dto.AntwortResponse;
import com.example.LernApp.dto.AntwortUpdateRequest;
import com.example.LernApp.dto.FrageUpdateRequest;
import com.example.LernApp.model.Antwort;
import com.example.LernApp.model.Frage;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class AntwortMapperTest {

    private AntwortMapper mapper;

    @BeforeEach
    public void setUp() {
        mapper = new AntwortMapper();
    }

    @Test
    void toEntity_konvertiertCreateRequestInEntitaet() {
        // Arrange
        AntwortCreateRequest request = new AntwortCreateRequest("Text_Beispiel-Test", true, 123L);
        Frage frage = new Frage();
        frage.setId(123L);

        // Act
        Antwort result = mapper.toEntity(request,frage);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getText()).isEqualTo("Text_Beispiel-Test");
        assertThat(result.isIstRichtig()).isTrue();
        assertThat(result.getFrage().getId()).isEqualTo(123L);
    }

    @Test
    void toResponse_konvertiertEntitaetInResponse() {
        // Arrange
        Frage frage = new Frage();
        frage.setId(123L);

        Antwort antwort = new Antwort();
        antwort.setId(456L);
        antwort.setText("Text_Beispiel-Test");
        antwort.setIstRichtig(true);
        antwort.setFrage(frage);

        // Act
        AntwortResponse response = mapper.toResponse(antwort);

        // Assert
        assertThat(response.id()).isEqualTo(456L);
        assertThat(response.text()).isEqualTo("Text_Beispiel-Test");
        assertThat(response.istRichtig()).isTrue();
        assertThat(response.frageId()).isEqualTo(123L);
    }

    @Test
    void updateEntity_ueberschreibtFelderEinerEntitaet() {
        // Arrange
        Antwort existing  = new Antwort();
        existing.setId(123L);
        existing.setText("Altes_Beispiel-Test");
        existing.setIstRichtig(true);

        Frage frage = new Frage();
        frage.setId(456L);

        AntwortUpdateRequest update = new AntwortUpdateRequest("Neues_Beispiel-Test", true, 456L);

        // Act
        mapper.updateEntity(existing, update, frage);

        // Assert
        assertThat(existing.getId()).isEqualTo(123L);
        assertThat(existing.getText()).isEqualTo("Neues_Beispiel-Test");
        assertThat(existing.isIstRichtig()).isTrue();
        assertThat(existing.getFrage().getId()).isEqualTo(456L);
    }
}
