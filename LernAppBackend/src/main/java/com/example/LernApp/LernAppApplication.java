package com.example.LernApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// Die wichtigste Annotation in einem Spring-Boot-Projekt.
// Sie ist eine Komfort-Annotation, die intern drei mächtige Features kombiniert:
// 1. @SpringBootConfiguration: Markiert die Klasse als Konfigurationsquelle für den Kontext.
// 2. @EnableAutoConfiguration: Aktiviert Springs Magie, die anhand der Dependencies im Build-File (z.B. pom.xml)
//    automatisch passende Beans (wie die DataSource für Hibernate/JPA oder den Tomcat-Server) konfiguriert.
// 3. @ComponentScan: Weist Spring an, das aktuelle Package und alle Unterpackages (Sub-Packages) nach
//    konfigurierten Komponenten (wie @Service, @Repository, @Component, @RestController) zu durchsuchen.
@SpringBootApplication
public class LernAppApplication {

	// Die Standard-Main-Methode. Sie dient als Einstiegspunkt (Entry Point) für die Java Virtual Machine (JVM).
	public static void main(String[] args) {
		// Startet den eingebetteten Tomcat-Webserver, initialisiert den Spring-Anwendungskontext (ApplicationContext)
		// und liest alle Annotations-basierten Beans in den Speicher ein.
		SpringApplication.run(LernAppApplication.class, args);
	}

}
