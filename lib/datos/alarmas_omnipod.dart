/// ALARMAS Y AVISOS DE OMNIPOD 5
///
/// Fuente: Guía técnica del usuario de Omnipod 5, edición para España
/// (Rev. 01, 2026-03-12), para el Controlador PDM-M001-G-MG:
/// cap. 13 (alarmas de peligro y de advertencia, págs. 176-190), cap. 21
/// (sensor FreeStyle Libre 2 Plus, págs. 328-341) y cap. 25 (alarmas del
/// Modo Automatizado, págs. 382-385). Los títulos son los textos que muestra
/// la Aplicación Omnipod 5. Las alarmas se repiten cada 15 minutos hasta que
/// se confirman.
library;

import '../modelos/alarma.dart';

const _manual = 'Omnipod 5 (guía técnica, España)';

/// Sensores cuyos avisos gestiona la propia Aplicación Omnipod 5. Con un
/// Dexcom, los avisos del sensor salen en la aplicación de Dexcom.
const _sensoresLibre = ['sfreelibre2plus'];

const List<Alarma> alarmasOmnipod = [
  // ---------------- ALARMAS DE PELIGRO: la insulina se detiene ----------------
  Alarma(
    id: 'pod_bloqueo',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '177',
    titulo: 'Obstrucción detectada',
    significado:
        'Se ha detectado una obstrucción (oclusión) por una cánula '
        'bloqueada, un fallo del Pod o una insulina antigua o inactiva, y se '
        'ha detenido la administración de insulina.',
    queHacer: [
      'Toca OK, DESACTIVAR POD AHORA.',
      'Cambia el Pod (mira la guía de cambio de Pod).',
      'Mide tu glucosa y sigue las pautas de tu equipo médico: sin insulina puede subir y aparecer cetoacidosis.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['oclusion', 'bloqueo', 'obstruccion', 'no pasa insulina', 'canula'],
  ),
  Alarma(
    id: 'pod_error',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '180',
    titulo: 'Error de Pod',
    significado:
        'El Pod ha detectado un error inesperado y ha detenido la '
        'administración de insulina.',
    queHacer: [
      'Toca OK, DESACTIVAR POD AHORA.',
      'Cambia el Pod. Si no tienes otro, usa otra forma de ponerte la insulina.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['fallo pod', 'error', 'alarma de peligro', 'pitido'],
  ),
  Alarma(
    id: 'pod_caducado',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '181, 186',
    titulo: 'Pod caducado',
    significado:
        'Primero es una alarma de advertencia: el Pod dejará de dar insulina '
        'pronto. Si no lo cambias, pasa a alarma de peligro: el Pod ha '
        'llegado al final de su vida y ha detenido la insulina.',
    queHacer: [
      'Si es la advertencia: toca OK y cambia el Pod.',
      'Si ya es la alarma de peligro: toca OK, DESACTIVAR POD AHORA y cambia el Pod.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['caducado', 'expirado', 'pod viejo', 'fin de vida'],
  ),
  Alarma(
    id: 'pod_sin_insulina',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '182, 185',
    titulo: 'Pod con insulina baja / Pod sin insulina',
    significado:
        'Con "Pod con insulina baja" (advertencia) queda menos insulina de '
        'la que tienes configurada en los ajustes. Si no lo cambias, pasa a '
        '"Pod sin insulina" (peligro): el depósito está vacío y se ha '
        'detenido la insulina.',
    queHacer: [
      'Si es la advertencia: toca OK y cambia el Pod.',
      'Si ya es la alarma de peligro: toca OK, DESACTIVAR POD AHORA y cambia el Pod.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['poca insulina', 'vacio', 'sin insulina', 'insulina baja'],
  ),
  Alarma(
    id: 'pod_apagado',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '183, 187',
    titulo: 'Apagado del Pod',
    significado:
        'Tienes configurada una hora de apagado del Pod. Primero salta una '
        'advertencia; si no respondes, el Pod deja de administrar insulina '
        '(alarma de peligro).',
    queHacer: [
      'Si es la advertencia: toca SIGUIENTE para reiniciar el temporizador de apagado.',
      'Si ya es la alarma de peligro: toca OK, DESACTIVAR POD AHORA y cambia el Pod.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['apagado', 'hora de apagado', 'pod apagado', 'sin respuesta'],
  ),
  Alarma(
    id: 'pod_error_app',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '178',
    titulo: 'Error de la Aplicación Omnipod 5',
    significado:
        'Se ha detectado un error inesperado en la Aplicación Omnipod 5. A '
        'veces la aplicación se cierra y se vuelve a abrir sola.',
    queHacer: [
      'Toca OK para confirmar o silenciar la alarma. Puede que el Controlador se reinicie: sigue igualmente con el paso siguiente.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['error aplicacion', 'controlador', 'reinicio', 'se cierra'],
  ),
  Alarma(
    id: 'pod_memoria',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '179',
    titulo: 'Corrupción de memoria de Omnipod 5',
    significado:
        'Se ha detectado un error inesperado en la Aplicación Omnipod 5 que '
        'obliga a restablecerla.',
    queHacer: [
      'Toca OK para confirmar la alarma y restablecer la Aplicación Omnipod 5.',
      'Quita el Pod.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['memoria', 'corrupcion', 'restablecer', 'controlador'],
  ),
  Alarma(
    id: 'pod_error_sistema',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '184',
    titulo: 'Error del sistema',
    significado:
        'Se ha detectado un error inesperado en el Pod o en la Aplicación '
        'Omnipod 5.',
    queHacer: [
      'Toca OK para confirmar la alarma.',
      'Quita el Pod.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['error', 'sistema', 'fallo'],
  ),

  // ---------------- ALARMAS DE ADVERTENCIA ----------------
  Alarma(
    id: 'pod_reiniciar_insulina',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '188',
    titulo: 'Iniciar insulina',
    significado:
        'Ha terminado el tiempo de pausa de la insulina que elegiste. En '
        'Modo Manual la insulina NO vuelve sola después de una pausa.',
    queHacer: [
      'Para volver a tu Programa Basal, toca INICIAR INSULINA.',
      'Si quieres seguir en pausa, toca RECORDÁRMELO EN 15 MINUTOS.',
      'Sin insulina la glucosa sube: no dejes la pausa más tiempo del necesario.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['pausa', 'iniciar insulina', 'reanudar', 'parada'],
  ),
  Alarma(
    id: 'pod_glucosa_baja_urgente',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '189-190',
    titulo: 'Glucosa baja urgente',
    significado:
        'Tu glucosa del sensor es de 55 mg/dL o menos. Se repite mientras '
        'siga baja y no deja de sonar hasta que llega un valor de 56 mg/dL o '
        'más.',
    queHacer: [
      'Toca OK para confirmar la alarma.',
      'Confirma tu glucosa con el medidor y trata la bajada como te haya indicado tu equipo médico.',
      'Si pierdes el conocimiento o no puedes tragar, es una urgencia: glucagón y llama al 112.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'urgente', 'hipoglucemia', '55'],
  ),

  // ---------------- MODO AUTOMATIZADO ----------------
  Alarma(
    id: 'pod_modo_automatico',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '382-383',
    titulo: 'Restricción de administración automatizada',
    significado:
        'En Modo Automatizado, la insulina ha estado parada o al máximo '
        'durante demasiado tiempo.',
    queHacer: [
      'Toca SIGUIENTE y confirma tu glucosa con el medidor.',
      'Si la glucosa está baja, trátala. Si está alta, revisa el Pod y las cetonas. Si el sensor no marca lo esperado, puede que haya que cambiarlo.',
      'Toca SIGUIENTE, después CAMBIAR A MODO MANUAL, y quédate en Modo Manual al menos 5 minutos.',
      'Después puedes volver al Modo Automatizado si los valores del sensor son correctos.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['modo automatico', 'restriccion', 'automatizado limitado', 'insulina parada'],
  ),
  Alarma(
    id: 'pod_valores_no_recibidos',
    bomba: 'bomnipod',
    deSensor: true,
    manual: _manual,
    pagina: '384-385',
    titulo: 'Valores del sensor no recibidos',
    significado:
        'En Modo Automatizado, el Pod lleva más de una hora sin recibir '
        'valores del sensor. Sigue en "Modo Automatizado: Limitado" hasta '
        'que vuelvan los valores o cambies a Modo Manual.',
    queHacer: [
      'Toca OK para confirmar la alarma.',
      'Con Dexcom: mira en la app de Dexcom si hay valores o algún aviso del sensor o del transmisor.',
      'Con FreeStyle Libre 2 Plus: mira en la Aplicación Omnipod 5 si hay valores y que el sensor siga bien puesto en el brazo.',
      'Si pasa a menudo, lleva el Pod y el sensor en el mismo lado del cuerpo, separados al menos 8 cm (Dexcom) o 2,5 cm (Libre 2 Plus).',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['faltan valores', 'sin valores', 'sin señal', 'automatizado limitado'],
  ),

  // ---------------- SENSOR FREESTYLE LIBRE 2 PLUS ----------------
  Alarma(
    id: 'pod_libre_glucosa',
    bomba: 'bomnipod',
    sensores: _sensoresLibre,
    deSensor: true,
    manual: _manual,
    pagina: '328-329',
    titulo: 'Glucosa alta o glucosa baja',
    significado:
        'Alarma opcional del sensor: tu glucosa está por encima de tu ajuste '
        'de Glucosa alta o por debajo de tu ajuste de Glucosa baja. Se '
        'repite cada 5 minutos hasta que vuelve al ajuste o hasta que la '
        'confirmas.',
    queHacer: [
      'Confirma la alarma abriendo la notificación en el icono de la campana o descartándola en la pantalla de bloqueo.',
      'Comprueba tu glucosa con el medidor para confirmar el valor.',
      'Trata la glucosa alta o baja como te haya indicado tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['alta', 'baja', 'hiper', 'hipo', 'glucosa alta', 'glucosa baja'],
  ),
  Alarma(
    id: 'pod_libre_faltan_valores',
    bomba: 'bomnipod',
    sensores: _sensoresLibre,
    deSensor: true,
    manual: _manual,
    pagina: '330',
    titulo: 'Valores de glucosa del sensor no recibidos',
    significado:
        'Alarma opcional del sensor: no han llegado valores durante 20 '
        'minutos, por pérdida de señal o un problema del sensor. Mientras '
        'tanto no se te avisará de subidas ni bajadas. Se repite cada 5 '
        'minutos, hasta 5 veces.',
    queHacer: [
      'Confirma la alarma desde la notificación.',
      'Comprueba que el sensor sigue pegado a la piel.',
      'Lleva el Pod y el sensor en el mismo lado del cuerpo, para que se "vean" sin que el cuerpo tape la señal.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['sin valores', 'sin datos', 'sin señal', 'perdida de señal'],
  ),
  Alarma(
    id: 'pod_sensor',
    bomba: 'bomnipod',
    sensores: _sensoresLibre,
    deSensor: true,
    manual: _manual,
    pagina: '336-341',
    titulo: 'Mensajes del sensor en Omnipod 5',
    significado:
        'Mensajes en rojo del panel de la Aplicación Omnipod 5: "Sensor '
        'demasiado frío", "Sensor demasiado caliente", "Problema temporal del '
        'sensor", "Sensor finalizado", "Sin sensor", "Sustituir sensor" o '
        '"Error al conectar". Sin sensor, el Modo Automatizado no funciona.',
    queHacer: [
      'Demasiado frío o caliente: muévete a un sitio con otra temperatura y vuelve a probar en unos minutos.',
      'Problema temporal del sensor: espera y vuelve a comprobarlo en 10 minutos.',
      'Sensor finalizado o "Sustituir sensor": quita el sensor, pon uno nuevo y escanéalo con el Controlador para activarlo.',
      'Sin sensor: toca AÑADIR SENSOR, ponte el sensor y escanéalo.',
      'Error al conectar: vuelve a intentarlo; si sigue fallando, cambia el sensor.',
      'Si el problema continúa, llama a Atención al cliente.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'sensor',
      'demasiado frio',
      'demasiado caliente',
      'sensor finalizado',
      'sustituir sensor',
      'sin sensor',
      'error al conectar',
    ],
  ),
];
