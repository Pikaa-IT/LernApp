package com.example.meinapplication.api;

import com.example.meinapplication.model.AntwortResponse;
import com.example.meinapplication.model.FrageResponse;
import com.example.meinapplication.model.ThemaResponse;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;
import retrofit2.http.Query;

/*
    LernAppApi — die Schnittstellen-Definition für alle HTTP-Requests ans Backend.

    Dies ist ein Retrofit-Interface. Retrofit ist eine Bibliothek, die HTTP-Aufrufe
    in Java-Methoden verwandelt. Man schreibt nur dieses Interface mit Annotationen,
    und Retrofit generiert zur Laufzeit automatisch den gesamten Netzwerk-Code darunter.

    Man schreibt also NICHT selbst:
      - URL zusammenbauen
      - HTTP-Verbindung öffnen
      - JSON parsen
      - Threads verwalten
    Das alles erledigt Retrofit anhand der Annotationen hier.

    Dieses Interface wird in RetrofitClient.getApi() als Instanz zurückgegeben.
    Aufgerufen wird es z.B. in FrageDetailAdapter:
        RetrofitClient.getApi().getAntwortenByFrage(frageId).enqueue(...)
*/
public interface LernAppApi {

    /*
        getAlleThemen — lädt die komplette Liste aller Themen vom Backend.

        @GET("themen")
            Retrofit schickt einen HTTP GET-Request an:
            [Basis-URL aus RetrofitClient] + "themen"
            Beispiel: http://10.0.2.2:8080/api/themen

            GET = "ich will Daten lesen" (kein Body, keine Änderung am Server).

        Call<List<ThemaResponse>>
            Call        = ein Retrofit-Objekt, das den noch-nicht-ausgeführten Request kapselt.
                          Man kann .enqueue() (asynchron) oder .execute() (synchron) aufrufen.
            List<ThemaResponse> = was Retrofit nach dem Request zurückliefert.
                          Retrofit + Jackson/Gson parst die JSON-Antwort des Backends
                          automatisch in eine Java-Liste von ThemaResponse-Objekten.

        Das Backend gibt z.B. zurück:
        [
          { "id": 1, "name": "Java Grundlagen", "beschreibung": "..." },
          { "id": 2, "name": "Spring Boot",     "beschreibung": "..." }
        ]
        → wird automatisch zu List<ThemaResponse> mit 2 Einträgen.
    */
    @GET("themen")
    Call<List<ThemaResponse>> getAlleThemen();

    /*
        getFragenByThema — lädt alle Fragen, die zu einem bestimmten Thema gehören.

        @GET("fragen")
            HTTP GET-Request an [Basis-URL] + "fragen"
            Beispiel: http://10.0.2.2:8080/api/fragen

        @Query("themaId") Long themaId
            @Query hängt einen URL-Parameter an die Adresse.
            Aus @GET("fragen") + @Query("themaId") mit Wert 3 wird:
            http://10.0.2.2:8080/api/fragen?themaId=3

            Das "?" trennt die eigentliche URL vom Query-String.
            Das "&" würde weitere Parameter trennen (hier nicht nötig).

            Long themaId = der Wert kommt aus dem Aufrufer (z.B. FrageListActivity),
            der die themaId per Intent von ThemaListActivity erhalten hat.

        Call<List<FrageResponse>>
            Das Backend antwortet mit einer JSON-Liste von Fragen,
            die Retrofit automatisch in List<FrageResponse> umwandelt.
    */
    @GET("fragen")
    Call<List<FrageResponse>> getFragenByThema(@Query("themaId") Long themaId);

    /*
        getAntwortenByFrage — lädt alle Antworten zu einer bestimmten Frage.

        @GET("antworten")
            HTTP GET-Request an [Basis-URL] + "antworten"
            Beispiel: http://10.0.2.2:8080/api/antworten

        @Query("frageId") Long frageId
            Hängt die Frage-ID als URL-Parameter an:
            http://10.0.2.2:8080/api/antworten?frageId=5

            frageId kommt aus FrageDetailAdapter.ladeAntworten(),
            wo frage.getId() übergeben wird.

        Call<List<AntwortResponse>>
            Das Backend antwortet mit einer JSON-Liste von Antworten,
            die Retrofit automatisch in List<AntwortResponse> umwandelt.

        Diese Methode wird als einzige LAZY aufgerufen —
        nicht beim Aufbau der Liste, sondern erst wenn der Nutzer
        auf "Antwort anzeigen" tippt. So werden keine unnötigen
        Netzwerkanfragen gemacht.
    */
    @GET("antworten")
    Call<List<AntwortResponse>> getAntwortenByFrage(@Query("frageId") Long frageId);
}