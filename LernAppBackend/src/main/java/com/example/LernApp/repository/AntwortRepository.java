package com.example.LernApp.repository;

import com.example.LernApp.model.Antwort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

// Spring-Annotation: Kennzeichnet das Interface als Repository-Komponente im Data Layer.
// Es sorgt dafür, dass datenbankspezifische Exceptions automatisch in Springs
// DataAccessException-Hierarchie übersetzt werden.
@Repository
public interface AntwortRepository extends JpaRepository<Antwort, Long> {

    /**
     * Ein sogenanntes "Query Method" (abgeleitete Abfrage).
     * Spring Data JPA analysiert den Methodennamen zur Laufzeit und generiert
     * automatisch das passende SQL-Statement im Hintergrund.
     * * @param frageId Die ID der Frage, zu der die Antworten gesucht werden.
     * @return Eine Liste aller Antworten, die mit dieser Frage verknüpft sind.
     */
    List<Antwort> findByFrageId(Long frageId);
}
