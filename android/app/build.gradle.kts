import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "io.github.samumartinez94.adiabetes"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Requerido por flutter_local_notifications para programar avisos.
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "io.github.samumartinez94.adiabetes"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Firma de release. Los datos vienen de `android/key.properties` (en local)
    // o de variables de entorno (en CI). Ninguno de los dos se sube a git.
    // Sin ellos, se firma con la clave de debug para que `flutter run --release`
    // siga funcionando; ese APK NO sirve para publicar.
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
