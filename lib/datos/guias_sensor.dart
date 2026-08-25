/// GUÍAS DE RECAMBIO DE SENSOR
///
/// Contenido volcado de los manuales oficiales del fabricante:
///
///   • Dexcom G6 — Guía de usuario, cap. 6, pp. 84-100 (español).
///   • Dexcom G7 — Guía del usuario, pp. 18-25 (español).
///   • Guardian 4 — Guía del usuario del sensor, pp. 19-30 (español).
///   • Simplera Sync — User Guide, pp. 13-17. En INGLÉS: los pasos están
///     traducidos, no son la cadena literal del manual.
///   • FreeStyle Libre 3 — Guía de inicio rápido, pp. 22-25 (español).
///
/// PENDIENTE DE FUENTE: los manuales de Guardian 4, Simplera Sync y Libre 3
/// disponibles son prospectos del sensor y NO indican el tiempo de
/// calentamiento. Los tiempos que aparecen aquí para esos tres vienen del
/// contenido anterior de la app, no de estos manuales: hay que confirmarlos
/// con la guía del sistema correspondiente.
library;

import '../modelos/paso.dart';

/// TODAS las guías están pendientes de validar por un profesional sanitario.
/// Se muestran en rojo y con aviso de borrador.
/// Cuando un endocrino valide una, borra su clave de este conjunto.
const Set<String> guiasSensorPorRevisar = {
  'bmedtronic_sguardian',
  'bmedtronic_ssimplera',
  'btandem_sdexg6',
  'btandem_sdexg7',
  'bomnipod_sdexg6',
  'bomnipod_sdexg7',
  'bypsopump_sdexg6',
  'bypsopump_sfreelibre3',
};

// ---------------------------------------------------------------------------
// DEXCOM G6 (manual cap. 6)
// ---------------------------------------------------------------------------

const List<Paso> _dexcomG6 = [
  Paso(
    texto: '''
Comprueba la fecha de caducidad en la bandeja del sensor. No uses un sensor caducado ni con el envase estéril dañado o abierto.

No abras la bandeja hasta que vayas a insertarlo.''',
  ),
  Paso(
    texto: '''
ELIGE LA ZONA

A partir de 18 años: solo el vientre (abdomen).
Entre 2 y 17 años: abdomen o el cuadrante superior de los glúteos.''',
    imagen: 'assets/images/sdexg6.png',
  ),
  Paso(
    texto: '''
La zona debe estar a un mínimo de 8 cm del equipo de infusión de la bomba o del punto de inyección.

Evita costillas y zonas de hueso, la cinturilla, el recorrido del cinturón de seguridad y el lado sobre el que duermes. No pongas dos sensores seguidos en el mismo sitio.''',
  ),
  Paso(texto: 'Lávate bien las manos y sécalas.'),
  Paso(
    texto:
        'Limpia el punto de inserción con alcohol y deja que se seque. La '
        'zona debe quedar sin restos de lociones, perfumes ni medicamentos. '
        'Aféitala si hace falta para que el adhesivo agarre.',
  ),
  Paso(
    texto: '''
Coge el MISMO aplicador cuyo código introdujiste en el dispositivo. Revisa que el envase no esté dañado.

Desprende la tapa y comprueba que el sensor no presenta daños.''',
  ),
  Paso(
    texto: '''
Retira las dos etiquetas adhesivas sin tocar el adhesivo.

CONSERVA la etiqueta con el código del sensor y guarda la caja hasta que termine la sesión.''',
  ),
  Paso(
    texto: '''
Apoya el aplicador sobre la piel EN HORIZONTAL, no en vertical.

Presiona con fuerza para pegar bien el adhesivo.''',
  ),
  Paso(
    texto: '''
Dobla la protección de seguridad, rómpela y deséchala.

PRECAUCIÓN: no la quites antes de apoyar el aplicador en la piel. Si la quitas antes, podrías pulsar el botón sin querer e insertar el sensor donde no toca.''',
  ),
  Paso(texto: 'Pulsa y suelta el botón para insertar el sensor.'),
  Paso(
    texto: '''
Retira el aplicador. Deben quedarte en la piel el cable del sensor y el soporte del transmisor.

Desecha el aplicador según la normativa local para material que ha estado en contacto con sangre.''',
  ),
  Paso(
    texto: '''
ACOPLAR EL TRANSMISOR

Limpia la parte posterior del transmisor con alcohol y deja que se seque. No toques ni arañes las partes metálicas.''',
  ),
  Paso(
    texto: '''
Desliza la pestaña del transmisor en la ranura del extremo más estrecho del soporte.

Presiona el extremo ancho hasta que haga CLIC.''',
  ),
  Paso(
    texto:
        'Frota con los dedos alrededor del parche tres veces para fijarlo '
        'mejor. Si el parche empieza a despegarse, puedes reforzarlo con un '
        'cubreparche o esparadrapo, sin taparlo por encima ni por debajo del '
        'transmisor.',
  ),
  Paso(
    texto: '''
El transmisor se emparejará solo con el dispositivo de visualización. Puede tardar hasta 30 minutos.

Manténlos a menos de 6 metros y sin paredes ni metal de por medio.''',
  ),
  Paso(
    texto: '''
Cuando confirme el emparejamiento, toca "Iniciar sensor" para comenzar las 2 HORAS de calentamiento.

Durante ese tiempo no habrá lecturas ni alertas: usa el medidor capilar para decidir tu tratamiento.''',
  ),
  Paso(
    texto: '''
Si no introdujiste el código del sensor durante la configuración, al terminar el calentamiento se te pedirá calibrar dos veces, y después cada día.

Si sí lo introdujiste, no necesitas calibrar.''',
  ),
];

// ---------------------------------------------------------------------------
// DEXCOM G7 (manual pp. 18-25)
// ---------------------------------------------------------------------------

const List<Paso> _dexcomG7 = [
  Paso(
    texto: '''
Cada sesión del G7 dura hasta 10 días, con un periodo de gracia de 12 horas al final para que puedas cambiarlo cuando te venga bien.

A diferencia del G6, el sensor y el transmisor son una sola pieza desechable: no se guarda nada.''',
  ),
  Paso(
    texto: '''
ELIGE LA ZONA

Brazo o glúteos. No lo uses en ningún otro sitio: fuera de esas zonas puede no funcionar como está previsto.

Si con el G6 usabas el abdomen, con el G7 debes pasar a la parte posterior de la parte superior del brazo. Los niños de 2 a 6 años también pueden usar la parte superior de los glúteos.''',
    imagen: 'assets/images/sdexg7.png',
  ),
  Paso(
    texto:
        'Retira el sensor anterior despegando el adhesivo y deséchalo entero.',
  ),
  Paso(
    texto:
        'Lávate bien las manos. Limpia la zona con alcohol y deja que se '
        'seque al aire antes de continuar.',
  ),
  Paso(
    texto:
        'Comprueba que ningún componente esté dañado o agrietado. Si lo está, '
        'no lo uses.',
  ),
  Paso(
    texto: '''
Retira el aplicador del envase y quita el protector del adhesivo.

Apoya el aplicador plano sobre la piel y presiona el botón para insertar el sensor.''',
  ),
  Paso(
    texto:
        'Retira el aplicador tirando en línea recta y presiona el adhesivo '
        'alrededor del sensor para fijarlo.',
  ),
  Paso(
    texto: '''
Coloca el SOBREPARCHE que viene en la caja.

No es opcional: el manual indica que debes usarlo para mantener el sensor en el cuerpo durante toda la sesión.''',
  ),
  Paso(
    texto: '''
Empareja el sensor introduciendo el código de emparejamiento y el número de serie que vienen en el aplicador.''',
  ),
  Paso(
    texto: '''
El periodo de adaptación dura MENOS DE 30 MINUTOS.

Durante ese tiempo no tomes decisiones de tratamiento con el sensor: usa el medidor capilar. Tampoco las tomes si no ves número ni flecha de tendencia.''',
  ),
];

// ---------------------------------------------------------------------------
// MAPA DE GUÍAS
// ---------------------------------------------------------------------------

const Map<String, List<Paso>> instruccionesSensor = {
  // ------------------------- DEXCOM G6 -------------------------
  'bypsopump_sdexg6': _dexcomG6,
  'bomnipod_sdexg6': _dexcomG6,
  'btandem_sdexg6': _dexcomG6,

  // ------------------------- DEXCOM G7 -------------------------
  'btandem_sdexg7': _dexcomG7,
  'bomnipod_sdexg7': _dexcomG7,

  // ------------------------- GUARDIAN 4 -------------------------
  'bmedtronic_sguardian': [
    Paso(
      texto: '''
El sensor Guardian 4 se usa durante un máximo de siete días seguidos.

El dispositivo de inserción One-press es el ÚNICO aprobado para este sensor. Con otro insertador la inserción puede salir mal y causar dolor o lesión.''',
    ),
    Paso(
      texto: '''
ZONA DE INSERCIÓN: solo la parte de atrás de la parte superior del brazo, tanto en adultos como a partir de 7 años.

PRECAUCIÓN: no lo uses en el abdomen ni en las nalgas. Ahí funciona distinto y puede provocarte una hipoglucemia o una hiperglucemia.''',
      imagen: 'assets/images/sguardian.png',
    ),
    Paso(
      texto:
          'No lo insertes en músculo, piel dura o tejido cicatricial, ni en '
          'zonas apretadas por la ropa o sometidas a mucho movimiento al '
          'hacer ejercicio.',
    ),
    Paso(texto: 'Lávate bien las manos con agua y jabón.'),
    Paso(
      texto: '''
Elige una zona con suficiente grasa subcutánea y límpiala con alcohol.

Usa solo alcohol: así no quedan residuos en la piel. Deja que se seque al aire.''',
    ),
    Paso(
      texto: '''
Abre el envase, sujeta la peana y saca el conjunto de sensor. Apoya la peana en una superficie plana y limpia.

Comprueba que la tira adhesiva del sensor esté metida DEBAJO del conector y de los enganches.''',
    ),
    Paso(
      texto: '''
Coloca el pulgar sobre la marca para el pulgar para sujetar el insertador. Los dedos no deben tocar los botones.

Presiona el insertador sobre la peana hasta que su base quede plana sobre la mesa y oigas un clic.''',
    ),
    Paso(
      texto: '''
Pon dos dedos sobre la base de la peana y, con la otra mano, tira del insertador hacia arriba.

ADVERTENCIA: nunca dirijas el insertador cargado hacia una parte del cuerpo donde no quieras insertar. Una pulsación accidental dispararía la aguja.''',
    ),
    Paso(
      texto: '''
Coloca el insertador sobre la zona preparada.

Presiona y suelta los DOS botones a la vez. Mantén el insertador apoyado cinco segundos o más para que el adhesivo se pegue.''',
    ),
    Paso(
      texto:
          'Levanta el insertador sin presionar los botones con los dedos '
          'mientras lo retiras.',
    ),
    Paso(
      texto: '''
Sujeta la base del sensor contra la piel por el conector y por el extremo opuesto.

Agarra la funda de la aguja por arriba y tira para separarla del sensor.''',
    ),
    Paso(
      texto: '''
Vigila si hay sangrado debajo, alrededor o encima del sensor.

Si sangra, presiona con una gasa estéril hasta tres minutos. Si se detiene, conecta el transmisor. Si NO se detiene, no lo conectes: puede entrar sangre en el conector y dañarlo.''',
    ),
    Paso(
      texto:
          'Retira la lámina del adhesivo tirando de ella sin levantarla mucho '
          'de la piel y sin tirar del sensor. No retires la lámina de la tira '
          'rectangular: esa se usa después para fijar el transmisor.',
    ),
    Paso(
      texto: '''
Conecta el transmisor y espera el periodo de calentamiento.

PENDIENTE DE CONFIRMAR: el prospecto del sensor no indica el tiempo de calentamiento. Consúltalo en la guía del sistema de tu bomba.''',
    ),
  ],

  // ------------------------- SIMPLERA SYNC -------------------------
  'bmedtronic_ssimplera': [
    Paso(
      texto: '''
El Simplera Sync no se inserta igual que otros sensores de Medtronic: su insertador funciona de forma distinta.

Lee sus instrucciones antes de usarlo por primera vez.''',
    ),
    Paso(
      texto: '''
ZONA DE INSERCIÓN: la parte posterior de la parte superior del brazo, a partir de 7 años.

No se recomienda insertarlo en el abdomen ni en los glúteos.''',
      imagen: 'assets/images/ssimplera.png',
    ),
    Paso(
      texto: '''
ANTES DE INSERTAR, anota el número de serie (SN) y el CÓDIGO que vienen en la etiqueta del insertador.

Los vas a necesitar después para emparejar el sensor con la bomba. También están en el interior de la tapa de la caja.''',
    ),
    Paso(
      texto: '''
Comprueba la fecha de caducidad: no uses un sensor caducado.

Revisa que la etiqueta del capuchón y la banda de seguridad estén intactas. Si falta alguna o está rota, no lo uses.''',
    ),
    Paso(texto: 'Lávate bien las manos con agua y jabón.'),
    Paso(
      texto: '''
Elige una zona con suficiente grasa.

Evita músculo, piel dura o cicatrices, zonas apretadas por la ropa y zonas con mucho movimiento al hacer ejercicio.''',
    ),
    Paso(
      texto: 'Limpia la zona con alcohol y deja que se seque al aire.',
    ),
    Paso(
      texto: '''
Desenrosca el capuchón del insertador: al hacerlo se rompe la banda de seguridad.

No vuelvas a colocar el capuchón: podrías dañar la aguja e impedir una inserción correcta.''',
    ),
    Paso(
      texto: '''
Coloca el insertador sobre la zona preparada.

Presiónalo con firmeza contra el cuerpo hasta que oigas un CLIC.''',
    ),
    Paso(
      texto: 'Separa el insertador del cuerpo tirando en línea recta.',
    ),
    Paso(
      texto:
          'Alisa el adhesivo con un dedo para que el sensor aguante pegado '
          'toda la sesión. Si quieres, puedes reforzarlo con esparadrapo.',
    ),
    Paso(
      texto: '''
Vigila si hay sangrado sobre el sensor. Si lo hay, presiona con una gasa estéril hasta tres minutos.

Si el sangrado continúa o hay dolor excesivo, retíralo y coloca uno nuevo en otro sitio.''',
    ),
    Paso(
      texto: '''
Empareja el sensor con la bomba usando el SN y el CÓDIGO que anotaste al principio.

No compartas el CÓDIGO con nadie y haz el emparejamiento en un sitio privado.''',
    ),
    Paso(
      texto: '''
Espera el periodo de calentamiento hasta las primeras lecturas.

PENDIENTE DE CONFIRMAR: el manual del sensor no indica ese tiempo. Consúltalo en la guía del sistema de tu bomba.''',
    ),
  ],

  // ------------------------- FREESTYLE LIBRE 3 -------------------------
  'bypsopump_sfreelibre3': [
    Paso(
      texto: '''
ZONA DE INSERCIÓN: la parte posterior del brazo, únicamente.

No uses otros sitios: pueden dar lecturas de glucosa inexactas.''',
      imagen: 'assets/images/sfreelibre3.png',
    ),
    Paso(
      texto:
          'Evita cicatrices, lunares, estrías, bultos y puntos de inyección '
          'de insulina. Cambia de sitio entre aplicaciones para no irritar la '
          'piel.',
    ),
    Paso(
      texto: '''
Lava la zona con jabón corriente y sécala.

Después límpiala con una toallita de alcohol y deja que se seque al aire antes de continuar.''',
    ),
    Paso(
      texto: '''
Desenrosca el tapón del aplicador.

PRECAUCIÓN: no vuelvas a ponerlo, podrías dañar el sensor. Y no toques el interior del aplicador: contiene una aguja.''',
    ),
    Paso(
      texto: '''
No lo uses si el kit o el aplicador parecen dañados, o si la etiqueta de manipulación indica que ya se había abierto.''',
    ),
    Paso(
      texto: '''
Coloca el aplicador sobre la zona preparada y empuja hacia abajo con firmeza.

PRECAUCIÓN: no presiones el aplicador hasta tenerlo colocado sobre el sitio: podrías lesionarte.''',
    ),
    Paso(
      texto: '''
Retira suavemente el aplicador del cuerpo y comprueba que el sensor haya quedado firme.

Vuelve a poner el tapón en el aplicador usado y deséchalo según la normativa local.''',
    ),
    Paso(
      texto: '''
Comprueba que el teléfono tenga conexión (wifi o datos) y arranca el sensor desde la aplicación, siguiendo el asistente en pantalla.''',
    ),
    Paso(
      texto: '''
Espera el periodo de calentamiento hasta la primera lectura.

PENDIENTE DE CONFIRMAR: la guía de inicio rápido disponible no indica ese tiempo. Consúltalo en el manual del usuario de la aplicación.''',
    ),
  ],
};
