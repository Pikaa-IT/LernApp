package com.example.LernApp.exception;

// Erbt von RuntimeException. Dadurch wird sie zu einer "Unchecked Exception".
// Das bedeutet, du musst sie nicht mit 'throws' im Methodenkopf deklarieren
// und der Code in deinen Services bleibt übersichtlich und kompakt.
public class FrageNotFoundException extends RuntimeException {

    // Der Konstruktor nimmt die ID der vermissten Frage entgegen.
    public FrageNotFoundException(Long id) {
        // Übergibt die dynamisch generierte Fehlermeldung an die Oberklasse (RuntimeException).
        // Diese Nachricht wird später im Exception Handler ausgelesen und an den Client geschickt.
        super("Frage mit ID " + id + " wurde nicht gefunden");
    }
}
