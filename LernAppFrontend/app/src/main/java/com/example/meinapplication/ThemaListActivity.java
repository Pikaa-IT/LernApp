package com.example.meinapplication;

import android.os.Bundle;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.meinapplication.adapter.ThemaAdapter;
import com.example.meinapplication.api.RetrofitClient;
import com.example.meinapplication.model.ThemaResponse;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/*
    ThemaListActivity — der echte Startbildschirm der App.

    Dies ist die erste Activity, die der Nutzer sieht — festgelegt im
    AndroidManifest.xml durch den intent-filter mit action.MAIN + category.LAUNCHER.

    Sie ist die einfachste der drei "List/Detail"-Activities und der
    Ausgangspunkt der gesamten Navigation:

      ThemaListActivity → FrageListActivity → FrageDetailActivity

    Aufgabe: alle Themen vom Backend laden und in einer scrollbaren
    Liste anzeigen. Klick auf ein Thema öffnet FrageListActivity
    (das passiert im ThemaAdapter, nicht hier).

    Gegenüber FrageListActivity noch einfacher aufgebaut:
      - Kein Intent nötig (es gibt keine "übergeordnete" Activity)
      - Keine Überschrift aus einem Intent — der Titel steht fest im Layout
      - Sonst identische Struktur: RecyclerView + Retrofit-Aufruf + Adapter
*/
public class ThemaListActivity extends AppCompatActivity {

    /*
        RecyclerView — zeigt die Themenliste an.
        Bekommt in onCreate() einen LinearLayoutManager (vertikale Liste)
        und nach dem Laden einen ThemaAdapter zugewiesen.
        Kein ViewPager wie in FrageDetailActivity — hier reicht eine
        einfache scrollbare Liste.
    */
    private RecyclerView recyclerView;

    /*
        onCreate() — wird aufgerufen, wenn die App gestartet wird.
        Da dies die Launcher-Activity ist, ist das der allererste
        Einstiegspunkt der gesamten App.
    */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Pflichtaufruf: initialisiert die Basisklasse AppCompatActivity.
        super.onCreate(savedInstanceState);

        // Lädt res/layout/activity_thema_list.xml als sichtbares Layout.
        setContentView(R.layout.activity_thema_list);

        // RecyclerView aus dem Layout holen.
        recyclerView = findViewById(R.id.recyclerViewThemen);

        /*
            LayoutManager festlegen.
            LinearLayoutManager = vertikale Liste, ein Thema pro Zeile.
            Ohne diesen Aufruf würde die RecyclerView nichts anzeigen.
            "this" = Context dieser Activity.
        */
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        /*
            Themen laden — der einzige API-Aufruf dieser Activity.
            Kein Intent nötig, weil es keine übergeordnete Activity gibt,
            die Daten mitschicken könnte. Der Aufruf geht direkt los.
        */
        ladeThemen();
    }

    /*
        ladeThemen() — holt die komplette Themenliste asynchron vom Backend.

        Verwendet den parameterlosesten Endpunkt der App:
        GET /api/themen  (kein Query-Parameter nötig, da alle Themen geladen werden)

        Struktur identisch mit FrageListActivity.ladeFragen() —
        beide zeigen das gleiche Muster:
          onResponse → Adapter erstellen → RecyclerView befüllen
          onFailure  → Toast mit Fehlermeldung
    */
    private void ladeThemen() {
        RetrofitClient.getApi().getAlleThemen().enqueue(new Callback<List<ThemaResponse>>() {

            /*
                onResponse — Server hat geantwortet.
                isSuccessful() = HTTP 200-299
                body() != null = Server hat Daten mitgeschickt (keine leere Antwort)
            */
            @Override
            public void onResponse(Call<List<ThemaResponse>> call, Response<List<ThemaResponse>> response) {
                if (response.isSuccessful() && response.body() != null) {

                    /*
                        ThemaAdapter erstellen und an die RecyclerView übergeben.

                        ThemaListActivity.this statt "this":
                        Innerhalb der anonymen Callback-Klasse zeigt "this" auf
                        den Callback, nicht auf die Activity.
                        ThemaListActivity.this ist der korrekte Context.

                        response.body() = die geparste Liste von ThemaResponse-Objekten,
                        die Gson automatisch aus dem JSON des Backends erstellt hat.
                    */
                    ThemaAdapter adapter = new ThemaAdapter(ThemaListActivity.this, response.body());
                    recyclerView.setAdapter(adapter);

                } else {
                    /*
                        Server erreichbar, aber Fehlerantwort (z.B. HTTP 500).
                        LENGTH_SHORT = Toast verschwindet nach ca. 2 Sekunden.
                    */
                    Toast.makeText(ThemaListActivity.this, "Fehler beim Laden", Toast.LENGTH_SHORT).show();
                }
            }

            /*
                onFailure — keine Verbindung zum Backend.
                Typische Ursachen:
                  - Backend (Spring Boot) nicht gestartet
                  - Falscher Port in RetrofitClient (nicht 8080)
                  - Emulator verwendet, aber BASE_URL_DEVICE eingestellt (oder umgekehrt)
                  - usesCleartextTraffic fehlt im AndroidManifest

                t.getMessage() liefert den technischen Fehlertext, z.B.:
                  "Failed to connect to /10.0.2.2:8080"
                LENGTH_LONG = Toast bleibt ca. 3,5 Sekunden — sinnvoll,
                weil die Nachricht mit t.getMessage() länger ist.
            */
            @Override
            public void onFailure(Call<List<ThemaResponse>> call, Throwable t) {
                Toast.makeText(ThemaListActivity.this, "Keine Verbindung: " + t.getMessage(), Toast.LENGTH_LONG).show();
            }
        });
    }
}