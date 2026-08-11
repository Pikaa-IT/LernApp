package com.example.LernApp.dto;

public record AntwortResponse (
        Long id,
        String text,
        boolean istRichtig,
        Long frageId
){}
