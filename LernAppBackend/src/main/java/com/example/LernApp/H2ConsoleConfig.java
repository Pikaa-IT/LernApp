package com.example.LernApp;

import org.h2.server.web.JakartaWebServlet;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// @Configuration = markiert diese Klasse als Konfigurationsklasse.
// Spring liest sie beim Start und registriert alle @Bean-Methoden
// als Beans im Container
@Configuration
public class H2ConsoleConfig {

    // @Bean = diese Methode erzeugt ein Objekt das Spring verwalten soll.
    // Spring ruft diese Methode beim Start auf und legt das
    // zurückgegebene Objekt in den Container
    @Bean
    public ServletRegistrationBean<JakartaWebServlet> h2Console() {

        // Registriert das H2-Konsolen-Servlet manuell in Spring Boot.
        // JakartaWebServlet = das eigentliche H2-Konsolen-Servlet von H2
        // "/h2-console/*" = unter dieser URL ist die Konsole erreichbar
        // Das /* am Ende bedeutet: alle Unterseiten der Konsole
        // sind ebenfalls erreichbar (z.B. /h2-console/login.do)
        ServletRegistrationBean<JakartaWebServlet> bean =
                new ServletRegistrationBean<>(new JakartaWebServlet(), "/h2-console/*");

        // Gibt an wann das Servlet beim Start geladen wird.
        // 1 = sofort beim Anwendungsstart laden, nicht erst beim
        // ersten Aufruf – stellt sicher dass die Konsole sofort
        // verfügbar ist wenn Tomcat startet
        bean.setLoadOnStartup(1);

        // Fertig konfigurierten Bean zurückgeben –
        // Spring registriert ihn und Tomcat kennt ab jetzt /h2-console
        return bean;
    }
}