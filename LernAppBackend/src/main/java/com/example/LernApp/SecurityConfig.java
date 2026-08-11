package com.example.LernApp;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

// @Configuration = markiert diese Klasse als Konfigurationsklasse.
// Spring liest sie beim Start und registriert alle @Bean-Methoden
// als Beans im Container
@Configuration
public class SecurityConfig {

    // @Bean = diese Methode erzeugt ein Objekt das Spring verwalten soll.
    // SecurityFilterChain = die Sicherheitskette die alle HTTP-Anfragen
    // durchlaufen – hier wird festgelegt was erlaubt ist und was nicht
    // throws Exception = wird von Spring Security intern benötigt
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth.anyRequest().permitAll())
                .csrf(csrf -> csrf.disable())
                .headers(headers -> headers.frameOptions(frame -> frame.disable()))
                .formLogin(form -> form.disable());
        return http.build();
    }

    // NEU: stellt den BCrypt-Hash-Algorithmus als Bean bereit.
    // Wird in den BenutzerMapper injiziert, um Passwörter zu hashen.
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}