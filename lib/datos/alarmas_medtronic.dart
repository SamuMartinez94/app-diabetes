/// ALARMAS Y AVISOS DE MEDTRONIC MINIMED 780G
///
/// Fuente: guía del usuario del sistema MiniMed 780G: capítulo 15 (resolución
/// de problemas) y apéndice A (lista de alarmas, alertas y mensajes de la
/// bomba, de los sensores y de SmartGuard). Las páginas son las impresas en
/// el manual. Los avisos de los sensores Simplera Sync y Guardian 4 salen de
/// las tablas del propio sistema 780G.
library;

import '../modelos/alarma.dart';

const _manual = 'MiniMed 780G';
const _sensoresMedtronic = ['ssimplera', 'sguardian'];

const List<Alarma> alarmasMedtronic = [
  // ---------------- BOMBA ----------------
  Alarma(
    id: 'mm_flujo_bloqueado',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '307-308',
    titulo: 'Flujo de insulina bloqueado',
    significado:
        'La bomba ha detectado que la insulina no pasa: puede ser un bloqueo '
        'en el catéter, que el reservorio esté vacío o un fallo al llenar el '
        'tubo o la cánula.',
    queHacer: [
      'Mide tu glucosa y comprueba las cetonas; si hace falta, usa la pluma de respaldo como te haya indicado tu equipo médico.',
      'Quita el catéter y el reservorio.',
      'En el menú elige Reservorio y equipo y empieza de nuevo con un catéter y un reservorio nuevos.',
      'Si saltó durante un bolo, mira en el Historial diario cuánto se llegó a poner antes de la alarma.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: [
      'oclusion',
      'bloqueo',
      'obstruido',
      'no pasa insulina',
      'flujo bloqueado',
      'reservorio vacio',
    ],
  ),
  Alarma(
    id: 'mm_pila_baja',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '309',
    titulo: 'Pila baja',
    significado:
        'A la pila AA le quedan 10 horas o menos. La bomba sigue '
        'funcionando con normalidad.',
    queHacer: [
      'Pulsa OK.',
      'Cambia la pila AA lo antes posible; si no, la insulina se detendrá.',
      'Si la bomba está poniendo un bolo o llenando la cánula, espera a que termine antes de cambiarla.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['pila baja', 'poca bateria', 'pila', 'bateria baja'],
  ),
  Alarma(
    id: 'mm_pila_agotada',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '303, 313',
    titulo: 'Pila agotada: cámbiala ya',
    significado:
        'A la pila le queda menos de media hora o ya se ha agotado, y la '
        'bomba ha dejado de dar insulina.',
    queHacer: [
      'Pulsa OK.',
      'Quita la pila vieja y pon una pila AA nueva de inmediato para reanudar la insulina.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin pila', 'pila agotada', 'apagada', 'no enciende'],
  ),
  Alarma(
    id: 'mm_sin_pila',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '304, 306, 311',
    titulo: 'Sin pila o pila no compatible',
    significado:
        'Has quitado la pila, o la que has puesto no es compatible. La bomba '
        'ha dejado de dar insulina y se apaga a los 10 minutos si no pones '
        'otra. Si pasan más de 10 minutos sin pila, pierde la hora y la '
        'fecha.',
    queHacer: [
      'Pon una pila AA nueva: la alarma se apaga sola.',
      'Si la pila no es compatible, quítala y pon otra AA.',
      'Si te sale "¿Reanudar bolo?", mira cuánto del bolo se puso y elige Reanudar o Cancelar.',
      'Si la bomba ha perdido la hora, pulsa OK e introduce la hora y la fecha.',
      'Mide tu glucosa para saber cuánto tiempo has estado sin insulina.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: [
      'insertar pila',
      'pila no compatible',
      'hora perdida',
      'sin bateria',
    ],
  ),
  Alarma(
    id: 'mm_error_bomba',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '286, 304, 311-313',
    titulo: 'Error de la bomba',
    significado:
        'La bomba ha tenido un error y tiene que reiniciarse. Según el caso '
        'conserva tus ajustes o vuelve a los valores de fábrica.',
    queHacer: [
      'Pulsa OK para reiniciar la bomba.',
      'Cuando reinicie, sigue las instrucciones de la pantalla y revisa que tus ajustes son los tuyos; si tenías una copia guardada, usa Restaurar ajustes.',
      'Si estaba poniendo un bolo o llenando la cánula, mira el Historial diario y valora si necesitas insulina.',
      'Si se repite a menudo, anota el código de error de la pantalla y llama al soporte técnico de 24 horas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: [
      'error',
      'reinicio',
      'ajustes borrados',
      'revisar ajustes',
      'restaurar ajustes',
    ],
  ),
  Alarma(
    id: 'mm_error_critico',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '284, 304-305',
    titulo: 'Error crítico de la bomba',
    significado:
        'La bomba tiene un fallo que no se puede resolver (por ejemplo, un '
        'problema mecánico) y no puede dar insulina. Suena la sirena.',
    queHacer: [
      'Desconecta el equipo de infusión de tu cuerpo y deja de usar la bomba.',
      'Usa otra forma de dar la insulina (pluma) como te haya indicado tu equipo médico.',
      'Mide tu glucosa y trátala si hace falta.',
      'Anota el código de error de la pantalla y llama al soporte técnico de 24 horas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['critico', 'sirena', 'no funciona', 'averia', 'fallo grave'],
  ),
  Alarma(
    id: 'mm_limite_entrega',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '305',
    titulo: 'Límite de entrega superado',
    significado:
        'La bomba ha parado la insulina porque se ha alcanzado el límite por '
        'hora (según tu bolo máximo y tu basal máxima). Si saltó durante un '
        'bolo, ese bolo se cancela.',
    queHacer: [
      'Mide tu glucosa.',
      'Elige Reanudar basal.',
      'Mira el Historial de bolos y vuelve a valorar tus necesidades de insulina.',
      'Sigue vigilando tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['limite', 'entrega detenida', 'bolo maximo', 'basal maxima'],
  ),
  Alarma(
    id: 'mm_suspension_auto',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '303',
    titulo: 'Suspensión automática',
    significado:
        'La bomba ha parado la insulina porque no has pulsado ningún botón '
        'durante el tiempo que configuraste.',
    queHacer: [
      'Elige Reanudar basal para apagar la alarma y volver a dar insulina.',
      'Mide tu glucosa y trátala si hace falta.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['auto suspend', 'suspendida', 'parada', 'sin tocar'],
  ),
  Alarma(
    id: 'mm_insulina_activa',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '284-285, 302-303',
    titulo: 'Insulina activa a cero',
    significado:
        'La bomba muestra 0 de insulina activa porque la has borrado o '
        'porque se ha reiniciado. La insulina anterior ya no cuenta en los '
        'cálculos del asistente de bolo.',
    queHacer: [
      'Pulsa OK.',
      'Antes de ponerte un bolo, mira en el Historial diario cuándo y cuánto te has puesto.',
      'No te fíes de la insulina activa que muestre la bomba hasta que tu equipo médico te diga cuánto esperar: podrías ponerte demasiada.',
      'Mide tu glucosa y trátala si hace falta.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['insulina activa', 'iob', 'reset', 'asistente de bolo'],
  ),
  Alarma(
    id: 'mm_bolo_interrumpido',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '306, 309, 313-315',
    titulo: 'Bolo interrumpido o no entregado',
    significado:
        'Un bolo se ha cancelado: pasaron 30 segundos sin confirmarlo, se '
        'quedó sin pila o la bomba tuvo un error durante la entrega.',
    queHacer: [
      'Pulsa OK y mira en el mensaje cuánto del bolo se llegó a poner.',
      'Si te sale "¿Reanudar bolo?", elige Reanudar para terminarlo o Cancelar. Solo se puede reanudar dentro de los 10 minutos siguientes.',
      'Si querías ponerte el bolo, mide tu glucosa y vuelve a programarlo.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['bolo cancelado', 'bolo no entregado', 'reanudar bolo'],
  ),
  Alarma(
    id: 'mm_reservorio_bajo',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '309, 314',
    titulo: 'Queda poca insulina en el reservorio',
    significado:
        'El reservorio está bajo según el aviso que configuraste, o el nivel '
        'estimado ha llegado a cero.',
    queHacer: [
      'Pulsa OK.',
      'Cambia el reservorio pronto. Si no lo cambias, saltará un segundo aviso cuando quede la mitad de lo previsto.',
      'Cuando vayas a cambiarlo, en el menú elige Reservorio y equipo.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['poca insulina', 'reservorio bajo', 'queda poco', 'reservorio'],
  ),
  Alarma(
    id: 'mm_sin_reservorio',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '311',
    titulo: 'No se detecta el reservorio',
    significado: 'No hay reservorio en la bomba o no está bien encajado.',
    queHacer: [
      'Comprueba que el reservorio está lleno de insulina.',
      'Elige Reservorio y equipo y, cuando te lo pida, confirma que está bien puesto y bloqueado.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['sin reservorio', 'reservorio mal puesto', 'no detecta'],
  ),
  Alarma(
    id: 'mm_carga_incompleta',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '306, 308-310, 314',
    titulo: 'Carga del reservorio incompleta o llenado de más',
    significado:
        'La bomba no ha terminado de cargar el reservorio, o de llenar el '
        'tubo o la cánula: ha pasado la cantidad esperada sin ver insulina, '
        'o ha habido un error al rebobinar. La pantalla ¿Llenar cánula? '
        'también avisa si lleva 15 minutos abierta.',
    queHacer: [
      'Si te pregunta si ves gotas en la punta del tubo, elige Sí si las ves y No si no.',
      'Si no hay gotas: quita el reservorio, mira que aún tenga insulina, comprueba que el tubo no está doblado y repite Reservorio y equipo.',
      'Si te pregunta por la cánula, elige Llenar (con la cantidad que indica la caja de tu catéter) o Hecho si tu catéter no necesita llenarla.',
      'Si vuelve a saltar, cambia el catéter. Si se repite a menudo, llama al soporte técnico de 24 horas.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'cebar',
      'llenar canula',
      'gotas',
      'carga incompleta',
      'rebobinar',
      'llenado',
    ],
  ),
  Alarma(
    id: 'mm_boton_atascado',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '285, 315',
    titulo: 'Botón atascado',
    significado:
        'La bomba ha detectado un botón pulsado durante más de 3 minutos. '
        'En un avión, el cambio de presión puede atascar los botones hasta '
        '45 minutos.',
    queHacer: [
      'Pulsa OK para apagar la alarma.',
      'En un avión, espera a que se arregle sola, o quita la tapa de la pila y vuelve a ponerla.',
      'Si vuelve a saltar, llama al soporte técnico de 24 horas.',
      'Si no puedes quitar la alarma, piensa en otra forma de dar la insulina: la bomba no está funcionando.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['boton', 'atascado', 'avion', 'pulsado'],
  ),
  Alarma(
    id: 'mm_basal_muy_alta',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '316, 330, 335',
    titulo: 'Basal demasiado alta',
    significado:
        'La bomba detecta que un patrón de basal en modo manual da mucha '
        'más insulina de la que sueles necesitar.',
    queHacer: [
      'Mide tu glucosa y trátala si hace falta.',
      'Revisa todos tus patrones de basal con tu equipo médico.',
      'Puedes posponer el aviso, pero volverá a salir si no se resuelve.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['basal alta', 'patron basal', 'demasiada insulina'],
  ),

  // ---------------- SUSPENSIÓN Y SMARTGUARD ----------------
  Alarma(
    id: 'mm_suspension_baja',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '317-318, 329-330',
    titulo: 'Insulina suspendida por glucosa baja',
    significado:
        'La bomba ha parado la insulina porque tu glucosa está en el límite '
        'bajo o se acerca a él (función Suspender antes de bajo o Suspender '
        'en bajo, en modo manual). La reanuda sola como mucho a las 2 horas.',
    queHacer: [
      'Pulsa OK.',
      'Mide tu glucosa y, si hace falta, trátala como te haya indicado tu equipo médico.',
      'Cuando la bomba reanude la insulina te lo avisa: vuelve a medir tu glucosa.',
      'Si a las 2 horas sigue por debajo del límite, la alarma sale de nuevo: vuelve a medir.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: [
      'suspension',
      'hipo',
      'suspender antes de bajo',
      'suspender en bajo',
      'parada por baja',
    ],
  ),
  Alarma(
    id: 'mm_emergencia',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '324',
    titulo: 'Pide ayuda de emergencia',
    significado:
        'La bomba está parada por glucosa baja y no has respondido a la '
        'alarma en 10 minutos. Puede ser una emergencia.',
    queHacer: [
      'Llama al 112 o pide ayuda de inmediato.',
      'Si estás en condiciones, toma hidratos de carbono de acción rápida.',
      'Toca Descartar cuando la situación esté controlada.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['emergencia', 'ayuda', '112', 'inconsciente', 'llamar'],
  ),
  Alarma(
    id: 'mm_smartguard_glucemia',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '331-333',
    titulo: 'SmartGuard pide una glucemia',
    significado:
        'SmartGuard necesita que introduzcas una glucemia (medida con el '
        'dedo): lleva mucho rato dando la insulina máxima o mínima, o tiene '
        'que comprobar que el sensor es fiable.',
    queHacer: [
      'Pulsa OK.',
      'Lávate las manos, mide con el medidor e introduce el valor para volver al modo automático.',
      'Sigue las indicaciones de tu equipo médico y vigila tu glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['smartguard', 'introducir glucemia', 'modo automatico', 'bg'],
  ),
  Alarma(
    id: 'mm_smartguard_salida',
    bomba: 'bmedtronic',
    manual: _manual,
    pagina: '333-335',
    titulo: 'Salida del modo automático (SmartGuard)',
    significado:
        'La bomba ha salido del modo automático porque se apagó el sensor, '
        'llevaba hasta cuatro horas sin lecturas o un aviso de suspensión '
        'no se atendió. Ahora sigue tu basal en modo manual.',
    queHacer: [
      'Introduce una glucemia medida con el dedo.',
      'Si la insulina sigue suspendida, reanuda la basal cuando corresponda.',
      'Revisa la lista de comprobación de SmartGuard para volver al modo automático.',
      'Mientras estés en manual, vigila más tu glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['smartguard', 'modo manual', 'automatico', 'salida'],
  ),

  // ---------------- SENSORES SIMPLERA SYNC Y GUARDIAN 4 ----------------
  Alarma(
    id: 'mm_senal_perdida',
    bomba: 'bmedtronic',
    sensores: _sensoresMedtronic,
    deSensor: true,
    manual: _manual,
    pagina: '287-288, 321, 325, 328',
    titulo: 'Se ha perdido la señal del sensor',
    significado:
        'Han pasado 30 minutos sin señal del sensor, o hay interferencias. '
        'Sin señal no tienes lecturas del sensor.',
    queHacer: [
      'Acerca la bomba al sensor (con Guardian 4, al transmisor) y pulsa OK. La bomba puede tardar hasta 15 minutos en encontrar la señal.',
      'Aléjate de aparatos electrónicos que puedan interferir.',
      'Con Guardian 4, comprueba que el transmisor y el sensor están bien conectados. Si no lo están, o el sensor no está bien insertado, cambia el sensor.',
      'Si no la encuentra en 15 minutos o sale "Señal del sensor no encontrada", llama al soporte técnico de 24 horas.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'no conecta',
      'sin senal',
      'interferencia',
      'comprobar conexion',
      'sin lecturas',
    ],
  ),
  Alarma(
    id: 'mm_cambiar_sensor',
    bomba: 'bmedtronic',
    sensores: _sensoresMedtronic,
    deSensor: true,
    manual: _manual,
    pagina: '319-320',
    titulo: 'Cambia el sensor',
    significado:
        'La bomba indica que el sensor no funciona bien y no se puede '
        'arreglar: puede haber fallado la calibración dos veces seguidas, el '
        'sensor puede no estar bien insertado o tener un problema.',
    queHacer: [
      'Pulsa OK.',
      'Quita el sensor y pon uno nuevo (mira la guía de cambio de sensor de esta app).',
      'Si el problema sigue con el sensor nuevo, llama al soporte técnico de 24 horas.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['cambiar sensor', 'sensor no funciona', 'sensor mal puesto'],
  ),
  Alarma(
    id: 'mm_calibracion',
    bomba: 'bmedtronic',
    sensores: _sensoresMedtronic,
    deSensor: true,
    manual: _manual,
    pagina: '288, 318-319, 321, 323-325',
    titulo: 'Calibración no aceptada o introduce una glucemia',
    significado:
        'El sistema usa cada glucemia que introduces para calibrar el '
        'sensor. No ha podido usar la última o te pide una nueva. Solo vale '
        'un valor entre 50 y 400 mg/dL.',
    queHacer: [
      'Lávate y sécate bien las manos y vuelve a medir con el dedo, esperando al menos 30 minutos desde la anterior.',
      'Comprueba que el valor era correcto: no debe diferir demasiado de la última lectura del sensor.',
      'Introdúcelo antes de la hora que indica la bomba, para no perder las lecturas.',
      'Si falla también la segunda vez, saldrá "Cambiar sensor".',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['calibrar', 'calibracion', 'introducir glucemia', 'medidor'],
  ),
  Alarma(
    id: 'mm_sensor_no_lee',
    bomba: 'bmedtronic',
    sensores: _sensoresMedtronic,
    deSensor: true,
    manual: _manual,
    pagina: '289, 327, 329, 331',
    titulo: 'Sensor calentando o actualizándose',
    significado:
        'Un sensor nuevo tarda un tiempo en dar lecturas (con Guardian 4, '
        'unas 2 horas). También puede haber una pausa temporal mientras el '
        'sensor hace comprobaciones de calidad: no hace falta cambiarlo.',
    queHacer: [
      'Pulsa OK y sigue las instrucciones de la pantalla.',
      'Espera: las lecturas pueden tardar hasta 3 horas en volver.',
      'Mientras tanto, usa el medidor de glucosa para decidir tu tratamiento.',
      'Si la bomba dice que no ha empezado el calentamiento y el sensor está puesto, cámbialo si han pasado más de 30 minutos.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: [
      'calentamiento',
      'actualizando',
      'sin lecturas',
      'iniciando',
      'warm up',
    ],
  ),
  Alarma(
    id: 'mm_fin_sensor',
    bomba: 'bmedtronic',
    sensores: _sensoresMedtronic,
    deSensor: true,
    manual: _manual,
    pagina: '322, 327-328, 330',
    titulo:
        'El sensor termina pronto, ha caducado o el transmisor no tiene batería',
    significado:
        'El sensor llega al final de su vida útil: Simplera Sync dura hasta '
        '6 días más 24 horas de gracia (en las que sigue funcionando igual) '
        'y Guardian 4, hasta 7 días. Con Guardian 4, el transmisor también '
        'avisa cuando hay que recargarlo.',
    queHacer: [
      'Pulsa OK.',
      'Ten un sensor de repuesto preparado y cámbialo cuando toque (mira la guía de cambio de sensor).',
      'Si tienes Guardian 4 y el transmisor avisa de batería baja, recárgalo lo antes posible: con la batería agotada no hay lecturas.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: [
      'sensor caducado',
      'fin de sensor',
      'periodo de gracia',
      'bateria transmisor',
      'recargar transmisor',
    ],
  ),
  Alarma(
    id: 'mm_glucosa_baja_64',
    bomba: 'bmedtronic',
    sensores: _sensoresMedtronic,
    deSensor: true,
    manual: _manual,
    pagina: '323',
    titulo: 'Glucosa baja: alarma que no se puede quitar',
    significado:
        'La lectura del sensor está por debajo de 64 mg/dL. Esta alarma es de '
        'fábrica: no se puede silenciar ni desactivar, y no suspende la '
        'insulina por sí sola.',
    queHacer: [
      'Mide tu glucosa y trátala como te haya indicado tu equipo médico.',
      'Pulsa OK para quitar la alarma.',
      'Si tú o quien cuidas tiene entre 7 y 13 años, no te fíes solo del sensor a estos niveles: confirma con el medidor.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'hipoglucemia', 'alarma baja', 'bajada'],
  ),
  Alarma(
    id: 'mm_avisos_glucosa',
    bomba: 'bmedtronic',
    sensores: _sensoresMedtronic,
    deSensor: true,
    manual: _manual,
    pagina: '316-317, 321, 326',
    titulo: 'Aviso de glucosa alta, baja o cambiando rápido',
    significado:
        'El sensor marca una glucosa en el límite (o cerca) de lo que '
        'configuraste, subiendo rápido, o por encima de 250 mg/dL durante '
        'más de 3 horas.',
    queHacer: [
      'Pulsa OK y mide tu glucosa.',
      'Si lleva más de 3 horas alta, revisa el catéter y comprueba las cetonas.',
      'Sigue las indicaciones de tu equipo médico y vigila tu glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hiper', 'alta', 'baja', 'subida rapida', 'alerta glucosa'],
  ),
];
