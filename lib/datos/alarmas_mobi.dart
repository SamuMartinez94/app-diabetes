/// ALARMAS Y AVISOS DE TANDEM MOBI (con Control-IQ+)
///
/// Fuente: guía del usuario oficial del sistema Tandem Mobi con Control-IQ
/// 7.9 (edición española, 2026): capítulos 12 a 15 (alertas, alarmas y
/// fallo) y 30 (alertas de la tecnología Control-IQ+). Las páginas indicadas
/// son las impresas en el manual. La Mobi no tiene pantalla: los avisos salen
/// en la aplicación móvil Tandem Mobi y en las luces de estado de la bomba.
library;

import '../modelos/alarma.dart';

const _manual = 'Tandem Mobi';

const List<Alarma> alarmasMobi = [
  // ---------------- ALARMAS: la insulina se detiene ----------------
  Alarma(
    id: 'mobi_oclusion',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '195-196',
    titulo: 'Alarma de oclusión',
    significado:
        'La bomba ha detectado que la insulina no puede pasar y ha detenido '
        'todo el suministro. Las luces de la bomba parpadean en rojo.',
    queHacer: [
      'Pulsa Ignorar en la app.',
      'Revisa el cartucho, el tubo y el sitio de infusión por si hay daños o bloqueos, y corrígelo.',
      'Para reanudar la insulina: Acciones → Reanudar insulina.',
      'Si salta una segunda alarma de oclusión seguida, cambia el cartucho, el tubo y el sitio de infusión antes de reanudar la insulina.',
      'Si saltó durante un bolo, la app te dice cuánto se llegó a poner antes del bloqueo.',
      'Mide tu glucosa y sigue las indicaciones de tu equipo médico.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['oclusion', 'obstruido', 'atasco', 'no pasa insulina', 'bloqueo'],
  ),
  Alarma(
    id: 'mobi_cartucho_vacio',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '192',
    titulo: 'Alarma de cartucho vacío',
    significado:
        'El cartucho se ha quedado sin insulina y se han detenido todos los '
        'suministros. Se repite cada 3 minutos hasta que lo cambies.',
    queHacer: [
      'Pulsa Ignorar.',
      'Cambia el cartucho ya: Acciones → Cargar cartucho (mira la guía de cambio de esta app).',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho', 'vacio', 'sin insulina'],
  ),
  Alarma(
    id: 'mobi_error_cartucho',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '193',
    titulo: 'Alarma de error del cartucho',
    significado:
        'La bomba no ha podido usar el cartucho y ha detenido todos los '
        'suministros. Puede ser un cartucho defectuoso o que no se siguió '
        'bien el procedimiento de carga.',
    queHacer: [
      'Pulsa Ignorar.',
      'Cambia el cartucho ya: Acciones → Cargar cartucho y sigue los pasos.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho', 'error', 'no reconoce'],
  ),
  Alarma(
    id: 'mobi_bateria_agotada',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '191',
    titulo: 'Alarma de batería baja',
    significado:
        'A la bomba le queda un 1 % de batería o menos y se han detenido '
        'todos los suministros. Se repite cada 3 minutos hasta que se apague.',
    queHacer: [
      'Pulsa Ignorar.',
      'Carga la bomba de inmediato para reanudar la insulina.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['bateria', 'sin bateria', 'cargar', 'apagada'],
  ),
  Alarma(
    id: 'mobi_reanudar',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '189-190',
    titulo: 'Alarma de reanudación de insulina',
    significado:
        'La insulina lleva detenida más de 15 minutos porque elegiste Detener '
        'insulina, o se ha detenido por otra alarma.',
    queHacer: [
      'Para reanudar la insulina: Acciones → Reanudar insulina y pulsa Sí.',
      'Si no la confirmas, vuelve a avisar a los 3 minutos; si la confirmas, a los 15.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['reanudar', 'insulina detenida', 'parada'],
  ),
  Alarma(
    id: 'mobi_apagado_auto',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '162-163',
    titulo: 'Alarma de apagado automático',
    significado:
        'Si la tienes activada, la bomba detiene la insulina cuando pasan las '
        'horas que elegiste (entre 5 y 24) sin usar la bomba ni la app.',
    queHacer: [
      'Pulsa Ignorar.',
      'Reanuda la insulina: Acciones → Reanudar insulina.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['apagado', 'automatico', 'sin uso'],
  ),
  Alarma(
    id: 'mobi_temperatura',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '185, 194',
    titulo: 'Alerta o alarma de temperatura',
    significado:
        'La temperatura interna de la bomba es demasiado alta o demasiado '
        'baja. Primero sale una alerta; si llega a temperaturas extremas, '
        'salta la alarma y se detienen todos los suministros.',
    queHacer: [
      'Pulsa Ignorar.',
      'Aleja la bomba del calor o del frío extremo.',
      'Si saltó la alarma, reanuda la insulina cuando vuelva a una temperatura normal.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['temperatura', 'calor', 'frio'],
  ),
  Alarma(
    id: 'mobi_boton',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '182-183, 197',
    titulo: 'Botón Bomba atascado',
    significado:
        'El botón Bomba se ha pulsado demasiadas veces o un bolo rápido no se '
        'ha podido dar (alerta). Si el botón está atascado o no funciona, '
        'salta la alarma y se detienen todos los suministros.',
    queHacer: [
      'Pulsa Ignorar.',
      'Comprueba que el botón Bomba no se ha quedado hundido.',
      'Si es la alarma o el problema continúa, llama al servicio de atención al cliente.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['boton', 'atascado', 'bolo rapido'],
  ),
  Alarma(
    id: 'mobi_reinicio',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '198',
    titulo: 'Alarma de restablecimiento de bomba e IA',
    significado:
        'La bomba se ha reiniciado: la insulina activa se ha puesto a cero y '
        'se han detenido todos los suministros.',
    queHacer: [
      'Pulsa Ignorar y llama al servicio de atención al cliente.',
      'Revisa el estado de la bomba en el Panel y reanuda tú la insulina.',
      'No tomes decisiones con la insulina activa que muestre la app después del reinicio, ni con la alerta de bolo máximo por hora durante 60 minutos.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['reinicio', 'restablecimiento', 'insulina activa'],
  ),
  Alarma(
    id: 'mobi_fallo',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '200-201',
    titulo: 'Fallo de la bomba',
    significado:
        'La bomba ha detectado un error crítico y ha detenido todos los '
        'suministros. Las vibraciones y las luces siguen hasta que se agota '
        'la batería.',
    queHacer: [
      'Pulsa Ignorar en la app para silenciar los pitidos.',
      'Llama al servicio de atención al cliente.',
      'Usa tu método de insulina de respaldo o pide a tu equipo médico un plan alternativo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['fallo', 'error critico', 'no funciona'],
  ),

  // ---------------- ALERTAS: no detienen la insulina ----------------
  Alarma(
    id: 'mobi_bateria_baja',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '168-169',
    titulo: 'Alertas de baja energía',
    significado:
        'Queda menos del 20 % de batería (primera alerta) o menos del 5 % '
        '(segunda alerta). Con la segunda, la insulina sigue durante 30 '
        'minutos y después la bomba se apaga.',
    queHacer: [
      'Pulsa Ignorar.',
      'Carga la bomba lo antes posible para evitar la segunda alerta.',
      'Si ya es la segunda, cárgala de inmediato.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['bateria baja', 'cargar', 'poca bateria'],
  ),
  Alarma(
    id: 'mobi_insulina_baja',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '162, 167',
    titulo: 'Alerta de nivel de insulina bajo',
    significado:
        'Queda poca insulina en el cartucho: por debajo del aviso que tienes '
        'configurado o casi nada.',
    queHacer: [
      'Pulsa Ignorar.',
      'Cambia el cartucho lo antes posible para evitar la alarma de cartucho vacío.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['poca insulina', 'queda poco', 'cartucho bajo'],
  ),
  Alarma(
    id: 'mobi_incompleto',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '170-175',
    titulo: 'Has dejado algo a medias',
    significado:
        'La app avisa si empiezas un bolo, un régimen temporal, la carga de '
        'un cartucho o una configuración y no lo terminas.',
    queHacer: [
      'Abre la notificación: vuelves a donde lo dejaste.',
      'Termina el proceso o cancélalo si ya no lo quieres.',
      'No dejes a medias un cambio de cartucho: mientras tanto no recibes insulina.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['incompleto', 'a medias', 'sin terminar'],
  ),
  Alarma(
    id: 'mobi_limites',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '178-181',
    titulo: 'Aviso de límite de bolo o de basal',
    significado:
        'Has pedido un bolo mayor que tu bolo máximo (o más de lo previsto en '
        'la última hora), o un régimen basal por encima de tu máximo o por '
        'debajo del mínimo.',
    queHacer: [
      'Revisa la cantidad y confírmala solo si estás seguro.',
      'Consulta con tu equipo médico si tus necesidades han cambiado.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['bolo maximo', 'limite', 'basal maxima'],
  ),

  // ---------------- CONTROL-IQ+ ----------------
  Alarma(
    id: 'mobi_ciq_fuera_alcance',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '315-316',
    titulo: 'Modo automático: el sensor está fuera de alcance',
    significado:
        'El sensor y la bomba no se comunican, así que no llegan lecturas. Si el modo automático está activado, sigue ajustando la insulina los primeros 20 minutos y después vuelve a la basal de tu perfil.',
    queHacer: [
      'Pulsa Ignorar.',
      'Acerca el sensor a la bomba o quita lo que haya entre ellos.',
      'Mientras no haya lecturas, mídete con el medidor.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['fuera de alcance', 'sin lecturas', 'sin señal'],
  ),
  Alarma(
    id: 'mobi_ciq_bajo',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '318',
    titulo: 'El modo automático prevé una glucosa baja',
    significado:
        'El modo automático predice que tu glucosa bajará de 70 mg/dL (80 si tienes activada la actividad Ejercicio) en los próximos 15 minutos.',
    queHacer: [
      'Pulsa Ignorar.',
      'Toma hidratos de carbono y mide tu glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['baja', 'hipo', 'prevision'],
  ),
  Alarma(
    id: 'mobi_ciq_alto',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '319',
    titulo: 'Modo automático: glucosa alta que no baja',
    significado:
        'El modo automático ha subido la insulina, pero ve una glucosa por encima de 200 mg/dL y no prevé que baje en los próximos 30 minutos.',
    queHacer: [
      'Pulsa Ignorar.',
      'Revisa el cartucho, el tubo y el sitio de infusión, y mide tu glucosa.',
      'Trata la glucosa alta según te haya indicado tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['alta', 'hiper', 'no baja'],
  ),
  Alarma(
    id: 'mobi_ciq_max_insulina',
    bomba: 'btandemmobi',
    manual: _manual,
    pagina: '320',
    titulo: 'Modo automático: máximo de insulina alcanzado',
    significado:
        'El modo automático ha puesto en las últimas 2 horas la mitad de tu dosis diaria total, que es el máximo permitido.',
    queHacer: [
      'Pulsa Ignorar.',
      'Comprueba que tu insulina diaria total está bien configurada: Ajustes → Bomba → Control-IQ.',
      'Si tu glucosa sigue alta, revisa el catéter y consúltalo con tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['maximo', 'insulina maxima', 'dosis diaria'],
  ),
];
