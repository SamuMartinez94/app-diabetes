/// ALARMAS Y AVISOS DE TANDEM t:slim X2 (con Control-IQ)
///
/// Fuente: guía del usuario oficial de la bomba t:slim X2 con Control-IQ
/// 7.8.1 (edición española, 2025): capítulos 12 a 15 (alertas, alarmas y
/// fallo) y 32 (alertas de la tecnología Control-IQ). Las páginas indicadas
/// son las impresas en el manual.
library;

import '../modelos/alarma.dart';

const _manual = 'Tandem t:slim X2';

const List<Alarma> alarmasTandem = [
  // ---------------- ALARMAS: la insulina se detiene ----------------
  Alarma(
    id: 'tandem_oclusion',
    bomba: 'btandem',
    manual: _manual,
    pagina: '201-202',
    titulo: 'Bloqueo de insulina (oclusión)',
    significado:
        'La bomba ha detectado que la insulina no puede pasar y ha detenido '
        'todo el suministro. Puede tardar un rato en detectar el bloqueo.',
    queHacer: [
      'Pulsa OK.',
      'Revisa el cartucho, el tubo y el sitio de infusión por si hay daños, dobleces o bloqueos, y corrígelo.',
      'Para reanudar la insulina: Opciones → Reanudar insulina y confirma.',
      'Si salta una segunda alarma de bloqueo seguida, cambia el cartucho, el tubo y el sitio de infusión, y reanuda la insulina después.',
      'Si saltó durante un bolo, la pantalla te dice cuánto se llegó a poner antes del bloqueo.',
      'Mide tu glucosa y, si está alta, comprueba las cetonas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: [
      'oclusion',
      'bloqueo',
      'obstruido',
      'atasco',
      'no pasa insulina',
      'tubo doblado',
    ],
  ),
  Alarma(
    id: 'tandem_cartucho_vacio',
    bomba: 'btandem',
    manual: _manual,
    pagina: '197',
    titulo: 'Cartucho vacío',
    significado:
        'El cartucho se ha quedado sin insulina y se han detenido todos los '
        'suministros. La alarma se repite cada 3 minutos hasta que lo cambies.',
    queHacer: [
      'Pulsa OK.',
      'Cambia el cartucho ya: en la pantalla de inicio pulsa Opciones → Cargar y sigue los pasos (mira la guía de cambio de esta app).',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho', 'vacio', 'sin insulina', 'se acabo'],
  ),
  Alarma(
    id: 'tandem_error_cartucho',
    bomba: 'btandem',
    manual: _manual,
    pagina: '198',
    titulo: 'Error de cartucho',
    significado:
        'La bomba no ha podido usar el cartucho y ha detenido todos los '
        'suministros. Puede ser un cartucho defectuoso, un llenado mal hecho '
        'o un cartucho demasiado lleno.',
    queHacer: [
      'Pulsa OK.',
      'Cambia el cartucho ya: Opciones → Cargar y sigue los pasos.',
      'Al llenar el nuevo, sigue el procedimiento del manual y no lo llenes por encima de su capacidad.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho defectuoso', 'error cartucho', 'sobrellenado'],
  ),
  Alarma(
    id: 'tandem_cartucho_extraido',
    bomba: 'btandem',
    manual: _manual,
    pagina: '199',
    titulo: 'Cartucho extraído',
    significado:
        'La bomba ha detectado que se ha sacado el cartucho y ha detenido '
        'todos los suministros.',
    queHacer: [
      'Pulsa Conectar si quieres volver a conectar el mismo cartucho.',
      'Pulsa Instalar si vas a poner un cartucho nuevo.',
      'Mide tu glucosa si tardas en reanudar la insulina.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['cartucho fuera', 'sacado', 'desconectado'],
  ),
  Alarma(
    id: 'tandem_bateria_agotada',
    bomba: 'btandem',
    manual: _manual,
    pagina: '196',
    titulo: 'Batería casi agotada (alarma)',
    significado:
        'A la bomba le queda un 1 % de carga o menos y se han detenido todos '
        'los suministros. Se repite cada 3 minutos hasta que se apague.',
    queHacer: [
      'Pulsa OK.',
      'Carga la bomba de inmediato para reanudar la insulina.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['sin bateria', 'apagada', 'cargar', 'no enciende'],
  ),
  Alarma(
    id: 'tandem_reanudar',
    bomba: 'btandem',
    manual: _manual,
    pagina: '195',
    titulo: 'Reanuda la insulina',
    significado:
        'Detuviste la insulina desde el menú Opciones y llevas más de 15 '
        'minutos sin reanudarla. La alarma vuelve a sonar cada 3 minutos.',
    queHacer: [
      'Pulsa OK.',
      'Para reanudar la insulina: Opciones → Reanudar insulina y confirma.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['reanudar', 'detenida', 'parada', 'stop', 'detener insulina'],
  ),
  Alarma(
    id: 'tandem_apagado_auto',
    bomba: 'btandem',
    manual: _manual,
    pagina: '166-167',
    titulo: 'Apagado automático',
    significado:
        'Has puesto un tiempo (entre 5 y 24 horas) tras el cual, si no tocas '
        'la bomba, esta deja de dar insulina. Antes salta un aviso con una '
        'cuenta atrás de 30 segundos.',
    queHacer: [
      'Si ves la advertencia previa, pulsa No apagar y la bomba sigue con normalidad.',
      'Si ya ha saltado la alarma, pulsa OK: verás "Todos los suministros detenidos".',
      'Reanuda la insulina: Opciones → Reanudar insulina.',
      'Mide tu glucosa: llevas un rato sin insulina de fondo.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['apagado automatico', 'auto off', 'se paro sola', 'sin tocar'],
  ),
  Alarma(
    id: 'tandem_temperatura',
    bomba: 'btandem',
    manual: _manual,
    pagina: '200',
    titulo: 'Demasiado frío o demasiado calor',
    significado:
        'La bomba o su batería están fuera del rango de temperatura seguro y '
        'se han detenido todos los suministros.',
    queHacer: [
      'Pulsa OK.',
      'Aleja la bomba del calor o del frío directo (sol, coche, nevera).',
      'Cuando vuelva a temperatura normal, reanuda la insulina.',
      'La insulina se estropea con el frío y con el calor: si ha estado expuesta mucho rato, cámbiala.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['calor', 'frio', 'sol', 'playa', 'temperatura'],
  ),
  Alarma(
    id: 'tandem_altitud',
    bomba: 'btandem',
    manual: _manual,
    pagina: '204',
    titulo: 'Cambio de altitud o de presión',
    significado:
        'La bomba ha notado una diferencia de presión entre el interior del '
        'cartucho y el aire de alrededor, y ha detenido los suministros.',
    queHacer: [
      'Pulsa OK.',
      'Saca el cartucho de la bomba para que se ventile del todo y vuelve a conectarlo.',
      'Reanuda la insulina.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['altitud', 'avion', 'presion', 'montana', 'vuelo'],
  ),
  Alarma(
    id: 'tandem_boton',
    bomba: 'btandem',
    manual: _manual,
    pagina: '203',
    titulo: 'Botón de arriba atascado',
    significado:
        'El botón Pantalla enc./Bolo rápido (el de arriba de la bomba) '
        'está atascado o no funciona bien, y se han detenido todos los '
        'suministros.',
    queHacer: [
      'Pulsa OK.',
      'Ponte en contacto con el servicio de atención al cliente.',
      'Mide tu glucosa: mientras esté detenida no recibes insulina.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['boton', 'atascado', 'bolo rapido', 'no funciona'],
  ),
  Alarma(
    id: 'tandem_fallo',
    bomba: 'btandem',
    manual: _manual,
    pagina: '205, 208-209',
    titulo: 'Fallo o reinicio de la bomba',
    significado:
        'La bomba ha detectado un error del sistema, o uno de sus '
        'procesadores se ha reiniciado, y ha detenido todos los suministros. '
        'El fallo suena al volumen más alto y con vibración.',
    queHacer: [
      'Anota el número de código de fallo que sale en la pantalla.',
      'Pulsa Silenciar alarma (la pantalla de fallo se queda aunque la silencies).',
      'Llama al servicio de atención al cliente y dales el código.',
      'No dependas de la bomba mientras tanto: mide tu glucosa y actúa como te haya indicado tu equipo médico.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['fallo', 'error', 'codigo de fallo', 'reinicio', 'reseteo'],
  ),

  // ---------------- ALERTAS: avisos que no detienen la insulina ----------------
  Alarma(
    id: 'tandem_bateria_baja',
    bomba: 'btandem',
    manual: _manual,
    pagina: '172-173',
    titulo: 'Batería baja (alerta)',
    significado:
        'Queda menos del 25 % de batería (primera alerta) o menos del 5 % '
        '(segunda alerta). Con la segunda, la insulina sigue durante unos 30 '
        'minutos y después la bomba se apaga.',
    queHacer: [
      'Pulsa OK.',
      'Carga la bomba lo antes posible para evitar la segunda alerta.',
      'Si ya es la segunda, cárgala de inmediato para evitar que se apague.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['poca bateria', 'bateria baja', 'baja energia', 'cargar'],
  ),
  Alarma(
    id: 'tandem_insulina_baja',
    bomba: 'btandem',
    manual: _manual,
    pagina: '171',
    titulo: 'Queda poca insulina',
    significado:
        'Queda muy poca insulina en el cartucho. El aviso se repite cada 5 '
        'minutos hasta que lo confirmes.',
    queHacer: [
      'Pulsa OK.',
      'Cambia el cartucho lo antes posible para evitar la alarma de cartucho vacío y quedarte sin insulina.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['poca insulina', 'queda poco', 'cartucho bajo', 'barra roja'],
  ),
  Alarma(
    id: 'tandem_incompleto',
    bomba: 'btandem',
    manual: _manual,
    pagina: '174-180',
    titulo: 'Has dejado algo a medias',
    significado:
        'La bomba avisa si empiezas un bolo o un régimen temporal y no lo '
        'terminas en 90 segundos, o si dejas a medias un cambio de cartucho, '
        'un llenado de tubo o de cánula (3 minutos) o una configuración (5 '
        'minutos).',
    queHacer: [
      'Pulsa OK: vuelves a la pantalla donde lo dejaste.',
      'Termina el proceso, o cancélalo si ya no lo quieres.',
      'No dejes a medias un cambio de cartucho: mientras tanto no recibes insulina.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['incompleto', 'a medias', 'bolo incompleto', 'no terminado'],
  ),
  Alarma(
    id: 'tandem_limites',
    bomba: 'btandem',
    manual: _manual,
    pagina: '182-187',
    titulo: 'Aviso de límite de bolo o de basal',
    significado:
        'Has pedido un bolo mayor que tu límite de bolo máximo (o más de lo '
        'previsto en la última hora), o un régimen temporal que supera tu '
        'límite de basal máxima o queda por debajo de la mitad de tu basal '
        'más baja.',
    queHacer: [
      'Vuelve atrás y ajusta la cantidad, o confírmala solo si estás seguro.',
      'Antes de confirmar, piensa si tus necesidades de insulina han cambiado desde que pediste el bolo.',
      'Con un régimen temporal, pulsa OK para aceptar el valor reducido y revisa tu régimen temporal en el menú Actividad.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['bolo maximo', 'basal maxima', 'basal minima', 'limite'],
  ),

  // ---------------- CONTROL-IQ ----------------
  Alarma(
    id: 'tandem_ciq_fuera_alcance',
    bomba: 'btandem',
    manual: _manual,
    pagina: '347-348',
    titulo: 'Modo automático: el sensor está fuera de alcance',
    significado:
        'El transmisor y la bomba no se comunican, así que la bomba no recibe lecturas. El modo automático sigue ajustando la insulina durante los primeros 20 minutos y después vuelve a la basal de tu perfil.',
    queHacer: [
      'Pulsa OK.',
      'Acerca la bomba y el transmisor, o quita lo que haya entre ellos.',
      'Mientras no haya lecturas, mídete con un pinchazo en el dedo.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['fuera de limites', 'sin senal', 'no conecta', 'control iq'],
  ),
  Alarma(
    id: 'tandem_ciq_bajo',
    bomba: 'btandem',
    manual: _manual,
    pagina: '349',
    titulo: 'El modo automático prevé una glucosa baja',
    significado:
        'El modo automático predice que tu glucosa estará por debajo de 70 mg/dL (80 si usas la función Ejercicio) en los próximos 15 minutos.',
    queHacer: [
      'Toma hidratos de carbono de acción rápida y mide tu glucosa.',
      'Pulsa OK para cerrar la alerta.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hipo', 'baja', 'prediccion', 'control iq', 'nivel bajo'],
  ),
  Alarma(
    id: 'tandem_ciq_alto',
    bomba: 'btandem',
    manual: _manual,
    pagina: '350',
    titulo: 'Modo automático: glucosa alta que no baja',
    significado:
        'El modo automático ha subido la insulina, pero ve una glucosa por encima de 200 mg/dL y no prevé que baje en los próximos 30 minutos.',
    queHacer: [
      'Revisa el cartucho, el tubo y el sitio de infusión.',
      'Mide tu glucosa y trata la glucosa alta según te haya indicado tu equipo médico.',
      'Pulsa OK para cerrar la alerta.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hiper', 'alta', 'control iq', 'nivel alto', 'no baja'],
  ),
  Alarma(
    id: 'tandem_ciq_max_insulina',
    bomba: 'btandem',
    manual: _manual,
    pagina: '351',
    titulo: 'Modo automático: máximo de insulina alcanzado',
    significado:
        'La bomba ha dado el máximo de insulina permitido en 2 horas (la mitad de tu dosis diaria total). El modo automático pausa la insulina un mínimo de 5 minutos y después la reanuda.',
    queHacer: [
      'Pulsa OK.',
      'Si tu glucosa sigue alta, revisa el catéter y consúltalo con tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['maximo', 'insulina maxima', 'control iq', 'dosis diaria'],
  ),
];
