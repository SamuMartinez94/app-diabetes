/// ALARMAS Y AVISOS
///
/// Fuentes: manuales oficiales de mylife YpsoPump, Medtronic MiniMed 780G,
/// Tandem t:slim X2 y Omnipod 5.
library;

import '../modelos/alarma.dart';

/// Alarmas todavía sin contrastar con el manual oficial del fabricante.
const Set<String> alarmasPorRevisar = {
  'oclusion',
  'reservorio_bajo',
  'reservorio_vacio',
  'bateria_baja',
  'bateria_agotada',
  'suspension_nivel_bajo',
  'suspension_antes_bajo',
  'senal_perdida',
  'sensor_caducado',
  'sensor_calibrar',
  'sensor_actualizando',
  'salida_modo_auto',
  'glucosa_alta',
  'glucosa_baja',
  'cateter_sin_llenar',
  'error_carga',
  'bomba_detenida',
  'pod_caducado',
  'pod_error',
  'pod_desactivar',
  'pod_comunicacion',
  'cartucho_vacio_ypso',
  'temperatura',
  'reinicio_bomba',
  'varilla_no_retraida',
  'cebado_no_finalizado',
  'parada_automatica',
  'error_electronico',
  'bateria_no_apta',
  'sin_bateria_ypso',
};

/// Alarmas y avisos habituales de bombas y sensores.
const List<Alarma> alarmas = [
  // ---------------- COMUNES A TODAS LAS BOMBAS ----------------
  Alarma(
    id: 'oclusion',
    bomba: '',
    titulo: 'Bloqueo (oclusión)',
    significado:
        'La bomba nota que algo bloquea el paso y la insulina no está '
        'llegando a tu cuerpo. Puede ser un catéter doblado, una cánula '
        'atascada o un cristal de insulina.',
    queHacer: [
      'Confirma la alarma y desconecta el catéter de tu cuerpo.',
      'Cambia el catéter entero y llena el tubo (cebar) como indica su guía.',
      'Si el llenado termina sin que vuelva a saltar el bloqueo, ya puedes seguir con normalidad.',
      'Si el bloqueo salta otra vez al llenar el catéter nuevo, cambia también el cartucho o reservorio y vuelve a llenar.',
      'Si sigue saltando aun con cartucho nuevo, la bomba puede estar averiada: contacta con el fabricante.',
      'Mide tu glucosa y, si está alta, comprueba las cetonas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: [
      'oclusion',
      'obstruido',
      'atasco',
      'no pasa insulina',
      'bloqueo',
      'acodado',
    ],
  ),
  Alarma(
    id: 'reservorio_bajo',
    bomba: '',
    titulo: 'Queda poca insulina',
    significado:
        'Queda poca insulina en el cartucho. Es solo un aviso: la bomba '
        'sigue funcionando con normalidad.',
    queHacer: [
      'Prepara un reservorio nuevo y ten insulina a mano.',
      'Haz el cambio antes de que se vacíe del todo.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['poca insulina', 'queda poco', 'cartucho bajo', 'reservorio'],
  ),
  Alarma(
    id: 'reservorio_vacio',
    bomba: '',
    titulo: 'Sin insulina (reservorio vacío)',
    significado:
        'Ya no queda insulina. La bomba ha dejado de darte insulina, también '
        'la de fondo (basal).',
    queHacer: [
      'Cambia el reservorio cuanto antes.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
      'Si no puedes cambiarlo ya, usa la pluma de respaldo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin insulina', 'cartucho vacio', 'se acabo', 'vacio'],
  ),
  Alarma(
    id: 'bateria_baja',
    bomba: '',
    titulo: 'Batería baja',
    significado: 'Queda poca carga. La bomba sigue funcionando con normalidad.',
    queHacer: [
      'Carga la bomba o ten una pila de repuesto preparada.',
      'No dejes que se agote: si se apaga, dejas de recibir insulina.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['pila baja', 'poca bateria', 'cargar', 'pila'],
  ),
  Alarma(
    id: 'bateria_agotada',
    bomba: '',
    titulo: 'Batería agotada / Cambiar pila',
    significado:
        'La bomba se va a apagar o ya se ha apagado, y no te está dando '
        'insulina.',
    queHacer: [
      'Cambia la pila o conecta el cargador enseguida.',
      'Cuando se reinicie, comprueba que la hora y tu programa de insulina de fondo (basal) son correctos.',
      'Mide tu glucosa para saber cuánto tiempo has estado sin insulina.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin bateria', 'apagada', 'no enciende', 'sin pila'],
  ),
  Alarma(
    id: 'bomba_detenida',
    bomba: '',
    titulo: 'Bomba parada',
    significado:
        'La bomba no te está dando insulina, porque la has parado tú o por '
        'un error.',
    queHacer: [
      'Mira en la pantalla por qué se ha parado.',
      'Si el motivo ya está resuelto, reanuda la insulina.',
      'Mide tu glucosa: sin insulina de fondo, sube rápido.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['parada', 'suspendida', 'no administra', 'stop', 'detenida'],
  ),
  Alarma(
    id: 'temperatura',
    bomba: '',
    titulo: 'Demasiado frío o demasiado calor',
    significado:
        'La bomba está demasiado fría o demasiado caliente para funcionar '
        'con seguridad. Además, la insulina se estropea con el calor.',
    queHacer: [
      'Aleja la bomba del calor o del frío directo (sol, coche, nevera).',
      'Espera a que vuelva a temperatura ambiente.',
      'Si ha estado expuesta mucho rato, cambia la insulina: puede haber perdido efecto.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['calor', 'frio', 'sol', 'playa', 'temperatura'],
  ),
  Alarma(
    id: 'cateter_sin_llenar',
    bomba: '',
    titulo: 'Cánula sin llenar',
    significado:
        'Has terminado el cambio pero no se ha llenado la cánula (el tubito '
        'que queda bajo la piel). Hay aire al final y no está entrando '
        'insulina.',
    queHacer: [
      'Elige "Llenar cánula" y pon la cantidad que indica la caja de tu catéter.',
      'Excepción: los catéteres con aguja de acero (Sure-T, TruSteel, Orbit micro) NO tienen cánula y no se llenan.',
      'No dejes la bomba parada en la pantalla de llenar cánula: mientras esté ahí, no te da insulina.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['cebar', 'purgar', 'llenar canula', 'aire', 'canula'],
  ),

  // ---------------- MEDTRONIC ----------------
  Alarma(
    id: 'suspension_nivel_bajo',
    bomba: 'bmedtronic',
    titulo: 'Insulina suspendida por glucosa baja',
    significado:
        'El sensor ha detectado que tu glucosa está baja y la bomba ha '
        'parado sola la insulina de fondo (basal).',
    queHacer: [
      'Confírmalo con un pinchazo en el dedo.',
      'Si de verdad está baja, trátala como te haya enseñado tu equipo médico.',
      'La insulina se reanuda sola cuando te recuperas; también puedes reanudarla tú.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hipo', 'suspension', 'smartguard', 'parada por baja'],
  ),
  Alarma(
    id: 'suspension_antes_bajo',
    bomba: 'bmedtronic',
    titulo: 'Insulina suspendida por si baja la glucosa',
    significado:
        'El sensor prevé que tu glucosa va a bajar y la bomba ha parado la '
        'insulina de fondo (basal) para evitarlo.',
    queHacer: [
      'Confírmalo con un pinchazo en el dedo.',
      'Si todavía estás en rango, no hace falta que tomes nada: la parada es preventiva.',
      'Vigila cómo evoluciona tu glucosa durante la siguiente media hora.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['prediccion', 'preventiva', 'smartguard'],
  ),
  Alarma(
    id: 'salida_modo_auto',
    bomba: 'bmedtronic',
    titulo: 'Salida del modo automático',
    significado:
        'La bomba ha vuelto al modo manual. Suele pasar porque el sensor no '
        'da lecturas o porque la bomba lleva mucho rato dando la insulina '
        'máxima o mínima.',
    queHacer: [
      'Comprueba que el sensor está dando lecturas.',
      'Sigue las indicaciones de la pantalla para volver al modo automático.',
      'Mientras estés en manual, vigila más tu glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['modo manual', 'smartguard', 'automatico', 'auto mode'],
  ),
  Alarma(
    id: 'error_carga',
    bomba: 'bmedtronic',
    titulo: 'Error al cargar el reservorio',
    significado:
        'La bomba no ha podido terminar de cargar el reservorio o de mover '
        'el pistón.',
    queHacer: [
      'Saca el reservorio y repite "Nuevo reservorio y equipo" desde el principio.',
      'Comprueba que el reservorio está bien puesto y girado hasta el tope.',
      'Si el error se repite, llama al soporte del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'error carga',
      'piston',
      'rebobinar',
      'error de administracion',
    ],
  ),

  // ---------------- OMNIPOD ----------------
  Alarma(
    id: 'pod_caducado',
    bomba: 'bomnipod',
    titulo: 'Pod caducado',
    significado:
        'El Pod ha llegado al final de su vida útil y ha dejado de dar '
        'insulina.',
    queHacer: [
      'INFORMACIÓN DEL POD → VER DETALLES DEL POD → CAMBIAR EL POD → DESACTIVAR POD.',
      'Despega despacio los bordes del adhesivo y quita el Pod.',
      'No pongas el Pod nuevo hasta haber desactivado y quitado el viejo.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['caducado', 'expirado', 'pod viejo'],
  ),
  Alarma(
    id: 'pod_error',
    bomba: 'bomnipod',
    titulo: 'Error del Pod (alarma de peligro)',
    significado:
        'El Pod ha detectado un fallo interno y ha dejado de dar insulina. '
        'Suele sonar un pitido continuo.',
    queHacer: [
      'Desactiva el Pod desde el Controlador y quítalo de la piel.',
      'Pon un Pod nuevo.',
      'Guarda el Pod estropeado: el soporte puede pedírtelo.',
      'Mide tu glucosa y comprueba las cetonas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['pitido', 'alarma continua', 'fallo pod'],
  ),
  Alarma(
    id: 'pod_desactivar',
    bomba: 'bomnipod',
    titulo: 'No se puede desactivar el Pod',
    significado:
        'El Controlador no consigue comunicarse con el Pod para '
        'desactivarlo.',
    queHacer: [
      'Acerca el Controlador al Pod para que puedan comunicarse.',
      'Si sigue sin desactivarse, usa la opción de descartar el Pod en el Controlador.',
      'Quita el Pod de la piel con la mano y ponte uno nuevo.',
      'Recuerda que el Pod y el sensor deben ir en el mismo lado del cuerpo para verse entre sí.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['no desactiva', 'no se apaga', 'quitar pod'],
  ),
  Alarma(
    id: 'pod_comunicacion',
    bomba: 'bomnipod',
    titulo: 'El Controlador no encuentra el Pod',
    significado:
        'El Controlador no localiza el Pod. El Pod sigue dando la insulina '
        'de fondo (basal) que tenía programada.',
    queHacer: [
      'Acerca el Controlador al Pod.',
      'Aléjate de cosas que puedan interferir (otros aparatos, paredes gruesas).',
      'Si no se recupera, el Pod seguirá con su última insulina de fondo: planifica el cambio.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'sin señal pod',
      'no conecta',
      'fuera de alcance',
      'sin comunicacion',
    ],
  ),

  // ---------------- YPSOPUMP ----------------
  Alarma(
    id: 'cartucho_vacio_ypso',
    bomba: 'bypsopump',
    titulo: 'Cartucho vacío',
    significado:
        'A la YpsoPump se le ha acabado la insulina del cartucho y ha '
        'dejado de darte insulina.',
    queHacer: [
      'Cambia el cartucho siguiendo la guía de cambio.',
      'Acuérdate de llenar el tubo (cebar) después de poner el cartucho nuevo.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho', 'vacio', 'sin insulina'],
  ),

  // ---------------- YPSOPUMP (manual cap. 8) ----------------
  Alarma(
    id: 'varilla_no_retraida',
    bomba: 'bypsopump',
    titulo: 'La varilla no ha terminado de retraerse',
    significado:
        'Has puesto el cartucho antes de que la varilla roscada terminara de '
        'retraerse y de que la bomba acabara su autocomprobación.',
    queHacer: [
      'Repite el cambio de cartucho desde el principio.',
      'Espera a que el porcentaje baje al 0 % y a que termine la autocomprobación antes de poner el cartucho.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['varilla', 'roscada', 'retraccion', 'cartucho antes'],
  ),
  Alarma(
    id: 'cebado_no_finalizado',
    bomba: 'bypsopump',
    titulo: 'No hay insulina / Falta llenar el tubo (cebado)',
    significado:
        'Después de retraer la varilla roscada pasaron 5 minutos sin llenar '
        'el tubo (cebar), o el llenado ha fallado. La bomba no te está '
        'dando insulina.',
    queHacer: [
      'Confirma la alarma.',
      'Pon un cartucho y llena el tubo (cebar).',
      'Repite hasta que salga insulina por el extremo y no queden burbujas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['no hay insulina', 'cebado', 'purgar', 'sin cebar'],
  ),
  Alarma(
    id: 'parada_automatica',
    bomba: 'bypsopump',
    titulo: 'Parada automática',
    significado:
        'La bomba llevaba 24 horas encendida sin usarse y se ha puesto '
        'sola en parada. Se han cancelado todas las entregas de insulina '
        'que estaban en marcha.',
    queHacer: [
      'Confirma la alarma y vuelve a poner la bomba en marcha.',
      'Mide tu glucosa: has estado sin insulina de fondo.',
      'Mira si tenías un bolo o una basal temporal en marcha, porque se han cancelado.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['parada', 'automatica', '24 horas', 'se paro sola'],
  ),
  Alarma(
    id: 'error_electronico',
    bomba: 'bypsopump',
    titulo: 'Error electrónico',
    significado:
        'La bomba ha detectado un fallo interno. Todas sus funciones quedan '
        'canceladas.',
    queHacer: [
      'Desconecta el catéter de tu cuerpo.',
      'Saca la pila alcalina y pulsa el botón de función durante 2 segundos: la bomba pasa a estado de almacenamiento.',
      'Vuelve a ponerla en marcha y revisa todos tus ajustes.',
      'Cambia el cartucho y el catéter.',
      'Si el error vuelve a aparecer, deja de usar la bomba, saca la pila y llama al fabricante.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['error', 'electronico', 'fallo interno', 'no funciona'],
  ),
  Alarma(
    id: 'bateria_no_apta',
    bomba: 'bypsopump',
    titulo: 'Pila no válida',
    significado:
        'La pila que has puesto tiene demasiado voltaje para la bomba.',
    queHacer: [
      'Confirma la alarma y saca la pila.',
      'Pon una pila alcalina AAA (LR03) nueva.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['pila', 'voltaje', 'no apta', 'incorrecta', 'bateria'],
  ),
  Alarma(
    id: 'sin_bateria_ypso',
    bomba: 'bypsopump',
    titulo: 'No hay pila',
    significado:
        'La pila alcalina lleva fuera de su hueco más de 5 minutos con la '
        'bomba en marcha.',
    queHacer: [
      'Confirma la alarma y pon una pila alcalina AAA (LR03) nueva.',
      'Mide tu glucosa: puede que hayas estado sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin pila', 'pila fuera', 'sin bateria'],
  ),

  // ---------------- TANDEM ----------------
  Alarma(
    id: 'reinicio_bomba',
    bomba: 'btandem',
    titulo: 'La bomba se ha reiniciado',
    significado:
        'La bomba se ha reiniciado por un error del programa. Puede que '
        'tengas que confirmar algunos ajustes.',
    queHacer: [
      'Comprueba que la hora y la fecha son correctas.',
      'Mira que tu programa de insulina de fondo (basal) sigue activo.',
      'Comprueba la insulina activa (la que aún te está haciendo efecto): puede haberse perdido el registro.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['reinicio', 'se reinicio', 'error software'],
  ),

  // ---------------- SENSORES ----------------
  Alarma(
    id: 'senal_perdida',
    bomba: '',
    titulo: 'Se ha perdido la señal del sensor',
    significado:
        'Tu móvil o tu bomba no reciben lecturas del sensor. La bomba sigue '
        'dando tu insulina de fondo (basal), pero sin ajustes automáticos.',
    queHacer: [
      'Acerca el móvil o el receptor al sensor.',
      'Si tu modelo lleva transmisor, comprueba que está bien encajado.',
      'Apaga y enciende el Bluetooth del dispositivo y espera 15 minutos.',
      'Mientras no haya lecturas, mídete con un pinchazo en el dedo.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['no conecta', 'sin señal', 'bluetooth', 'sin lecturas'],
  ),
  Alarma(
    id: 'sensor_caducado',
    bomba: '',
    titulo: 'Sensor caducado / Cambiar sensor',
    significado:
        'El sensor ha llegado al final de su vida útil y ha dejado de '
        'medir.',
    queHacer: [
      'Quita el sensor y ponte uno nuevo.',
      'Mira la guía de cambio de sensor de esta app.',
      'Recuerda que hay un tiempo de calentamiento antes de las primeras lecturas.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['caducado', 'expirado', 'fin de vida', 'cambiar sensor'],
  ),
  Alarma(
    id: 'sensor_calibrar',
    bomba: '',
    titulo: 'Toca calibrar',
    significado:
        'El sensor necesita que le des el valor de un pinchazo en el dedo '
        'para seguir dando lecturas fiables.',
    queHacer: [
      'Lávate y sécate bien las manos antes de pincharte.',
      'Mete el valor del dedo en cuanto lo tengas.',
      'No calibres si tu glucosa está cambiando rápido: espera a un momento estable.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['calibracion', 'calibrar', 'capilar', 'referencia'],
  ),
  Alarma(
    id: 'sensor_actualizando',
    bomba: '',
    titulo: 'Sensor calentando',
    significado:
        'El sensor recién puesto se está estabilizando y todavía no da '
        'lecturas.',
    queHacer: [
      'Espera el tiempo de calentamiento de tu modelo: entre 30 minutos y 2 horas.',
      'Mientras tanto, mídete con un pinchazo en el dedo.',
      'Si al terminar sigue sin dar lecturas, revisa el emparejamiento.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: [
      'calentamiento',
      'iniciando',
      'sin lecturas aun',
      'actualizando',
    ],
  ),
  Alarma(
    id: 'glucosa_alta',
    bomba: '',
    titulo: 'Aviso de glucosa alta',
    significado:
        'El sensor ha detectado un valor por encima del límite que tienes '
        'configurado.',
    queHacer: [
      'Confírmalo con un pinchazo en el dedo.',
      'Si el valor es muy alto o lleva mucho rato sin bajar, comprueba las cetonas.',
      'Revisa el catéter: una glucosa alta sin motivo suele deberse a que el catéter no funciona bien.',
      'Actúa como te haya indicado tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hiper', 'alta', 'hiperglucemia', 'subida'],
  ),
  Alarma(
    id: 'glucosa_baja',
    bomba: '',
    titulo: 'Aviso de glucosa baja',
    significado:
        'El sensor ha detectado un valor por debajo del límite que tienes '
        'configurado.',
    queHacer: [
      'Si puedes, confírmalo con un pinchazo en el dedo, pero no retrases el tratamiento.',
      'Toma hidratos de carbono de acción rápida (azúcar, zumo…) como te haya enseñado tu equipo médico.',
      'Vuelve a medirte a los 15 minutos.',
      'Si pierdes el conocimiento o no puedes tragar, es una urgencia: glucagón y llama al 112.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'hipoglucemia', 'bajada'],
  ),
];
