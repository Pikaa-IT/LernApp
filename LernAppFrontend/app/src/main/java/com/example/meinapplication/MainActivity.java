package com.example.meinapplication;

import android.os.Bundle;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

/*
    MainActivity — die automatisch von Android Studio generierte Starter-Activity.

    WICHTIG: Diese Activity wird in dieser App NICHT verwendet.
    Der tatsächliche Startbildschirm ist ThemaListActivity — das ist im
    AndroidManifest.xml festgelegt (dort hat ThemaListActivity den intent-filter
    mit action.MAIN + category.LAUNCHER, nicht MainActivity).

    MainActivity ist ein Überbleibsel aus der Projektgenerierung:
    Wenn man in Android Studio ein neues Projekt erstellt, legt es automatisch
    eine MainActivity an. Da wir ThemaListActivity als Einstiegspunkt gewählt haben,
    ist MainActivity überflüssig — kann aber bedenkenlos stehen bleiben,
    solange sie nicht im Manifest als LAUNCHER eingetragen ist.
*/
public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Pflichtaufruf: initialisiert die Basisklasse AppCompatActivity.
        super.onCreate(savedInstanceState);

        /*
            EdgeToEdge.enable(this) — aktiviert das "Edge-to-Edge"-Display-Modus.

            Normalerweise zeichnet Android die App nur im sicheren Bereich
            des Bildschirms — also unterhalb der Statusleiste (oben mit Uhrzeit
            und Akkuanzeige) und oberhalb der Navigationsleiste (unten mit
            Zurück/Home/Übersicht-Buttons).

            EdgeToEdge.enable() erlaubt der App, den GESAMTEN Bildschirm zu nutzen —
            also auch hinter der Statusleiste und Navigationsleiste zu zeichnen.
            Das sieht moderner aus, erfordert aber die manuelle Behandlung der
            "System Bars" weiter unten, damit Inhalte nicht dahinter verschwinden.
        */
        EdgeToEdge.enable(this);

        // Lädt res/layout/activity_main.xml als sichtbares Layout.
        // Da diese Activity nie gestartet wird, spielt das in der Praxis keine Rolle.
        setContentView(R.layout.activity_main);

        /*
            ViewCompat.setOnApplyWindowInsetsListener — behandelt die System-Bar-Abstände.

            Dieses Konstrukt ist die notwendige Gegenseite zu EdgeToEdge.enable():
            Wenn die App den ganzen Bildschirm nutzt, müssen wir manuell dafür sorgen,
            dass der Inhalt NICHT hinter Statusleiste oder Navigationsleiste landet.

            findViewById(R.id.main):
                Das Root-View-Element des Layouts (das äußerste Element in activity_main.xml,
                das die ID "main" hat — meist ein ConstraintLayout oder LinearLayout).

            setOnApplyWindowInsetsListener((v, insets) -> { ... }):
                Registriert einen Listener, der aufgerufen wird, sobald Android
                die Größe der System Bars kennt (Statusleiste oben, Navigationsleiste unten).
                v      = das Root-View-Element (R.id.main)
                insets = Informationen über alle "Einschränkungen" des Bildschirms

            insets.getInsets(WindowInsetsCompat.Type.systemBars()):
                Holt die konkreten Pixel-Abstände der System Bars:
                  systemBars.top    = Höhe der Statusleiste (oben)
                  systemBars.bottom = Höhe der Navigationsleiste (unten)
                  systemBars.left   = Abstand links (relevant bei Landscape-Modus)
                  systemBars.right  = Abstand rechts (relevant bei Landscape-Modus)

            v.setPadding(left, top, right, bottom):
                Setzt das Padding des Root-Views auf exakt die Größe der System Bars.
                Dadurch wird der Inhalt automatisch nach innen verschoben und
                liegt nicht mehr hinter Statusleiste oder Navigationsleiste.

            return insets:
                Pflicht — gibt die Insets an eventuelle Kind-Views weiter,
                die ebenfalls auf System-Bar-Abstände reagieren wollen.
        */
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}