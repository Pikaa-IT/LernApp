package com.example.meinapplication.adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.meinapplication.FrageDetailActivity;
import com.example.meinapplication.R;
import com.example.meinapplication.model.FrageResponse;

import java.util.List;

/*
    FrageAdapter — der "Übersetzer" zwischen Datenliste und Bildschirm.

    RecyclerView ist das Android-Widget für scrollbare Listen (wie ein modernes ListView).
    Eine RecyclerView weiß selbst NICHT, wie ein einzelnes Listenelement aussieht oder
    welche Daten es anzeigen soll — das ist die Aufgabe des Adapters.

    Das Prinzip dahinter heißt "ViewHolder-Pattern":
    Anstatt für jeden Eintrag in der Liste ein neues View-Objekt zu erstellen
    (was bei 500 Fragen sehr langsam wäre), recycelt Android die Views —
    daher der Name RecyclerView. Wenn ein Element aus dem sichtbaren Bereich
    scrollt, wird sein View-Objekt wiederverwendet und mit neuen Daten befüllt.

    FrageAdapter<FrageAdapter.FrageViewHolder> bedeutet:
    Dieser Adapter arbeitet mit dem ViewHolder-Typ "FrageViewHolder",
    der weiter unten in dieser Datei als innere Klasse definiert ist.
*/
public class FrageAdapter extends RecyclerView.Adapter<FrageAdapter.FrageViewHolder> {

    // Die Liste aller Fragen, die in der RecyclerView angezeigt werden sollen.
    // FrageResponse ist unser Datenmodell — eine Java-Klasse, die die JSON-Antwort
    // vom Spring-Boot-Backend repräsentiert (z.B. frageText, themaId, usw.).
    private List<FrageResponse> fragen;

    // Context ist ein Android-Konzept: ein Zugang zur Laufzeitumgebung der App.
    // Wir brauchen ihn hier für zwei Dinge:
    //   1. LayoutInflater.from(context) — um XML-Layouts in echte View-Objekte umzuwandeln
    //   2. context.startActivity(...) — um eine neue Activity zu öffnen
    private Context context;

    /*
        Konstruktor: wird aufgerufen, wenn FrageListActivity den Adapter erstellt.
        Beide Werte werden von außen übergeben und hier gespeichert,
        damit onCreateViewHolder und onBindViewHolder sie verwenden können.
    */
    public FrageAdapter(Context context, List<FrageResponse> fragen) {
        this.context = context;
        this.fragen = fragen;
    }

    /*
        onCreateViewHolder — Phase 1: View-Objekt erstellen.

        Diese Methode wird aufgerufen, wenn die RecyclerView ein NEUES View-Objekt braucht
        (beim ersten Befüllen der Liste oder wenn mehr Views gebraucht werden als vorhanden).

        Sie erstellt ein leeres, noch nicht befülltes Listenelement und verpackt es
        in einen FrageViewHolder.

        Parameter:
          parent   = die RecyclerView selbst (wird für den LayoutInflater benötigt,
                     damit das neue Element die richtigen Maße bekommt)
          viewType = falls man verschiedene Layout-Typen in einer Liste hat (hier nicht der Fall)

        LayoutInflater "bläst" eine XML-Layoutdatei auf — d.h. er liest die XML-Datei
        (hier: R.layout.item_frage = res/layout/item_frage.xml) und erstellt daraus
        echte Java-View-Objekte zur Laufzeit.
        false = das neue View-Element soll NICHT sofort an parent angehängt werden
                (das macht die RecyclerView selbst, wenn sie bereit ist).
    */
    @NonNull
    @Override
    public FrageViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.item_frage, parent, false);
        return new FrageViewHolder(view);
    }

    /*
        onBindViewHolder — Phase 2: View-Objekt mit Daten befüllen.

        Diese Methode wird aufgerufen, wenn ein ViewHolder (ein bereits existierendes
        View-Objekt) mit den Daten eines bestimmten Listeneintrags befüllt werden soll.
        Das passiert:
          - beim ersten Anzeigen der Liste
          - jedes Mal, wenn ein recycelter ViewHolder neue Daten bekommt

        Parameter:
          holder   = der ViewHolder, dessen Views befüllt werden sollen
          position = der Index in der Liste (0 = erste Frage, 1 = zweite Frage, usw.)
    */
    @Override
    public void onBindViewHolder(@NonNull FrageViewHolder holder, int position) {

        // Holt das FrageResponse-Objekt an der aktuellen Position aus der Liste.
        FrageResponse frage = fragen.get(position);

        // Setzt den Fragetext in das TextView des Listenelements.
        // getFrageText() ist ein Getter aus der FrageResponse-Klasse.
        holder.frageText.setText(frage.getFrageText());

        /*
            Klick-Listener: Was passiert, wenn der Nutzer auf eine Frage tippt?

            setOnClickListener registriert eine Aktion für den Klick auf das gesamte
            Listenelement (itemView = die Root-View des item_frage.xml-Layouts).

            "v -> { ... }" ist eine Lambda-Funktion (Kurzschreibweise für eine anonyme
            Klasse, die das Interface OnClickListener implementiert).
            v = das View-Objekt, auf das geklickt wurde (hier nicht weiter verwendet).

            Intent = "Absicht" — das Kommunikationsmittel zwischen Activities in Android.
            Hier sagen wir: "Ich möchte FrageDetailActivity öffnen."
        */
        holder.itemView.setOnClickListener(v -> {
            Intent intent = new Intent(context, FrageDetailActivity.class);

            // putExtra fügt Zusatzdaten an den Intent an — wie Parameter bei einem Methodenaufruf.
            // FrageDetailActivity kann diese Daten später mit getIntent().getLongExtra(...) auslesen.

            // themaId: wird gebraucht, damit FrageDetailActivity weiß, zu welchem Thema
            // die Fragen gehören — für den API-Aufruf ans Backend.
            intent.putExtra("themaId", frage.getThemaId());

            // fragePosition: der Index der angeklickten Frage in der Liste,
            // damit FrageDetailActivity direkt bei der richtigen Frage startet
            // (z.B. in einer ViewPager-Karte).
            // (long) position = expliziter Cast, weil position ein int ist,
            // putExtra aber einen long erwartet (um konsistent mit themaId zu sein).
            intent.putExtra("fragePosition", (long) position);

            // Startet die FrageDetailActivity mit dem zusammengebauten Intent.
            context.startActivity(intent);
        });
    }

    /*
        getItemCount — wie viele Elemente hat die Liste?

        Die RecyclerView ruft diese Methode auf, um zu wissen, wie viele
        Einträge sie anzeigen soll. Sie bestimmt, wie oft onCreateViewHolder
        und onBindViewHolder aufgerufen werden.
    */
    @Override
    public int getItemCount() {
        return fragen.size();
    }

    /*
        FrageViewHolder — die Schablone für ein einzelnes Listenelement.

        Ein ViewHolder ist ein Container, der die View-Referenzen eines
        Listenelements speichert. Das ist wichtig für Performance:
        findViewById() ist eine teure Operation (Android muss den gesamten
        View-Baum durchsuchen). Indem wir das Ergebnis im ViewHolder speichern,
        muss die Suche nur einmal pro View-Objekt gemacht werden —
        nicht bei jedem Scroll-Schritt.

        "static" bedeutet: diese innere Klasse braucht keine Referenz auf die
        äußere Klasse (FrageAdapter). Das ist guter Stil und verhindert
        Memory Leaks.
    */
    public static class FrageViewHolder extends RecyclerView.ViewHolder {

        // Die TextView, die den Fragetext anzeigt.
        // Entspricht dem Element mit android:id="@+id/textViewFrageText"
        // in der Datei res/layout/item_frage.xml.
        TextView frageText;

        /*
            Konstruktor des ViewHolders.
            itemView = das aufgeblasene View-Objekt des Listenelements
                       (kommt aus LayoutInflater.inflate() in onCreateViewHolder).

            super(itemView) übergibt die View an die Elternklasse RecyclerView.ViewHolder,
            die damit grundlegende Funktionen wie getAdapterPosition() ermöglicht.

            Hier wird einmalig per findViewById nach der TextView gesucht
            und die Referenz im Feld frageText gespeichert.
        */
        public FrageViewHolder(@NonNull View itemView) {
            super(itemView);
            frageText = itemView.findViewById(R.id.textViewFrageText);
        }
    }
}