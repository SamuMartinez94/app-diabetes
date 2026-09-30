/// ALARMAS Y AVISOS DE YPSOMED mylife YpsoPump
///
/// Fuente: guía del usuario de la mylife YpsoPump, capítulo 8 (localización y
/// resolución de errores: incidencias, advertencias y alarmas). Las páginas
/// son las impresas en el manual. Las advertencias no detienen la insulina;
/// las alarmas siempre la cancelan.
library;

import '../modelos/alarma.dart';

const _manual = 'mylife YpsoPump';

const List<Alarma> alarmasYpso = [
  // ---------------- ALARMAS: cancelan la insulina ----------------
  Alarma(
    id: 'ypso_oclusion',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '162-163',
    titulo: 'Oclusión (vía de infusión bloqueada)',
    significado:
        'La vía de infusión está bloqueada (adaptador, tubo o cánula). Al '
        'quitarse el bloqueo de golpe, podría entrar de golpe insulina en tu '
        'cuerpo, por eso hay que desconectarse.',
    queHacer: [
      'Confirma la alarma y desconecta el catéter de tu cuerpo.',
      'Cambia el catéter y llena el tubo (cebar) con la cantidad que indica su caja.',
      'Si el llenado termina sin que vuelva a saltar el bloqueo, ya puedes seguir con normalidad.',
      'Si el bloqueo salta otra vez al llenar el catéter nuevo, cambia también el cartucho y vuelve a llenar.',
      'Si sigue saltando aun con cartucho nuevo, la bomba está defectuosa: contacta con el servicio de atención al cliente.',
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
    id: 'cartucho_vacio_ypso',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '165',
    titulo: 'Cartucho vacío',
    significado:
        'A la YpsoPump se le ha acabado la insulina del cartucho y ha '
        'dejado de darte insulina.',
    queHacer: [
      'Confirma la alarma.',
      'Cambia el cartucho siguiendo la guía de cambio.',
      'Acuérdate de llenar el tubo (cebar) después de poner el cartucho nuevo.',
      'Mide tu glucosa.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho', 'vacio', 'sin insulina'],
  ),
  Alarma(
    id: 'cebado_no_finalizado',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '151, 164',
    titulo: 'No hay insulina / Falta llenar el tubo (cebado)',
    significado:
        'Después de retraer la varilla roscada pasaron 5 minutos sin llenar '
        'el tubo (cebar), o el llenado ha fallado o se ha cancelado. La '
        'bomba no te está dando insulina.',
    queHacer: [
      'Confirma la alarma.',
      'Pon un cartucho y llena el tubo (cebar).',
      'Comprueba que el cartucho está bien puesto y que el adaptador está bien conectado a la bomba.',
      'Repite hasta que salga insulina por el extremo y no queden burbujas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['no hay insulina', 'cebado', 'purgar', 'sin cebar'],
  ),
  Alarma(
    id: 'parada_automatica',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '166',
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
    manual: _manual,
    pagina: '167',
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
    id: 'sin_bateria_ypso',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '158',
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
  Alarma(
    id: 'bateria_no_apta',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '160',
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
    id: 'ypso_bateria_interna',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '161',
    titulo: 'Cargar la batería interna recargable',
    significado:
        'La batería interna recargable de la bomba se ha descargado por un '
        'uso intenso. Se cancelan las entregas en curso: bolos, basal '
        'temporal y basal.',
    queHacer: [
      'Confirma la alarma: la batería interna se carga con la pila alcalina que llevas puesta (unos 20 minutos).',
      'Después de confirmar, la bomba te avisa de los bolos y de la basal temporal que se han cancelado.',
      'Mide tu glucosa y vuelve a programar lo que necesites.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['bateria interna', 'recargable', 'uso intenso', 'cargar'],
  ),

  // ---------------- ADVERTENCIAS: no detienen la insulina ----------------
  Alarma(
    id: 'ypso_cartucho_bajo',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '148',
    titulo: 'Nivel de cartucho bajo',
    significado:
        'Es una advertencia: con lo que queda en el cartucho no llega para '
        'las próximas 12 horas de basal y el bolo en curso. Si no lo cambias, '
        'pasará a la alarma de cartucho vacío.',
    queHacer: [
      'Confirma la advertencia.',
      'Cambia el cartucho lo antes posible (mira la guía de cambio).',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['poca insulina', 'queda poco', 'cartucho bajo', 'advertencia'],
  ),
  Alarma(
    id: 'varilla_no_retraida',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '150',
    titulo: 'La varilla no ha terminado de retraerse',
    significado:
        'Es una advertencia: la varilla roscada no ha podido retraerse bien. '
        'Puede haber suciedad (arena, insulina seca) en el compartimento del '
        'cartucho, un fallo mecánico, o algo que ha tocado la varilla.',
    queHacer: [
      'Confirma la advertencia.',
      'Saca primero el cartucho y comprueba que no hay suciedad en el compartimento.',
      'No toques la varilla con ningún objeto y repite la retracción.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['varilla', 'roscada', 'retraccion', 'cartucho antes'],
  ),
  Alarma(
    id: 'ypso_bateria_baja',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '149, 159',
    titulo: 'Queda poca batería o batería vacía',
    significado:
        'Con la advertencia "Queda poca batería" aún puedes usar la bomba al '
        'menos dos días. Si no cambias la pila, pasa a la alarma "Batería '
        'vacía", que sí detiene la insulina.',
    queHacer: [
      'Confirma el aviso.',
      'Pon una pila alcalina AAA (LR03) nueva cuanto antes.',
      'Si ya es la alarma de batería vacía, mide tu glucosa: puede que hayas estado sin insulina de fondo.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['pila', 'bateria baja', 'bateria vacia', 'poca bateria'],
  ),
  Alarma(
    id: 'ypso_bomba_parada',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '154',
    titulo: 'Bomba parada más de una hora',
    significado:
        'Es una advertencia: la bomba lleva más de una hora en modo de '
        'parada, sin dar insulina.',
    queHacer: [
      'Confirma la advertencia.',
      'Si ya no quieres la bomba parada, ponla en marcha de nuevo.',
      'Mide tu glucosa: sin insulina de fondo, sube rápido.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['parada', 'stop', 'modo parada', 'una hora'],
  ),
  Alarma(
    id: 'ypso_bolo_cancelado',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '152-153',
    titulo: 'Bolo o basal temporal cancelados',
    significado:
        'Es una advertencia: un bolo o una basal temporal se han cancelado '
        'antes de tiempo por una alarma o porque pusiste la bomba en modo de '
        'parada, o la basal temporal ha terminado.',
    queHacer: [
      'Confirma la advertencia.',
      'Mira en los datos de terapia cuánta insulina se llegó a poner.',
      'Si quieres seguir con el bolo o con la basal temporal, tienes que volver a programarlos.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['bolo cancelado', 'basal temporal', 'cancelado'],
  ),
  Alarma(
    id: 'ypso_bluetooth',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '155',
    titulo: 'Error de conexión Bluetooth',
    significado:
        'Es una advertencia: pasaron más de 30 segundos al escribir el '
        'código de emparejamiento, lo escribiste mal, o se cortó una '
        'conexión Bluetooth activa.',
    queHacer: [
      'Confirma la advertencia.',
      'Vuelve a emparejar la bomba con el dispositivo.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['bluetooth', 'emparejar', 'codigo', 'conexion'],
  ),

  // ---------------- INCIDENCIAS ----------------
  Alarma(
    id: 'ypso_incidencias',
    bomba: 'bypsopump',
    manual: _manual,
    pagina: '142-146',
    titulo: 'Se ha caído, mojado o ensuciado la bomba',
    significado:
        'Una caída, agua en la pila o el cartucho, burbujas de aire o '
        'suciedad en el compartimento pueden alterar la administración de '
        'insulina, aunque no salte ninguna alarma.',
    queHacer: [
      'Mide tu glucosa y pon la bomba en modo de parada.',
      'Desconecta el catéter de tu cuerpo.',
      'Si hay agua: saca la pila o el cartucho y seca el compartimento con un paño de algodón seco. Si hay suciedad, quítala golpeando suavemente la bomba contra la palma de la mano (nunca contra una superficie dura) y limpia con un paño húmedo y luego seco.',
      'Después de una caída, cambia el cartucho y el catéter: puede haber microgrietas que no se ven.',
      'Si hay burbujas de aire, llena de nuevo el tubo sin burbujas desconectado de tu cuerpo.',
      'Si la bomba tiene daños visibles o no funciona, contacta con el servicio de atención al cliente.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['caida', 'agua', 'mojada', 'burbujas', 'suciedad', 'golpe'],
  ),
];
