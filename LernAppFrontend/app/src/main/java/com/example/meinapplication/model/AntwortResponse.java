package com.example.meinapplication.model;

/*
    AntwortResponse — Datenmodell für eine Antwort, die vom Backend kommt.

    Diese Klasse ist ein sogenanntes "DTO" (Data Transfer Object).
    Sie hat nur einen Zweck: die JSON-Antwort des Backends in ein Java-Objekt zu übersetzen.

    Wenn das Backend auf GET /api/antworten?frageId=5 antwortet, kommt z.B. das zurück:
    [
      { "id": 12, "text": "Java ist eine Programmiersprache", "istRichtig": true,  "frageId": 5 },
      { "id": 13, "text": "Java ist ein Betriebssystem",      "istRichtig": false, "frageId": 5 }
    ]

    Gson (der JSON-Konverter in RetrofitClient) liest dieses JSON und erstellt
    für jedes Objekt darin eine Instanz dieser Klasse — die Feldnamen im JSON
    müssen dafür mit den Feldnamen hier übereinstimmen (z.B. "istRichtig" ↔ istRichtig).

    Diese Klasse hat bewusst:
      - KEINE Konstruktoren  → Gson befüllt die Felder direkt per Reflection
      - KEINE Setter         → die Daten vom Backend sollen nicht verändert werden
      - NUR Getter           → der Rest der App liest die Daten nur
*/
public class AntwortResponse {

    /*
        id — die eindeutige ID dieser Antwort in der Datenbank.
        Long (Großbuchstabe) statt long (Kleinbuchstabe), weil Long ein Objekt ist
        und null sein kann — wichtig falls das Backend mal keine ID mitschickt.
    */
    private Long id;

    /*
        text — der Anzeigetext der Antwort, z.B. "Java ist eine Programmiersprache".
        Wird in FrageDetailAdapter in die textViewAntworten geschrieben:
            sb.append(antwort.getText()).append("\n\n");
    */
    private String text;

    /*
        istRichtig — gibt an, ob diese Antwort die korrekte Antwort auf die Frage ist.
        boolean (klein) statt Boolean (groß), weil eine Antwort immer entweder
        richtig oder falsch ist — null wäre hier kein sinnvoller Zustand.

        Aktuell wird dieses Feld in der App noch nicht ausgewertet
        (die Antworten werden nur angezeigt, nicht bewertet).
        Es ist aber bereits vorbereitet für eine spätere Funktion,
        z.B. um richtige Antworten grün einzufärben.
    */
    private boolean istRichtig;

    /*
        frageId — die ID der Frage, zu der diese Antwort gehört.
        Entspricht dem Fremdschlüssel in der Datenbanktabelle.
        In der App selbst wird dieser Wert nicht direkt verwendet
        (wir haben die frageId bereits beim Request mitgeschickt),
        aber er kommt vom Backend mit und wird hier gespeichert.
    */
    private Long frageId;

    /*
        Getter — die einzigen öffentlichen Methoden dieser Klasse.

        Warum Getter statt direkt public-Felder?
        Kapselung: der Rest der App greift nie direkt auf die Felder zu,
        sondern immer über diese Methoden. Falls sich später etwas an der
        internen Darstellung ändert, muss nur der Getter angepasst werden,
        nicht jede Stelle im Code, die den Wert verwendet.
    */

    // Gibt die Datenbank-ID dieser Antwort zurück.
    public Long getId() { return id; }

    // Gibt den Anzeigetext der Antwort zurück.
    // Wird in FrageDetailAdapter mit antwort.getText() aufgerufen.
    public String getText() { return text; }

    /*
        isIstRichtig() — der Name klingt doppelt, hat aber einen Grund:
        Java generiert für boolean-Felder automatisch den Getter-Namen "is" + Feldname.
        Da der Feldname bereits "istRichtig" heißt, entsteht "isIstRichtig".
        Sauberer wäre der Feldname "richtig" gewesen → Getter würde dann "isRichtig()" heißen.
        Funktioniert aber genauso.
    */
    public boolean isIstRichtig() { return istRichtig; }

    // Gibt die ID der zugehörigen Frage zurück (Fremdschlüssel aus dem Backend).
    public Long getFrageId() { return frageId; }
}