package com.example.LernApp.mapper;

import com.example.LernApp.dto.FrageCreateRequest;
import com.example.LernApp.dto.FrageResponse;
import com.example.LernApp.dto.FrageUpdateRequest;
import com.example.LernApp.model.Frage;
import com.example.LernApp.model.Thema;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Unit-Test für den FrageMapper.
 *
 * Keine Spring-Annotationen, keine Datenbank. Wir erzeugen das Objekt mit
 * 'new' und rufen seine Methoden direkt auf. So testen wir in Mikrosekunden,
 * weil nichts hochgefahren werden muss.
 */

public class FrageMapperTest {

    // Das zu testende Objekt. In jedem Test eine frische Instanz.
    private FrageMapper mapper;

    /**
     * @BeforeEach-Methoden werden vor jedem einzelnen @Test ausgeführt.
     * Dadurch beginnt jeder Test mit einem definierten Ausgangszustand.
     */
    @BeforeEach
    void setUp() {
        mapper = new FrageMapper();
    }

    @Test
    void toEntity_konvertiertCreateRequestInEntitaet() {
        // Arrange: einen Eingabewert vorbereiten.
        FrageCreateRequest request = new FrageCreateRequest("Fragetext-Test", "ultra-leicht",123L );
        Thema thema = new Thema();
        thema.setId(123L);

        // Act: die zu testende Methode aufrufen.
        Frage result = mapper.toEntity(request,thema);

        // Assert: das Ergebnis prüfen.
        assertThat(result.getId()).isNull();              // ID darf nicht gesetzt sein
        assertThat(result.getText()).isEqualTo("Fragetext-Test");
        assertThat(result.getSchwierigkeit()).isEqualTo("ultra-leicht");
        assertThat(result.getThema().getId()).isEqualTo(123L);
    }

    @Test
    void toResponse_konvertiertEntitaetInResponse() {
        // Arrange
        Thema thema = new Thema();
        thema.setId(123L);

        Frage frage = new Frage();
        frage.setId(456L);
        frage.setText("Test");
        frage.setSchwierigkeit("ultra-leicht");
        frage.setThema(thema);

        // Act
        FrageResponse response = mapper.toResponse(frage);

        //Assert
        assertThat(response.getId()).isEqualTo(456L);
        assertThat(response.getText()).isEqualTo("Test");
        assertThat(response.getSchwierigkeit()).isEqualTo("ultra-leicht");
        assertThat(response.getThemaId()).isEqualTo(123L);
    }

    @Test
    void updateEntity_ueberschreibtFelderEinerEntitaet() {
        // Arrange
        // Bestehende Entität (z.B. aus der DB geladen).
        Frage existing = new Frage();
        existing.setId(789L);
        existing.setText("Alte Frage");

        Thema thema = new Thema();
        thema.setId(123L);

        FrageUpdateRequest update = new FrageUpdateRequest("Neue Frage", "extra schwer", 123L);

        // Act
        mapper.updateEntity(existing, update, thema);

        // Assert
        // ID bleibt gleich, Inhalt ist überschrieben.
        assertThat(existing.getId()).isEqualTo(789L);
        assertThat(existing.getText()).isEqualTo("Neue Frage");
        assertThat(existing.getSchwierigkeit()).isEqualTo("extra schwer");
        assertThat(existing.getThema().getId()).isEqualTo(123L);
    }
}
