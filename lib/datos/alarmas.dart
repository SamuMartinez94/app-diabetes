/// ALARMAS Y AVISOS
///
/// Contrastado con los manuales oficiales:
///   • mylife YpsoPump — cap. 8, pp. 148-173 (español).
///   • Medtronic MiniMed 780G — pp. 110-124 y tablas de alertas (inglés).
///   • Tandem t:slim X2 — cap. 6 y cap. 12 (español).
///   • Omnipod 5 — pp. 24-29 (español).
///
/// El campo `codigo` solo se rellena cuando el fabricante numera la alarma de
/// forma inequívoca. Ninguno de los manuales disponibles usa códigos
/// numéricos para estas alarmas, así que están todos vacíos: inventar uno
/// sería peor que no ponerlo.
library;

import '../modelos/alarma.dart';

/// Alarmas todavía sin contrastar con el manual oficial del fabricante.
/// Se muestran en rojo y con aviso de borrador.
/// Cuando valides una, borra su id de este conjunto.
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
///
/// Nota: el campo `codigo` solo se rellena cuando el fabricante numera la
/// alarma de forma inequívoca. Un código equivocado sería peor que ninguno.
const List<Alarma> alarmas = [
  // ---------------- COMUNES A TODAS LAS BOMBAS ----------------
  Alarma(
    id: 'oclusion',
    bomba: '',
    titulo: 'Oclusión / Flujo bloqueado',
    significado:
        'La bomba ha detectado resistencia y la insulina no está llegando a tu '
        'cuerpo. Puede ser un catéter doblado, una cánula obstruida o un '
        'cristal de insulina.',
    queHacer: [
      'Confirma la alarma y desconéctate el equipo de infusión del cuerpo.',
      'Cambia el equipo de infusión completo y cébalo con el volumen que indique su guía.',
      'Si el cebado termina sin volver a dar oclusión, puedes seguir con el tratamiento.',
      'Si la oclusión se repite al cebar el equipo nuevo, cambia también el cartucho o reservorio y vuelve a cebar.',
      'Si se repite aun después de cambiar el cartucho, la bomba puede estar defectuosa: contacta con el fabricante.',
      'Mídete la glucosa y comprueba cetonas si está alta.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['obstruido', 'atasco', 'no pasa insulina', 'bloqueo', 'acodado'],
  ),
  Alarma(
    id: 'reservorio_bajo',
    bomba: '',
    titulo: 'Insulina baja en el reservorio',
    significado:
        'Queda poca insulina en el cartucho. Es un aviso preventivo: la bomba '
        'sigue administrando con normalidad.',
    queHacer: [
      'Prepara un reservorio nuevo y ten insulina a mano.',
      'Planifica el recambio antes de que se vacíe del todo.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['poca insulina', 'queda poco', 'cartucho bajo'],
  ),
  Alarma(
    id: 'reservorio_vacio',
    bomba: '',
    titulo: 'Reservorio vacío',
    significado:
        'No queda insulina. La bomba ha dejado de administrar, incluida la basal.',
    queHacer: [
      'Cambia el reservorio cuanto antes.',
      'Mídete la glucosa: llevas tiempo sin basal.',
      'Si no puedes cambiarlo ya, usa una pluma de respaldo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin insulina', 'cartucho vacio', 'se acabo'],
  ),
  Alarma(
    id: 'bateria_baja',
    bomba: '',
    titulo: 'Batería baja',
    significado: 'Queda poca carga. La bomba sigue funcionando con normalidad.',
    queHacer: [
      'Carga la bomba o ten una pila de repuesto preparada.',
      'No dejes que se agote: si se apaga, dejas de recibir basal.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['pila baja', 'poca bateria', 'cargar'],
  ),
  Alarma(
    id: 'bateria_agotada',
    bomba: '',
    titulo: 'Batería agotada / Sustituir pila',
    significado:
        'La bomba se apagará o ya se ha apagado, y no está administrando insulina.',
    queHacer: [
      'Sustituye la pila o conecta el cargador inmediatamente.',
      'Al reiniciar, comprueba que la hora y la basal son correctas.',
      'Mídete la glucosa para saber cuánto tiempo has estado sin insulina.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin bateria', 'apagada', 'no enciende'],
  ),
  Alarma(
    id: 'bomba_detenida',
    bomba: '',
    titulo: 'Administración detenida / Bomba parada',
    significado:
        'La bomba no está administrando insulina, por una parada manual o por un error.',
    queHacer: [
      'Comprueba en pantalla el motivo de la parada.',
      'Reanuda la administración si el motivo ya está resuelto.',
      'Mídete la glucosa: sin basal, sube rápido.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['parada', 'suspendida', 'no administra', 'stop'],
  ),
  Alarma(
    id: 'temperatura',
    bomba: '',
    titulo: 'Temperatura fuera de rango',
    significado:
        'La bomba está demasiado fría o demasiado caliente para funcionar con '
        'seguridad. La insulina también se degrada con el calor.',
    queHacer: [
      'Aleja el dispositivo de fuentes de calor o frío directo.',
      'Espera a que vuelva a temperatura ambiente.',
      'Si ha estado expuesta mucho tiempo, sustituye la insulina: puede haber perdido efecto.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['calor', 'frio', 'sol', 'playa'],
  ),
  Alarma(
    id: 'cateter_sin_llenar',
    bomba: '',
    titulo: 'Cánula sin llenar',
    significado:
        'Has terminado el recambio pero no se ha completado el llenado de la '
        'cánula, así que hay aire en el tramo final y no está entrando insulina.',
    queHacer: [
      'Ejecuta "Llenar cánula" con las unidades que indique la guía de tu catéter (normalmente entre 0,1 y 1,0 U).',
      'Excepción: los equipos con aguja de acero (Sure-T, TruSteel, Orbit micro) NO tienen cánula y no se llenan.',
      'No dejes la bomba parada en la pantalla de llenado de cánula: mientras esté ahí, la insulina está suspendida.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['cebar', 'purgar', 'llenar canula', 'aire'],
  ),

  // ---------------- MEDTRONIC ----------------
  Alarma(
    id: 'suspension_nivel_bajo',
    bomba: 'bmedtronic',
    titulo: 'Suspensión por nivel bajo',
    significado:
        'El sensor ha detectado glucosa baja y la bomba ha suspendido '
        'automáticamente la administración de basal.',
    queHacer: [
      'Confirma con una glucemia capilar.',
      'Trata la hipoglucemia si se confirma.',
      'La basal se reanuda sola al recuperarte; también puedes reanudarla manualmente.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hipo', 'suspension', 'smartguard', 'parada por baja'],
  ),
  Alarma(
    id: 'suspension_antes_bajo',
    bomba: 'bmedtronic',
    titulo: 'Suspensión antes de nivel bajo',
    significado:
        'El sensor predice que vas a bajar y la bomba ha suspendido la basal '
        'de forma preventiva.',
    queHacer: [
      'Confirma con glucemia capilar.',
      'No hace falta tomar hidratos si aún estás en rango: la suspensión es preventiva.',
      'Vigila la evolución los siguientes 30 minutos.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['prediccion', 'preventiva', 'smartguard'],
  ),
  Alarma(
    id: 'salida_modo_auto',
    bomba: 'bmedtronic',
    titulo: 'Salida del modo automático',
    significado:
        'La bomba ha vuelto a modo manual, normalmente por falta de lecturas '
        'del sensor o porque lleva demasiado tiempo administrando la basal '
        'máxima o mínima.',
    queHacer: [
      'Comprueba que el sensor está dando lecturas.',
      'Sigue las indicaciones de la pantalla para volver a modo automático.',
      'Mientras estés en manual, vigila más de cerca tu glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['modo manual', 'smartguard', 'automatico', 'auto mode'],
  ),
  Alarma(
    id: 'error_carga',
    bomba: 'bmedtronic',
    titulo: 'Error de carga / Error de administración',
    significado:
        'La bomba no ha podido completar la carga del reservorio o el '
        'movimiento del pistón.',
    queHacer: [
      'Retira el reservorio y repite "Nueva configuración" desde el principio.',
      'Comprueba que el reservorio está bien encajado y girado hasta el tope.',
      'Si el error se repite, llama al soporte del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['error carga', 'piston', 'rebobinar'],
  ),

  // ---------------- OMNIPOD ----------------
  Alarma(
    id: 'pod_caducado',
    bomba: 'bomnipod',
    titulo: 'Pod caducado',
    significado:
        'El Pod ha superado su vida útil y ha dejado de administrar insulina.',
    queHacer: [
      'INFORMACIÓN DEL POD → VER DETALLES DEL POD → CAMBIAR EL POD → DESACTIVAR POD.',
      'Despega despacio los bordes del adhesivo y retira el Pod.',
      'No apliques el Pod nuevo hasta haber desactivado y retirado el viejo.',
      'Mídete la glucosa: llevas tiempo sin basal.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['caducado', 'expirado', 'pod viejo'],
  ),
  Alarma(
    id: 'pod_error',
    bomba: 'bomnipod',
    titulo: 'Error del Pod / Alarma de peligro',
    significado:
        'El Pod ha detectado un fallo interno y ha detenido la administración. '
        'Suele ir acompañado de un pitido continuo.',
    queHacer: [
      'Desactiva el Pod desde el Controlador y retíralo de la piel.',
      'Coloca un Pod nuevo.',
      'Guarda el Pod defectuoso: el soporte puede pedírtelo.',
      'Mídete la glucosa y comprueba cetonas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['pitido', 'alarma continua', 'fallo pod'],
  ),
  Alarma(
    id: 'pod_desactivar',
    bomba: 'bomnipod',
    titulo: 'No se puede desactivar el Pod',
    significado:
        'El Controlador no consigue comunicarse con el Pod para desactivarlo.',
    queHacer: [
      'Acerca el Controlador al Pod para que puedan comunicarse.',
      'Si sigue sin desactivarse, usa la opción de descartar el Pod del Controlador.',
      'Retira el Pod de la piel manualmente y ponte uno nuevo.',
      'Recuerda que el Pod y el sensor deben ir en el mismo lado del cuerpo para verse entre sí.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['no desactiva', 'no se apaga', 'quitar pod'],
  ),
  Alarma(
    id: 'pod_comunicacion',
    bomba: 'bomnipod',
    titulo: 'Sin comunicación con el Pod',
    significado:
        'El Controlador no encuentra el Pod. El Pod sigue administrando la '
        'basal que tenía programada.',
    queHacer: [
      'Acerca el Controlador al Pod.',
      'Aléjate de fuentes de interferencia.',
      'Si no se recupera, el Pod seguirá con su última basal: planifica el recambio.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['sin señal pod', 'no conecta', 'fuera de alcance'],
  ),

  // ---------------- YPSOPUMP ----------------
  Alarma(
    id: 'cartucho_vacio_ypso',
    bomba: 'bypsopump',
    titulo: 'Cartucho vacío',
    significado:
        'La YpsoPump ha llegado al final del cartucho y ha detenido la administración.',
    queHacer: [
      'Sustituye el cartucho siguiendo el proceso de recambio.',
      'Recuerda cebar el catéter tras poner el cartucho nuevo.',
      'Mídete la glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho', 'vacio', 'sin insulina'],
  ),

  // ---------------- YPSOPUMP (manual cap. 8) ----------------
  Alarma(
    id: 'varilla_no_retraida',
    bomba: 'bypsopump',
    titulo: 'Retracción de la varilla roscada no finalizada',
    significado:
        'Has insertado el cartucho antes de que la varilla roscada terminara '
        'de retraerse y de que la bomba completara su autocomprobación.',
    queHacer: [
      'Repite el proceso de cambio de cartucho desde el principio.',
      'Espera a que el porcentaje baje al 0 % y termine la autocomprobación antes de insertar el cartucho.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['varilla', 'roscada', 'retraccion', 'cartucho antes'],
  ),
  Alarma(
    id: 'cebado_no_finalizado',
    bomba: 'bypsopump',
    titulo: 'No hay insulina / Cebado no finalizado',
    significado:
        'Tras retraer la varilla roscada no se ha realizado ningún cebado en '
        '5 minutos, o el cebado ha fallado. La bomba no está administrando.',
    queHacer: [
      'Confirma la alarma.',
      'Inserta un cartucho y realiza el cebado del tubo.',
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
        'La bomba llevaba 24 horas en modo operativo sin usarse y ha pasado '
        'sola a modo de parada. Se han cancelado todas las administraciones '
        'en curso.',
    queHacer: [
      'Confirma la alarma y vuelve a poner la bomba en modo operativo.',
      'Comprueba tu glucosa: has estado sin basal.',
      'Revisa si tenías un bolo o una basal temporal en marcha, porque se han cancelado.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['parada', 'automatica', '24 horas', 'se paro sola'],
  ),
  Alarma(
    id: 'error_electronico',
    bomba: 'bypsopump',
    titulo: 'Error electrónico',
    significado:
        'La bomba ha detectado un fallo interno de funcionamiento. Todas sus '
        'funciones quedan canceladas.',
    queHacer: [
      'Desconéctate el kit de infusión del cuerpo.',
      'Extrae la pila alcalina y pulsa el botón de función durante 2 segundos: la bomba pasa a estado de almacenamiento.',
      'Vuelve a ponerla en marcha y comprueba todos tus ajustes de terapia.',
      'Cambia el cartucho y el kit de infusión.',
      'Si el error vuelve a aparecer, deja de usar la bomba, saca la pila y llama al fabricante.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['error', 'electronico', 'fallo interno', 'no funciona'],
  ),
  Alarma(
    id: 'bateria_no_apta',
    bomba: 'bypsopump',
    titulo: 'Batería no apta',
    significado:
        'La pila que has insertado tiene un voltaje excesivo para la bomba.',
    queHacer: [
      'Confirma la alarma y extrae la pila.',
      'Inserta una pila alcalina AAA (LR03) nueva.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['pila', 'voltaje', 'no apta', 'incorrecta'],
  ),
  Alarma(
    id: 'sin_bateria_ypso',
    bomba: 'bypsopump',
    titulo: 'No hay batería',
    significado:
        'La pila alcalina lleva fuera del compartimento más de 5 minutos con '
        'la bomba en modo operativo.',
    queHacer: [
      'Confirma la alarma e inserta una pila alcalina AAA (LR03) nueva.',
      'Comprueba tu glucosa: puedes haber estado sin basal.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin pila', 'pila fuera', 'sin bateria'],
  ),

  // ---------------- TANDEM ----------------
  Alarma(
    id: 'reinicio_bomba',
    bomba: 'btandem',
    titulo: 'Reinicio de la bomba',
    significado:
        'La bomba se ha reiniciado tras un error de software. Algunos ajustes '
        'pueden requerir confirmación.',
    queHacer: [
      'Comprueba que la hora y la fecha son correctas.',
      'Revisa que tu perfil basal sigue activo.',
      'Comprueba la insulina activa: puede haberse perdido el registro.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['reinicio', 'se reinicio', 'error software'],
  ),

  // ---------------- SENSORES ----------------
  Alarma(
    id: 'senal_perdida',
    bomba: '',
    titulo: 'Pérdida de señal del sensor',
    significado:
        'El dispositivo no recibe lecturas del sensor. La bomba sigue '
        'administrando tu basal, pero sin ajuste automático.',
    queHacer: [
      'Acerca el receptor o el móvil al sensor.',
      'Comprueba que el transmisor está bien encajado, si tu modelo lo lleva.',
      'Reinicia el Bluetooth del dispositivo y espera 15 minutos.',
      'Mide con glucemia capilar mientras no haya lecturas.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['no conecta', 'sin señal', 'bluetooth', 'sin lecturas'],
  ),
  Alarma(
    id: 'sensor_caducado',
    bomba: '',
    titulo: 'Sensor caducado / Cambiar sensor',
    significado:
        'El sensor ha llegado al final de su vida útil y ha dejado de medir.',
    queHacer: [
      'Retira el sensor y coloca uno nuevo.',
      'Consulta la guía de recambio de sensor de esta app.',
      'Recuerda que hay un periodo de calentamiento antes de las primeras lecturas.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['caducado', 'expirado', 'fin de vida', 'cambiar sensor'],
  ),
  Alarma(
    id: 'sensor_calibrar',
    bomba: '',
    titulo: 'Calibrar ahora',
    significado:
        'El sensor necesita una glucemia capilar de referencia para seguir '
        'dando lecturas fiables.',
    queHacer: [
      'Lávate y sécate bien las manos antes de pincharte.',
      'Introduce el valor capilar en cuanto lo obtengas.',
      'No calibres si tu glucosa está cambiando rápido: espera a un momento estable.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['calibracion', 'calibrar', 'capilar', 'referencia'],
  ),
  Alarma(
    id: 'sensor_actualizando',
    bomba: '',
    titulo: 'Sensor actualizando / Calentamiento',
    significado:
        'El sensor recién insertado se está estabilizando y todavía no da lecturas.',
    queHacer: [
      'Espera el tiempo de calentamiento de tu modelo: de 30 minutos a 2 horas.',
      'Mide con glucemia capilar mientras tanto.',
      'Si al terminar sigue sin dar lecturas, revisa el emparejamiento.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['calentamiento', 'iniciando', 'sin lecturas aun'],
  ),
  Alarma(
    id: 'glucosa_alta',
    bomba: '',
    titulo: 'Alerta de glucosa alta',
    significado:
        'El sensor ha detectado un valor por encima de tu umbral configurado.',
    queHacer: [
      'Confirma con glucemia capilar.',
      'Comprueba cetonas si el valor es muy alto o lleva tiempo sin bajar.',
      'Revisa el catéter: una hiperglucemia inexplicada suele ser un fallo de infusión.',
      'Corrige según las pautas de tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hiper', 'alta', 'hiperglucemia', 'subida'],
  ),
  Alarma(
    id: 'glucosa_baja',
    bomba: '',
    titulo: 'Alerta de glucosa baja',
    significado:
        'El sensor ha detectado un valor por debajo de tu umbral configurado.',
    queHacer: [
      'Confirma con glucemia capilar si puedes, pero no retrases el tratamiento.',
      'Toma hidratos de acción rápida según la pauta de tu equipo médico.',
      'Vuelve a medir a los 15 minutos.',
      'Si pierdes la consciencia o no puedes tragar, es una urgencia: glucagón y 112.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'hipoglucemia', 'bajada'],
  ),
];
