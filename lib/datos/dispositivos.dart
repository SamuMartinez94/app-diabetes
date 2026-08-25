/// Nombre comercial de cada dispositivo, a partir de su identificador interno.
///
/// Los identificadores (`btandem`, `sdexg7`…) son los que se usan como clave
/// en las guías y en las preferencias; esto es solo lo que ve el usuario.
const Map<String, String> nombresDispositivos = {
  // --- BOMBAS ---
  'bmedtronic': 'Medtronic',
  'btandem': 'Tandem',
  'bomnipod': 'Omnipod',
  'bypsopump': 'YpsoPump',

  // --- SENSORES ---
  'sdexg6': 'Dexcom G6',
  'sdexg7': 'Dexcom G7',
  'sfreelibre3': 'FreeStyle Libre 3',
  'sguardian': 'Guardian 4',
  'ssimplera': 'Simplera Sync',

  // --- CATÉTERES ---
  'cextended': 'Extended',
  'cmio': 'Mio',
  'cmio30': 'Mio 30',
  'cquickset': 'Quick-set',
  'csilhouette': 'Silhouette',
  'csuret': 'Sure-T',
  'cpod': 'Pod',
  'corbit': 'Orbit',
  'cinset': 'Inset',
  'cautosoft90': 'AutoSoft 90',
  'cautosoft30': 'AutoSoft 30',
  'ctrusteel': 'TruSteel',
};

/// Devuelve el nombre comercial, o el propio identificador si no está en el
/// mapa: es preferible mostrar `sdexg9` que dejar el hueco vacío.
String nombreDispositivo(String id) => nombresDispositivos[id] ?? id;
