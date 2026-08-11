package com.example.meinapplication.model;

import java.util.List;

/*
    FrageResponse — Datenmodell für eine Frage, die vom Backend kommt.

    Wie AntwortResponse ist auch diese Klasse ein DTO (Data Transfer Object) —
    ein reiner Datenbehälter ohne eigene Logik.

    Wenn das Backend auf GET /api/fragen?themaId=3 antwortet, kommt z.B.:
    [
      {
        "id": 7,
        "text": "Was ist eine Variable?",
        "themaId": 3,
        "antworten": []
      },
      {
        "id": 8,
        "text": "Was ist eine Schleife?",
        "themaId": 3,
        "antworten": []
      }
    ]

    Gson erstellt für jedes Objekt im JSON-Array eine Instanz dieser Klasse.

    Besonderheit gegenüber AntwortResponse:
    FrageResponse enthält ein Listenfeld (antworten), das wiederum
    AntwortResponse-Objekte enthält — eine verschachtelte Struktur.
    Gson kann auch das automatisch befüllen, sofern das Backend die
    Antworten eingebettet mitschickt. In dieser App werden die Antworten
    aber separat per eigenem API-Aufruf geladen (lazy in FrageDetailAdapter),
    weshalb antworten in der Praxis meist eine leere Liste ist.
*/
public class FrageResponse {

    /*
        id — die eindeutige ID dieser Frage in der Datenbank.
        Long (Objekt) statt long (Primitiv), damit null möglich ist,
        falls das Backend die ID in manchen Fällen weglässt.
        Wird in FrageDetailAdapter mit frage.getId() an ladeAntworten() übergeben.
    */
    private Long id;

    /*
        text — der eigentliche Fragetext, z.B. "Was ist eine Variable?".

        ACHTUNG: Das Feld heißt intern "text", aber der Getter heißt getFrageText().
        Das ist eine bewusste Entscheidung: im JSON und in der Datenbank
        heißt das Feld "text", in der App-Oberfläche und im Code soll es
        aber als "Fragetext" lesbar sein.

        Gson befüllt das Feld anhand des JSON-Schlüssels "text" — der Getter-Name
        spielt für Gson keine Rolle. Nur der Feldname muss mit dem JSON übereinstimmen.
    */
    private String text;

    /*
        themaId — die ID des Themas, zu dem diese Frage gehört (Fremdschlüssel).
        Wird im Klick-Listener des FrageAdapters per Intent weitergegeben:
            intent.putExtra("themaId", frage.getThemaId());
        FrageDetailActivity braucht die themaId, um alle Fragen des Themas
        für den ViewPager nachzuladen.
    */
    private Long themaId;

    /*
        antworten — die Liste der zugehörigen Antworten als eingebettete Objekte.

        Gson kann verschachtelte Strukturen automatisch befüllen:
        Wenn das Backend die Antworten direkt im Frage-JSON mitschickt,
        würde Gson hier automatisch AntwortResponse-Objekte erstellen.

        In dieser App ist das Feld aber in der Praxis immer eine leere Liste,
        weil die Antworten erst bei Bedarf separat geladen werden
        (GET /api/antworten?frageId=X in FrageDetailAdapter.ladeAntworten()).
        Das Feld ist trotzdem definiert, um die Möglichkeit offen zu halten,
        die API später so umzubauen, dass Antworten direkt mitgeliefert werden.
    */
    private List<AntwortResponse> antworten;

    /*
        Getter — einzige öffentliche Schnittstelle dieser Klasse.
        Kein Konstruktor, keine Setter — Gson befüllt die Felder per Reflection.
    */

    // Gibt die Datenbank-ID der Frage zurück.
    // Wird in FrageDetailAdapter als Parameter für getAntwortenByFrage() verwendet.
    public Long getId() { return id; }

    /*
        getFrageText() — gibt den Fragetext zurück.

        Der Getter-Name weicht absichtlich vom Feldnamen ab:
        Das Feld heißt "text" (so kommt es vom Backend im JSON),
        der Getter heißt "getFrageText()" (lesbarer im App-Code).

        Aufgerufen in:
          - FrageAdapter:       holder.frageText.setText(frage.getFrageText())
          - FrageDetailAdapter: holder.textViewFrage.setText(frage.getFrageText())
    */
    public String getFrageText() { return text; }

    /*
        getThemaId() — gibt die ID des zugehörigen Themas zurück.
        Aufgerufen im Klick-Listener in FrageAdapter:
            intent.putExtra("themaId", frage.getThemaId())
        Damit weiß FrageDetailActivity, welche Thema-ID sie für den
        Nachladen aller Fragen verwenden soll.
    */
    public Long getThemaId() { return themaId; }

    // Gibt die Liste der eingebetteten Antworten zurück.
    // In der aktuellen App-Version in der Praxis immer eine leere Liste,
    // da Antworten lazy per separatem API-Aufruf geladen werden.
    public List<AntwortResponse> getAntworten() { return antworten; }
}