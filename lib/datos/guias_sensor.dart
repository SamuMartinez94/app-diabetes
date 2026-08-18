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

const Map<String, List<Paso>> instruccionesSensor = {
  'bypsopump_sdexg6': [
    Paso(texto: 'Lávate las manos y limpia la zona con alcohol'),
    Paso(
      texto: 'Prepara el aplicador del Dexcom G6',
      imagen: 'assets/images/sdexg6.png',
    ),
    Paso(texto: 'Inserta el sensor y coloca el transmisor'),
  ],
  'bmedtronic_sguardian': [
    Paso(texto: 'Inserta el sensor Guardian 4'),
    Paso(
      texto: 'Espera a que se inicie el periodo de calentamiento',
      imagen: 'assets/images/paso1.png',
    ),
  ],
  // Medtronic + Simplera Sync
  'bmedtronic_ssimplera': [
    Paso(
      texto:
          'Lávate las manos y limpia la zona de inserción del brazo con alcohol.',
    ),
    Paso(
      texto:
          'IMPORTANTE: El sensor Simplera Sync está indicado para insertarse ÚNICAMENTE en la parte posterior del brazo.',
    ),
    Paso(
      texto:
          'Utiliza el dispositivo de inserción para colocar el sensor en la zona preparada.',
    ),
    Paso(
      texto:
          'Retira el papel adhesivo y presiona suavemente para que se pegue bien a la piel.',
    ),
    Paso(
      texto:
          'En la bomba, ve a "Sensores emparejados" y asegúrate de que el nuevo sensor esté vinculado.',
    ),
    Paso(
      texto:
          'Espera a que finalice el periodo de calentamiento. La bomba te avisará cuando empiece a mostrar lecturas de glucosa.',
    ),
  ],
  'btandem_sdexg6': [
    Paso(texto: 'En la bomba, ve a Opciones > Mi MCG > Detener Sensor.'),
    Paso(
      texto:
          'Despega el adhesivo del sensor viejo. Guarda el transmisor (la pieza gris reutilizable) y limpia los restos de sangre con alcohol.',
    ),
    Paso(
      texto:
          'Lávate las manos y limpia la nueva zona de inserción con alcohol.',
    ),
    Paso(
      texto:
          'Coloca el aplicador del nuevo sensor sobre la piel, retira la pestaña de seguridad y presiona el botón naranja.',
    ),
    Paso(
      texto:
          'Encaja el transmisor en el soporte del nuevo sensor hasta oír dos "clics".',
    ),
    Paso(
      texto:
          'Ve a Opciones > Mi MCG > Iniciar Sensor. Introduce el código de 4 dígitos que viene en el papel del adhesivo del sensor.',
    ),
    Paso(
      texto: 'Espera a que termine el periodo de calentamiento de 2 horas.',
    ),
  ],

  // Tandem + Dexcom G7
  'btandem_sdexg7': [
    Paso(
      texto:
          'Si tienes un sensor activo, ve a Opciones > Mi MCG > Detener sensor antes de retirarlo.',
    ),
    Paso(
      texto: '''
Despega el adhesivo del sensor antiguo y deséchalo entero.

A diferencia del G6, el G7 no tiene transmisor reutilizable: sensor y transmisor son una sola pieza desechable.''',
    ),
    Paso(
      texto:
          'Lávate las manos y limpia con alcohol la parte posterior del brazo. Deja secar la piel completamente.',
    ),
    Paso(
      texto:
          'Saca el aplicador del envase y retira el protector del adhesivo.',
      imagen: 'assets/images/sdexg7.png',
    ),
    Paso(
      texto:
          'Apoya el aplicador plano sobre la piel y presiona el botón hasta oír un clic.',
    ),
    Paso(
      texto:
          'Retira el aplicador tirando en línea recta y presiona el adhesivo alrededor del sensor para fijarlo.',
    ),
    Paso(
      texto:
          'En la bomba, ve a Opciones > Mi MCG > Iniciar sensor e introduce el código de emparejamiento de 4 dígitos que aparece en el aplicador.',
    ),
    Paso(
      texto:
          'Espera el periodo de calentamiento de 30 minutos hasta que aparezcan las primeras lecturas.',
    ),
  ],

  // Omnipod 5 + Dexcom G6
  'bomnipod_sdexg6': [
    Paso(
      texto:
          'Detén el sensor activo desde el Controlador de Omnipod 5 o desde la app de Dexcom.',
    ),
    Paso(
      texto: '''
Despega el adhesivo del sensor antiguo.

IMPORTANTE: guarda el transmisor gris, es reutilizable y lo necesitas para el sensor nuevo.''',
    ),
    Paso(
      texto:
          'Lávate las manos y limpia la nueva zona de inserción con alcohol. Deja secar.',
    ),
    Paso(
      texto:
          'Coloca el aplicador sobre la piel, retira la pestaña de seguridad y presiona el botón naranja.',
      imagen: 'assets/images/sdexg6.png',
    ),
    Paso(
      texto:
          'Encaja el transmisor en el soporte del sensor hasta oír dos clics.',
    ),
    Paso(
      texto:
          'En el Controlador, entra en el menú de MCG e introduce el código del sensor que viene en el adhesivo.',
    ),
    Paso(
      texto: '''
Espera las 2 horas de calentamiento.

Durante ese tiempo el modo automatizado no está disponible: la bomba funcionará en modo manual.''',
    ),
  ],

  // Omnipod 5 + Dexcom G7
  'bomnipod_sdexg7': [
    Paso(
      texto:
          'Detén el sensor activo desde el Controlador de Omnipod 5 o desde la app de Dexcom.',
    ),
    Paso(
      texto:
          'Despega el sensor antiguo y deséchalo entero. El G7 no lleva transmisor reutilizable.',
    ),
    Paso(
      texto:
          'Lávate las manos y limpia con alcohol la parte posterior del brazo. Deja secar.',
    ),
    Paso(
      texto:
          'Retira el protector del adhesivo, apoya el aplicador plano sobre la piel y presiona el botón hasta oír un clic.',
      imagen: 'assets/images/sdexg7.png',
    ),
    Paso(
      texto:
          'Retira el aplicador en línea recta y presiona el adhesivo alrededor del sensor.',
    ),
    Paso(
      texto:
          'En el Controlador, entra en el menú de MCG e introduce el código de emparejamiento de 4 dígitos del aplicador.',
    ),
    Paso(
      texto: '''
Espera el calentamiento de 30 minutos.

Hasta que no haya lecturas, la bomba funcionará en modo manual.''',
    ),
  ],

  // Ypsopump + FreeStyle Libre 3
  'bypsopump_sfreelibre3': [
    Paso(
      texto:
          'Lávate las manos y limpia con alcohol la parte posterior del brazo. Deja secar la piel completamente.',
    ),
    Paso(
      texto: '''
Abre el envase del sensor.

El Libre 3 viene ya montado en un aplicador de un solo uso: no hay que ensamblar nada ni manipular agujas.''',
      imagen: 'assets/images/sfreelibre3.png',
    ),
    Paso(texto: 'Retira el tapón del aplicador.'),
    Paso(
      texto:
          'Apoya el aplicador firmemente sobre la piel y presiona hacia abajo hasta el tope.',
    ),
    Paso(
      texto:
          'Retira el aplicador. El sensor queda pegado a la piel. Pasa el dedo por el borde del adhesivo para asegurarlo.',
    ),
    Paso(
      texto:
          'Empareja el sensor desde la app que uses con la YpsoPump siguiendo el asistente de la propia app.',
    ),
    Paso(
      texto:
          'Espera los 60 minutos de calentamiento hasta la primera lectura.',
    ),
  ],
};
