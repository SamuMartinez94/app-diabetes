/// GUÍAS DE RECAMBIO DE CATÉTER / EQUIPO DE INFUSIÓN
///
/// Contenido basado en los manuales oficiales del fabricante:
///
///   • Medtronic MiniMed 780G — System User Guide, pp. 110-125.
///     ATENCIÓN: ese manual está en INGLÉS. Los nombres de menú en español
///     son una traducción, no la cadena literal que muestra la bomba. Hay
///     que contrastarlos con el dispositivo.
///   • Tandem t:slim X2 — Guía del usuario, cap. 6, pp. 96-105 (español).
///   • Omnipod 5 — Guía del usuario, pp. 24-29 (español).
///   • mylife YpsoPump — Guía del usuario, cap. 5, pp. 96-113 (español).
///
/// Estilo de redacción: pensado para una persona que empieza con la bomba.
/// Frases cortas, sin jerga médica y SIN cantidades de insulina: la app no
/// indica ni calcula dosis ni volúmenes. Donde el manual da un número de
/// insulina, aquí se remite a las instrucciones del catéter o al equipo médico.
///
/// Los manuales de bomba describen el lado de la BOMBA (reservorio, cebado,
/// llenado de cánula). Los pasos de inserción propios de cada catéter vienen
/// en las instrucciones de uso de ese catéter, que no están entre los
/// manuales disponibles: siguen pendientes de contrastar.
library;

import '../modelos/paso.dart';

/// Guías pendientes de validar por un profesional sanitario.
/// Cuando un endocrino valide una, borra su clave de este conjunto.
const Set<String> guiasCateterPorRevisar = {
  'bmedtronic_cextended',
  'bmedtronic_cmio',
  'bmedtronic_cmio30',
  'bmedtronic_cquickset',
  'bmedtronic_csilhouette',
  'bmedtronic_csuret',
  'bomnipod_cpod',
  'bypsopump_corbit',
  'bypsopump_cinset',
  'btandem_cautosoft90',
  'btandem_cautosoft30',
  'btandem_ctrusteel',
};

// ---------------------------------------------------------------------------
// MEDTRONIC — bloques comunes de reservorio (manual pp. 110-124)
// ---------------------------------------------------------------------------

const List<Paso> _medtronicPreparacion = [
  Paso(
    texto:
        'Saca la insulina de la nevera un rato antes: tiene que estar a '
        'temperatura ambiente. Si está fría, se forman burbujas de aire y '
        'recibirás menos insulina de la que crees.',
  ),
  Paso(texto: 'Lávate bien las manos con agua y jabón.'),
  Paso(
    texto: '''
En la bomba, entra en el menú y elige "Nuevo reservorio y equipo".

Necesitas: un reservorio, un catéter nuevo y el vial de la insulina rápida que uses.''',
  ),
  Paso(
    texto:
        'Quita el catéter usado: despega el adhesivo y sepáralo del cuerpo. '
        'Después confirma en la bomba para continuar.',
  ),
  Paso(
    texto: '''
Saca de la bomba el reservorio usado y elige "Rebobinar".

ADVERTENCIA: antes de rebobinar, el catéter tiene que estar SIN conectar al cuerpo. Si no, podrías recibir insulina sin querer.''',
  ),
];

const List<Paso> _medtronicLlenado = [
  Paso(
    texto: '''
Saca el reservorio del envase y tira del émbolo (la varilla de dentro) hasta la cantidad de insulina que vayas a cargar.

Limpia el tapón del vial con alcohol, apoya el vial sobre una superficie firme y presiona el transfer (la pieza de plástico) sobre él.''',
  ),
  Paso(
    texto: '''
Empuja el émbolo y mantenlo apretado.

Sin soltar el pulgar, dale la vuelta al conjunto para que el vial quede arriba. Suelta y tira del émbolo para llenar el reservorio.''',
  ),
  Paso(
    texto: '''
Da golpecitos suaves al reservorio para que las burbujas suban.

Empuja el émbolo para devolver el aire al vial y vuelve a tirar hasta la cantidad que necesitas.''',
  ),
  Paso(
    texto: '''
Vuelve a girar el conjunto para que el reservorio quede arriba: así evitas que caiga insulina en su parte superior.

Sujeta el transfer y gira el reservorio en sentido antihorario (al revés de las agujas del reloj) para separarlo.''',
  ),
  Paso(
    texto:
        'ADVERTENCIA: no uses el reservorio ni el catéter si ha caído '
        'insulina o cualquier líquido en la parte superior del reservorio o '
        'dentro del conector del tubo. Podría bloquear los respiraderos y '
        'alterar la insulina que recibes. Empieza de nuevo con material nuevo.',
  ),
  Paso(
    texto:
        'Conecta el conector del tubo al reservorio: empuja con suavidad y '
        'gira en sentido horario (como las agujas del reloj) hasta que quede '
        'bloqueado.',
  ),
  Paso(
    texto: '''
Da golpecitos al reservorio para que suban las burbujas y empuja un poco el émbolo para pasarlas al tubo.

Después gira el émbolo en sentido antihorario para aflojarlo y quítalo.''',
  ),
];

const List<Paso> _medtronicCarga = [
  Paso(
    texto: '''
Mete el reservorio en la bomba y gíralo en sentido horario hasta que quede bloqueado. Continúa.

El catéter NO debe estar conectado al cuerpo.''',
  ),
  Paso(
    texto:
        'Elige "Colocar" y mantén pulsado hasta que aparezca la marca de '
        'verificación en pantalla. Después continúa.',
  ),
  Paso(
    texto: '''
Elige "Llenar" y mantén pulsado hasta que no queden burbujas en el tubo y salgan gotas por el extremo. (Este paso se llama cebar: es llenar el tubo de insulina.)

ADVERTENCIA: mira siempre el tubo. Si quedan burbujas, sigue llenando.''',
  ),
];

const List<Paso> _medtronicCierre = [
  Paso(
    texto: '''
Elige "Llenar cánula" y pon la cantidad que indica la caja de tu catéter. (La cánula es el tubito flexible que queda bajo la piel.)

ADVERTENCIA: no dejes la bomba parada en la pantalla de llenar cánula. Mientras esté ahí, no te da insulina.''',
  ),
  Paso(
    texto:
        'Entre 1 y 3 horas después del cambio, mide tu glucosa con el medidor '
        '(pinchazo en el dedo). Así compruebas que el catéter nuevo funciona '
        'bien.',
  ),
];

const List<Paso> _medtronicCierreAcero = [
  Paso(
    texto: '''
Este catéter lleva aguja de acero, así que NO se llena la cánula.

Cuando la bomba lo pregunte, elige "Omitir llenado de cánula" o "Hecho".''',
  ),
  Paso(
    texto:
        'Entre 1 y 3 horas después del cambio, mide tu glucosa con el medidor '
        '(pinchazo en el dedo).',
  ),
];

/// Une los bloques comunes de Medtronic con los pasos propios del catéter.
List<Paso> _medtronic(List<Paso> insercion, {bool llenarCanula = true}) => [
  ...enFase(Fases.preparacion, _medtronicPreparacion),
  ...enFase(Fases.reservorio, _medtronicLlenado),
  ...enFase(Fases.cebado, _medtronicCarga),
  ...enFase(Fases.insercion, insercion),
  ...enFase(
    Fases.cierre,
    llenarCanula ? _medtronicCierre : _medtronicCierreAcero,
  ),
];

/// Cambio de solo reservorio: el manual indica que en ese caso NO se llena
/// cánula, se elige "Hecho" en esa pantalla (p. 122).
final List<Paso> _medtronicSoloReservorio = [
  ...enFase(Fases.preparacion, _medtronicPreparacion),
  ...enFase(Fases.reservorio, _medtronicLlenado),
  ...enFase(Fases.cebado, _medtronicCarga),
  ...enFase(Fases.cierre, const [
    Paso(
      texto: '''
Vuelve a conectarte el catéter, que no has cambiado.

Como es un cambio de solo reservorio, NO hay que llenar cánula: elige "Hecho" en esa pantalla.''',
    ),
    Paso(
      texto:
          'Entre 1 y 3 horas después del cambio, mide tu glucosa con el '
          'medidor (pinchazo en el dedo).',
    ),
  ]),
];

// ---------------------------------------------------------------------------
// TANDEM — bloques comunes de cartucho (manual cap. 6)
// ---------------------------------------------------------------------------

const List<Paso> _tandemComun = [
  Paso(texto: 'Lávate bien las manos con agua y jabón.'),
  Paso(
    texto: '''
Prepara el material: un cartucho nuevo sin abrir, la jeringa de llenado con su aguja (viene con el cartucho), el vial de insulina, toallitas de alcohol y un catéter nuevo.

El cartucho se cambia cada 2 o 3 días, según te haya indicado tu equipo médico.''',
  ),
  Paso(
    texto: '''
Decide con tu equipo médico cuánta insulina cargar en el cartucho.

Ten en cuenta que al llenar el tubo se gasta un poco de insulina, así que no toda la que cargues quedará disponible.''',
  ),
  Paso(
    texto: '''
Limpia el tapón del vial con alcohol. Enrosca la aguja en la jeringa y quita el capuchón.

Tira del émbolo para llenar la jeringa de AIRE, hasta la marca de la cantidad de insulina que vayas a cargar.''',
  ),
  Paso(
    texto: '''
Con el vial en vertical, clava la aguja y mete el aire en el vial. Sigue apretando el émbolo.

Da la vuelta al conjunto y suelta el émbolo: la insulina pasará a la jeringa. Tira despacio hasta la cantidad que necesitas.''',
  ),
  Paso(
    texto: '''
Con la aguja aún en el vial y boca abajo, da golpecitos a la jeringa para que las burbujas suban y empuja despacio para devolverlas al vial.

Repite hasta que no quede ninguna burbuja y saca la aguja.''',
  ),
  Paso(
    texto: '''
Sujeta el cartucho en vertical y mete la aguja poco a poco en el puerto blanco de llenado. No la fuerces hasta el fondo.

Tira del émbolo hasta el tope para sacar el aire que hay en el cartucho y suéltalo.''',
  ),
  Paso(
    texto: '''
Saca la aguja del puerto. Pon la jeringa en vertical, da golpecitos y aprieta con suavidad hasta ver una gota de insulina en la punta.

Vuelve a meterla en el puerto y llena el cartucho poco a poco. Es normal notar algo de resistencia.''',
  ),
  Paso(
    texto: '''
Mantén el émbolo apretado mientras sacas la aguja del cartucho.

Comprueba que no gotea. Si pierde insulina, tira ese cartucho y empieza de nuevo con uno nuevo.''',
  ),
  Paso(
    texto: '''
En la bomba: OPCIONES → Cargar → Cambiar cartucho.

Saldrá un aviso de que la bomba dejará de dar insulina. Confirma para continuar.''',
  ),
  Paso(
    texto:
        'Desconecta el catéter de tu cuerpo y confirma. Saca el cartucho '
        'usado; si cuesta, ayúdate con la herramienta de extracción o con el '
        'borde de una moneda en la ranura de abajo.',
  ),
  Paso(
    texto: '''
Coloca la parte de abajo del cartucho nuevo en el extremo de la bomba, alineado con los carriles guía.

Empuja hacia dentro el puerto de llenado redondo y pulsa DESBLOQUEAR.''',
  ),
  Paso(
    texto: '''
Conecta el tubo al conector del cartucho. Gira en sentido horario hasta apretar con la mano y da UN CUARTO DE VUELTA EXTRA.

ADVERTENCIA: sin ese cuarto de vuelta, la conexión puede quedar floja y perder insulina.''',
  ),
  Paso(
    texto: '''
ADVERTENCIA: nunca llenes el tubo con el catéter conectado al cuerpo.

Sujeta la bomba en vertical y pulsa INICIO. Vibrará o pitará mientras se llena el tubo (a esto se le llama cebar).''',
  ),
  Paso(
    texto: '''
Pulsa DETENER cuando veas 3 gotas de insulina en el extremo del tubo, y después LISTO.

Si no ves las gotas, pulsa LLENAR y repite.''',
  ),
];

/// Los 9 primeros pasos son preparar y llenar el cartucho; el resto, cargarlo
/// en la bomba y llenar el tubo.
final List<Paso> _tandemConFases = [
  ...enFase(Fases.preparacion, _tandemComun.take(9).toList()),
  ...enFase(Fases.cebado, _tandemComun.skip(9).toList()),
];

/// Cambio de solo cartucho: se salta la inserción del catéter y el llenado de
/// cánula. El manual permite cambiarlos por separado.
final List<Paso> _tandemSoloCartucho = [
  ..._tandemConFases,
  ...enFase(Fases.cierre, const [
    Paso(
      texto: '''
Vuelve a conectar el catéter, que no has cambiado.

Como no has puesto un catéter nuevo, no hace falta llenar la cánula.''',
    ),
    Paso(
      texto:
          'Reanuda la insulina en la bomba y, entre 1 y 3 horas después, mide '
          'tu glucosa con el medidor.',
    ),
  ]),
];

const List<Paso> _tandemCierre = [
  Paso(
    texto: '''
Pulsa "Llenar la cánula" y después "Editar cantidad de llenado".

Elige la cantidad que indiquen las instrucciones de tu catéter y pulsa INICIO.''',
  ),
  Paso(
    texto: '''
Si lo usas, configura el Recordatorio del sitio para que la bomba te avise del próximo cambio.

Después reanuda la insulina.''',
  ),
  Paso(
    texto:
        'La bomba te recordará medir la glucosa entre 1 y 2 horas después. '
        'Hazlo: es la forma de comprobar que el catéter nuevo está '
        'funcionando bien.',
  ),
];

const List<Paso> _tandemCierreAcero = [
  Paso(
    texto: '''
El TruSteel lleva aguja de acero: no tiene cánula, así que se salta el llenado de cánula.

Cuando la bomba lo ofrezca, márcalo como hecho y reanuda la insulina.''',
  ),
  Paso(
    texto:
        'Entre 1 y 2 horas después del cambio, mide tu glucosa para confirmar '
        'que el catéter funciona bien.',
  ),
];

// ---------------------------------------------------------------------------
// MAPA DE GUÍAS
// ---------------------------------------------------------------------------

final Map<String, List<Paso>> instruccionesCateter = {
  // ------------------------- MEDTRONIC -------------------------
  'bmedtronic_cextended': _medtronic(const [
    Paso(
      texto: '''
Elige una zona de inserción (abdomen, muslo, nalgas o brazo) y límpiala con alcohol o con el antiséptico que te haya indicado tu equipo médico.

Coloca el catéter Extended siguiendo las instrucciones de su envase.''',
    ),
    Paso(
      texto:
          'PRECAUCIÓN: no uses siempre la misma zona. Ve cambiando de sitio '
          'para que la piel tenga tiempo de recuperarse.',
    ),
  ]),

  'bmedtronic_cmio': _medtronic(const [
    Paso(
      texto: '''
PREPARAR EL DISPOSITIVO
Coloca el Mio dentro de su insertador (la pieza que lo pone) y presiona hacia abajo hasta que encaje.''',
    ),
    Paso(
      texto:
          'Quita el papel protector del adhesivo y el protector de plástico '
          'de la aguja.',
    ),
    Paso(
      texto: '''
TENSAR Y COLOCAR
Tira del mango del insertador hacia atrás hasta oír un clic.

Apóyalo sobre la zona ya limpia y presiona los botones laterales.''',
    ),
    Paso(
      texto: '''
Retira el insertador con cuidado.

Presiona el adhesivo con el dedo para que quede bien pegado a la piel.''',
    ),
  ]),

  'bmedtronic_cmio30': _medtronic(const [
    Paso(
      texto: '''
PREPARAR EL MIO 30
Quita el papel del adhesivo y, con cuidado, el protector de la aguja.''',
    ),
    Paso(
      texto: '''
TENSAR EL DISPOSITIVO
Sujeta las protuberancias de los lados y tira hacia atrás hasta oír un CLIC.

La aguja queda al descubierto, inclinada.''',
    ),
    Paso(
      texto: '''
INSERCIÓN INCLINADA
Apoya el dispositivo plano sobre la piel: la inclinación de 30 grados ya viene incorporada.

Presiona los botones laterales para insertar.''',
    ),
    Paso(
      texto:
          'Presiona el centro del insertador para fijar el adhesivo y retira '
          'el envase de plástico hacia atrás, siguiendo la línea de la aguja.',
    ),
  ]),

  'bmedtronic_cquickset': _medtronic(const [
    Paso(
      texto: '''
PREPARAR EL DISPOSITIVO
Coloca el Quick-set dentro del insertador azul (Quick-serter) y presiona hacia abajo hasta que encaje.''',
    ),
    Paso(
      texto:
          'Quita el papel protector del adhesivo y el protector de plástico '
          'de la aguja.',
    ),
    Paso(
      texto: '''
TENSAR Y COLOCAR
Tira del mango verde del insertador hacia atrás hasta oír un clic.

Apóyalo en la zona de inserción y presiona los botones laterales.''',
    ),
    Paso(
      texto:
          'Retira con cuidado el insertador azul y presiona el adhesivo con '
          'el dedo para que quede bien pegado a la piel.',
    ),
  ]),

  'bmedtronic_csilhouette': _medtronic(const [
    Paso(
      texto: '''
PREPARACIÓN
Quita el papel protector del adhesivo y el protector de la aguja.

Puedes insertarlo a mano o con el dispositivo Sil-serter.''',
    ),
    Paso(
      texto: '''
INSERCIÓN INCLINADA
Pellizca la piel e inserta la aguja inclinada, con un ángulo de entre 30 y 45 grados respecto a la piel.''',
    ),
    Paso(
      texto:
          'RETIRAR LA AGUJA: sujeta el catéter con un dedo para que no se '
          'mueva y saca con cuidado la aguja guía.',
    ),
  ]),

  'bmedtronic_csuret': _medtronic(const [
    Paso(
      texto: '''
PREPARAR LA AGUJA
Quita el papel protector del adhesivo grande y el protector de plástico de la aguja de acero.''',
    ),
    Paso(
      texto: '''
INSERCIÓN A MANO
Pellizca suavemente la piel en la zona elegida e inserta la aguja de acero directamente.

Presiona el adhesivo con firmeza contra la piel.''',
    ),
    Paso(
      texto:
          'Quita el papel del adhesivo pequeño (el del tubo) y pégalo a '
          'unos centímetros del sitio de inserción, para que un tirón '
          'accidental no arranque la aguja.',
    ),
  ], llenarCanula: false),

  // ------------------------- OMNIPOD -------------------------
  'bomnipod_cpod': porTramos(_omnipodBase, const [
    (Fases.preparacion, 4),
    (Fases.reservorio, 5),
    (Fases.cebado, 1),
    (Fases.zona, 2),
    (Fases.insercion, 2),
  ]),
  'bypsopump_corbit': porTramos(_orbitBase, const [
    (Fases.preparacion, 4),
    (Fases.reservorio, 2),
    (Fases.cebado, 3),
    (Fases.insercion, 7),
    (Fases.cierre, 1),
  ]),
  'bypsopump_cinset': porTramos(_orbitMicroBase, const [
    (Fases.preparacion, 4),
    (Fases.reservorio, 1),
    (Fases.cebado, 2),
    (Fases.insercion, 4),
    (Fases.cierre, 1),
  ]),

  // ------------------------- TANDEM -------------------------
  'btandem_cautosoft90': [
    ..._tandemConFases,
    ...enFase(Fases.insercion, [
      const Paso(
        texto: '''
Quita el papel del adhesivo y el protector de la aguja.

Tira de la parte central del insertador hacia arriba hasta oír un CLIC.''',
      ),
      const Paso(
        texto: '''
Apoya el dispositivo sobre la zona elegida y presiona los huecos de los lados para disparar.

Presiona el centro del insertador y retíralo con cuidado.''',
      ),
    ]),
    ...enFase(Fases.cierre, _tandemCierre),
  ],
  'btandem_cautosoft30': [
    ..._tandemConFases,
    ...enFase(Fases.insercion, [
      const Paso(
        texto: '''
PREPARAR EL DISPOSITIVO
Quita los protectores y tira del insertador hacia atrás hasta oír el CLIC.

El diseño ya incorpora la inclinación de 30 grados.''',
      ),
      const Paso(
        texto: '''
INSERCIÓN
Apoya el dispositivo plano sobre la piel y dispara.

Retira el insertador deslizándolo hacia atrás con cuidado, siguiendo la inclinación de la aguja.''',
      ),
    ]),
    ...enFase(Fases.cierre, _tandemCierre),
  ],
  'btandem_ctrusteel': [
    ..._tandemConFases,
    ...enFase(Fases.insercion, [
      const Paso(
        texto: '''
INSERCIÓN A MANO
Quita los protectores e inserta la aguja de acero a 90 grados (en vertical, recta).

Fija el adhesivo principal presionándolo contra la piel.''',
      ),
      const Paso(
        texto:
            'Pega el segundo adhesivo (el del tubo) a unos centímetros de la '
            'aguja, para que un tirón accidental no la arranque.',
      ),
    ]),
    ...enFase(Fases.cierre, _tandemCierreAcero),
  ],
};

const List<Paso> _omnipodBase = [
  Paso(
    texto: '''
Saca la insulina de la nevera un rato antes: tiene que estar a temperatura ambiente.

Lávate las manos con agua y jabón y limpia el tapón del vial con una toallita de alcohol.''',
  ),
  Paso(
    texto: '''
IMPORTANTE: no pongas un Pod nuevo hasta haber desactivado y quitado el anterior.

Para desactivarlo: INFORMACIÓN DEL POD → VER DETALLES DEL POD → CAMBIAR EL POD → DESACTIVAR POD.''',
  ),
  Paso(
    texto:
        'Despega despacio los bordes del adhesivo y quita el Pod usado. '
        'Hacerlo despacio irrita menos la piel.',
  ),
  Paso(
    texto: 'En la aplicación o en el Controlador, toca CONFIGURAR NUEVO POD.',
  ),
  Paso(
    texto: '''
Saca la aguja y la jeringa de llenado de la bandeja del Pod, pero DEJA el Pod dentro de la bandeja durante toda la preparación.

Enrosca la aguja en la jeringa y quita el capuchón tirando en línea recta.''',
  ),
  Paso(
    texto: '''
Llena la jeringa de AIRE hasta la cantidad de insulina que vayas a poner.

Ese aire va al vial, NUNCA al Pod. Ten en cuenta la línea MÍN marcada en la jeringa: la insulina tiene que llegar al menos hasta ahí.''',
  ),
  Paso(
    texto: '''
Clava la aguja en el vial y empuja el émbolo para meter el aire en el vial.

Con la jeringa aún en el vial, dale la vuelta al conjunto y tira despacio del émbolo. Da unos golpecitos para eliminar las burbujas.''',
  ),
  Paso(
    texto: '''
Saca la aguja del vial e insértala directamente en el puerto de llenado del Pod.

Una flecha en el papel blanco de la parte de atrás señala dónde está. Empuja el émbolo despacio hasta llenarlo del todo.

Si notas resistencia al empujar, no uses ese Pod.''',
  ),
  Paso(
    texto: '''
El Pod emitirá DOS PITIDOS.

Esa es la señal de que está lleno y listo para continuar. Si no pita, no lo uses: cámbialo por otro.''',
  ),
  Paso(
    texto: '''
Con el Pod todavía en la bandeja, acércalo al Controlador y toca SIGUIENTE.

El sistema hará unas comprobaciones de seguridad y llenará el Pod de forma automática (esto se llama cebar). Espera a que termine.''',
  ),
  Paso(
    texto: '''
Elige la zona respetando estas distancias mínimas:

• 8 cm de tu sensor Dexcom
• 2,5 cm del sitio del Pod anterior
• 5 cm del ombligo

El Pod y el sensor deben ir en el mismo lado del cuerpo, para que puedan comunicarse sin que tu cuerpo tape la señal.''',
  ),
  Paso(
    texto: '''
Evita lunares, tatuajes y cicatrices, zonas con infección, pliegues de piel y sitios donde el cinturón o la ropa ajustada puedan rozar el Pod.

Busca una zona con algo de grasa y fácil de alcanzar.''',
  ),
  Paso(
    texto:
        'Quita los papeles de los adhesivos, pega el Pod sobre la piel y '
        'sigue las instrucciones de la pantalla para que salga la cánula.',
  ),
  Paso(
    texto: '''
Mira por la ventanita del Pod que la cánula ha quedado bien puesta y confírmalo en el Controlador.

Mide tu glucosa a la hora y media del cambio, aproximadamente.''',
  ),
];

// ------------------------- YPSOPUMP -------------------------
const List<Paso> _orbitBase = [
  Paso(
    texto: '''
El catéter Orbit soft no debe usarse durante más de 72 horas.

Empieza desconectándote el catéter del cuerpo.''',
  ),
  Paso(
    texto: '''
Abre el menú principal y toca el icono "Cambio de cartucho y nivel actual del cartucho".

Después toca "Retraer varilla roscada" y confirma. La bomba vibrará un instante.''',
  ),
  Paso(
    texto: '''
Espera a que la varilla se retraiga por completo (el porcentaje baja al 0 %) y a que termine la autocomprobación.

NO insertes el cartucho antes: si lo haces, aparecerá el aviso "Retracción varilla roscada no finalizada" y habrá que repetir el proceso.''',
  ),
  Paso(
    texto: '''
Desconecta el catéter girando el adaptador en sentido antihorario hasta el tope.

Saca de la bomba el cartucho vacío.''',
  ),
  Paso(
    texto:
        'Sujeta la bomba en vertical, con el orificio del compartimento '
        'hacia arriba, y mete un reservorio cargado por ti o un cartucho '
        'precargado que sea compatible con tu YpsoPump.',
  ),
  Paso(
    texto: '''
Pon el adaptador en vertical sobre el cartucho y gíralo en sentido horario hasta la posición de bloqueo.

Oirás un ligero clic o notarás un tope.''',
  ),
  Paso(
    texto: '''
Abre el menú principal, toca "Cebar kit de infusión" y después "Cebar tubo". (Cebar es llenar el tubo de insulina.)

Elige el volumen que indican las instrucciones de tu catéter Orbit y confirma.''',
  ),
  Paso(
    texto: '''
Confirma que el catéter está desconectado del cuerpo.

Mientras se llena, mantén la bomba en vertical con el adaptador hacia arriba y golpéala suavemente contra la palma de la mano para que suban las burbujas.''',
  ),
  Paso(
    texto: '''
Repite hasta que no quede aire en el cartucho, el adaptador ni el tubo, y hasta que salga insulina por el extremo.

El volumen que indica el catéter es solo una referencia: puede hacer falta llenar más.''',
  ),
  Paso(
    texto: '''
Lávate bien las manos.

Limpia la zona con una toallita de alcohol isopropílico. Asegúrate de que no hay vello y de que la piel está seca antes de continuar.''',
  ),
  Paso(
    texto: '''
Despega con cuidado la lámina protectora de la cinta adhesiva, sin tocar la parte pegajosa.

Después quita el protector de la cánula.''',
  ),
  Paso(
    texto: '''
Sujeta bien la zona e inserta la cánula en vertical (90°).

Puedes usar el insertador mylife Orbit para que entre con más facilidad.''',
  ),
  Paso(
    texto:
        'Presiona la cinta contra la piel y recórrela con los dedos unos '
        'segundos, para que quede bien pegada.',
  ),
  Paso(
    texto: '''
Sujeta la cinta contra la piel con una mano y, con dos dedos de la otra, agarra el capuchón del introductor.

Saca la aguja introductora apretando las dos aletas exteriores del capuchón.''',
  ),
  Paso(
    texto:
        'Tapa la aguja introductora con el capuchón protector azul y tírala '
        'en un contenedor para objetos punzantes.',
  ),
  Paso(
    texto: '''
Conecta el capuchón del tubo a la base de la cánula sin ladearlo. Asegúrate de oírlo encajar.

Después gira el tubo a izquierda y derecha, al menos una vuelta completa en cada dirección, tirando del capuchón hacia arriba: así confirmas que está bien encajado y que la vía está abierta.''',
  ),
  Paso(
    texto: '''
Abre el menú principal, toca "Cebar kit de infusión" y después "Cebar cánula".

Elige la cantidad que indican las instrucciones de tu catéter y confirma.''',
  ),
];

// NOTA PENDIENTE: el manual de la YpsoPump solo reconoce como compatibles
// los kits Orbit soft y Orbit micro; no menciona el Inset. Esta entrada
// conserva el identificador 'cinset' para no romper el asset, pero el
// contenido es el del Orbit micro, que es el kit de aguja de acero del
// sistema. Hay que decidir si se renombra el identificador y se sustituye
// la imagen.
const List<Paso> _orbitMicroBase = [
  Paso(
    texto: '''
El catéter Orbit micro lleva cánula de acero y no debe usarse durante más de 48 horas.

Empieza desconectándote el catéter del cuerpo.''',
  ),
  Paso(
    texto: '''
Abre el menú principal y toca el icono "Cambio de cartucho y nivel actual del cartucho".

Después toca "Retraer varilla roscada" y confirma.''',
  ),
  Paso(
    texto: '''
Espera a que la varilla se retraiga del todo (0 %) y a que termine la autocomprobación.

NO insertes el cartucho antes de que acabe.''',
  ),
  Paso(
    texto:
        'Desconecta el catéter girando el adaptador en sentido antihorario '
        'hasta el tope y saca el cartucho vacío.',
  ),
  Paso(
    texto: '''
Sujeta la bomba en vertical con el compartimento hacia arriba y mete un reservorio compatible con tu YpsoPump.

Pon el adaptador en vertical y gíralo en sentido horario hasta oír el clic de bloqueo.''',
  ),
  Paso(
    texto: '''
Menú principal → "Cebar kit de infusión" → "Cebar tubo". (Cebar es llenar el tubo de insulina.)

Elige el volumen que indican las instrucciones de tu catéter y confirma que estás desconectado.''',
  ),
  Paso(
    texto: '''
Mantén la bomba vertical con el adaptador hacia arriba y golpéala suavemente contra la palma para eliminar las burbujas.

Repite hasta que no quede aire y salga insulina por el extremo del tubo.''',
  ),
  Paso(
    texto: '''
Lávate las manos y limpia la zona con alcohol isopropílico. La piel debe estar seca y sin vello.

Despega la lámina protectora del adhesivo y quita el protector de la cánula.''',
  ),
  Paso(
    texto: '''
El Orbit micro lleva una cánula de acero que se pone sin aguja introductora.

Sujeta bien la zona e inserta la cánula en vertical (90°). Puedes usar el insertador mylife Orbit.''',
  ),
  Paso(
    texto: '''
Presiona la cinta contra la piel y recórrela con los dedos unos segundos.

Quita el capuchón introductor apretando sus dos aletas exteriores.''',
  ),
  Paso(
    texto: '''
Conecta el capuchón del tubo a la base de la cánula sin ladearlo, hasta oírlo encajar.

Gira el tubo al menos una vuelta completa en cada dirección tirando hacia arriba, para confirmar que la vía está abierta.''',
  ),
  Paso(
    texto: '''
Menú principal → "Cebar kit de infusión" → "Cebar cánula".

Elige la cantidad que indican las instrucciones de tu catéter.''',
  ),
];

/// Variante de cambio de SOLO reservorio o cartucho, sin tocar el catéter.
/// Los manuales de Medtronic, Tandem y YpsoPump contemplan expresamente
/// cambiarlos por separado; el Omnipod no, porque el Pod integra el catéter.
final Map<String, List<Paso>> instruccionesSoloReservorio = {
  'bmedtronic': _medtronicSoloReservorio,
  'btandem': _tandemSoloCartucho,
  'bypsopump': [
    ...enFase(Fases.preparacion, const [
      Paso(
        texto: '''
La YpsoPump permite cambiar el cartucho sin cambiar el catéter: son independientes.

Empieza desconectándote el catéter del cuerpo.''',
      ),
      Paso(
        texto: '''
Menú principal, icono "Cambio de cartucho y nivel actual del cartucho", y después "Retraer varilla roscada". Confirma.

Espera a que baje al 0 % y termine la autocomprobación antes de seguir.''',
      ),
      Paso(
        texto:
            'Desconecta el catéter girando el adaptador en sentido antihorario '
            'hasta el tope y saca el cartucho vacío.',
      ),
      Paso(
        texto: '''
Sujeta la bomba en vertical con el compartimento hacia arriba y mete un reservorio compatible con tu YpsoPump.

Pon el adaptador en vertical y gíralo en sentido horario hasta oír el clic.''',
      ),
    ]),
    ...enFase(Fases.cebado, const [
      Paso(
        texto: '''
Menú principal, "Cebar kit de infusión", "Cebar tubo".

Si NO hay burbujas en el cartucho, basta con el volumen mínimo. Si las hay, usa el volumen que indique tu catéter hasta eliminarlas.''',
      ),
      Paso(
        texto:
            'Mantén la bomba vertical con el adaptador hacia arriba y '
            'golpéala suavemente contra la palma para que suban las burbujas. '
            'Repite hasta que no quede aire.',
      ),
    ]),
    ...enFase(Fases.cierre, const [
      Paso(
        texto: '''
Vuelve a conectar el capuchón del tubo a la base de la cánula hasta oírlo encajar.

Como no has cambiado el catéter, no hace falta llenar la cánula.''',
      ),
      Paso(
        texto:
            'Entre 1 y 3 horas después del cambio, mide tu glucosa con el '
            'medidor.',
      ),
    ]),
  ],
};
