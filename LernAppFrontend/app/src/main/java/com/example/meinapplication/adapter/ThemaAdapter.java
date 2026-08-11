package com.example.meinapplication.adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.meinapplication.FrageListActivity;
import com.example.meinapplication.R;
import com.example.meinapplication.model.ThemaResponse;

import java.util.List;

/*
    ThemaAdapter — Adapter für die Themenliste auf dem Startbildschirm.

    Dieser Adapter ist der einfachste der drei Adapter in der App:
      - ThemaAdapter     → zeigt Themen (Name + Beschreibung + laufende Nummer)
      - FrageAdapter     → zeigt Fragen zu einem Thema (nur Text, klickbar)
      - FrageDetailAdapter → zeigt Fragen mit aufklappbaren Antworten

    Besonderheit gegenüber FrageAdapter:
      - Zwei TextViews pro Listenelement (Name + Beschreibung) statt einer
      - Eine dritte TextView für die laufende Nummer (1, 2, 3, ...)
        wird direkt in onBindViewHolder per findViewById geholt,
        nicht im ViewHolder gespeichert — funktioniert, ist aber
        weniger performant (dazu unten mehr)
      - Der Intent übergibt themaId UND themaName an FrageListActivity
*/
public class ThemaAdapter extends RecyclerView.Adapter<ThemaAdapter.ThemaViewHolder> {

    // Liste aller Themen vom Backend.
    // ThemaResponse ist das Datenmodell — entspricht einem Thema-Objekt
    // aus der Spring-Boot-API (id, name, beschreibung).
    private List<ThemaResponse> themen;

    // Context für LayoutInflater und startActivity().
    private Context context;

    /*
        Konstruktor: wird von ThemaListActivity aufgerufen.
        Speichert Context und Themenliste für spätere Verwendung
        in onCreateViewHolder und onBindViewHolder.
    */
    public ThemaAdapter(Context context, List<ThemaResponse> themen) {
        this.context = context;
        this.themen = themen;
    }

    /*
        onCreateViewHolder — erstellt ein neues, leeres View-Objekt.

        Lädt res/layout/item_thema.xml und verpackt es in einen ThemaViewHolder.
        Wird nur aufgerufen, wenn die RecyclerView wirklich ein
        neues View-Objekt braucht — nicht bei jedem Scroll-Schritt.
    */
    @NonNull
    @Override
    public ThemaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.item_thema, parent, false);
        return new ThemaViewHolder(view);
    }

    /*
        onBindViewHolder — befüllt einen ViewHolder mit den Daten
        des Themas an der gegebenen Position.

        Wird bei jedem Recycling aufgerufen. Da ThemaAdapter keinen
        Ein-/Ausklapp-Zustand hat, gibt es hier weniger zurückzusetzen
        als im FrageDetailAdapter — trotzdem wird alles neu gesetzt,
        weil der ViewHolder vorher ein anderes Thema angezeigt haben könnte.
    */
    @Override
    public void onBindViewHolder(@NonNull ThemaViewHolder holder, int position) {

        // Holt das ThemaResponse-Objekt an der aktuellen Position.
        ThemaResponse thema = themen.get(position);

        // Setzt den Themanamen in die obere TextView.
        holder.name.setText(thema.getName());

        // Setzt die Beschreibung in die untere TextView.
        holder.beschreibung.setText(thema.getBeschreibung());

        /*
            Laufende Nummer anzeigen (1-basiert, nicht 0-basiert).

            Hier wird textViewThemaNummer direkt per findViewById gesucht,
            anstatt die Referenz im ViewHolder zu speichern.

            Das funktioniert, ist aber weniger optimal:
            Der ViewHolder-Pattern-Sinn ist genau, dass man findViewById
            nur einmal im Konstruktor aufruft und die Referenz danach
            wiederverwendet. Hier passiert der Aufruf bei jedem
            onBindViewHolder — also bei jedem Recycling.

            Bei einer kurzen Liste (wenige Themen) spielt das keine Rolle.
            Sauberer wäre es, nummer ebenfalls als Feld im ViewHolder zu speichern
            (wie name und beschreibung).

            position + 1: position ist 0-basiert (0, 1, 2, ...),
            für den Nutzer soll aber "1, 2, 3, ..." angezeigt werden.
            String.valueOf() wandelt den int in einen String um,
            weil setText() einen String oder eine CharSequence erwartet.
        */
        TextView nummer = holder.itemView.findViewById(R.id.textViewThemaNummer);
        nummer.setText(String.valueOf(position + 1));

        /*
            Klick-Listener: Thema antippen öffnet die Fragenliste.

            Intent übergibt zwei Werte an FrageListActivity:
              themaId   = die Backend-ID des Themas (Long) — wird für den
                          API-Aufruf "GET /api/fragen?themaId=X" benötigt
              themaName = der Name des Themas (String) — wird in
                          FrageListActivity als Titel der Toolbar angezeigt,
                          damit der Nutzer sieht, welches Thema er gerade lernt

            Beide Werte können in FrageListActivity mit
            getIntent().getLongExtra("themaId", -1) bzw.
            getIntent().getStringExtra("themaName") ausgelesen werden.
        */
        holder.itemView.setOnClickListener(v -> {
            Intent intent = new Intent(context, FrageListActivity.class);
            intent.putExtra("themaId", thema.getId());
            intent.putExtra("themaName", thema.getName());
            context.startActivity(intent);
        });
    }

    /*
        getItemCount — Anzahl der Listenelemente.
        RecyclerView ruft das intern auf, um zu wissen,
        wie viele Einträge es gibt.
    */
    @Override
    public int getItemCount() {
        return themen.size();
    }

    /*
        ThemaViewHolder — Container für die Views eines einzelnen Themeneintrags.

        Speichert Referenzen auf name und beschreibung.
        textViewThemaNummer fehlt hier — der wird direkt in onBindViewHolder
        per findViewById gesucht (siehe Kommentar dort).

        "static" = keine implizite Referenz auf den äußeren Adapter,
        verhindert Memory Leaks.
    */
    public static class ThemaViewHolder extends RecyclerView.ViewHolder {

        // TextView für den Themanamen (z.B. "Java Grundlagen").
        // Entspricht android:id="@+id/textViewThemaName" in item_thema.xml.
        TextView name;

        // TextView für die Beschreibung (z.B. "Variablen, Schleifen, OOP").
        // Entspricht android:id="@+id/textViewThemaBeschreibung" in item_thema.xml.
        TextView beschreibung;

        /*
            Konstruktor: sucht einmalig die Views per ID und speichert sie.
            Wird von onCreateViewHolder aufgerufen — nur wenn ein neuer
            ViewHolder wirklich gebraucht wird, nicht bei jedem Scroll.
        */
        public ThemaViewHolder(@NonNull View itemView) {
            super(itemView);
            name = itemView.findViewById(R.id.textViewThemaName);
            beschreibung = itemView.findViewById(R.id.textViewThemaBeschreibung);
        }
    }
}