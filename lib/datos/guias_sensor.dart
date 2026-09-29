/// GUÍAS DE RECAMBIO DE SENSOR
///
/// Contenido basado en los manuales oficiales del fabricante:
///
///   • Dexcom G6 — Guía de usuario, cap. 6, pp. 84-100 (español).
///   • Dexcom G7 — Guía del usuario, pp. 18-25 (español).
///   • Guardian 4 — Guía del usuario del sensor, pp. 19-30 (español).
///   • Simplera Sync — User Guide, pp. 13-17. En INGLÉS: los pasos están
///     traducidos, no son la cadena literal del manual.
///   • FreeStyle Libre 3 — Guía de inicio rápido, pp. 22-25 (español).
///
/// Los tiempos de calentamiento de Guardian 4 (2 h), Simplera Sync (2 h) y
/// Libre 3 (60 min) se han contrastado con las webs oficiales de Medtronic y
/// Abbott; los prospectos del sensor no los incluyen.
///
/// Estilo de redacción: pensado para una persona que empieza con el sensor.
/// Frases cortas, sin jerga médica y sin dosis de insulina.
library;

import '../modelos/paso.dart';

/// Guías pendientes de validar por un profesional sanitario.
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

const List<Paso> _dexcomG6Base = [
  Paso(
    texto: '''
Mira la fecha de caducidad en la bandeja del sensor. No uses un sensor caducado ni con el envase dañado o abierto.

No abras la bandeja hasta que vayas a ponértelo.''',
  ),
  Paso(
    texto: '''
ELIGE LA ZONA

A partir de 18 años: solo el vientre (abdomen).
De 2 a 17 años: el vientre o la parte de arriba de los glúteos.''',
    imagen: 'assets/images/sdexg6.png',
  ),
  Paso(
    texto: '''
La zona debe estar como mínimo a 8 cm del catéter de la bomba o del punto donde te inyectes.

Evita las costillas y los huesos, la cintura, el recorrido del cinturón del coche y el lado sobre el que duermes. No pongas dos sensores seguidos en el mismo sitio.''',
  ),
  Paso(texto: 'Lávate bien las manos y sécalas.'),
  Paso(
    texto:
        'Limpia la piel con alcohol y espera a que se seque. No debe quedar '
        'nada de crema, perfume ni medicamentos. Si hay vello, aféitalo para '
        'que el adhesivo se pegue bien.',
  ),
  Paso(
    texto: '''
Coge el MISMO aplicador cuyo código pusiste en el dispositivo. Comprueba que el envase no está dañado.

Quita la tapa y mira que el sensor no tiene daños.''',
  ),
  Paso(
    texto: '''
Quita las dos etiquetas adhesivas sin tocar la parte pegajosa.

GUARDA la etiqueta con el código del sensor y no tires la caja hasta que termine la sesión.''',
  ),
  Paso(
    texto: '''
Apoya el aplicador sobre la piel EN HORIZONTAL, no en vertical.

Presiona con fuerza para que el adhesivo se pegue bien.''',
  ),
  Paso(
    texto: '''
Dobla la protección de seguridad, rómpela y tírala.

PRECAUCIÓN: no la quites antes de apoyar el aplicador en la piel. Si la quitas antes, podrías pulsar el botón sin querer y ponerte el sensor donde no toca.''',
  ),
  Paso(texto: 'Pulsa y suelta el botón para insertar el sensor.'),
  Paso(
    texto: '''
Retira el aplicador. En la piel te tienen que quedar el sensor y el soporte del transmisor.

Tira el aplicador como indique la normativa de tu zona para material que ha estado en contacto con sangre.''',
  ),
  Paso(
    texto: '''
ACOPLAR EL TRANSMISOR

Limpia la parte de atrás del transmisor con alcohol y deja que se seque. No toques ni rayes las partes metálicas.''',
  ),
  Paso(
    texto: '''
Desliza la pestaña del transmisor en la ranura del extremo más estrecho del soporte.

Presiona el extremo ancho hasta que haga CLIC.''',
  ),
  Paso(
    texto:
        'Frota con los dedos alrededor del parche tres veces para que se '
        'fije mejor. Si el parche empieza a despegarse, puedes reforzarlo con '
        'un cubreparche o esparadrapo, sin tapar el transmisor ni por encima '
        'ni por debajo.',
  ),
  Paso(
    texto: '''
El transmisor se emparejará solo con el dispositivo donde ves los datos (móvil o receptor). Puede tardar hasta 30 minutos.

Mantenlos a menos de 6 metros y sin paredes ni metal de por medio.''',
  ),
  Paso(
    texto: '''
Cuando confirme el emparejamiento, toca "Iniciar sensor" para comenzar las 2 HORAS de calentamiento.

Durante ese tiempo no hay lecturas ni alertas: usa el medidor de dedo para decidir tu tratamiento.''',
  ),
  Paso(
    texto: '''
Si no pusiste el código del sensor al configurarlo, cuando termine el calentamiento te pedirá calibrar dos veces, y después cada día. (Calibrar es meter el valor de un pinchazo en el dedo.)

Si sí pusiste el código, no necesitas calibrar.''',
  ),
];

// ---------------------------------------------------------------------------
// DEXCOM G7 (manual pp. 18-25)
// ---------------------------------------------------------------------------

const List<Paso> _dexcomG7Base = [
  Paso(
    texto: '''
Cada sensor G7 dura hasta 10 días, más 12 horas de margen al final para que puedas cambiarlo cuando te venga bien.

A diferencia del G6, el sensor y el transmisor son una sola pieza desechable: no hay que guardar nada.''',
  ),
  Paso(
    texto: '''
ELIGE LA ZONA

Brazo o glúteos. No lo pongas en ningún otro sitio: fuera de esas zonas puede no funcionar bien.

Si con el G6 usabas el abdomen, con el G7 tienes que pasar a la parte de atrás de la parte superior del brazo. Los niños de 2 a 6 años también pueden usar la parte de arriba de los glúteos.''',
    imagen: 'assets/images/sdexg7.png',
  ),
  Paso(
    texto: 'Quita el sensor anterior despegando el adhesivo y tíralo entero.',
  ),
  Paso(
    texto:
        'Lávate bien las manos. Limpia la piel con alcohol y espera a que se '
        'seque al aire antes de continuar.',
  ),
  Paso(
    texto:
        'Comprueba que ninguna pieza está dañada o agrietada. Si lo está, no '
        'la uses.',
  ),
  Paso(
    texto: '''
Saca el aplicador del envase y quita el protector del adhesivo.

Apoya el aplicador plano sobre la piel y pulsa el botón para insertar el sensor.''',
  ),
  Paso(
    texto:
        'Retira el aplicador tirando en línea recta y presiona el adhesivo '
        'alrededor del sensor para fijarlo.',
  ),
  Paso(
    texto: '''
Pon el SOBREPARCHE que viene en la caja.

No es opcional: el manual indica que hay que usarlo para que el sensor aguante puesto toda la sesión.''',
  ),
  Paso(
    texto: '''
Empareja el sensor con tu móvil: introduce el código de emparejamiento que viene en el aplicador.''',
  ),
  Paso(
    texto: '''
El periodo de adaptación dura MENOS DE 30 MINUTOS.

Durante ese tiempo no tomes decisiones de tratamiento con el sensor: usa el medidor de dedo. Tampoco las tomes si no ves el número ni la flecha de tendencia.''',
  ),
];

// ---------------------------------------------------------------------------
// MAPA DE GUÍAS
// ---------------------------------------------------------------------------

final List<Paso> _dexcomG6 = [
  ...enFase(Fases.preparacion, _dexcomG6Base.take(1).toList()),
  ...enFase(Fases.zona, _dexcomG6Base.skip(1).take(4).toList()),
  ...enFase(Fases.insercion, _dexcomG6Base.skip(5).take(6).toList()),
  ...enFase(Fases.emparejar, _dexcomG6Base.skip(11).toList()),
];

final List<Paso> _dexcomG7 = [
  ...enFase(Fases.preparacion, _dexcomG7Base.take(1).toList()),
  ...enFase(Fases.zona, _dexcomG7Base.skip(1).take(4).toList()),
  ...enFase(Fases.insercion, _dexcomG7Base.skip(5).take(3).toList()),
  ...enFase(Fases.emparejar, _dexcomG7Base.skip(8).toList()),
];

final Map<String, List<Paso>> instruccionesSensor = {
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
El sensor Guardian 4 se usa como máximo siete días seguidos.

El insertador One-press es el ÚNICO aprobado para este sensor. Con otro insertador la colocación puede salir mal y causar dolor o lesión.''',
    ),
    Paso(
      texto: '''
ZONA DE INSERCIÓN: solo la parte de atrás de la parte superior del brazo, tanto en adultos como a partir de 7 años.

PRECAUCIÓN: no lo uses en el abdomen ni en las nalgas. Ahí funciona distinto y puede darte lecturas que te lleven a error.''',
      imagen: 'assets/images/sguardian.png',
    ),
    Paso(
      texto:
          'No lo pongas sobre músculo, piel dura o cicatrices, ni en zonas '
          'apretadas por la ropa o que se muevan mucho al hacer ejercicio.',
    ),
    Paso(texto: 'Lávate bien las manos con agua y jabón.'),
    Paso(
      texto: '''
Elige una zona con algo de grasa y límpiala con alcohol.

Usa solo alcohol, para que no queden restos en la piel. Deja que se seque al aire.''',
    ),
    Paso(
      texto: '''
Abre el envase, sujeta la peana y saca el conjunto del sensor. Apoya la peana en una superficie plana y limpia.

Comprueba que la tira adhesiva del sensor está metida DEBAJO del conector y de los enganches.''',
    ),
    Paso(
      texto: '''
Pon el pulgar sobre la marca del pulgar para sujetar el insertador. Los dedos no deben tocar los botones.

Presiona el insertador sobre la peana hasta que su base quede plana sobre la mesa y oigas un clic.''',
    ),
    Paso(
      texto: '''
Pon dos dedos sobre la base de la peana y, con la otra mano, tira del insertador hacia arriba.

ADVERTENCIA: nunca apuntes el insertador cargado hacia una parte del cuerpo donde no quieras ponerte el sensor. Un toque accidental dispararía la aguja.''',
    ),
    Paso(
      texto: '''
Coloca el insertador sobre la zona preparada.

Presiona y suelta los DOS botones a la vez. Mantén el insertador apoyado cinco segundos o más para que el adhesivo se pegue.''',
    ),
    Paso(
      texto:
          'Levanta el insertador sin apretar los botones con los dedos '
          'mientras lo retiras.',
    ),
    Paso(
      texto: '''
Sujeta la base del sensor contra la piel por el conector y por el extremo contrario.

Agarra la funda de la aguja por arriba y tira para separarla del sensor.''',
    ),
    Paso(
      texto: '''
Vigila si hay sangrado debajo, alrededor o encima del sensor.

Si sangra, presiona con una gasa estéril hasta tres minutos. Si para, conecta el transmisor. Si NO para, no lo conectes: puede entrar sangre en el conector y estropearlo.''',
    ),
    Paso(
      texto:
          'Despega la lámina del adhesivo sin levantarla mucho de la piel y '
          'sin tirar del sensor. No quites la lámina de la tira rectangular: '
          'esa se usa después para fijar el transmisor.',
    ),
    Paso(
      texto: '''
Conecta el transmisor y espera el calentamiento: son 2 HORAS. En la pantalla verás una cuenta atrás.

Durante ese tiempo no hay lecturas: usa el medidor de dedo para decidir tu tratamiento.''',
    ),
  ],

  // ------------------------- SIMPLERA SYNC -------------------------
  'bmedtronic_ssimplera': [
    Paso(
      texto: '''
El Simplera Sync no se pone igual que otros sensores de Medtronic: su insertador funciona de otra manera.

Lee sus instrucciones antes de usarlo por primera vez.''',
    ),
    Paso(
      texto: '''
ZONA DE INSERCIÓN: la parte de atrás de la parte superior del brazo, a partir de 7 años.

No se recomienda ponerlo en el abdomen ni en los glúteos.''',
      imagen: 'assets/images/ssimplera.png',
    ),
    Paso(
      texto: '''
ANTES DE PONERLO, apunta el número de serie (SN) y el CÓDIGO que vienen en la etiqueta del insertador.

Los necesitarás después para emparejar el sensor con la bomba. También están dentro de la tapa de la caja.''',
    ),
    Paso(
      texto: '''
Mira la fecha de caducidad: no uses un sensor caducado.

Comprueba que la etiqueta del capuchón y la banda de seguridad están intactas. Si falta alguna o está rota, no lo uses.''',
    ),
    Paso(texto: 'Lávate bien las manos con agua y jabón.'),
    Paso(
      texto: '''
Elige una zona con algo de grasa.

Evita el músculo, la piel dura o con cicatrices, las zonas apretadas por la ropa y las que se muevan mucho al hacer ejercicio.''',
    ),
    Paso(texto: 'Limpia la zona con alcohol y deja que se seque al aire.'),
    Paso(
      texto: '''
Desenrosca el capuchón del insertador: al hacerlo se rompe la banda de seguridad.

No vuelvas a poner el capuchón: podrías dañar la aguja y el sensor no se pondría bien.''',
    ),
    Paso(
      texto: '''
Coloca el insertador sobre la zona preparada.

Presiónalo con firmeza contra el cuerpo hasta que oigas un CLIC.''',
    ),
    Paso(texto: 'Separa el insertador del cuerpo tirando en línea recta.'),
    Paso(
      texto:
          'Alisa el adhesivo con un dedo para que el sensor aguante pegado '
          'toda la sesión. Si quieres, puedes reforzarlo con esparadrapo.',
    ),
    Paso(
      texto: '''
Vigila si hay sangrado sobre el sensor. Si lo hay, presiona con una gasa estéril hasta tres minutos.

Si sigue sangrando o hay mucho dolor, quítalo y ponte uno nuevo en otro sitio.''',
    ),
    Paso(
      texto: '''
Empareja el sensor con la bomba usando el SN y el CÓDIGO que apuntaste al principio.

No compartas el CÓDIGO con nadie y haz el emparejamiento en un sitio privado.''',
    ),
    Paso(
      texto: '''
Espera el calentamiento: son 2 HORAS hasta las primeras lecturas.

Mientras tanto, usa el medidor de dedo para decidir tu tratamiento.''',
    ),
  ],

  // ------------------------- FREESTYLE LIBRE 3 -------------------------
  'bypsopump_sfreelibre3': [
    Paso(
      texto: '''
ZONA DE INSERCIÓN: solo la parte posterior del brazo.

No uses otros sitios: pueden dar lecturas de glucosa poco exactas.''',
      imagen: 'assets/images/sfreelibre3.png',
    ),
    Paso(
      texto:
          'Evita cicatrices, lunares, estrías, bultos y sitios donde te '
          'inyectes insulina. Cambia de sitio en cada sensor para no irritar '
          'la piel.',
    ),
    Paso(
      texto: '''
Lava la zona con jabón normal y sécala.

Después límpiala con una toallita de alcohol y deja que se seque al aire antes de continuar.''',
    ),
    Paso(
      texto: '''
Desenrosca el tapón del aplicador.

PRECAUCIÓN: no vuelvas a ponerlo, podrías dañar el sensor. Y no toques el interior del aplicador: tiene una aguja.''',
    ),
    Paso(
      texto: '''
No lo uses si el kit o el aplicador parecen dañados, o si la etiqueta indica que ya se había abierto.''',
    ),
    Paso(
      texto: '''
Coloca el aplicador sobre la zona preparada y empuja hacia abajo con firmeza.

PRECAUCIÓN: no presiones el aplicador hasta tenerlo colocado sobre el sitio: podrías hacerte daño.''',
    ),
    Paso(
      texto: '''
Retira suavemente el aplicador del cuerpo y comprueba que el sensor ha quedado firme.

Vuelve a poner el tapón al aplicador usado y tíralo como indique la normativa de tu zona.''',
    ),
    Paso(
      texto: '''
Comprueba que el móvil tiene conexión (wifi o datos) e inicia el sensor desde la aplicación, siguiendo las indicaciones de la pantalla.''',
    ),
    Paso(
      texto: '''
Espera el calentamiento: son 60 MINUTOS hasta la primera lectura.

Mientras tanto, usa el medidor de dedo para decidir tu tratamiento.''',
    ),
  ],
};
