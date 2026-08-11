package com.example.LernApp.repository;

import com.example.LernApp.model.Benutzer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

// Spring-Annotation: Kennzeichnet das Interface als Repository-Komponente.
// Dadurch wird es von Springs Component-Scanning erfasst und steht als Bean bereit.
// Zudem sorgt es dafür, dass DB-Exceptions in Springs einheitliche DataAccessException-Hierarchie übersetzt werden.
@Repository
public interface BenutzerRepository extends JpaRepository<Benutzer, Long> {

    // Durch das Erben von JpaRepository stehen dir ohne eine einzige Zeile Code
    // sofort alle Standard-Datenbankoperationen zur Verfügung:
    // - save(Benutzer)        -> Erstellen oder Aktualisieren
    // - findById(Long)        -> Suchen anhand der ID
    // - findAll()             -> Alle Benutzer auflisten
    // - deleteById(Long)      -> Löschen anhand der ID
    // - count()               -> Anzahl der Benutzer ermitteln
}
