package com.example.meinapplication;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.meinapplication.adapter.FrageAdapter;
import com.example.meinapplication.api.RetrofitClient;
import com.example.meinapplication.model.FrageResponse;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/*
    FrageListActivity — zeigt alle Fragen eines bestimmten Themas als scrollbare Liste.

    Diese Activity ist die mittlere Ebene in der Navigation:
      ThemaListActivity → FrageListActivity → FrageDetailActivity

    Ablauf:
      1. ThemaAdapter schickt einen Intent mit themaId und themaName
      2. onCreate() liest diese Werte aus dem Intent
      3. themaName wird sofort als Überschrift angezeigt (kein Laden nötig)
      4. ladeFragen() holt alle Fragen dieses Themas vom Backend
      5. FrageAdapter zeigt sie in der RecyclerView an
      6. Klick auf eine Frage öffnet FrageDetailActivity (im FrageAdapter)

    Gegenüber FrageDetailActivity ist diese Activity einfacher aufgebaut:
      - Kein ViewPager, nur eine schlichte RecyclerView
      - Kein Positions-Tracking
      - Dafür vollständige Fehlerbehandlung in onFailure (anders als FrageDetailActivity)
*/
public class FrageListActivity extends AppCompatActivity {

    /*
        RecyclerView — das scrollbare Listen-Widget.
        Zeigt alle Fragen des gewählten Themas untereinander an.
        Bekommt in onCreate() einen LinearLayoutManager (vertikale Liste)
        und nach dem Laden einen FrageAdapter zugewiesen.
    */
    private RecyclerView recyclerView;

    /*
        textViewThemaName — zeigt den Namen des gewählten Themas als Überschrift.
        Wird direkt aus dem Intent befüllt, ohne einen eigenen API-Aufruf —
        der Name wurde bereits von ThemaListActivity mitgeschickt.
    */
    private TextView textViewThemaName;

    /*
        themaId — die Backend-ID des Themas, dessen Fragen geladen werden sollen.
        Als Klassenfeld gespeichert, weil ladeFragen() sie braucht
        und dort nicht mehr direkt über getIntent() erreichbar ist.
    */
    private Long themaId;

    /*
        onCreate() — Einstiegspunkt der Activity.
        Initialisiert Layout, Views, Intent-Daten und startet den API-Aufruf.
    */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Pflichtaufruf: initialisiert die Basisklasse AppCompatActivity.
        super.onCreate(savedInstanceState);

        // Lädt res/layout/activity_frage_list.xml als sichtbares Layout.
        setContentView(R.layout.activity_frage_list);

        // RecyclerView aus dem Layout holen.
        recyclerView = findViewById(R.id.recyclerViewFragen);

        /*
            LayoutManager festlegen — wie sollen die Listenelemente angeordnet werden?

            LinearLayoutManager = einfache vertikale Liste (ein Element pro Zeile,
            von oben nach unten scrollbar). Das ist der häufigste Fall.
            Alternativen wären z.B. GridLayoutManager (Raster) oder
            StaggeredGridLayoutManager (Pinterest-Stil).

            "this" = der Context dieser Activity, den der LayoutManager
            für interne Berechnungen (z.B. Bildschirmgröße) braucht.

            Ohne setLayoutManager() würde die RecyclerView gar nichts anzeigen —
            der LayoutManager ist Pflicht.
        */
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        // TextView für den Themanamen aus dem Layout holen.
        textViewThemaName = findViewById(R.id.textViewThemaName);

        /*
            Intent-Daten auslesen — Werte, die ThemaAdapter mitgeschickt hat.

            getLongExtra("themaId", -1):
                Liest die Thema-ID. Fallback -1 = "nicht vorhanden"
                (würde später im API-Aufruf zu einem Fehler führen).

            getStringExtra("themaName"):
                Liest den Themanamen als String. Kein Fallback nötig,
                da null-Strings von setText() als leerer Text behandelt werden.

            textViewThemaName.setText(themaName):
                Zeigt den Themanamen sofort an — kein API-Aufruf nötig,
                weil ThemaAdapter den Namen bereits mitgeschickt hat.
                Der Nutzer sieht die Überschrift also ohne Wartezeit.
        */
        themaId = getIntent().getLongExtra("themaId", -1);
        String themaName = getIntent().getStringExtra("themaName");
        textViewThemaName.setText(themaName);

        // Fragen vom Backend laden und in der RecyclerView anzeigen.
        ladeFragen();
    }

    /*
        ladeFragen() — holt alle Fragen des Themas asynchron vom Backend.

        Verwendet themaId als Query-Parameter:
        GET /api/fragen?themaId=3

        Im Gegensatz zu FrageDetailActivity.ladeFragen() hat diese Methode
        eine vollständige Fehlerbehandlung — beide Fehlerfälle zeigen
        eine verständliche Meldung per Toast.
    */
    private void ladeFragen() {
        RetrofitClient.getApi().getFragenByThema(themaId).enqueue(new Callback<List<FrageResponse>>() {

            /*
                onResponse — Server hat geantwortet.
                Kann trotzdem ein Fehler sein (z.B. HTTP 404, 500) —
                deshalb die Prüfung mit isSuccessful() und body() != null.
            */
            @Override
            public void onResponse(Call<List<FrageResponse>> call, Response<List<FrageResponse>> response) {
                if (response.isSuccessful() && response.body() != null) {

                    /*
                        Adapter erstellen und sofort an die RecyclerView übergeben.

                        Hier wird response.body() direkt übergeben statt wie in
                        FrageDetailActivity in einer lokalen Variable zwischenzuspeichern —
                        weil der Wert nur einmal gebraucht wird (kein fragen.size() o.ä.).

                        FrageListActivity.this statt "this":
                        Wir sind in einer anonymen Callback-Klasse — "this" würde auf
                        den Callback zeigen. FrageListActivity.this zeigt auf die Activity.
                    */
                    FrageAdapter adapter = new FrageAdapter(FrageListActivity.this, response.body());
                    recyclerView.setAdapter(adapter);

                } else {
                    /*
                        Server hat geantwortet, aber mit einem Fehlercode (z.B. 404, 500).
                        Toast = kurze Einblendung am unteren Bildschirmrand.
                        LENGTH_SHORT = verschwindet nach ca. 2 Sekunden.
                    */
                    Toast.makeText(FrageListActivity.this, "Fehler beim Laden", Toast.LENGTH_SHORT).show();
                }
            }

            /*
                onFailure — gar keine Verbindung zum Backend möglich.

                Gegenüber FrageDetailActivity (wo onFailure leer ist) gibt es hier
                eine ausführlichere Fehlermeldung: t.getMessage() liefert den
                technischen Fehlertext der Exception, z.B.:
                  "Failed to connect to /10.0.2.2:8080"
                  "timeout"

                LENGTH_LONG = Toast bleibt ca. 3,5 Sekunden sichtbar —
                sinnvoll hier, weil die Nachricht länger ist.

                t.getMessage() kann theoretisch null zurückgeben —
                dann würde "Keine Verbindung: null" angezeigt.
                Sauberer wäre: (t.getMessage() != null ? t.getMessage() : "Unbekannter Fehler")
            */
            @Override
            public void onFailure(Call<List<FrageResponse>> call, Throwable t) {
                Toast.makeText(FrageListActivity.this, "Keine Verbindung: " + t.getMessage(), Toast.LENGTH_LONG).show();
            }
        });
    }
}