/// Nombre comercial de cada dispositivo, a partir de su identificador.
const Map<String, String> nombresDispositivos = {
  // --- BOMBAS ---
  'bmedtronic': 'MiniMed 780G',
  'btandem': 't:slim X2',
  'btandemmobi': 'Tandem Mobi',
  'bomnipod': 'Omnipod 5',
  'bypsopump': 'YpsoPump',

  // --- SENSORES ---
  'sdexg6': 'Dexcom G6',
  'sdexg7': 'Dexcom G7',
  'sfreelibre2plus': 'FreeStyle Libre 2 Plus',
  'sfreelibre3': 'FreeStyle Libre 3',
  'sguardian': 'Guardian 4',
  'ssimplera': 'Simplera Sync',
  'sinstinct': 'Instinct',

  // --- CATÉTERES ---
  'cextended': 'Extended',
  'cmio30': 'Mio 30',
  'cquickset': 'Quick-set',
  'csilhouette': 'Silhouette',
  'csuret': 'Sure-T',
  'cpod': 'Pod',
  'corbit': 'myOrbit Soft',
  'corbitmicro': 'myOrbit Micro',
  'cinset': 'myInset',
  'cautosoft90': 'AutoSoft 90',
  'cautosoft30': 'AutoSoft 30',
  'ctrusteel': 'TruSteel',
  'cvarisoft': 'VariSoft',
};

/// Devuelve el nombre comercial, o el propio identificador si no está en el mapa.
String nombreDispositivo(String id) => nombresDispositivos[id] ?? id;
