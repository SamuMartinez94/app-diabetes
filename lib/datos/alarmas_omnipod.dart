/// ALARMAS Y AVISOS DE OMNIPOD 5
///
/// Fuente: guía del usuario del Sistema Automatizado de Administración de
/// Insulina Omnipod 5, sección "Alarmas y notificaciones" (páginas 40 a 43).
/// Es la guía resumida: describe cada alarma en pocas líneas. El manual dice
/// que las alarmas se repiten cada 15 minutos hasta que las reconozcas y que
/// las del Pod se reconocen en la aplicación.
library;

import '../modelos/alarma.dart';

const _manual = 'Omnipod 5';

const List<Alarma> alarmasOmnipod = [
  // ---------------- POD ----------------
  Alarma(
    id: 'pod_bloqueo',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '40',
    titulo: 'Bloqueo detectado en el Pod',
    significado:
        'El sistema ha detectado un bloqueo (oclusión) en la cánula del Pod '
        'y ha detenido la administración de insulina. Es una alarma de '
        'peligro.',
    queHacer: [
      'Quita el Pod.',
      'Mide tu glucosa y, si está alta, comprueba las cetonas.',
      'Pon un Pod nuevo (mira la guía de cambio de Pod).',
      'Reconoce la alarma en la aplicación.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['oclusion', 'bloqueo', 'no pasa insulina', 'canula', 'peligro'],
  ),
  Alarma(
    id: 'pod_error',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '40',
    titulo: 'Error del Pod',
    significado:
        'El sistema ha detectado un error del Pod y ha detenido la '
        'administración de insulina. Es una alarma de peligro.',
    queHacer: [
      'Quita el Pod.',
      'Pon un Pod nuevo.',
      'Mide tu glucosa y comprueba las cetonas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['fallo pod', 'error', 'alarma de peligro', 'pitido'],
  ),
  Alarma(
    id: 'pod_caducado',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '40-41',
    titulo: 'Pod caducado',
    significado:
        'El Pod ha llegado al final de su vida útil. Primero avisa una vez '
        'por hora (advertencia) y, si no lo cambias, deja de dar insulina '
        '(alarma de peligro).',
    queHacer: [
      'Cambia el Pod pronto: mira la guía de cambio de Pod de esta app.',
      'Si ya ha saltado la alarma de peligro, quita el Pod: ha dejado de dar insulina.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['caducado', 'expirado', 'pod viejo', 'fin de vida'],
  ),
  Alarma(
    id: 'pod_sin_insulina',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '40-41',
    titulo: 'El Pod se queda sin insulina',
    significado:
        'Con el aviso "Pod con insulina baja", la insulina del Pod está por '
        'debajo del valor que pusiste en Ajustes. Si lo ignoras, pasa a la '
        'alarma de peligro "Pod sin insulina": está vacío y la insulina se '
        'ha detenido.',
    queHacer: [
      'Si es el aviso, cambia el Pod pronto para que no llegue a la alarma de peligro.',
      'Si ya está vacío, quita el Pod y pon uno nuevo.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['poca insulina', 'vacio', 'sin insulina', 'insulina baja'],
  ),
  Alarma(
    id: 'pod_apagado',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '40-41',
    titulo: 'Apagado del Pod',
    significado:
        'Configuraste una hora de apagado del Pod. Antes de que llegue, la '
        'aplicación te avisa; si no respondes, el Pod deja de dar insulina '
        '(alarma de peligro).',
    queHacer: [
      'Si es el aviso, toca OK para reconocerlo y evitar que el Pod se apague.',
      'Si ya ha saltado la alarma de peligro, quita el Pod y pon uno nuevo.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['apagado', 'hora de apagado', 'pod apagado', 'sin respuesta'],
  ),
  Alarma(
    id: 'pod_reiniciar_insulina',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '41',
    titulo: 'Reinicia la insulina',
    significado: 'Ha terminado el tiempo que pusiste para pausar la insulina.',
    queHacer: [
      'Toca Iniciar la insulina para reanudarla y evitar la hiperglucemia.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['pausa', 'iniciar insulina', 'pausada', 'reanudar'],
  ),

  // ---------------- APLICACIÓN Y MODO AUTOMÁTICO ----------------
  Alarma(
    id: 'pod_error_app',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '40',
    titulo: 'Error de la aplicación Omnipod 5',
    significado:
        'El sistema ha detectado un error en la aplicación. En algunos casos '
        'el Controlador se reinicia y se borran todos los ajustes.',
    queHacer: [
      'Si el aviso dice que quites el Pod, quítalo y pon uno nuevo.',
      'Si el Controlador se reinicia y se borran los ajustes, vuelve a introducirlos con tu equipo médico.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['error aplicacion', 'controlador', 'memoria', 'reinicio'],
  ),
  Alarma(
    id: 'pod_glucosa_baja_urgente',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '41',
    titulo: 'Glucosa baja urgente',
    significado: 'La glucosa del sensor es de 55 mg/dL o menos.',
    queHacer: [
      'Considera comer hidratos de carbono de acción rápida para tratar la hipoglucemia.',
      'Mide tu glucosa.',
      'Si pierdes el conocimiento o no puedes tragar, es una urgencia: glucagón y llama al 112.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'urgente', 'hipoglucemia', '55'],
  ),
  Alarma(
    id: 'pod_modo_automatico',
    bomba: 'bomnipod',
    manual: _manual,
    pagina: '42',
    titulo: 'Aviso del modo automático',
    significado:
        'En modo automático, el Pod no ha recibido valores del sensor '
        'durante una hora, o el sistema no ve que tu glucosa cambie como '
        'esperaba y te pide que revises el sensor, el Pod y tu glucosa '
        '(avisos "Faltan los valores del sensor", "Revise la glucosa en '
        'sangre" o "Restricción de entrega automatizada").',
    queHacer: [
      'Comprueba el sensor y el Pod.',
      'Mide tu glucosa con el medidor.',
      'Si el aviso lo pide (Restricción de entrega automatizada), cambia a modo manual durante 5 minutos o más para reconocerlo.',
      'Sin valores del sensor, el sistema funciona en "Automatizado: Limitado" hasta que vuelvan a llegar.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'modo automatico',
      'automatizado limitado',
      'faltan valores',
      'revise glucosa',
      'restriccion',
    ],
  ),

  // ---------------- SENSOR ----------------
  Alarma(
    id: 'pod_sensor',
    bomba: 'bomnipod',
    deSensor: true,
    manual: _manual,
    pagina: '42-43',
    titulo: 'Mensajes del sensor en Omnipod 5',
    significado:
        'La aplicación te avisa si el sensor está demasiado frío o caliente, '
        'no puede enviar valores por un momento, tiene un error, ha '
        'terminado o hay que reemplazarlo, o no se ha podido conectar. Sin '
        'sensor, el modo automático no funciona.',
    queHacer: [
      'Demasiado frío o caliente: muévete a un sitio con una temperatura más suave.',
      'Problema temporal del sensor: vuelve a comprobarlo en 10 minutos.',
      'Sensor finalizado o "Reemplazar sensor": pon un sensor nuevo (mira la guía de cambio de sensor).',
      'No se pudo conectar: vuelve a intentarlo.',
      'Para usar el modo automático necesitas un sensor y un Pod activo.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'sensor',
      'demasiado frio',
      'demasiado caliente',
      'error del sensor',
      'reemplazar sensor',
      'sin sensor',
    ],
  ),
];
