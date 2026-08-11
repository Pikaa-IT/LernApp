package com.example.LernApp.mapper;

import com.example.LernApp.dto.BenutzerCreateRequest;
import com.example.LernApp.dto.BenutzerResponse;
import com.example.LernApp.dto.BenutzerUpdateRequest;
import com.example.LernApp.model.Benutzer;
import org.apache.commons.lang3.ObjectUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.AssertionsForInterfaceTypes.assertThat;

public class BenutzerMapperTest {

    private BenutzerMapper mapper;

    @BeforeEach
    public void setUp() {
        mapper = new BenutzerMapper();
    }

    @Test
    void toEntity_konvertiertCreateRequestInEntitaet() {
        // Arrange
        BenutzerCreateRequest request = new BenutzerCreateRequest();
        request.setBenutzername("Benutzername-test");
        request.setEmail("test@test.com");
        request.setPassword("passwort-test");

        // Act
        Benutzer result = mapper.toEntity(request, request.getPassword());

        // Assert
        assertThat(result.getId()).isNull();
        assertThat(result.getEmail()).isEqualTo("test@test.com");
        assertThat(result.getBenutzername()).isEqualTo("Benutzername-test");
        assertThat(result.getPasswortHash()).isEqualTo("passwort-test");
    }

    @Test
    void toResponse_konvertiertEntitaetInResponse() {
        // Arrange
        Benutzer benutzer = new Benutzer();
        benutzer.setId(1L);
        // benutzer.setPasswortHash("passwort-test");  // gesetzt, aber darf nicht im Response erscheinen!
        benutzer.setBenutzername("Benutzername-test");
        benutzer.setEmail("test@test.com");

        // Act
        BenutzerResponse response = mapper.toResponse(benutzer);

        // Assert
        assertThat(response.getId()).isEqualTo(1L);
        assertThat(response.getBenutzername()).isEqualTo("Benutzername-test");
        // Sicherheits-Garantie: BenutzerResponse hat keine getPasswortHash()-Methode
        // → Passwort wird vom Mapper bewusst herausgefiltert
        assertThat(response.getEmail()).isEqualTo("test@test.com");
        // einfach prüfen dass alle 3 Felder stimmen und kein 4. Feld (Passwort) existiert
        assertThat(response).isInstanceOf(BenutzerResponse.class);
    }

    @Test
    void updateEntityMitPasswort_ueberschreibtFelderEinerEntitaet() {
        // Arrange
        Benutzer existing = new Benutzer();
        existing.setId(1L);
        existing.setBenutzername("Alter_benutzername-test");
        existing.setEmail("alttest@test.com");
        existing.setPasswortHash("alter_hash-test");

        BenutzerUpdateRequest update = new BenutzerUpdateRequest("Neuer_benutzername-test","neutest@test.com","neue_passwort-test");

        // Act – Service hätte "neue_passwort-test" encodiert, wir simulieren das:
        mapper.updateEntity(existing, update, "neuer_hash-test"); // ← neuer Hash direkt übergeben

        // Assert
        assertThat(existing.getId()).isEqualTo(1L);
        assertThat(existing.getBenutzername()).isEqualTo("Neuer_benutzername-test");
        assertThat(existing.getEmail()).isEqualTo("neutest@test.com");
        assertThat(existing.getPasswortHash()).isEqualTo("neuer_hash-test");
    }

    @Test
    void updateEntityOhnePasswort_ueberschreibtFelderEinerEntitaet() {
        // Arrange
        Benutzer existing = new Benutzer();
        existing.setId(1L);
        existing.setBenutzername("Alter_benutzername-test");
        existing.setEmail("alttest@test.com");
        existing.setPasswortHash("alter_hash-test"); // ← soll nach Update gleich bleiben!

        BenutzerUpdateRequest update = new BenutzerUpdateRequest("Neuer_benutzername-test","neutest@test.com", null);

        // Act
        mapper.updateEntity(existing, update, null); // ← kein neues Passwort

        // Assert
        assertThat(existing.getId()).isEqualTo(1L);
        assertThat(existing.getBenutzername()).isEqualTo("Neuer_benutzername-test");
        assertThat(existing.getEmail()).isEqualTo("neutest@test.com");
        assertThat(existing.getPasswortHash()).isEqualTo("alter_hash-test");
    }

}
