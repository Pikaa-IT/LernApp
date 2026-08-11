package com.example.LernApp.exception;

public class AntwortNotFoundException extends RuntimeException {
    public AntwortNotFoundException(Long id) {
        super("Antwort mit ID " + id + " wurde nicht gefunden");
    }
}
