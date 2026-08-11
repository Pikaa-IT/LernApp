package com.example.meinapplication;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager2.widget.ViewPager2;

import com.example.meinapplication.adapter.FrageDetailAdapter;
import com.example.meinapplication.api.RetrofitClient;
import com.example.meinapplication.model.FrageResponse;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/*
    FrageDetailActivity — der Bildschirm für die Detailansicht der Lernkarten.

    Diese Activity ist das Herzstück der App. Sie zeigt alle Fragen eines Themas
    als durchblätterbare Karten an — ähnlich wie ein digitales Karteikarten-System.

    Ablauf wenn der Nutzer auf eine Frage in FrageListActivity tippt:
      1. FrageAdapter schickt einen Intent mit themaId und fragePosition
      2. Diese Activity empfängt den Intent in onCreate()
      3. ladeFragen() lädt ALLE Fragen des Themas vom Backend
      4. Ein ViewPager2 zeigt die Fragen als wischbare Karten an
      5. Der ViewPager startet direkt bei der angeklickten Frage (startPosition)
      6. Oben wird "Frage X von Y" angezeigt und beim Wischen aktualisiert

    AppCompatActivity = die Android-Basisklasse für moderne Activities,
    stellt grundlegende Funktionen bereit (Toolbar, Theme, Lifecycle).
*/
public class FrageDetailActivity extends AppCompatActivity {

    /*
        ViewPager2 — das wischbare Karten-Widget.

        ViewPager2 ist das modernere Nachfolger-Widget des alten ViewPager.
        Es zeigt immer genau eine "Seite" (hier: eine Fragekarte) an und
        lässt den Nutzer durch horizontales Wischen zur nächsten/vorherigen wechseln.
        Intern verwendet es eine RecyclerView — deshalb funktioniert
        FrageDetailAdapter als normaler RecyclerView.Adapter damit.
    */
    private ViewPager2 viewPager;

    /*
        Zwei TextViews für die Fortschrittsanzeige oben auf dem Bildschirm.
        Zusammen ergeben sie z.B.: "Frage 3 von 12"

        textViewFrageNummer = "Frage 3"   → wird beim Wischen aktualisiert
        textViewFrageCount  = "von 12"    → wird einmalig nach dem Laden gesetzt
    */
    private TextView textViewFrageNummer;
    private TextView textViewFrageCount;

    /*
        themaId — die ID des Themas, dessen Fragen angezeigt werden sollen.
        Kommt per Intent von FrageAdapter (intent.putExtra("themaId", ...)).
        Wird als Klassenfeld gespeichert, weil ladeFragen() sie braucht
        und sie dort nicht mehr über den Intent abgerufen werden kann.
    */
    private Long themaId;

    /*
        onCreate() — wird aufgerufen, wenn die Activity zum ersten Mal gestartet wird.
        Hier wird alles initialisiert: Layout, Views, Intent-Daten, erster API-Aufruf.

        Bundle savedInstanceState: enthält gespeicherte Zustandsdaten,
        falls die Activity nach einer Rotation oder Unterbrechung neu gestartet wird.
        Hier nicht weiter verwendet, aber super.onCreate() braucht ihn zwingend.
    */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Pflichtaufruf: initialisiert die Basisklasse AppCompatActivity.
        // Muss immer als erstes in onCreate() stehen.
        super.onCreate(savedInstanceState);

        // Lädt res/layout/activity_frage_detail.xml als sichtbares Layout dieser Activity.
        setContentView(R.layout.activity_frage_detail);

        // Views per ID aus dem Layout holen und in den Feldern speichern.
        // Ab jetzt können diese Views im gesamten Code dieser Activity verwendet werden.
        viewPager = findViewById(R.id.viewPager);
        textViewFrageNummer = findViewById(R.id.textViewFrageNummer);
        textViewFrageCount = findViewById(R.id.textViewFrageCount);

        /*
            Intent-Daten auslesen — die Werte, die FrageAdapter mitgeschickt hat.

            getIntent() gibt den Intent zurück, mit dem diese Activity gestartet wurde.

            getLongExtra("themaId", -1):
                Liest den Long-Wert mit dem Schlüssel "themaId".
                -1 ist der Fallback-Wert, falls kein Wert unter "themaId" gefunden wird
                (sollte nie passieren, aber -1 ist ein eindeutiges Signal für "fehlt").

            getLongExtra("fragePosition", 0):
                Liest die Position der angeklickten Frage.
                Fallback 0 = erste Frage, falls kein Wert mitgeschickt wurde.
                Cast zu int, weil ViewPager2.setCurrentItem() einen int erwartet,
                putExtra aber nur long unterstützt (daher der Umweg über long).
        */
        themaId = getIntent().getLongExtra("themaId", -1);
        int startPosition = (int) getIntent().getLongExtra("fragePosition", 0);

        // Alle Fragen des Themas laden und den ViewPager aufbauen.
        // startPosition wird übergeben, damit der ViewPager direkt
        // bei der angeklickten Frage startet.
        ladeFragen(startPosition);
    }

    /*
        ladeFragen() — lädt alle Fragen des Themas asynchron vom Backend
        und baut danach den ViewPager auf.

        Warum werden ALLE Fragen geladen, obwohl der Nutzer nur eine angeklickt hat?
        Weil der ViewPager alle Karten zum Durchblättern braucht. Würde man nur
        eine Frage laden, könnte der Nutzer nicht zur nächsten wischen.
        Die angeklickte Frage wird per startPosition direkt angesprungen.

        Parameter:
          startPosition = Index der Frage, bei der der ViewPager starten soll
    */
    private void ladeFragen(int startPosition) {
        RetrofitClient.getApi().getFragenByThema(themaId).enqueue(new Callback<List<FrageResponse>>() {

            /*
                onResponse — Server hat geantwortet (erfolgreich oder mit Fehler).
                Nur bei HTTP 200-299 UND nicht-leerem Body wird der ViewPager aufgebaut.
            */
            @Override
            public void onResponse(Call<List<FrageResponse>> call, Response<List<FrageResponse>> response) {
                if (response.isSuccessful() && response.body() != null) {
                    List<FrageResponse> fragen = response.body();

                    /*
                        Gesamtanzahl der Fragen einmalig setzen: "von 12"
                        fragen.size() = Anzahl der Elemente in der geladenen Liste.
                        Diese Zahl ändert sich nicht beim Wischen, daher nur einmal hier.
                    */
                    textViewFrageCount.setText("von " + fragen.size());

                    /*
                        FrageDetailAdapter erstellen und an den ViewPager übergeben.

                        FrageDetailActivity.this statt einfach "this":
                        Wir sind hier innerhalb einer anonymen Callback-Klasse.
                        "this" würde auf den Callback zeigen, nicht auf die Activity.
                        FrageDetailActivity.this zeigt explizit auf die äußere Activity —
                        das ist der Context, den der Adapter braucht.
                    */
                    FrageDetailAdapter adapter = new FrageDetailAdapter(FrageDetailActivity.this, fragen);
                    viewPager.setAdapter(adapter);

                    /*
                        ViewPager direkt bei der angeklickten Frage starten.

                        setCurrentItem(startPosition, false):
                          startPosition = Index der gewünschten Startseite
                          false = kein Scroll-Animation beim Sprung zur Startposition
                                  (würde sonst sichtbar durch alle Karten scrollen)
                    */
                    viewPager.setCurrentItem(startPosition, false);

                    /*
                        OnPageChangeCallback — reagiert auf Wisch-Ereignisse des Nutzers.

                        registerOnPageChangeCallback() registriert einen Listener,
                        der bei jedem Seitenwechsel aufgerufen wird.

                        onPageSelected(int position):
                            Wird aufgerufen, sobald eine neue Seite vollständig sichtbar ist.
                            position = Index der neuen Seite (0-basiert).
                            position + 1 = menschenlesbare Nummer (1-basiert).

                        Ergebnis: Beim Wischen von Karte 3 zu Karte 4 wird
                        textViewFrageNummer auf "Frage 4" aktualisiert.
                    */
                    viewPager.registerOnPageChangeCallback(new ViewPager2.OnPageChangeCallback() {
                        @Override
                        public void onPageSelected(int position) {
                            textViewFrageNummer.setText("Frage " + (position + 1));
                        }
                    });

                    /*
                        Startnummer sofort anzeigen, bevor der Nutzer wischt.

                        Ohne diese Zeile würde textViewFrageNummer leer bleiben,
                        bis der Nutzer das erste Mal wischt — weil onPageSelected
                        beim initialen setCurrentItem() nicht aufgerufen wird.
                        startPosition + 1 = menschenlesbare Nummer der Startseite.
                    */
                    textViewFrageNummer.setText("Frage " + (startPosition + 1));
                }
            }

            /*
                onFailure — keine Verbindung zum Backend möglich.
                Aktuell leer: die Activity zeigt dann einfach einen leeren Bildschirm.
                Sauberer wäre hier eine Fehlermeldung per Toast oder TextView,
                damit der Nutzer weiß, was passiert ist.
            */
            @Override
            public void onFailure(Call<List<FrageResponse>> call, Throwable t) {
            }
        });
    }
}