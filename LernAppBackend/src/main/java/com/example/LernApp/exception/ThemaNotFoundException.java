package com.example.LernApp.exception;

// Erbt von RuntimeException. Damit ist es eine "Unchecked Exception",
// die nicht zwingend im Methodenkopf mit 'throws' deklariert werden muss.
public class ThemaNotFoundException extends RuntimeException {

    // Der Konstruktor erwartet die ID des Themas, das nicht gefunden wurde.
    // Tipp: Nenne den Parameter lieber 'id' statt 'message', da du eine ID (Long) übergibst.
    public ThemaNotFoundException(Long id) {
        // Übergibt den dynamischen Fehlertext an die Oberklasse (RuntimeException).
        // Dieser Text wird später von deinem GlobalExceptionHandler ausgelesen.
        super("Das Thema mit ID " + id + " wurde nicht gefunden");
    }
}
