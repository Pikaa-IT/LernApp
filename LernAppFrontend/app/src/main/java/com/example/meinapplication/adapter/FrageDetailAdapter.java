package com.example.meinapplication.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.example.meinapplication.R;
import com.example.meinapplication.api.RetrofitClient;
import com.example.meinapplication.model.AntwortResponse;
import com.example.meinapplication.model.FrageResponse;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/*
    FrageDetailAdapter — Adapter für die Detailansicht einer Frage mit aufklappbarer Antwort.

    Dieser Adapter ist der "große Bruder" von FrageAdapter.
    Der Unterschied:
      - FrageAdapter zeigt nur den Fragetext in einer einfachen Liste
      - FrageDetailAdapter zeigt eine Karte pro Frage, bei der man per Button
        die Antworten ein- und ausblenden kann (Lernkarten-Prinzip)

    Neu gegenüber FrageAdapter:
      - Ein Button pro Karte steuert die Sichtbarkeit der Antworten
      - Antworten werden LAZY geladen — d.h. erst beim Klick vom Backend geholt,
        nicht schon beim Aufbau der Liste (spart Traffic und Zeit)
      - Der Zustand "zeigt gerade Antworten oder nicht" wird pro ViewHolder gespeichert
      - Beim Scrollen (= Recycling des ViewHolders) wird der Zustand zurückgesetzt
*/
public class FrageDetailAdapter extends RecyclerView.Adapter<FrageDetailAdapter.FrageDetailViewHolder> {

    // Liste aller Fragen, die als Karten angezeigt werden.
    // Kommt vom Backend über Retrofit und wird von FrageDetailActivity übergeben.
    private List<FrageResponse> fragen;

    // Context wird benötigt für:
    //   1. LayoutInflater (XML-Layout -> Java-View-Objekt)
    //   2. Toast.makeText (Fehlermeldungen anzeigen)
    private Context context;

    /*
        Konstruktor: FrageDetailActivity erstellt diesen Adapter und übergibt
        den Context und die bereits geladene Fragenliste.
    */
    public FrageDetailAdapter(Context context, List<FrageResponse> fragen) {
        this.context = context;
        this.fragen = fragen;
    }

    /*
        onCreateViewHolder — erstellt ein neues, leeres View-Objekt für eine Karte.

        Lädt das Layout res/layout/item_frage_detail.xml und verpackt es
        in einen FrageDetailViewHolder. Passiert nur, wenn die RecyclerView
        wirklich ein neues View-Objekt braucht (nicht bei jedem Scroll-Schritt).
    */
    @NonNull
    @Override
    public FrageDetailViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.item_frage_detail, parent, false);
        return new FrageDetailViewHolder(view);
    }

    /*
        onBindViewHolder — befüllt einen (möglicherweise recycelten) ViewHolder
        mit den Daten der Frage an der gegebenen Position.

        WICHTIG: Diese Methode wird bei jedem Recycling aufgerufen.
        Das heißt: ein ViewHolder, der vorher Frage 1 angezeigt hat,
        wird jetzt vielleicht für Frage 7 wiederverwendet.
        Deshalb MÜSSEN hier alle Zustandsvariablen zurückgesetzt werden —
        sonst würde Frage 7 vielleicht noch die aufgeklappten Antworten
        von Frage 1 anzeigen.
    */
    @Override
    public void onBindViewHolder(@NonNull FrageDetailViewHolder holder, int position) {

        // Holt das FrageResponse-Objekt an der aktuellen Position.
        FrageResponse frage = fragen.get(position);

        // Setzt den Fragetext in die obere TextView der Karte.
        holder.textViewFrage.setText(frage.getFrageText());

        /*
            ZUSTAND ZURÜCKSETZEN (wichtig wegen Recycling!)

            Wenn dieser ViewHolder vorher eine andere Frage angezeigt hat,
            bei der die Antworten ausgeklappt waren, müssen wir das rückgängig machen.
            Andernfalls würde die neue Frage fälschlicherweise auch Antworten zeigen.

            cardViewAntworten.setVisibility(View.GONE):
                GONE = unsichtbar UND nimmt keinen Platz ein.
                (Im Gegensatz zu INVISIBLE = unsichtbar, nimmt aber noch Platz ein)

            buttonUmdrehen.setText("Antwort anzeigen"):
                Button-Beschriftung zurück auf den Ausgangszustand.

            holder.zeigtAntworten = false:
                Zustandsvariable im ViewHolder zurücksetzen.
        */
        holder.cardViewAntworten.setVisibility(View.GONE);
        holder.buttonUmdrehen.setText("Antwort anzeigen");
        holder.zeigtAntworten = false;

        /*
            Klick-Listener für den "Antwort anzeigen / verbergen" Button.

            Dieser Listener wird bei jedem onBindViewHolder neu gesetzt —
            das ist wichtig, damit er immer auf das richtige frage-Objekt
            (und nicht auf eine alte Frage aus einem recycelten ViewHolder) zeigt.

            Die if-Abfrage prüft den aktuellen Zustand:
              - zeigtAntworten == false → Antworten noch nicht sichtbar → laden und anzeigen
              - zeigtAntworten == true  → Antworten gerade sichtbar → ausblenden
        */
        holder.buttonUmdrehen.setOnClickListener(v -> {
            if (!holder.zeigtAntworten) {
                // Antworten sind noch nicht sichtbar → vom Backend laden.
                // frage.getId() = die ID dieser Frage aus dem Backend (Long).
                ladeAntworten(frage.getId(), holder);
            } else {
                // Antworten sind gerade sichtbar → ausblenden und Zustand zurücksetzen.
                holder.cardViewAntworten.setVisibility(View.GONE);
                holder.buttonUmdrehen.setText("Antwort anzeigen");
                holder.zeigtAntworten = false;
            }
        });
    }

    /*
        ladeAntworten — holt die Antworten einer Frage asynchron vom Backend.

        "asynchron" bedeutet: der Netzwerkaufruf läuft im Hintergrund.
        Die App friert dabei NICHT ein — der Nutzer kann weiter scrollen.
        Wenn die Antwort vom Server kommt, werden die Callbacks
        onResponse oder onFailure aufgerufen.

        Parameter:
          frageId = die ID der Frage im Backend (wird als URL-Parameter mitgeschickt)
          holder  = der ViewHolder der zugehörigen Karte (wird in den Callbacks
                    gebraucht, um die UI zu aktualisieren)

        RetrofitClient.getApi() gibt die generierte Retrofit-API-Instanz zurück.
        .getAntwortenByFrage(frageId) ruft den entsprechenden Endpoint auf,
        z.B. GET /api/antworten?frageId=5
        .enqueue(...) schickt den Request asynchron ab.
    */
    private void ladeAntworten(Long frageId, FrageDetailViewHolder holder) {
        RetrofitClient.getApi().getAntwortenByFrage(frageId).enqueue(new Callback<List<AntwortResponse>>() {

            /*
                onResponse — wird aufgerufen, wenn der Server geantwortet hat.
                Das bedeutet NICHT automatisch Erfolg — auch ein HTTP 404 oder 500
                landet hier. Deshalb prüfen wir:
                  response.isSuccessful() = HTTP-Statuscode 200-299?
                  response.body() != null = hat der Server einen Body geschickt?
            */
            @Override
            public void onResponse(Call<List<AntwortResponse>> call, Response<List<AntwortResponse>> response) {
                if (response.isSuccessful() && response.body() != null) {

                    /*
                        Antworten aus der Response-Liste zu einem einzigen String zusammenbauen.

                        StringBuilder ist effizienter als String-Konkatenation mit "+",
                        weil er intern einen Buffer verwendet und nicht bei jeder
                        Zusammenfügung ein neues String-Objekt erstellt.

                        "\n\n" = zwei Zeilenumbrüche zwischen den Antworten (optischer Abstand).
                        .trim() am Ende entfernt den letzten überflüssigen Zeilenumbruch.
                    */
                    StringBuilder sb = new StringBuilder();
                    for (AntwortResponse antwort : response.body()) {
                        sb.append(antwort.getText()).append("\n\n");
                    }

                    // Zusammengebauten Antworttext in die TextView setzen.
                    holder.textViewAntworten.setText(sb.toString().trim());

                    // Antwortkarte sichtbar machen.
                    // VISIBLE = sichtbar und nimmt Platz ein.
                    holder.cardViewAntworten.setVisibility(View.VISIBLE);

                    // Button-Beschriftung und Zustand auf "Antworten sichtbar" setzen.
                    holder.buttonUmdrehen.setText("Antwort verbergen");
                    holder.zeigtAntworten = true;

                } else {
                    // Server hat geantwortet, aber mit einem Fehler (z.B. 404, 500).
                    // Toast = kurze Einblendung am unteren Bildschirmrand (verschwindet automatisch).
                    Toast.makeText(context, "Fehler beim Laden", Toast.LENGTH_SHORT).show();
                }
            }

            /*
                onFailure — wird aufgerufen, wenn gar keine Verbindung möglich war.
                Beispiele: kein WLAN, Backend nicht gestartet, falscher Port.
                t = das Throwable (Exception) mit dem genauen Fehlergrund —
                hier nicht weiter ausgewertet, nur ein genereller Hinweis an den Nutzer.
            */
            @Override
            public void onFailure(Call<List<AntwortResponse>> call, Throwable t) {
                Toast.makeText(context, "Keine Verbindung", Toast.LENGTH_SHORT).show();
            }
        });
    }

    /*
        getItemCount — wie viele Karten soll die RecyclerView anzeigen?
        Wird von der RecyclerView intern aufgerufen, um die Listengröße zu kennen.
    */
    @Override
    public int getItemCount() {
        return fragen.size();
    }

    /*
        FrageDetailViewHolder — Container für alle Views einer einzelnen Fragekarte.

        Gegenüber dem einfachen FrageViewHolder hat dieser ViewHolder mehr Views:
          textViewFrage    = zeigt den Fragetext (immer sichtbar)
          textViewAntworten = zeigt die Antworten (nur wenn ausgeklappt)
          cardViewAntworten = die CardView, die textViewAntworten umhüllt (ein-/ausblendbar)
          buttonUmdrehen   = der Button zum Umschalten

        Neu: zeigtAntworten — eine Zustandsvariable, die speichert,
        ob diese Karte gerade die Antworten anzeigt oder nicht.
        Wird in onBindViewHolder gelesen und geschrieben.

        "static" = keine implizite Referenz auf den äußeren Adapter,
        verhindert Memory Leaks.
    */
    public static class FrageDetailViewHolder extends RecyclerView.ViewHolder {
        TextView textViewFrage, textViewAntworten;
        CardView cardViewAntworten;
        Button buttonUmdrehen;

        // Zustand dieser Karte: false = Antworten versteckt, true = Antworten sichtbar.
        // Initialisierung mit false, weil Karten standardmäßig zugeklappt starten.
        boolean zeigtAntworten = false;

        /*
            Konstruktor: sucht einmalig alle Views per ID und speichert sie.
            Diese IDs müssen exakt mit den android:id-Attributen in
            res/layout/item_frage_detail.xml übereinstimmen.
        */
        public FrageDetailViewHolder(@NonNull View itemView) {
            super(itemView);
            textViewFrage = itemView.findViewById(R.id.textViewFrage);
            textViewAntworten = itemView.findViewById(R.id.textViewAntworten);
            cardViewAntworten = itemView.findViewById(R.id.cardViewAntworten);
            buttonUmdrehen = itemView.findViewById(R.id.buttonUmdrehen);
        }
    }
}