/// CONTROLES DEL AEROPUERTO Y VUELOS
///
/// Lo que dice el manual de cada bomba y sensor sobre el arco detector de
/// metales, el escáner corporal, los rayos X del equipaje y el avión. Cada
/// dispositivo dice una cosa distinta, por eso no hay una regla común.
library;

/// Lo que dice el manual de un dispositivo sobre el aeropuerto.
class AvisoAeropuerto {
  final List<String> puntos;

  /// Manual del que sale y página impresa, para poder comprobarlo.
  final String manual;
  final String pagina;

  const AvisoAeropuerto({
    required this.puntos,
    required this.manual,
    required this.pagina,
  });
}

const _tandem = [
  'Arco detector de metales: sí, puedes pasar con la bomba.',
  'Escáner corporal y rayos X del equipaje: no, también son rayos X. Avisa '
      'al agente de que la bomba no puede pasar por ellos y pide otro tipo de '
      'control.',
  'En el avión puedes usarla. Si pones el móvil en modo avión, deja el '
      'Bluetooth activado para seguir usando la app.',
];

/// Instinct y FreeStyle Libre comparten las indicaciones del fabricante.
const _abbott = [
  'Arco detector de metales: sí, puedes pasar con el sensor puesto.',
  'Escáner corporal: no. Pide otro tipo de control; si pasas por él, '
      'tendrás que quitarte el sensor.',
  'En el avión puedes usarlo, siguiendo las indicaciones de la tripulación.',
];

/// Por identificador de bomba o de sensor. Los sensores Guardian 4 y Simplera
/// Sync no tienen entrada propia: los cubre lo que dice el manual de la 780G.
const Map<String, AvisoAeropuerto> avisosAeropuerto = {
  'btandem': AvisoAeropuerto(
    puntos: _tandem,
    manual: 'Tandem t:slim X2',
    pagina: '217',
  ),
  'btandemmobi': AvisoAeropuerto(
    puntos: _tandem,
    manual: 'Tandem Mobi',
    pagina: '44, 210',
  ),
  'bmedtronic': AvisoAeropuerto(
    puntos: [
      'Escáner corporal: no. Quítate la bomba y el sensor antes de pasar, o '
          'pide otro tipo de control para no tener que quitártelos.',
      'Rayos X del equipaje: no pases la bomba ni el sensor por la máquina.',
      'Lleva la tarjeta de emergencia médica que viene con la bomba: explica '
          'qué controles puedes pasar y cómo usarla en el avión.',
      'Mide la glucosa durante el vuelo: los cambios de presión al despegar y '
          'aterrizar pueden hacer que entre más o menos insulina.',
    ],
    manual: 'MiniMed 780G',
    pagina: '35, 39',
  ),
  'bomnipod': AvisoAeropuerto(
    puntos: [
      'El Pod y el Controlador soportan los sistemas de seguridad de los '
          'aeropuertos. Si te preocupa el arco detector, avisa al agente de que '
          'llevas una bomba de insulina que no te puedes quitar.',
      'Puedes pedir que revisen a mano tu material en lugar de pasarlo por '
          'rayos X. Pídelo antes de que empiece el control y llévalo en una '
          'bolsa aparte.',
      'Mide la glucosa a menudo durante el vuelo: los cambios de presión '
          'pueden afectar a la insulina.',
      'Antes de viajar, mira las normas de seguridad en la web del aeropuerto '
          'y en la de AESA.',
    ],
    manual: 'Omnipod 5 (guía técnica, España)',
    pagina: '207, 217-218',
  ),
  'bypsopump': AvisoAeropuerto(
    puntos: [
      'Desconecta el catéter del cuerpo durante el despegue y el aterrizaje. En '
          'aviones presurizados no hace falta parar la bomba durante el vuelo.',
      'No la acerques a fuentes de rayos X, como la máquina del equipaje: pide '
          'otro tipo de control.',
      'El manual recomienda apagar el Bluetooth de la bomba al embarcar, al '
          'desembarcar y mientras el avión esté en el aeropuerto, por los '
          'radares. Sin Bluetooth, la app no puede ajustar la insulina: pregunta '
          'a tu equipo médico cómo organizarte.',
    ],
    manual: 'YpsoPump',
    pagina: '181-182',
  ),
  'sdexg7': AvisoAeropuerto(
    puntos: [
      'Arco detector de metales y escáner corporal: sí, puedes pasar con el '
          'sensor puesto.',
      'Mientras estés en el control sin el móvil ni el receptor, decide con el '
          'medidor de glucosa.',
      'Rayos X del equipaje: pide que revisen a mano cualquier parte del '
          'sistema en lugar de pasarla por la máquina.',
      'En el avión, pon el móvil en modo avión. El receptor puede seguir '
          'encendido.',
    ],
    manual: 'Dexcom G7',
    pagina: '14, 135',
  ),
  'sdexg6': AvisoAeropuerto(
    puntos: [
      'Arco detector de metales, detector de varilla, cacheo o revisión a mano: '
          'sí.',
      'Escáner corporal y rayos X del equipaje: mejor evitarlos. Pide un '
          'detector de varilla o un cacheo.',
      'Si pasas por el arco, decide con el medidor de glucosa hasta salir del '
          'control.',
      'En el avión, pon el móvil en modo avión y activa el Bluetooth.',
    ],
    manual: 'Dexcom G6',
    pagina: '267-268',
  ),
  'sinstinct': AvisoAeropuerto(
    puntos: [
      ..._abbott,
      'Con el móvil en modo avión no recibes alarmas ni lecturas, salvo que '
          'actives el Bluetooth.',
    ],
    manual: 'Instinct',
    pagina: '11',
  ),
  'sfreelibre2plus': AvisoAeropuerto(
    puntos: _abbott,
    manual: 'FreeStyle Libre 2 / 2 Plus',
    pagina: '83',
  ),
  'sfreelibre3': AvisoAeropuerto(
    puntos: _abbott,
    manual: 'FreeStyle Libre 3 / 3 Plus',
    pagina: '89',
  ),
};
