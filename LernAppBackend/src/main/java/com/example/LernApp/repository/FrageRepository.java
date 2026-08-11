package com.example.LernApp.repository;

import com.example.LernApp.model.Frage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

// Spring-Annotation: Kennzeichnet das Interface als Repository-Komponente im Data Layer.
// Ermöglicht das automatische Scannen durch Spring und sorgt für die Übersetzung
// von DB-Ausnahmen in Springs interne Exception-Hierarchie.
@Repository
public interface FrageRepository extends JpaRepository<Frage, Long> {

    /**
     * Nutzt die Spring Data Query Derivation (abgeleitete Abfrage).
     * Da die Entität 'Frage' ein Objekt 'Thema thema' besitzt, das wiederum eine 'id' hat,
     * erkennt Spring diese Kette automatisch und generiert den passenden SQL-Join bzw. die WHERE-Klausel.
     * * @param themaId Die ID des Themas, nach dem gefiltert werden soll.
     * @return Eine Liste aller Fragen, die genau diesem Thema zugeordnet sind.
     */
    // Query Derivation: SELECT * FROM fragen WHERE themen_id = ?
    List<Frage> findByThemaId(Long themaId);
}