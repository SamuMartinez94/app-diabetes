/// ALARMAS Y AVISOS
///
/// Cada aviso indica en qué manual oficial y en qué página está (`manual` y
/// `pagina`), para poder comprobarlo. Los que no llevan manual todavía no se
/// han contrastado con ninguno y la app los marca como "en revisión".
///
/// Fuentes: manuales oficiales de Tandem t:slim X2, MiniMed 780G (con
/// Simplera Sync y Guardian 4), mylife YpsoPump, Omnipod 5, Dexcom G6, Dexcom
/// G7 y la guía de inicio rápido del FreeStyle Libre 3. Cada fichero
/// `alarmas_*.dart` resume las fuentes que ha usado.
library;

import '../modelos/alarma.dart';
import 'alarmas_medtronic.dart';
import 'alarmas_omnipod.dart';
import 'alarmas_sensores.dart';
import 'alarmas_tandem.dart';
import 'alarmas_ypso.dart';

const List<Alarma> alarmas = [
  ...alarmasTandem,
  ...alarmasMedtronic,
  ...alarmasYpso,
  ...alarmasOmnipod,
  ...alarmasSensores,
];

/// Alarmas todavía sin contrastar con el manual oficial del fabricante.
final Set<String> alarmasPorRevisar = {
  for (final a in alarmas)
    if (a.porRevisar) a.id,
};

/// Alarmas que le pueden aparecer a alguien con esta [bomba] y este [sensor].
List<Alarma> alarmasPara({required String bomba, required String sensor}) {
  return alarmas.where((a) {
    final valeBomba = a.bomba.isEmpty || a.bomba == bomba;
    final valeSensor = a.sensores.isEmpty || a.sensores.contains(sensor);
    return valeBomba && valeSensor;
  }).toList();
}
