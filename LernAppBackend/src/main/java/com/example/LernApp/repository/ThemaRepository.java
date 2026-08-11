package com.example.LernApp.repository;

import com.example.LernApp.model.Benutzer;
import com.example.LernApp.model.Thema;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

// Spring-Annotation: Kennzeichnet das Interface als Repository-Komponente im Data Layer.
// Sie sorgt für das automatische Component-Scanning von Spring und übersetzt
// SQL-Ausnahmen in Springs plattformunabhängige DataAccessException-Hierarchie.
@Repository
public interface ThemaRepository extends JpaRepository<Thema, Long> {

    // Durch das Erben von JpaRepository<Thema, Long> erhälts du sofort
    // alle Standard-Datenbankoperationen einsatzbereit:
    // - save(Thema)         -> Erstellen oder Aktualisieren eines Themas
    // - findById(Long)      -> Suchen eines Themas anhand der ID
    // - findAll()           -> Alle Themen auslesen (z.B. für eine Übersicht im Frontend)
    // - deleteById(Long)    -> Löschen eines Themas anhand der ID
}
