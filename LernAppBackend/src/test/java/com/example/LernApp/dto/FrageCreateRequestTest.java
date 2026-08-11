package com.example.LernApp.dto;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

// JUnit 5 Testklasse für das FrageCreateRequest-DTO.
// Kein Spring-Kontext nötig – wir testen nur die Jakarta-Validation-Annotationen
// direkt mit dem Hibernate-Validator (der steckt hinter jakarta.validation).
class FrageCreateRequestTest {

    // Der Validator ist für alle Tests gleich – deshalb einmal in @BeforeAll erzeugen.
    // @BeforeAll läuft genau einmal vor dem ersten Test in dieser Klasse.
    private static Validator validator;

    @BeforeAll
    static void setUp() {
        // Erzeugt eine ValidatorFactory nach dem Jakarta-Standard.
        // Hibernate Validator ist die Standard-Implementierung in Spring Boot.
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    // ---------------------------------------------------------------------------
    // Hilfsmethode: Erstellt ein gültiges Basis-Objekt.
    // Statt in jedem Test new FrageCreateRequest("...", "...", 1L) zu tippen,
    // nutzen wir diese Methode und überschreiben nur das Feld das wir testen wollen.
    // Das macht den Test-Intent sofort erkennbar.
    // ---------------------------------------------------------------------------
    private FrageCreateRequest validRequest() {
        return new FrageCreateRequest(
                "Was ist Vererbung in Java?",  // text           – gültig
                "mittel",                     // schwierigkeit  – gültig
                1L                            // themaId        – gültig
        );
    }

    // ---------------------------------------------------------------------------
    // @Nested gruppiert zusammenhängende Tests in einem eigenen Block.
    // IntelliJ zeigt sie als Baum an: FrageCreateRequestTest > text > ...
    // So weiss man auf den ersten Blick, welches Feld gerade geprüft wird.
    // ---------------------------------------------------------------------------

    // ============================================================
    //  Tests für das Feld: text
    // ============================================================
    @Nested
    @DisplayName("Feld: text")
    class TextValidation {

        // @Test markiert eine Methode als einzelnen Testfall.
        // @DisplayName gibt dem Test einen lesbaren Namen im Test-Report.
        @Test
        @DisplayName("Gueltiger Text – keine Violations erwartet")
        void valid_text_should_pass() {
            // ARRANGE – Objekt mit gültigen Werten bauen
            FrageCreateRequest request = validRequest();

            // ACT – Validator prüft alle Constraints des Objekts
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT – keine einzige Constraint-Verletzung erwartet
            assertThat(violations).isEmpty();
        }

        @Test
        @DisplayName("Leerer Text (nur Leerzeichen) – @NotBlank muss anschlagen")
        void blank_text_should_fail() {
            // ARRANGE – nur das Feld 'text' ist ungültig, alles andere gültig
            FrageCreateRequest request = new FrageCreateRequest(
                    "   ",          // @NotBlank schlägt an: nur Whitespace zählt als "blank"
                    "mittel",
                    1L
            );

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT – genau eine Verletzung, und zwar beim Feld 'text'
            assertThat(violations).hasSize(1);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactly("text");
        }

        @Test
        @DisplayName("Null-Text – @NotBlank deckt auch null ab")
        void null_text_should_fail() {
            // ARRANGE
            // Wichtig: @NotBlank schliesst null MIT EIN – man braucht kein zusätzliches @NotNull
            FrageCreateRequest request = new FrageCreateRequest(null, "mittel", 1L);

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT
            assertThat(violations).hasSize(1);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactly("text");
        }

        @Test
        @DisplayName("Leerer String \"\" – @NotBlank muss anschlagen")
        void empty_string_text_should_fail() {
            // ARRANGE – leerer String "" ist ebenfalls "blank"
            FrageCreateRequest request = new FrageCreateRequest("", "mittel", 1L);

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT
            assertThat(violations).hasSize(1);
            assertThat(violations)
                    .extracting(v -> v.getMessage())
                    // Prüft die exakte Fehlermeldung aus der @NotBlank-Annotation
                    .containsExactly("Fragetext darf nicht leer sein");
        }
    }

    // ============================================================
    //  Tests für das Feld: schwierigkeit
    // ============================================================
    @Nested
    @DisplayName("Feld: schwierigkeit")
    class SchwierigkeitValidation {

        @Test
        @DisplayName("Gueltige Schwierigkeit mit max 50 Zeichen – keine Violations")
        void valid_schwierigkeit_should_pass() {
            // ARRANGE
            FrageCreateRequest request = validRequest(); // schwierigkeit = "mittel" (6 Zeichen)

            // ACT + ASSERT
            assertThat(validator.validate(request)).isEmpty();
        }

        @Test
        @DisplayName("Leere Schwierigkeit – @NotBlank muss anschlagen")
        void blank_schwierigkeit_should_fail() {
            // ARRANGE
            FrageCreateRequest request = new FrageCreateRequest(
                    "Was ist Vererbung?",
                    "",             // @NotBlank schlägt an
                    1L
            );

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT
            assertThat(violations).hasSize(1);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactly("schwierigkeit");
        }

        @Test
        @DisplayName("Null-Schwierigkeit – @NotBlank deckt null ab")
        void null_schwierigkeit_should_fail() {
            // ARRANGE
            FrageCreateRequest request = new FrageCreateRequest(
                    "Was ist Vererbung?",
                    null,           // @NotBlank gilt auch für null
                    1L
            );

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT
            assertThat(violations).hasSize(1);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactly("schwierigkeit");
        }

        @Test
        @DisplayName("Schwierigkeit mit 51 Zeichen – @Size(max=50) muss anschlagen")
        void schwierigkeit_exceeding_50_chars_should_fail() {
            // ARRANGE
            // "A".repeat(51) erzeugt einen String mit 51 'A'-Zeichen – einen mehr als erlaubt
            String zuLang = "A".repeat(51);
            FrageCreateRequest request = new FrageCreateRequest(
                    "Was ist Vererbung?",
                    zuLang,         // @Size(max=50) schlägt an
                    1L
            );

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT
            assertThat(violations).hasSize(1);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactly("schwierigkeit");
            assertThat(violations)
                    .extracting(v -> v.getMessage())
                    .containsExactly("Schwierigkeitsfeld darf höchstens 50 Zeichen lang sein");
        }

        @Test
        @DisplayName("✅ Schwierigkeit mit genau 50 Zeichen – Grenzwert gültig")
        void schwierigkeit_with_exactly_50_chars_should_pass() {
            // ARRANGE
            // Grenzwerttest (Boundary Value): genau 50 Zeichen soll noch gültig sein
            String genau50 = "A".repeat(50);
            FrageCreateRequest request = new FrageCreateRequest(
                    "Was ist Vererbung?",
                    genau50,        // Exakt am Limit – muss noch durchgehen
                    1L
            );

            // ACT + ASSERT
            assertThat(validator.validate(request)).isEmpty();
        }

        @Test
        @DisplayName("✅ Schwierigkeit mit genau 1 Zeichen – Mindestlaenge gueltig")
        void schwierigkeit_with_one_char_should_pass() {
            // ARRANGE
            // Kein @Size(min=...) definiert, also ist 1 Zeichen erlaubt
            FrageCreateRequest request = new FrageCreateRequest(
                    "Was ist Vererbung?",
                    "X",
                    1L
            );

            // ACT + ASSERT
            assertThat(validator.validate(request)).isEmpty();
        }
    }

    // ============================================================
    //  Tests für das Feld: themaId
    // ============================================================
    @Nested
    @DisplayName("Feld: themaId")
    class ThemaIdValidation {

        @Test
        @DisplayName("Gültige themaId – keine Violations")
        void valid_themaId_should_pass() {
            // ARRANGE
            FrageCreateRequest request = validRequest(); // themaId = 1L

            // ACT + ASSERT
            assertThat(validator.validate(request)).isEmpty();
        }

        @Test
        @DisplayName("themaId ist null – @NotNull muss anschlagen")
        void null_themaId_should_fail() {
            // ARRANGE
            // Hier verwenden wir @NotNull (nicht @NotBlank), weil themaId ein Long-Objekt
            // ist, kein String. @NotBlank funktioniert nur auf CharSequence (z.B. String).
            FrageCreateRequest request = new FrageCreateRequest(
                    "Was ist Vererbung?",
                    "mittel",
                    null            // @NotNull schlägt an
            );

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT
            assertThat(violations).hasSize(1);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactly("themaId");
            assertThat(violations)
                    .extracting(v -> v.getMessage())
                    .containsExactly("themaId darf nicht null sein");
        }
    }

    // ============================================================
    //  Kombinierte Tests: mehrere Felder gleichzeitig ungültig
    // ============================================================
    @Nested
    @DisplayName("Mehrere Felder gleichzeitig ungültig")
    class CombinedValidation {

        @Test
        @DisplayName("Alle drei Felder ungültig – 3 Violations erwartet")
        void all_fields_invalid_should_report_all_violations() {
            // ARRANGE
            // Alle drei Felder verletzen ihre Constraints
            FrageCreateRequest request = new FrageCreateRequest(
                    "",     // @NotBlank verletzt
                    "",     // @NotBlank verletzt
                    null    // @NotNull verletzt
            );

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT – alle drei Felder müssen auftauchen
            assertThat(violations).hasSize(3);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactlyInAnyOrder("text", "schwierigkeit", "themaId");
        }

        @Test
        @DisplayName("text leer + schwierigkeit zu lang – 2 Violations erwartet")
        void two_invalid_fields_should_report_two_violations() {
            // ARRANGE
            FrageCreateRequest request = new FrageCreateRequest(
                    null,           // @NotBlank verletzt
                    "A".repeat(51), // @Size(max=50) verletzt
                    1L              // themaId gültig
            );

            // ACT
            Set<ConstraintViolation<FrageCreateRequest>> violations = validator.validate(request);

            // ASSERT
            assertThat(violations).hasSize(2);
            assertThat(violations)
                    .extracting(v -> v.getPropertyPath().toString())
                    .containsExactlyInAnyOrder("text", "schwierigkeit");
        }
    }
}
