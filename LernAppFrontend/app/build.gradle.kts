plugins {
    alias(libs.plugins.android.application)
}

android {
    namespace = "com.example.meinapplication"
    compileSdk {
        version = release(36) {
            minorApiLevel = 1
        }
    }

    defaultConfig {
        applicationId = "com.example.meinapplication"
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            optimization {
                enable = false
            }
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    implementation(libs.activity.ktx)
    implementation(libs.appcompat)
    implementation(libs.constraintlayout)
    implementation(libs.material)
    testImplementation(libs.junit)
    androidTestImplementation(libs.espresso.core)
    androidTestImplementation(libs.ext.junit)
    // Retrofit – HTTP-Client für API-Aufrufe
    implementation("com.squareup.retrofit2:retrofit:2.11.0")

    // Gson Converter – wandelt JSON automatisch in Java-Objekte um
    implementation("com.squareup.retrofit2:converter-gson:2.11.0")

    // RecyclerView – für scrollbare Listen (Themen, Fragen)
    implementation("androidx.recyclerview:recyclerview:1.3.2")

    // CardView – für Karten-Design
    implementation("androidx.cardview:cardview:1.0.0")

    implementation("androidx.viewpager2:viewpager2:1.1.0")
}