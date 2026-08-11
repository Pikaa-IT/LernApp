package com.example.LernApp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * DTO für das Erstellen einer neuen Antwortmöglichkeit.
 * Wird im Controller bei POST-Requests entgegengenommen.
 */
public record AntwortCreateRequest(

        @NotBlank(message = "Der Antworttext darf nicht leer sein.")
        @Size(max = 1000, message = "Der Antworttext darf maximal 1000 Zeichen lang sein.")
        String text,

        boolean istRichtig,

        Long frageId
) {}
