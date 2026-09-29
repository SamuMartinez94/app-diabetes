import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "io.github.samumartinez94.diaguia"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "io.github.samumartinez94.diaguia"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Firma de release: `android/key.properties` o variables de entorno.
    // Sin ellas se firma con la clave de debug (no sirve para publicar).
    val propiedadesFirma = Properties().apply {
        val fichero = rootProject.file("key.properties")
        if (fichero.exists()) fichero.inputStream().use { load(it) }
    }

    fun dato(clave: String, entorno: String): String? =
        propiedadesFirma.getProperty(clave) ?: System.getenv(entorno)

    val rutaAlmacen = dato("storeFile", "ANDROID_KEYSTORE_PATH")
    val hayFirma = rutaAlmacen != null &&
        dato("storePassword", "ANDROID_KEYSTORE_PASSWORD") != null &&
        dato("keyAlias", "ANDROID_KEY_ALIAS") != null &&
        dato("keyPassword", "ANDROID_KEY_PASSWORD") != null

    signingConfigs {
        if (hayFirma) {
            create("release") {
                storeFile = rootProject.file(rutaAlmacen!!)
                storePassword = dato("storePassword", "ANDROID_KEYSTORE_PASSWORD")
                keyAlias = dato("keyAlias", "ANDROID_KEY_ALIAS")
                keyPassword = dato("keyPassword", "ANDROID_KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hayFirma) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
