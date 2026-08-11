package com.example.meinapplication.api;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/*
    RetrofitClient — die zentrale Konfiguration für alle Netzwerkanfragen der App.

    Diese Klasse hat zwei Aufgaben:
      1. Die Basis-URL des Backends verwalten (Emulator vs. echtes Gerät)
      2. Eine einzige, wiederverwendbare Retrofit-Instanz bereitstellen

    Warum eine eigene Klasse dafür?
    Retrofit-Objekte sind teuer in der Erstellung (viel Initialisierungsarbeit).
    Wenn jede Activity oder jeder Adapter sein eigenes Retrofit-Objekt erstellen würde,
    wäre das langsam und verschwenderisch. Stattdessen wird hier genau eine Instanz
    erstellt und von allen Stellen in der App wiederverwendet.

    Dieses Muster heißt "Singleton" — eine Klasse, die garantiert
    nur ein einziges Objekt von sich selbst erstellt.
*/
public class RetrofitClient {

    /*
        Basis-URLs für verschiedene Ausführungsumgebungen.

        Das Backend läuft auf dem Entwickler-PC (localhost:8080).
        "localhost" aus Sicht des Android-Geräts bedeutet aber das Gerät selbst —
        nicht den PC. Deshalb braucht man je nach Situation eine andere Adresse.

        BASE_URL_EMULATOR = "http://10.0.2.2:8080/"
            10.0.2.2 ist eine spezielle IP-Adresse im Android-Emulator.
            Sie zeigt immer auf den localhost des Host-PCs (also den Entwicklungsrechner).
            Wenn der Emulator auf dem PC läuft und das Backend auf Port 8080 läuft,
            ist diese Adresse der richtige Weg, das Backend zu erreichen.

        BASE_URL_DEVICE = "http://192.168.X.X:8080/"
            Wenn die App auf einem echten Android-Handy getestet wird,
            das im selben WLAN wie der Entwicklungsrechner hängt,
            muss die lokale IP-Adresse des PCs im Heimnetzwerk verwendet werden.
            Das "X.X" ist ein Platzhalter und MUSS vor dem Test durch die eigene
            IP ersetzt werden — sie ist bei jedem Router und PC anders.
            (Nachschauen unter Windows: ipconfig | unter Linux/Mac: ip a oder ifconfig)

        "static final" bedeutet:
            static = gehört zur Klasse, nicht zu einer Instanz (kein new RetrofitClient() nötig)
            final  = kann nach der Zuweisung nicht mehr geändert werden (Konstante)
    */
    private static final String BASE_URL_EMULATOR = "http://10.0.2.2:8080/";
    private static final String BASE_URL_DEVICE = "http://192.168.X.X:8080/";

    /*
        Aktuell aktive URL — hier wird entschieden, gegen welches Ziel die App baut.
        Zum Umschalten zwischen Emulator und echtem Gerät nur diese eine Zeile ändern.

        Wichtig: Die URL MUSS mit einem "/" enden — Retrofit verlangt das zwingend,
        sonst gibt es zur Laufzeit eine IllegalArgumentException.
    */
    private static final String BASE_URL = BASE_URL_EMULATOR;

    /*
        Die Retrofit-Instanz — das Herzstück dieses Clients.

        "static" = existiert einmal für die gesamte App-Laufzeit, nicht pro Aufruf.
        "null" als Startwert = wurde noch nicht erstellt. Die Erstellung passiert
        beim ersten Aufruf von getApi() (sogenannte "Lazy Initialization").
    */
    private static Retrofit retrofit = null;

    /*
        getApi() — gibt eine einsatzbereite Implementierung des LernAppApi-Interfaces zurück.

        Diese Methode ist der einzige Einstiegspunkt für den Rest der App.
        Aufruf z.B. in FrageDetailAdapter:
            RetrofitClient.getApi().getAntwortenByFrage(frageId).enqueue(...)

        Das Singleton-Muster hier:
            Beim ersten Aufruf ist retrofit noch null → wird erstellt und gespeichert.
            Bei allen weiteren Aufrufen ist retrofit bereits befüllt → wird direkt zurückgegeben.
            So wird das Retrofit-Objekt nur einmal gebaut, egal wie oft getApi() aufgerufen wird.
    */
    public static LernAppApi getApi() {
        if (retrofit == null) {

            /*
                Retrofit.Builder — baut das Retrofit-Objekt Schritt für Schritt zusammen.
                Das Builder-Pattern bedeutet: man ruft nacheinander Konfigurations-Methoden
                auf, die alle wieder "this" zurückgeben, und schließt mit .build() ab.
            */
            retrofit = new Retrofit.Builder()

                    /*
                        .baseUrl(BASE_URL)
                        Setzt die Basis-URL für alle Requests.
                        Die einzelnen Endpunkte aus LernAppApi werden dahinter gehängt:
                        BASE_URL + "themen" → "http://10.0.2.2:8080/themen"
                        BASE_URL + "fragen" → "http://10.0.2.2:8080/fragen"
                        BASE_URL + "antworten" → "http://10.0.2.2:8080/antworten"
                    */
                    .baseUrl(BASE_URL)

                    /*
                        .addConverterFactory(GsonConverterFactory.create())
                        Fügt einen JSON-Konverter hinzu.

                        Das Backend schickt Antworten als JSON-Text, z.B.:
                        [{"id":1,"name":"Java Grundlagen","beschreibung":"..."}]

                        Retrofit alleine versteht kein JSON — es braucht eine Converter-Factory,
                        die das Parsen übernimmt. GsonConverterFactory verwendet Google Gson,
                        eine Bibliothek, die JSON-Text automatisch in Java-Objekte umwandelt
                        (und umgekehrt).

                        Gson gleicht dabei die JSON-Feldnamen (z.B. "frageText") mit den
                        Java-Feldnamen in den Response-Klassen (z.B. FrageResponse.frageText) ab.
                        Stimmen die Namen überein, befüllt Gson die Felder automatisch.
                    */
                    .addConverterFactory(GsonConverterFactory.create())

                    /*
                        .build()
                        Schließt die Konfiguration ab und erstellt das fertige Retrofit-Objekt.
                        Ab hier können keine weiteren Einstellungen mehr gemacht werden.
                    */
                    .build();
        }

        /*
            retrofit.create(LernAppApi.class)
            Das ist Retrofits Kernfunktion: es liest das LernAppApi-Interface
            und generiert zur Laufzeit automatisch eine Implementierung davon.

            Man schreibt im Interface nur:
                @GET("themen")
                Call<List<ThemaResponse>> getAlleThemen();

            Retrofit erstellt daraus intern eine Klasse, die beim Aufruf von getAlleThemen()
            tatsächlich einen HTTP GET-Request an BASE_URL + "themen" schickt,
            die JSON-Antwort mit Gson parst und als List<ThemaResponse> zurückgibt.

            LernAppApi.class = das Class-Objekt des Interfaces (Java-Reflection),
            damit Retrofit weiß, welches Interface es implementieren soll.
        */
        return retrofit.create(LernAppApi.class);
    }
}