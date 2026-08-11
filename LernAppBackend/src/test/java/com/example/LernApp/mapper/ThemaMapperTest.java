package com.example.LernApp.mapper;

import com.example.LernApp.dto.ThemaCreateRequest;
import com.example.LernApp.dto.ThemaResponse;
import com.example.LernApp.dto.ThemaUpdateRequest;
import com.example.LernApp.model.Thema;
import org.aspectj.lang.annotation.Before;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

public class ThemaMapperTest {

    private ThemaMapper mapper;

    @BeforeEach
    public void setUp() {
        mapper = new ThemaMapper();
    }
    @Test
    void toEntity_konvertiertCreateRequestInEntitaet() {
        // Arrange
        ThemaCreateRequest themaCreateRequest = new ThemaCreateRequest("Thematext-Test","Themabeschreibung-Test");
        Thema thema = new Thema();
        thema.setId(1L);

        // Act
        Thema result = mapper.toEntity(themaCreateRequest);

        // Assert
        assertThat(result.getId()).isNull();
        assertThat(result.getName()).isEqualTo("Thematext-Test");
        assertThat(result.getBeschreibung()).isEqualTo("Themabeschreibung-Test");
    }

    @Test
    void toResponse_konvertiertEntitaetInResponse() {
        // Arrange
        Thema thema = new Thema();
        thema.setId(1L);
        thema.setName("Test-Name");
        thema.setBeschreibung("Test-Beschreibung");

        // Act
        ThemaResponse response = mapper.toResponse(thema);

        // Assert
        assertThat(response.getId()).isEqualTo(1L);
        assertThat(response.getName()).isEqualTo("Test-Name");
        assertThat(response.getBeschreibung()).isEqualTo("Test-Beschreibung");
    }

    @Test
    void updateEntity_ueberschreibtFelderEinerEntitaet() {
        // Arrange
        // Bestehende Entität (z.B. aus der DB geladen).
        Thema existing =  new Thema();
        existing.setId(1L);
        existing.setName("Alter-Name");
        existing.setBeschreibung("Alter-Beschreibung");

        Thema thema = new Thema();
        thema.setId(2L);

        ThemaUpdateRequest updateRequest = new ThemaUpdateRequest("Neuer-Name", "Neue-Beschreibung");

        // Act
        mapper.updateEntity(existing, updateRequest);

        // Assert
        // ID bleibt gleich, Inhalt ist überschrieben.
        assertThat(existing.getId()).isEqualTo(1L);
        assertThat(existing.getName()).isEqualTo("Neuer-Name");
        assertThat(existing.getBeschreibung()).isEqualTo("Neue-Beschreibung");
    }
}
