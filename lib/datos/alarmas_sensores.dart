/// ALARMAS Y AVISOS DE LOS SENSORES
///
/// Fuentes: guía del usuario del Dexcom G7 (capítulo 5, alertas, y capítulo
/// 11, solución de problemas), guía del usuario del Dexcom G6 (capítulo 14,
/// resolución de problemas, y capítulos 4 y 13) y manual del lector
/// FreeStyle Libre 3 y 3 Plus (ART52185, 2025). Los avisos de Simplera Sync,
/// Guardian 4 e Instinct están en el fichero de MiniMed, porque los muestra
/// la bomba 780G; los del FreeStyle Libre 2 Plus, en el de Omnipod 5, porque
/// los gestiona su aplicación.
library;

import '../modelos/alarma.dart';

const _g6 = ['sdexg6'];
const _g7 = ['sdexg7'];
const _dexcom = ['sdexg6', 'sdexg7'];
const _libre = ['sfreelibre3'];

const _manualG7 = 'Dexcom G7';
const _manualG6 = 'Dexcom G6';
const _manualDexcom = 'Dexcom G6 y G7';
const _manualLibre = 'FreeStyle Libre 3 y 3 Plus (manual del lector)';

const List<Alarma> alarmasSensores = [
  // ---------------- DEXCOM G6 Y G7: GLUCOSA ----------------
  Alarma(
    id: 'dex_bajo_urgente',
    bomba: '',
    sensores: _dexcom,
    deSensor: true,
    manual: _manualDexcom,
    pagina: 'G7 57 · G6 cap. 4 y 10',
    titulo: 'Valor bajo urgente',
    significado:
        'La lectura del sensor es de 55 mg/dL o menos. Es una alerta de '
        'seguridad que suena aunque tengas el móvil en silencio.',
    queHacer: [
      'Mide tu glucosa con el medidor y trátala ya, como te haya indicado tu equipo médico.',
      'Toma hidratos de carbono de acción rápida (azúcar, zumo…).',
      'Vuelve a medirte a los 15 minutos.',
      'Si pierdes el conocimiento o no puedes tragar, es una urgencia: glucagón y llama al 112.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'urgente', 'hipoglucemia', '55'],
  ),
  Alarma(
    id: 'dex_bajo_inminente',
    bomba: '',
    sensores: _dexcom,
    deSensor: true,
    manual: _manualDexcom,
    pagina: 'G7 57-58 · G6 cap. 4 y 14',
    titulo: 'Valor bajo urgente inminente',
    significado:
        'Tu glucosa va a llegar a 55 mg/dL o menos en unos 20 minutos, '
        'aunque ahora esté dentro de rango. Es una bajada rápida.',
    queHacer: [
      'Actúa ahora para evitar la bajada: come o bebe hidratos de carbono de acción rápida como te haya enseñado tu equipo médico.',
      'Mide tu glucosa y vuelve a medirte a los 15 minutos.',
      'Ojo: si recibes esta alerta, no recibirás la de glucosa baja durante un rato; funcionan juntas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['bajada rapida', 'a punto de bajar', 'inminente', 'hipo'],
  ),
  Alarma(
    id: 'dex_glucosa_baja',
    bomba: '',
    sensores: _dexcom,
    deSensor: true,
    manual: _manualDexcom,
    pagina: 'G7 58 · G6 cap. 10 y 14',
    titulo: 'Alerta de glucosa baja',
    significado:
        'La lectura del sensor es igual o menor que el límite bajo que '
        'configuraste (por defecto, 70 mg/dL en el G7 y 80 en el G6).',
    queHacer: [
      'Si puedes, confírmalo con un pinchazo en el dedo, pero no retrases el tratamiento.',
      'Toma hidratos de carbono de acción rápida (azúcar, zumo…) como te haya enseñado tu equipo médico.',
      'Vuelve a medirte a los 15 minutos.',
      'Si pierdes el conocimiento o no puedes tragar, es una urgencia: glucagón y llama al 112.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'hipoglucemia', 'bajada', 'nivel bajo'],
  ),
  Alarma(
    id: 'dex_glucosa_alta',
    bomba: '',
    sensores: _dexcom,
    deSensor: true,
    manual: _manualDexcom,
    pagina: 'G7 59 · G6 cap. 10 y 14',
    titulo: 'Alerta de glucosa alta',
    significado:
        'La lectura del sensor es igual o mayor que el límite alto que '
        'configuraste (por defecto, 250 mg/dL en el G7 y 200 en el G6).',
    queHacer: [
      'Confírmalo con un pinchazo en el dedo.',
      'Si el valor es muy alto o lleva mucho rato sin bajar, comprueba las cetonas.',
      'Revisa el catéter: una glucosa alta sin motivo suele deberse a que el catéter no funciona bien.',
      'Actúa como te haya indicado tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hiper', 'alta', 'hiperglucemia', 'subida', 'nivel alto'],
  ),
  Alarma(
    id: 'dex_cambio_rapido',
    bomba: '',
    sensores: _dexcom,
    deSensor: true,
    manual: _manualDexcom,
    pagina: 'G7 60 · G6 cap. 10',
    titulo: 'Glucosa subiendo o bajando rápido',
    significado:
        'Son avisos opcionales: tu glucosa sube o baja más rápido de lo que '
        'configuraste (por ejemplo, 3 mg/dL por minuto o más).',
    queHacer: [
      'Mira la flecha de tendencia y, si hace falta, mide tu glucosa.',
      'Actúa como te haya indicado tu equipo médico.',
      'Si la glucosa llega a 55 mg/dL o menos, recibirás la alerta de valor bajo urgente en su lugar.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['subiendo rapido', 'bajando rapido', 'flecha', 'tendencia'],
  ),
  Alarma(
    id: 'dex_no_coincide',
    bomba: '',
    sensores: _dexcom,
    deSensor: true,
    manual: _manualDexcom,
    pagina: 'G7 117-119 · G6 257-258',
    titulo: 'La lectura no coincide con el medidor o con cómo me siento',
    significado:
        'El sensor mide la glucosa del líquido que hay entre las células y '
        'el medidor la de la sangre: es normal que no den exactamente el '
        'mismo número, sobre todo si la glucosa cambia rápido.',
    queHacer: [
      'Lávate las manos con agua y jabón (no con gel desinfectante), sécalas y vuelve a medir con el dedo.',
      'El primer día del sensor las diferencias pueden ser mayores.',
      'Si estás tumbado sobre el sensor, la presión puede bajar la lectura: cambia de postura y vuelve a comparar.',
      'Comprueba que las tiras no han caducado y que están bien guardadas.',
      'Si tus síntomas no coinciden con el sensor, decide con el valor del medidor.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: [
      'precision',
      'no coincide',
      'diferente',
      'no me fio',
      'lecturas raras',
      'dedo',
    ],
  ),

  // ---------------- DEXCOM G7 ----------------
  Alarma(
    id: 'g7_perdida_senal',
    bomba: '',
    sensores: _g7,
    deSensor: true,
    manual: _manualG7,
    pagina: '61, 130-132',
    titulo: 'Pérdida de señal',
    significado:
        'El móvil o el receptor no reciben lecturas del sensor por un '
        'momento. Tras unos 20 minutos sin lecturas también suena o vibra. '
        'No hay lecturas ni alertas hasta que se arregle.',
    queHacer: [
      'Usa el medidor de glucosa para decidir tu tratamiento.',
      'Apaga y vuelve a encender el Bluetooth del móvil y déjalo encendido. Mantén abierta la app (no la fuerces a cerrar).',
      'Mantén el móvil a menos de 10 metros del sensor, sin nada en medio (paredes, agua) y en el mismo lado del cuerpo.',
      'Si no funciona, reinicia el móvil y abre la app. Mantén el móvil con al menos un 20 % de batería.',
      'Espera hasta 30 minutos. Si sigue igual, llama al servicio técnico del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['sin senal', 'no conecta', 'bluetooth', 'sin lecturas'],
  ),
  Alarma(
    id: 'g7_problema_temporal',
    bomba: '',
    sensores: _g7,
    deSensor: true,
    manual: _manualG7,
    pagina: '61, 127',
    titulo: 'Problema temporal del sensor',
    significado:
        'El sensor no puede medir la glucosa por ahora. Suele pasar durante '
        'el primer día, pero puede ocurrir en cualquier momento y casi '
        'siempre se arregla solo en menos de 3 horas.',
    queHacer: [
      'No quites el sensor.',
      'Usa el medidor de glucosa para decidir tu tratamiento.',
      'Toca Ayuda en la app para ver más consejos.',
      'Si dura más de 3 horas, llama al servicio técnico del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['problema temporal', 'sin lecturas', 'no mide', 'espera'],
  ),
  Alarma(
    id: 'g7_sensor_fallo',
    bomba: '',
    sensores: _g7,
    deSensor: true,
    manual: _manualG7,
    pagina: '61, 128',
    titulo: 'El sensor ha fallado',
    significado:
        'Ya no habrá lecturas ni alertas hasta que empieces un sensor nuevo. '
        'Puede llegar después de un problema temporal.',
    queHacer: [
      'Quita el sensor ya: despega el parche por el borde.',
      'Pon y empareja un sensor nuevo (mira la guía de cambio de sensor de esta app).',
      'Mientras tanto usa el medidor de glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'fallo',
      'sensor fallado',
      'extraer sensor',
      'error del sensor',
    ],
  ),
  Alarma(
    id: 'g7_cambiar_sensor',
    bomba: '',
    sensores: _g7,
    deSensor: true,
    manual: _manualG7,
    pagina: '111-112',
    titulo: 'Cambia el sensor ahora',
    significado:
        'La sesión del sensor (hasta 10 días) y su periodo de gracia de 12 '
        'horas han terminado. Ya no habrá lecturas ni alertas hasta que uses '
        'un sensor nuevo.',
    queHacer: [
      'Toca Aceptar y sigue las instrucciones de la pantalla (en el receptor, Iniciar sensor nuevo).',
      'Quita el sensor viejo y pon uno nuevo (mira la guía de cambio de sensor).',
      'Recuerda que el sensor nuevo tarda unos 30 minutos en empezar a dar lecturas.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'sensor caducado',
      'periodo de gracia',
      'fin de sesion',
      'cambiar sensor',
    ],
  ),
  Alarma(
    id: 'g7_buscando_sensor',
    bomba: '',
    sensores: _g7,
    deSensor: true,
    manual: _manualG7,
    pagina: '129-130',
    titulo: 'Buscando el sensor (el emparejamiento tarda)',
    significado:
        'El emparejamiento suele tardar menos de 5 minutos con el móvil y '
        'menos de 10 con el receptor. Si tarda más, prueba estos consejos.',
    queHacer: [
      'Mantén el móvil cerca del sensor (a menos de 10 metros; el receptor, a menos de 1 metro).',
      'Comprueba que el sensor está puesto y que el código de emparejamiento es el del aplicador.',
      'Aléjate de otras personas que lleven sensores para evitar interferencias.',
      'Recuerda que un sensor solo se empareja con un móvil, un receptor y un reloj. Mantén abierta la app.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['emparejar', 'buscando', 'codigo', 'vincular', 'no empareja'],
  ),
  Alarma(
    id: 'g7_calibracion',
    bomba: '',
    sensores: _g7,
    deSensor: true,
    manual: _manualG7,
    pagina: '119-120',
    titulo: 'Calibración no utilizada',
    significado:
        'Con este sensor calibrar es opcional. Si sale este aviso, el sistema no ha usado el valor que introdujiste.',
    queHacer: [
      'Lávate las manos con agua y jabón, sécalas y mide con el dedo.',
      'Introduce el valor antes de que pasen 5 minutos, solo si está entre 40 y 400 mg/dL.',
      'Calibra en el móvil o en el receptor, no en los dos.',
      'No calibres si la glucosa cambia rápido o si estás apoyado sobre el sensor.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['calibrar', 'calibracion', 'medidor', 'capilar'],
  ),
  Alarma(
    id: 'g7_comprobacion',
    bomba: '',
    sensores: _g7,
    deSensor: true,
    manual: _manualG7,
    pagina: '132',
    titulo: 'Comprobación del sistema (error del receptor)',
    significado:
        'El receptor ha encontrado un error y no recibirás lecturas ni '
        'alertas del sensor. Aparece un código de error.',
    queHacer: [
      'Anota el código de error que sale en la pantalla.',
      'Llama al servicio técnico del fabricante y dales el código.',
      'Mientras tanto usa el medidor de glucosa.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['receptor', 'error', 'codigo', 'evaluacion del sistema'],
  ),

  // ---------------- DEXCOM G6 ----------------
  Alarma(
    id: 'g6_sin_lecturas',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '227-229',
    titulo: 'Sin lecturas del sensor',
    significado:
        'No recibes lecturas del sensor desde hace 20 minutos (en el receptor, aparece como error de sensor). No hay alarma ni alertas de glucosa hasta que se solucione.',
    queHacer: [
      'Usa el medidor de glucosa para decidir tu tratamiento.',
      'Toca la alerta para ver más información.',
      'Comprueba que el transmisor está bien encajado en su soporte.',
      'Espera: en la app, hasta 3 horas; en el receptor, 30 minutos. Si no se arregla, saldrá "Fallo del sensor": llama al servicio técnico del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'sin lecturas',
      'no lecturas',
      'error de sensor',
      'no hay datos',
    ],
  ),
  Alarma(
    id: 'g6_perdida_senal',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '231-232',
    titulo: 'Pérdida de señal',
    significado:
        'El dispositivo de visualización y el transmisor no se conectan, así '
        'que no hay lecturas, alarma ni alertas de glucosa.',
    queHacer: [
      'Usa el medidor de glucosa.',
      'Acerca el transmisor y el móvil o receptor a menos de 6 metros, sin obstáculos (paredes, metales). Bajo el agua, en la ducha o nadando, acércalos aún más.',
      'En la app: reinicia el móvil. Si sigue, abre los ajustes de Bluetooth, elimina todas las entradas de Dexcom y empareja de nuevo el transmisor.',
      'Espera hasta 30 minutos: puede arreglarse solo. Si pasan más, llama al servicio técnico del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['sin senal', 'perdida de senal', 'no conecta', 'bluetooth'],
  ),
  Alarma(
    id: 'g6_fallo_sensor',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '229-230, 253-254',
    titulo: 'Fallo del sensor',
    significado:
        'El sensor ha dejado de funcionar: no hay lecturas, alarma ni '
        'alertas.',
    queHacer: [
      'Usa el medidor de glucosa.',
      'Toca la alerta para ver más información.',
      'Antes de parar una sesión antes de tiempo, llama siempre al servicio técnico del fabricante. Una sesión detenida no se puede reanudar.',
      'Para volver a tener lecturas, pon un sensor nuevo e inicia la sesión.',
      'Si un hilo del sensor se rompe y no lo ves, no intentes sacarlo: consulta a tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['fallo', 'error del sensor', 'sensor fallado', 'parar sesion'],
  ),
  Alarma(
    id: 'g6_transmisor_no_encontrado',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '252-253',
    titulo: 'Transmisor no encontrado',
    significado:
        'El transmisor no se ha emparejado con tu móvil o receptor, así que '
        'no hay lecturas, alarma ni alertas.',
    queHacer: [
      'Usa el medidor de glucosa.',
      'Comprueba que el número de serie del transmisor que introdujiste coincide con el de la caja.',
      'Asegúrate de que el transmisor está bien encajado en su soporte.',
      'Si nada funciona, puede que el sensor esté mal insertado: llama al servicio técnico del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['transmisor', 'no encontrado', 'numero de serie', 'emparejar'],
  ),
  Alarma(
    id: 'g6_calibracion',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '250, 258',
    titulo: 'Repetir calibración',
    significado:
        'El sistema no ha aceptado tu calibración, o el valor estaba fuera '
        'de lo esperado. No hay lecturas hasta solucionarlo.',
    queHacer: [
      'Usa el medidor de glucosa.',
      'Sigue las instrucciones de la pantalla: te pedirá calibrar de nuevo en 15 minutos.',
      'En el receptor, si vuelve a fallar, introduce un valor más y espera 15 minutos.',
      'Si siguen sin salir lecturas, cambia el sensor y llama al servicio técnico del fabricante.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: [
      'calibrar',
      'calibracion',
      'repetir calibracion',
      'error calibracion',
    ],
  ),
  Alarma(
    id: 'g6_fin_sesion',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '207-208',
    titulo: 'Fin de la sesión del sensor (10 días)',
    significado:
        'La sesión del sensor dura 10 días. Recibes avisos 6 horas, 2 horas '
        'y 30 minutos antes del final, y sigues recibiendo lecturas hasta '
        'entonces.',
    queHacer: [
      'Abre la app (o toca OK en el receptor) para confirmar el aviso.',
      'Quita el sensor viejo antes de empezar uno nuevo (mira la guía de cambio de sensor).',
      'Un sensor nuevo tarda unas 2 horas en calentarse antes de dar lecturas.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: [
      'fin de sesion',
      'sensor caducado',
      'diez dias',
      'cambiar sensor',
    ],
  ),
  Alarma(
    id: 'g6_bateria_transmisor',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '214-215',
    titulo: 'Batería del transmisor',
    significado:
        'La batería del transmisor dura unos 3 meses. Tres semanas antes de '
        'agotarse empiezan los avisos con una cuenta atrás; con 10 días o '
        'menos no podrás iniciar una sesión nueva. Cuando se agota o falla, '
        'suena o vibra.',
    queHacer: [
      'Empareja un transmisor nuevo cuando el sistema te lo pida: necesitarás el código del sensor y el número de serie del transmisor.',
      'Espera a que se confirme el emparejamiento antes de insertar el sensor y acoplar el transmisor.',
      'Si usas app y receptor, inicia la sesión en uno antes de emparejar el transmisor con el otro.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['transmisor', 'bateria', 'tres meses', 'fallo transmisor'],
  ),
  Alarma(
    id: 'g6_bajo_alto',
    bomba: '',
    sensores: _g6,
    deSensor: true,
    manual: _manualG6,
    pagina: '233',
    titulo: '"Bajo" o "Alto" en lugar de un número',
    significado:
        'El sensor muestra "Bajo" por debajo de 40 mg/dL y "Alto" por encima de 400 mg/dL. Funciona correctamente.',
    queHacer: [
      'Mide con el medidor y trata la bajada o la subida.',
      'Cuando tu glucosa vuelva a estar entre 40 y 400 mg/dL, el sensor mostrará de nuevo las lecturas.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['bajo', 'alto', 'lo', 'hi', 'sin numero'],
  ),

  // ---------------- DEXCOM: PARCHE ----------------
  Alarma(
    id: 'dex_parche',
    bomba: '',
    sensores: _dexcom,
    deSensor: true,
    manual: _manualDexcom,
    pagina: 'G7 121-123 · G6 237-239',
    titulo: 'El parche se despega o me irrita la piel',
    significado:
        'Si el parche adhesivo no aguanta toda la sesión del sensor, o la '
        'piel se irrita, se puede prevenir cuidando la colocación.',
    queHacer: [
      'Pon el sensor en una zona plana, limpia y completamente seca, sin pliegues de piel ni cerca del cinturón, y con poco vello.',
      'Antes de ponerlo, puedes usar un adhesivo cutáneo opcional; después, un cubreparche o cinta médica por encima.',
      'Si se moja, sécalo con suavidad, sin frotar. Si se despega, recorta lo despegado y pon cinta médica.',
      'No uses el mismo sitio para dos sensores seguidos. Si la irritación es importante (picor, ardor, erupción), consulta con tu equipo médico.',
      'Si el aplicador se te queda pegado, despega el parche con cuidado junto con el aplicador, comprueba que el sensor no se ha quedado en la piel y no lo reutilices.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: [
      'parche',
      'adhesivo',
      'se despega',
      'irritacion',
      'alergia',
      'aplicador',
    ],
  ),

  // ---------------- FREESTYLE LIBRE 3 ----------------
  // Manual del lector FreeStyle Libre 3 y 3 Plus (ART52185, 2025): inicio del
  // sensor (págs. 28-29), alarmas (35-45) y resolución de problemas (95-97).
  Alarma(
    id: 'libre3_arranque',
    bomba: '',
    sensores: _libre,
    deSensor: true,
    manual: _manualLibre,
    pagina: '28-29, 95',
    titulo: 'Iniciando nuevo sensor (60 minutos)',
    significado:
        'Después de escanear el sensor para iniciarlo, hay un periodo de '
        'puesta en marcha de 60 minutos. Hasta que termina, el sensor no '
        'está listo para leer la glucosa.',
    queHacer: [
      'Espera a que pasen los 60 minutos sin quitar el sensor.',
      'Mientras tanto, usa el medidor de glucosa para decidir tu tratamiento.',
      'Si sale "Tiempo agotado escaneo", acerca más el dispositivo al sensor y vuelve a escanear.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['arranque', 'calentamiento', 'escanear', 'sin lecturas'],
  ),
  Alarma(
    id: 'libre3_alarmas',
    bomba: '',
    sensores: _libre,
    deSensor: true,
    manual: _manualLibre,
    pagina: '35-45',
    titulo: 'Alarmas de glucosa del sensor',
    significado:
        'Hay tres alarmas: glucosa baja, glucosa alta y pérdida de señal. En '
        'el lector vienen desactivadas de fábrica y hay que activarlas. El '
        'sensor por sí solo no suena: el lector o el móvil tienen que estar a '
        'menos de 10 metros.',
    queHacer: [
      'Decide con tu equipo médico si activarlas y a qué niveles.',
      'En el lector: Configuración → Alarmas → Cambiar config. de las alarmas.',
      'Comprueba que el sonido o la vibración están activados y que el dispositivo tiene batería.',
      'Las alarmas de glucosa son un apoyo: mira siempre también la glucosa actual, la flecha y el gráfico.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['alarmas', 'descartar', 'desactivar', 'configurar'],
  ),
  Alarma(
    id: 'libre_senal_perdida',
    bomba: '',
    sensores: _libre,
    deSensor: true,
    manual: _manualLibre,
    pagina: '44-45, 95, 97',
    titulo: 'Alarma de pérdida de señal',
    significado:
        'El sensor lleva 20 minutos sin comunicarse con el lector o el móvil, '
        'así que no te llegarán las alarmas de glucosa baja ni alta. Puede '
        'ser porque está a más de 10 metros o por un problema del sensor o '
        'del dispositivo.',
    queHacer: [
      'Toca Descartar alarma.',
      'Acerca el dispositivo a menos de 10 metros del sensor.',
      'Si sigue saliendo aunque estés cerca, llama al Servicio al Cliente.',
      'Mientras no haya lecturas, mídete con el medidor.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['no conecta', 'sin senal', 'perdida de señal', 'sin lecturas'],
  ),
  Alarma(
    id: 'libre_sensor_caducado',
    bomba: '',
    sensores: _libre,
    deSensor: true,
    manual: _manualLibre,
    pagina: '95-96',
    titulo: 'Sensor agotado / Sustituir el sensor',
    significado:
        '"Sensor agotado": el sensor ha llegado al final de su vida útil. '
        '"Sustituir el sensor": el sistema ha detectado un problema con él.',
    queHacer: [
      'Quita el sensor, ponte uno nuevo e inícialo.',
      'Mira la guía de cambio de sensor de esta app.',
    ],
    gravedad: Gravedad.informativa,
    sinonimos: ['caducado', 'agotado', 'fin de vida', 'cambiar sensor', 'sustituir'],
  ),
  Alarma(
    id: 'libre3_mensajes',
    bomba: '',
    sensores: _libre,
    deSensor: true,
    manual: _manualLibre,
    pagina: '95-96',
    titulo: 'Mensajes del sensor',
    significado:
        'Otros mensajes que pueden salir al leer el sensor: "Error de '
        'escaneo", "Error del sensor", "Lectura de glucosa no disponible", '
        '"Sensor ya en uso" o "Comprobar sensor".',
    queHacer: [
      'Error de escaneo: vuelve a escanear, alejándote de aparatos que puedan interferir.',
      'Error del sensor: vuelve a comprobarlo en 10 minutos.',
      'Lectura de glucosa no disponible: el sensor está demasiado caliente o frío; muévete a un sitio con otra temperatura.',
      'Sensor ya en uso: se inició con otro dispositivo. Léelo con ese o pon un sensor nuevo.',
      'Comprobar sensor: puede que la punta no esté bajo la piel. Inícialo otra vez; si vuelve a salir, pon un sensor nuevo.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['error de escaneo', 'error del sensor', 'no disponible', 'ya en uso', 'comprobar sensor'],
  ),
  Alarma(
    id: 'libre_glucosa_alta',
    bomba: '',
    sensores: _libre,
    deSensor: true,
    manual: _manualLibre,
    pagina: '44',
    titulo: 'Alarma de glucosa alta',
    significado:
        'Tu glucosa ha subido por encima del nivel que configuraste. Solo '
        'recibes una alarma por cada subida.',
    queHacer: [
      'Toca Descartar alarma.',
      'Confírmalo con el medidor si no cuadra con cómo te encuentras.',
      'Actúa como te haya indicado tu equipo médico.',
    ],
    gravedad: Gravedad.atencion,
    sinonimos: ['hiper', 'alta', 'hiperglucemia', 'subida'],
  ),
  Alarma(
    id: 'libre_glucosa_baja',
    bomba: '',
    sensores: _libre,
    deSensor: true,
    manual: _manualLibre,
    pagina: '44',
    titulo: 'Alarma de glucosa baja',
    significado:
        'Tu glucosa ha bajado por debajo del nivel que configuraste. Solo '
        'recibes una alarma por cada bajada.',
    queHacer: [
      'Toca Descartar alarma.',
      'Trata la bajada como te haya indicado tu equipo médico, sin retrasarlo.',
      'Si pierdes el conocimiento o no puedes tragar, es una urgencia: glucagón y llama al 112.',
    ],
    gravedad: Gravedad.urgente,
    sinonimos: ['hipo', 'baja', 'hipoglucemia', 'bajada'],
  ),
];
