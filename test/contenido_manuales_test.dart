import 'package:flutter_test/flutter_test.dart';

import 'package:app_diabetes/datos/alarmas.dart';
import 'package:app_diabetes/datos/guias_cateter.dart';
import 'package:app_diabetes/datos/guias_sensor.dart';
import 'package:app_diabetes/modelos/paso.dart';

String textoDe(List<Paso> pasos) => pasos.map((p) => p.texto).join(' ');

void main() {
  group('Datos concretos tomados de los manuales', () {
    test('Omnipod: mínimo de 85 unidades al llenar el Pod', () {
      expect(textoDe(instruccionesCateter['bomnipod_cpod']!), contains('85'));
    });

    test('Omnipod: distancia mínima al sensor Dexcom', () {
      expect(textoDe(instruccionesCateter['bomnipod_cpod']!), contains('8 cm'));
    });

    test('Tandem: cuarto de vuelta extra en el conector del tubo', () {
      expect(
        textoDe(instruccionesCateter['btandem_cautosoft90']!).toUpperCase(),
        contains('CUARTO DE VUELTA'),
      );
    });

    test('YpsoPump Orbit soft: límite de 72 horas', () {
      expect(
        textoDe(instruccionesCateter['bypsopump_corbit']!),
        contains('72 horas'),
      );
    });

    test('YpsoPump Orbit micro: límite de 48 horas', () {
      expect(
        textoDe(instruccionesCateter['bypsopump_cinset']!),
        contains('48 horas'),
      );
    });

    test('Dexcom G6: calentamiento de 2 horas', () {
      expect(
        textoDe(instruccionesSensor['btandem_sdexg6']!),
        contains('2 HORAS'),
      );
    });

    test('Dexcom G7: adaptación de menos de 30 minutos', () {
      expect(
        textoDe(instruccionesSensor['btandem_sdexg7']!),
        contains('30 MINUTOS'),
      );
    });

    test('Guardian 4 y Simplera son solo de brazo, nunca abdomen', () {
      for (final clave in ['bmedtronic_sguardian', 'bmedtronic_ssimplera']) {
        final texto = textoDe(instruccionesSensor[clave]!).toLowerCase();
        expect(texto, contains('brazo'), reason: clave);
        expect(texto, contains('abdomen'), reason: '$clave debe advertirlo');
      }
    });

    test('Libre 3: solo parte posterior del brazo', () {
      expect(
        textoDe(instruccionesSensor['bypsopump_sfreelibre3']!).toLowerCase(),
        contains('parte posterior del brazo'),
      );
    });

    test('Los equipos de acero avisan de que no se llena cánula', () {
      for (final clave in ['bmedtronic_csuret', 'btandem_ctrusteel']) {
        expect(
          textoDe(instruccionesCateter[clave]!).toLowerCase(),
          contains('acero'),
          reason: clave,
        );
      }
    });

    test('Medtronic recuerda medir la glucemia tras el cambio', () {
      expect(
        textoDe(instruccionesCateter['bmedtronic_cmio']!).toLowerCase(),
        contains('glucemia'),
      );
    });
  });

  group('Integridad del contenido', () {
    test('Ninguna guía de catéter está vacía', () {
      instruccionesCateter.forEach((clave, pasos) {
        expect(pasos, isNotEmpty, reason: clave);
      });
    });

    test('Ninguna guía de sensor está vacía', () {
      instruccionesSensor.forEach((clave, pasos) {
        expect(pasos, isNotEmpty, reason: clave);
      });
    });

    test('Ningún paso tiene el texto en blanco', () {
      for (final mapa in [instruccionesCateter, instruccionesSensor]) {
        mapa.forEach((clave, pasos) {
          for (var i = 0; i < pasos.length; i++) {
            expect(
              pasos[i].texto.trim(),
              isNotEmpty,
              reason: '$clave, paso ${i + 1}',
            );
          }
        });
      }
    });

    test('Ningún texto arrastra comillas sueltas del código', () {
      for (final mapa in [instruccionesCateter, instruccionesSensor]) {
        mapa.forEach((clave, pasos) {
          for (final paso in pasos) {
            expect(paso.texto.trim().startsWith("'"), isFalse, reason: clave);
            expect(paso.texto.trim().endsWith("',"), isFalse, reason: clave);
          }
        });
      }
    });

    test('Toda alarma tiene significado y al menos un paso de actuación', () {
      for (final alarma in alarmas) {
        expect(alarma.significado.trim(), isNotEmpty, reason: alarma.id);
        expect(alarma.queHacer, isNotEmpty, reason: alarma.id);
      }
    });

    test('No hay ids de alarma repetidos', () {
      final ids = alarmas.map((a) => a.id).toList();
      expect(ids.toSet().length, ids.length);
    });
  });
}
