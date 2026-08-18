> [!WARNING]
> **Proyecto No Oficial:** Esta aplicación es un proyecto personal sin fines de lucro, desarrollado exclusivamente con fines informativos y orientados al usuario. No es una herramienta médica profesional, ni está vinculada, patrocinada o avalada por ninguna de las marcas comerciales de dispositivos médicos mencionadas.

> [!CAUTION]
> **Contenido pendiente de validación clínica.** Todas las guías de recambio y las fichas de alarmas están marcadas como borrador y se muestran en rojo dentro de la app. Están pendientes de revisión por un profesional sanitario.

---

# App Control de bombas Diabetes

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
