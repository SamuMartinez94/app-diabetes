/// GUÍAS DE RECAMBIO DE CATÉTER / EQUIPO DE INFUSIÓN
///
/// Contenido volcado de los manuales oficiales del fabricante:
///
///   • Medtronic MiniMed 780G — System User Guide, pp. 110-125.
///     ATENCIÓN: ese manual está en INGLÉS. Los nombres de menú en español
///     son una traducción, no la cadena literal que muestra la bomba. Hay
///     que contrastarlos con el dispositivo.
///   • Tandem t:slim X2 — Guía del usuario, cap. 6, pp. 96-105 (español).
///   • Omnipod 5 — Guía del usuario, pp. 24-29 (español).
///   • mylife YpsoPump — Guía del usuario, cap. 5, pp. 96-113 (español).
///
/// Los manuales de bomba describen el lado de la BOMBA (reservorio, cebado,
/// llenado de cánula). Los pasos de inserción propios de cada catéter vienen
/// en las instrucciones de uso de ese catéter, que no están entre los
/// manuales disponibles: siguen pendientes de contrastar.
library;

import '../modelos/paso.dart';

/// TODAS las guías están pendientes de validar por un profesional sanitario.
/// Se muestran en rojo y con aviso de borrador.
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
        'Saca la insulina con antelación: debe estar a temperatura ambiente. '
        'La insulina fría genera burbujas de aire en el reservorio y en el '
        'tubo, y eso altera la cantidad que recibes.',
  ),
  Paso(texto: 'Lávate bien las manos con agua y jabón.'),
  Paso(
    texto: '''
En la bomba, entra en el menú y selecciona "Nuevo reservorio y equipo".

Necesitas: reservorio Medtronic, equipo de infusión y un vial de insulina rápida U-100.''',
  ),
  Paso(
    texto:
        'Retira el equipo de infusión usado aflojando el adhesivo y '
        'separándolo del cuerpo. Confirma en la bomba para continuar.',
  ),
  Paso(
    texto: '''
Retira el reservorio usado de la bomba y selecciona "Rebobinar".

ADVERTENCIA: el equipo de infusión tiene que estar DESCONECTADO del cuerpo antes de rebobinar. Si no lo está, puedes recibir insulina de forma accidental.''',
  ),
];

const List<Paso> _medtronicLlenado = [
  Paso(
    texto: '''
Saca el reservorio del envase y tira del émbolo hasta la cantidad de insulina que vayas a cargar.

Limpia el tapón del vial con alcohol, apoya el vial en una superficie firme y presiona el transfer sobre él.''',
  ),
  Paso(
    texto: '''
Empuja el émbolo y mantenlo presionado.

Sin soltar el pulgar, dale la vuelta al conjunto para que el vial quede arriba. Suelta y tira del émbolo para llenar el reservorio.''',
  ),
  Paso(
    texto: '''
Golpea suavemente el reservorio para que las burbujas suban.

Empuja el émbolo para devolver el aire al vial y vuelve a tirar hasta la cantidad que necesitas.''',
  ),
  Paso(
    texto: '''
Vuelve a girar el conjunto para que el reservorio quede arriba: así evitas que caiga insulina sobre su parte superior.

Sujeta el transfer y gira el reservorio en sentido antihorario para separarlo.''',
  ),
  Paso(
    texto:
        'ADVERTENCIA: no uses el reservorio ni el equipo si ha caído insulina '
        'o cualquier líquido sobre la parte superior del reservorio o dentro '
        'del conector del tubo. Puede bloquear los respiraderos y alterar la '
        'insulina que recibes. Empieza de nuevo con material nuevo.',
  ),
  Paso(
    texto:
        'Conecta el conector del tubo al reservorio empujando con suavidad y '
        'girándolo en sentido horario hasta que quede bloqueado.',
  ),
  Paso(
    texto: '''
Golpea el reservorio para subir las burbujas y empuja ligeramente el émbolo para pasarlas al tubo.

Después gira el émbolo en sentido antihorario para aflojarlo y retíralo.''',
  ),
];

const List<Paso> _medtronicCarga = [
  Paso(
    texto: '''
Introduce el reservorio en la bomba y gíralo en sentido horario hasta que quede bloqueado. Continúa.

El equipo NO debe estar conectado al cuerpo.''',
  ),
  Paso(
    texto:
        'Selecciona "Colocar" y mantén pulsado hasta que aparezca la marca de '
        'verificación en pantalla. Después continúa.',
  ),
  Paso(
    texto: '''
Selecciona "Llenar" y mantén pulsado hasta que no quede ninguna burbuja en el tubo y salgan gotas por el extremo.

ADVERTENCIA: revisa siempre el tubo. Si quedan burbujas, sigue llenando.''',
  ),
];

const List<Paso> _medtronicCierre = [
  Paso(
    texto: '''
Selecciona "Llenar cánula" e introduce la cantidad que indique la caja de tu catéter.

ADVERTENCIA: no dejes la bomba parada en la pantalla de llenado de cánula. Mientras esté ahí, la administración de insulina está suspendida.''',
  ),
  Paso(
    texto:
        'Comprueba tu glucemia con un medidor capilar entre 1 y 3 horas '
        'después del cambio. Es la forma de detectar a tiempo que el equipo '
        'no esté administrando bien.',
  ),
];

const List<Paso> _medtronicCierreAcero = [
  Paso(
    texto: '''
Este equipo lleva aguja de acero, así que NO se llena cánula.

Cuando la bomba lo pregunte, selecciona "Omitir llenado de cánula" o "Hecho".''',
  ),
  Paso(
    texto:
        'Comprueba tu glucemia con un medidor capilar entre 1 y 3 horas '
        'después del cambio.',
  ),
];

/// Une los bloques comunes de Medtronic con los pasos propios del catéter.
List<Paso> _medtronic(List<Paso> insercion, {bool llenarCanula = true}) => [
  ..._medtronicPreparacion,
  ..._medtronicLlenado,
  ..._medtronicCarga,
  ...insercion,
  ...(llenarCanula ? _medtronicCierre : _medtronicCierreAcero),
];

// ---------------------------------------------------------------------------
// TANDEM — bloques comunes de cartucho (manual cap. 6)
// ---------------------------------------------------------------------------

const List<Paso> _tandemComun = [
  Paso(texto: 'Lávate bien las manos con agua y jabón.'),
  Paso(
    texto: '''
Prepara el material: cartucho sin abrir, jeringa de 3,0 ml con aguja de llenado, vial de insulina, toallitas de alcohol y un equipo de infusión nuevo.

El cartucho se cambia cada 48-72 horas, según te haya indicado tu equipo médico.''',
  ),
  Paso(
    texto: '''
Calcula cuánta insulina cargar: añade unas 45 unidades a la cantidad que quieras tener disponible.

El llenado del tubo consume hasta 30 unidades que después no quedan disponibles para administrar.''',
  ),
  Paso(
    texto: '''
Limpia el tapón del vial con alcohol. Enrosca la aguja en la jeringa y retira el capuchón.

Carga la jeringa de aire hasta la cantidad de insulina deseada.''',
  ),
  Paso(
    texto: '''
Con el vial en vertical, inserta la aguja e inyecta el aire. Mantén la presión en el émbolo.

Da la vuelta al conjunto y suelta el émbolo: la insulina fluirá hacia la jeringa. Tira despacio hasta la cantidad que necesitas.''',
  ),
  Paso(
    texto: '''
Con la aguja aún en el vial y boca abajo, da golpecitos a la jeringa para que las burbujas suban y empuja despacio para devolverlas al vial.

Repite hasta que no quede ninguna burbuja y saca la aguja.''',
  ),
  Paso(
    texto: '''
Sujeta el cartucho en vertical e inserta poco a poco la aguja en el puerto blanco de llenado. No la fuerces hasta el fondo.

Tira del émbolo hasta el tope para extraer el aire residual del cartucho y después suéltalo.''',
  ),
  Paso(
    texto: '''
Retira la aguja del puerto. Pon la jeringa en vertical, da golpecitos y presiona con suavidad hasta ver una gota de insulina en la punta.

Vuelve a insertarla en el puerto y llena el cartucho poco a poco. Es normal notar contrapresión.''',
  ),
  Paso(
    texto: '''
Mantén la presión en el émbolo mientras sacas la aguja del cartucho.

Comprueba que no haya fugas. Si pierde insulina, desecha el cartucho y empieza de nuevo con uno nuevo.''',
  ),
  Paso(
    texto: '''
En la bomba: OPCIONES → Cargar → Cambiar cartucho.

Aparecerá un aviso de que se detiene toda la administración de insulina. Confirma para continuar.''',
  ),
  Paso(
    texto:
        'Desconecta el equipo de infusión de tu cuerpo y confirma. Extrae el '
        'cartucho usado; si se resiste, ayúdate con la herramienta de '
        'extracción o el borde de una moneda en la ranura inferior.',
  ),
  Paso(
    texto: '''
Coloca la parte inferior del cartucho nuevo en el extremo de la bomba, alineado con los carriles guía.

Empuja el puerto de llenado circular para deslizarlo hacia dentro y pulsa DESBLOQUEAR.''',
  ),
  Paso(
    texto: '''
Conecta el tubo del equipo al conector del cartucho. Gira en sentido horario hasta apretar con la mano y da un CUARTO DE VUELTA EXTRA.

ADVERTENCIA: sin ese cuarto de vuelta la conexión puede quedar floja y perder insulina.''',
  ),
  Paso(
    texto: '''
ADVERTENCIA: nunca llenes el tubo con el equipo conectado al cuerpo.

Sujeta la bomba en vertical y pulsa INICIO. Vibrará o pitará mientras se llena.''',
  ),
  Paso(
    texto: '''
Pulsa DETENER cuando veas 3 gotas de insulina en el extremo del tubo, y después LISTO.

Si no ves las gotas, pulsa LLENAR y repite. Cada ciclo admite un máximo de 30 unidades.''',
  ),
];

const List<Paso> _tandemCierre = [
  Paso(
    texto: '''
Pulsa "Llenar la cánula" y después "Editar cantidad de llenado".

Selecciona la cantidad que indiquen las instrucciones de tu equipo de infusión, entre 0,1 y 1,0 unidades, y pulsa INICIO.''',
  ),
  Paso(
    texto: '''
Configura el Recordatorio del sitio si lo usas: entre 1 y 3 días, con 3 días por defecto.

Después reanuda la administración de insulina.''',
  ),
  Paso(
    texto:
        'La bomba te recordará medir la glucemia entre 1 y 2 horas después. '
        'Hazlo: es la forma de comprobar que el equipo nuevo está '
        'administrando bien.',
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
        'Mide la glucemia entre 1 y 2 horas después del cambio para confirmar '
        'que el equipo administra correctamente.',
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
Elige una zona de inserción (abdomen, muslo, nalgas o brazo) y límpiala con alcohol o el antiséptico que te haya indicado tu equipo médico.

Inserta el equipo Extended siguiendo las instrucciones de su envase.''',
    ),
    Paso(
      texto:
          'PRECAUCIÓN: no repitas la misma zona de inserción una y otra vez. '
          'Ve rotando para que la piel tenga tiempo de recuperarse.',
    ),
  ]),

  'bmedtronic_cmio': _medtronic(const [
    Paso(
      texto: '''
PREPARAR EL DISPOSITIVO
Coloca el Mio dentro de su insertador y presiona hacia abajo hasta que encaje.''',
    ),
    Paso(
      texto:
          'Retira el papel protector del adhesivo y el protector de plástico '
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
Retira el papel del adhesivo y, con cuidado, el protector de la aguja.''',
    ),
    Paso(
      texto: '''
TENSAR EL DISPOSITIVO
Sujeta las protuberancias laterales y tira hacia atrás hasta oír un CLIC.

La aguja queda expuesta en ángulo inclinado.''',
    ),
    Paso(
      texto: '''
INSERCIÓN ANGULADA
Coloca el dispositivo plano sobre la piel: el ángulo de 30 grados ya viene incorporado.

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
          'Retira el papel protector del adhesivo y el protector de plástico '
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
          'Retira el insertador azul con cuidado y presiona el adhesivo con '
          'el dedo para que quede bien pegado a la piel.',
    ),
  ]),

  'bmedtronic_csilhouette': _medtronic(const [
    Paso(
      texto: '''
PREPARACIÓN
Retira el papel protector del adhesivo y quita el protector de la aguja.

Puedes insertarlo manualmente o con el dispositivo Sil-serter.''',
    ),
    Paso(
      texto: '''
INSERCIÓN ANGULADA
Pellizca la piel e inserta la aguja de forma inclinada, buscando un ángulo de entre 30 y 45 grados respecto a la piel.''',
    ),
    Paso(
      texto:
          'RETIRAR LA AGUJA: sujeta el catéter con un dedo para que no se '
          'mueva y retira la aguja guía con cuidado.',
    ),
  ]),

  'bmedtronic_csuret': _medtronic(
    const [
      Paso(
        texto: '''
PREPARAR LA AGUJA
Retira el papel protector del adhesivo grande y quita el protector de plástico de la aguja de acero.''',
      ),
      Paso(
        texto: '''
INSERCIÓN MANUAL
Pellizca suavemente la piel en la zona elegida e inserta la aguja de acero directamente.

Presiona el adhesivo firmemente contra la piel.''',
      ),
      Paso(
        texto:
            'Retira el papel del adhesivo pequeño (el del tubo) y pégalo a '
            'unos centímetros del lugar de inserción, para que un tirón '
            'accidental no arranque la aguja.',
      ),
    ],
    llenarCanula: false,
  ),

  // ------------------------- OMNIPOD -------------------------
  'bomnipod_cpod': const [
    Paso(
      texto: '''
Saca la insulina con antelación: tiene que estar a temperatura ambiente.

Lávate las manos con agua y jabón y limpia el tapón del vial con una toallita de alcohol.''',
    ),
    Paso(
      texto: '''
IMPORTANTE: no apliques un Pod nuevo hasta haber desactivado y retirado el anterior.

Para retirarlo: INFORMACIÓN DEL POD → VER DETALLES DEL POD → CAMBIAR EL POD → DESACTIVAR POD.''',
    ),
    Paso(
      texto:
          'Despega despacio los bordes del adhesivo y retira el Pod usado. '
          'Hacerlo lentamente reduce la irritación de la piel.',
    ),
    Paso(
      texto: 'En la aplicación o el Controlador, toca CONFIGURAR NUEVO POD.',
    ),
    Paso(
      texto: '''
Saca la aguja y la jeringa de la bandeja del Pod, pero DEJA el Pod dentro de la bandeja durante toda la configuración.

Enrosca la aguja en la jeringa y retira el capuchón tirando en línea recta.''',
    ),
    Paso(
      texto: '''
Carga la jeringa con una cantidad de aire igual a la insulina que vas a usar.

Debes cargar como MÍNIMO 85 unidades: es la línea de llenado MÍN marcada en la jeringa.''',
    ),
    Paso(
      texto: '''
Inserta la aguja en el vial y empuja el émbolo para introducir el aire.

Con la jeringa aún en el vial, dale la vuelta al conjunto y tira despacio del émbolo. Da unos golpecitos para eliminar las burbujas.''',
    ),
    Paso(
      texto: '''
Retira la aguja del vial e insértala directamente en el puerto de llenado del Pod.

Una flecha en el papel blanco del reverso señala dónde está. Empuja el émbolo despacio hasta llenarlo del todo.''',
    ),
    Paso(
      texto: '''
El Pod emitirá DOS PITIDOS.

Esa es la señal de que está lleno y listo para continuar. Si durante la activación no pita, no lo uses: sustitúyelo.''',
    ),
    Paso(
      texto: '''
Con el Pod todavía en la bandeja, ponlo en contacto con el Controlador y toca SIGUIENTE.

El sistema hará una serie de comprobaciones de seguridad y cebará el Pod automáticamente. Espera a que termine.''',
    ),
    Paso(
      texto: '''
Elige la zona respetando estas distancias mínimas:

• 8 cm de tu sensor Dexcom
• 2,5 cm del sitio del Pod anterior
• 5 cm del ombligo

El Pod y el sensor deben ir en el mismo lado del cuerpo, para que puedan comunicarse sin que tu cuerpo bloquee la señal.''',
    ),
    Paso(
      texto: '''
Evita lunares, tatuajes y cicatrices, zonas con infección, pliegues de piel y sitios donde el cinturón o la ropa ajustada puedan rozar el Pod.

Busca una zona con una capa de tejido graso y de fácil acceso.''',
    ),
    Paso(
      texto:
          'Retira los adhesivos, aplica el Pod sobre la piel y sigue las '
          'instrucciones que aparecen en pantalla para insertar la cánula.',
    ),
    Paso(
      texto: '''
Comprueba a través de la ventana del Pod que la cánula ha quedado bien insertada y confírmalo en el Controlador.

Mide tu glucosa unas horas después del cambio.''',
    ),
  ],

  // ------------------------- YPSOPUMP -------------------------
  'bypsopump_corbit': const [
    Paso(
      texto: '''
El kit Orbit soft no debe usarse durante más de 72 horas.

Empieza desconectándote el kit de infusión del cuerpo.''',
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
Desconecta el kit de infusión girando el adaptador en sentido antihorario hasta el tope.

Extrae el cartucho vacío de la bomba.''',
    ),
    Paso(
      texto:
          'Sujeta la bomba en vertical, con el orificio del compartimento '
          'hacia arriba, e inserta un reservorio de 1,6 ml cargado por ti o '
          'un cartucho precargado de 1,6 ml.',
    ),
    Paso(
      texto: '''
Coloca el adaptador en vertical sobre el cartucho y gíralo en sentido horario hasta la posición de bloqueo.

Oirás un ligero clic o notarás un tope mecánico definido.''',
    ),
    Paso(
      texto: '''
Abre el menú principal, toca "Cebar kit de infusión" y después "Cebar tubo".

Selecciona el volumen de cebado, entre 1,0 U y 30,0 U, según las instrucciones de tu kit Orbit, y confirma.''',
    ),
    Paso(
      texto: '''
Confirma que el kit está desconectado del cuerpo.

Durante el cebado, mantén la bomba en vertical con el adaptador hacia arriba y golpéala suavemente contra la palma de la mano para que suban las burbujas.''',
    ),
    Paso(
      texto: '''
Repite el cebado hasta que no quede aire en el cartucho, el adaptador ni el tubo, y hasta que salga insulina por el extremo.

El volumen indicado es solo una referencia: puede hacer falta administrar más.''',
    ),
    Paso(
      texto: '''
Lávate bien las manos.

Limpia la zona con una toallita de alcohol isopropílico al 70 %. Asegúrate de que no haya vello y de que la piel esté seca antes de continuar.''',
    ),
    Paso(
      texto: '''
Desprende con cuidado la lámina protectora de la cinta adhesiva, sin tocar la película.

Retira después el protector de la cánula.''',
    ),
    Paso(
      texto: '''
Estabiliza la zona de infusión e inserta la cánula con un ángulo de 90°.

Puedes usar el insertador mylife Orbit para que la entrada sea más fácil.''',
    ),
    Paso(
      texto:
          'Presiona la cinta sobre la piel y recórrela con los dedos unos '
          'segundos, para que la adhesión sea óptima.',
    ),
    Paso(
      texto: '''
Sujeta la cinta contra la piel con una mano y, con dos dedos de la otra, sujeta el capuchón del introductor.

Extrae la aguja introductora presionando las dos aletas exteriores del capuchón.''',
    ),
    Paso(
      texto:
          'Cubre la aguja introductora con el capuchón protector azul y '
          'deséchala en un contenedor para objetos punzantes.',
    ),
    Paso(
      texto: '''
Conecta el capuchón del tubo a la base de la cánula sin ladearlo. Asegúrate de oírlo encajar.

Después gira el tubo a izquierda y derecha, al menos una vuelta completa en cada dirección, tirando del capuchón hacia arriba: así confirmas que está bien encajado y que la vía está abierta.''',
    ),
    Paso(
      texto: '''
Abre el menú principal, toca "Cebar kit de infusión" y después "Cebar cánula".

Selecciona un volumen entre 0,1 U y 1,0 U según las instrucciones de tu kit y confirma.''',
    ),
  ],

  // NOTA PENDIENTE: el manual de la YpsoPump solo reconoce como compatibles
  // los kits Orbit soft y Orbit micro; no menciona el Inset. Esta entrada
  // conserva el identificador 'cinset' para no romper el asset, pero el
  // contenido es el del Orbit micro, que es el kit de aguja de acero del
  // sistema. Hay que decidir si se renombra el identificador y se sustituye
  // la imagen.
  'bypsopump_cinset': const [
    Paso(
      texto: '''
El kit Orbit micro lleva cánula de acero y no debe usarse durante más de 48 horas.

Empieza desconectándote el kit de infusión del cuerpo.''',
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
          'Desconecta el kit girando el adaptador en sentido antihorario '
          'hasta el tope y extrae el cartucho vacío.',
    ),
    Paso(
      texto: '''
Sujeta la bomba en vertical con el compartimento hacia arriba e inserta un reservorio de 1,6 ml.

Coloca el adaptador en vertical y gíralo en sentido horario hasta oír el clic de bloqueo.''',
    ),
    Paso(
      texto: '''
Menú principal → "Cebar kit de infusión" → "Cebar tubo".

Selecciona el volumen (1,0-30,0 U) según las instrucciones de tu kit y confirma que estás desconectado.''',
    ),
    Paso(
      texto: '''
Mantén la bomba vertical con el adaptador hacia arriba y golpéala suavemente contra la palma para eliminar las burbujas.

Repite hasta que no quede aire y salga insulina por el extremo del tubo.''',
    ),
    Paso(
      texto: '''
Lávate las manos y limpia la zona con alcohol isopropílico al 70 %. La piel debe estar seca y sin vello.

Desprende la lámina protectora del adhesivo y retira el protector de la cánula.''',
    ),
    Paso(
      texto: '''
El Orbit micro lleva una cánula de acero que se aplica sin aguja introductora.

Estabiliza la zona e inserta la cánula a 90°. Puedes usar el insertador mylife Orbit.''',
    ),
    Paso(
      texto: '''
Presiona la cinta sobre la piel y recórrela con los dedos unos segundos.

Retira el capuchón introductor presionando sus dos aletas exteriores.''',
    ),
    Paso(
      texto: '''
Conecta el capuchón del tubo a la base de la cánula sin ladearlo, hasta oírlo encajar.

Gira el tubo al menos una vuelta completa en cada dirección tirando hacia arriba, para confirmar que la vía está abierta.''',
    ),
    Paso(
      texto: '''
Menú principal → "Cebar kit de infusión" → "Cebar cánula".

Selecciona un volumen entre 0,1 U y 1,0 U según las instrucciones de tu kit.''',
    ),
  ],

  // ------------------------- TANDEM -------------------------
  'btandem_cautosoft90': [
    ..._tandemComun,
    const Paso(
      texto: '''
Retira el papel del adhesivo y el protector de la aguja.

Tira de la parte central del insertador hacia arriba hasta oír un CLIC.''',
    ),
    const Paso(
      texto: '''
Coloca el dispositivo sobre la zona elegida y presiona los huecos laterales para disparar.

Presiona el centro del insertador y retíralo con cuidado.''',
    ),
    ..._tandemCierre,
  ],

  'btandem_cautosoft30': [
    ..._tandemComun,
    const Paso(
      texto: '''
PREPARAR EL DISPOSITIVO
Retira los protectores y tira del insertador hacia atrás hasta oír el CLIC.

El diseño ya incorpora la inclinación de 30 grados.''',
    ),
    const Paso(
      texto: '''
INSERCIÓN
Coloca el dispositivo plano sobre la piel y dispara.

Retira el insertador deslizándolo hacia atrás con cuidado, siguiendo el ángulo de la aguja.''',
    ),
    ..._tandemCierre,
  ],

  'btandem_ctrusteel': [
    ..._tandemComun,
    const Paso(
      texto: '''
INSERCIÓN MANUAL
Retira los protectores e inserta la aguja de acero a 90 grados.

Fija el adhesivo principal presionándolo contra la piel.''',
    ),
    const Paso(
      texto:
          'Pega el segundo adhesivo (el del tubo) a unos centímetros de la '
          'aguja, para que un tirón accidental no la arranque.',
    ),
    ..._tandemCierreAcero,
  ],
};
