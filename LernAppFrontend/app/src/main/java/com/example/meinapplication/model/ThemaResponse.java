package com.example.meinapplication.model;

/*
    ThemaResponse — Datenmodell für ein Thema, das vom Backend kommt.

    Wie AntwortResponse und FrageResponse ist auch diese Klasse ein DTO
    (Data Transfer Object) — ein reiner Datenbehälter ohne eigene Logik.

    Wenn das Backend auf GET /api/themen antwortet, kommt z.B.:
    [
      { "id": 1, "name": "Java Grundlagen",  "beschreibung": "Variablen, Schleifen, OOP" },
      { "id": 2, "name": "Spring Boot",      "beschreibung": "REST APIs, JPA, Security"  },
      { "id": 3, "name": "Android",          "beschreibung": "Activities, Adapter, Retrofit" }
    ]

    Gson erstellt für jedes Objekt im JSON-Array automatisch eine Instanz
    dieser Klasse und befüllt die Felder anhand der JSON-Schlüsselnamen.

    ThemaResponse ist das "oberste" Datenmodell in der App-Hierarchie:
      Thema → hat mehrere → Fragen → haben mehrere → Antworten
    (ThemaResponse → FrageResponse → AntwortResponse)

    Im Gegensatz zu FrageResponse enthält ThemaResponse aber KEINE
    eingebettete Liste von Fragen — die werden erst bei Klick auf ein Thema
    separat geladen (GET /api/fragen?themaId=X in FrageListActivity).
*/
public class ThemaResponse {

    /*
        id — die eindeutige ID dieses Themas in der Datenbank.
        Long (Objekt) statt long (Primitiv), damit null möglich ist.

        Wird im Klick-Listener des ThemaAdapters weitergegeben:
            intent.putExtra("themaId", thema.getId())
        FrageListActivity liest sie aus und schickt sie als Query-Parameter
        an das Backend: GET /api/fragen?themaId=1
    */
    private Long id;

    /*
        name — der Anzeigename des Themas, z.B. "Java Grundlagen".

        Wird an zwei Stellen verwendet:
          1. ThemaAdapter: holder.name.setText(thema.getName())
             → angezeigt als Überschrift in der Themenliste
          2. ThemaAdapter Klick-Listener: intent.putExtra("themaName", thema.getName())
             → weitergegeben an FrageListActivity, damit die Toolbar
                den Themanamen als Titel anzeigen kann
    */
    private String name;

    /*
        beschreibung — ein kurzer Erklärungstext zum Thema.
        Wird in ThemaAdapter als Untertitel unter dem Namen angezeigt:
            holder.beschreibung.setText(thema.getBeschreibung())

        Einfachstes Feld dieser Klasse — wird nur gelesen und angezeigt,
        nirgendwo sonst in der App weiterverwendet.
    */
    private String beschreibung;

    /*
        Getter — einzige öffentliche Schnittstelle dieser Klasse.
        Kein Konstruktor, keine Setter — Gson befüllt die Felder per Reflection.

        Anders als in FrageResponse stimmen hier Feldname und Getter-Name
        immer überein (getId, getName, getBeschreibung) — kein Sonderfall
        wie getFrageText() für das Feld "text".
    */

    // Gibt die Datenbank-ID des Themas zurück.
    // Wird im Intent an FrageListActivity übergeben.
    public Long getId() { return id; }

    // Gibt den Anzeigenamen des Themas zurück.
    // Wird in ThemaAdapter als Listenüberschrift und als Intent-Wert verwendet.
    public String getName() { return name; }

    // Gibt die Beschreibung des Themas zurück.
    // Wird in ThemaAdapter als Untertitel angezeigt.
    public String getBeschreibung() { return beschreibung; }
}