import 'package:flutter_test/flutter_test.dart';

import 'package:diaguia/datos/aeropuerto.dart';
import 'package:diaguia/datos/dispositivos.dart';

void main() {
  test('Cada bomba tiene lo que dice su manual sobre el aeropuerto', () {
    final bombas = nombresDispositivos.keys.where((id) => id.startsWith('b'));
    for (final bomba in bombas) {
      expect(avisosAeropuerto[bomba], isNotNull, reason: bomba);
    }
  });

  test('Cada aviso cita su manual y su página', () {
    avisosAeropuerto.forEach((id, aviso) {
      expect(aviso.puntos, isNotEmpty, reason: id);
      expect(aviso.manual, isNotEmpty, reason: id);
      expect(aviso.pagina, isNotEmpty, reason: id);
    });
  });
}
