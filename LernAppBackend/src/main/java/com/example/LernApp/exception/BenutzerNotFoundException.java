package com.example.LernApp.exception;


// Erbt von RuntimeException. Dadurch handelt es sich um eine "Unchecked Exception".
// Sie muss nicht zwingend im Methodenkopf mit 'throws' deklariert werden,
// was den Code in den Services deutlich cleaner hält.
public class BenutzerNotFoundException extends RuntimeException {

    // Der Konstruktor erwartet die ID des Benutzers, der nicht gefunden wurde.
    public BenutzerNotFoundException(Long id) {
        // Reicht die dynamisch gebaute Fehlermeldung an den Konstruktor
        // der Oberklasse (RuntimeException) weiter.
        // Diese Meldung kann später über .getMessage() ausgelesen werden.
        super("Benutzer mit ID " + id + " wurde nicht gefunden");
    }
}
