> [!WARNING]
> **Proyecto No Oficial:** Esta aplicación es un proyecto personal sin fines de lucro, desarrollado exclusivamente con fines informativos y orientados al usuario. No es una herramienta médica profesional, ni está vinculada, patrocinada o avalada por ninguna de las marcas comerciales de dispositivos médicos mencionadas.

> [!CAUTION]
> **Contenido pendiente de validación clínica.** Las guías de recambio y las fichas de alarmas llevan un aviso discreto de "contenido en revisión" dentro de la app. Están pendientes de revisión por un profesional sanitario.

---

# DiaGuía

*Guía para usuarios de bombas de insulina y sensores de glucosa.*

Aplicación de soporte desarrollada en **Flutter** para usuarios de bombas de insulina y sensores de glucosa. Ofrece guías visuales paso a paso, un buscador de alarmas y herramientas de seguimiento.

---

## Características

- **Tu configuración:** selección de bomba, sensor y catéter, que adapta todo el contenido a tus dispositivos. Se guarda, así que solo se pregunta una vez.
- **Guías de recambio:** tutoriales paso a paso de catéter y de sensor, con la pantalla siempre encendida mientras dura el proceso.
- **Buscador:** encuentra alarmas por su nombre, por su código o por lo que te está pasando ("no pasa insulina", "pitido"), y también apartados de la app. Funciona sin tildes.
- **Árbol de diagnóstico:** flujo de preguntas para resolver los fallos más comunes.
- **Rotación de zonas:** registra dónde te has puesto el catéter o el sensor y sugiere la próxima zona, para evitar la lipohipertrofia. Desactivable.
- **Recordatorios de recambio:** notificaciones locales configurables. Desactivadas por defecto.
- **Kit de viaje:** checklist de qué llevar y qué papeles necesitas.
- **Soporte y manuales:** webs oficiales de cada fabricante y acceso rápido al 112.
- **Tema claro y oscuro**, o el del sistema.
- **Cinco idiomas:** castellano, inglés, gallego, catalán y euskera. Se elige con banderas y el cambio es instantáneo, sin cerrar la pantalla en la que estás.

---

## Publicar en Google Play

El APK de release se firma con **tu propia clave**. Sin ella, se firma con la de debug: sirve para probar, pero Google Play no lo acepta.

### 1. Crear la clave (una sola vez)

En PowerShell, con el `keytool` que trae Android Studio. Te pedirá contraseñas y tus datos: **elígelas tú y guárdalas en un gestor de contraseñas**.

```powershell
& "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -genkeypair -v `
  -keystore "$HOME\upload-keystore.jks" -alias upload `
  -keyalg RSA -keysize 2048 -validity 10000
```

> Haz **copia de seguridad** del `.jks` y de las contraseñas fuera del repositorio. Si los pierdes no podrás actualizar la app (Play App Signing permite recuperar la clave de subida, pero es un trámite).

### 2. Compilar en local

Copia `android/key.properties.example` como `android/key.properties`, rellénalo con la ruta al `.jks` y tus contraseñas, y compila:

```bash
flutter build appbundle --release
```

El `.aab` queda en `build/app/outputs/bundle/release/`. Es el formato que pide Google Play.

### 3. Compilar en GitHub Actions

En *Settings → Secrets and variables → Actions* crea estos cuatro secretos:

| Secreto | Valor |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | El `.jks` en base64: `[Convert]::ToBase64String([IO.File]::ReadAllBytes("$HOME\upload-keystore.jks"))` |
| `ANDROID_KEYSTORE_PASSWORD` | Contraseña del almacén |
| `ANDROID_KEY_ALIAS` | `upload` (o el alias que hayas usado) |
| `ANDROID_KEY_PASSWORD` | Contraseña de la clave |

Sin los secretos (por ejemplo en un fork) el flujo sigue funcionando y firma con la clave de debug.

### 4. Antes de subir a Play Console

- La política de privacidad tiene que tener una URL pública. La app no recoge datos, pero Play la exige igualmente.
- Rellena el formulario de *Seguridad de los datos* (no se recopilan datos) y la declaración de app de salud.
- Esta app no es un producto sanitario: indícalo en la ficha y mantén el aviso médico.

---

## Idiomas

El castellano es el idioma de origen: todos los textos del código están escritos en castellano y **ese mismo texto sirve de clave** para buscar su traducción.

```dart
Text(t('Lávate bien las manos con agua y jabón.'))     // texto fijo
Text(tf('Hace {n} días', {'n': dias}))                  // con datos variables
```

Las traducciones están en [`lib/l10n/`](lib/l10n/) (`en.dart`, `gl.dart`, `ca.dart`, `eu.dart`). Son un mapa `'texto en castellano': 'traducción'`.

Si cambias un texto en castellano hay que actualizar su clave en los cuatro ficheros. `flutter test test/traducciones_test.dart` avisa de qué falta, qué sobra y de los marcadores `{n}` que no coincidan. Las guías, alarmas y el kit se comprueban desde sus datos; el resto, buscando las llamadas a `t()` y `tf()` en el código.

> Las traducciones son automáticas y **están pendientes de revisión por personas nativas**. El modo sugerencias añade el idioma que se estaba leyendo al reportar un fallo.

---

## Privacidad

La aplicación es **100 % offline**. No tiene cuentas, ni registro, ni analítica, ni servidores: no realiza ninguna conexión de red por sí misma. Todo lo que anotas (tu configuración, tus zonas de inserción, tus ajustes) se guarda únicamente en tu dispositivo y se borra al desinstalar.

Los únicos permisos que pide son notificaciones (solo si activas los recordatorios) y abrir enlaces externos (webs de fabricantes y llamada al 112).

---

## Modo sugerencias (revisores)

Pensado para quienes revisan el contenido: un endocrino, personas de pruebas.
El usuario normal no ve nada de esto.

Se activa en **Configuración → Revisión de contenido → Modo sugerencias**
introduciendo un código. A partir de ahí aparece un botón *"Sugerir un cambio
aquí"* en cada paso de cada guía y en cada ficha de alarma, que abre un
formulario de Google con la ubicación exacta ya rellenada.

### Cómo conectarlo

Ya está conectado. Estos pasos quedan como referencia por si algún día cambias
de formulario; todo se configura en
[`lib/datos/sugerencias.dart`](lib/datos/sugerencias.dart).

1. Crea un formulario de Google con **cuatro** preguntas, en este orden:
   `Nombre` (respuesta corta), `Sugerencia` (párrafo), `Ubicación` (respuesta
   corta) y `Versión` (respuesta corta).
2. En *Configuración* del formulario, deja **desactivado** "Recopilar
   direcciones de correo" y no lo limites a ningún dominio: así se puede
   responder sin cuenta de Google.
3. Copia el enlace del formulario (*Enviar* → icono de enlace) en
   `kFormularioUrl`.
4. Abre `⋮ → Obtener enlace prerrellenado`, escribe cualquier cosa en los
   cuatro campos y pulsa "Obtener enlace". En la URL que te da aparece un
   `entry.NNNNNNNNN=` por cada campo: cópialos a `kCampoNombre`,
   `kCampoSugerencia`, `kCampoUbicacion` y `kCampoVersion`.
5. Cambia `kCodigoModoSugerencias` por el código que quieras.

Mientras falte algún dato, el botón avisa en pantalla en vez de abrir un
enlace roto.

### Recibir las sugerencias por correo

La notificación nativa de Google Forms avisa de que hay respuesta nueva pero no
incluye el contenido. Para recibirlo entero, vincula el formulario a una hoja
de cálculo y añade en *Extensiones → Apps Script*:

```javascript
function alEnviarFormulario(e) {
  const r = e.namedValues;
  let cuerpo = '';
  for (const campo in r) {
    cuerpo += campo + ':
' + r[campo].join(', ') + '

';
  }
  MailApp.sendEmail({
    to: 'TU_CORREO@ejemplo.com',
    subject: 'Sugerencia · ' + (r['Ubicación'] || 'sin ubicación'),
    body: cuerpo,
  });
}
```

Con un activador de tipo *"Al enviarse el formulario"*. El asunto del correo
lleva ya la clave de la guía y el paso, así que se puede filtrar en Gmail.

---

## Tecnologías

- **Lenguaje:** Dart
- **Framework:** Flutter
- **Almacenamiento:** `shared_preferences` (local)
- **Notificaciones:** `flutter_local_notifications` (programadas en el dispositivo)

---

## Desarrollo

```bash
flutter pub get
flutter test
flutter run
```

Para verlo en el navegador sin emulador: `flutter run -d chrome`.

---

## Instalación

Puedes descargar la última versión lista para instalar en tu dispositivo Android pulsando aquí:

[![Descargar APK](https://img.shields.io/badge/Descargar-APK-blue?style=for-the-badge&logo=android)](https://github.com/SamuMartinez94/app-diabetes/releases/latest/download/app-release-latest.apk)
