import 'package:flutter_test/flutter_test.dart';

import 'package:diaguia/datos/alarmas.dart';
import 'package:diaguia/datos/guias_cateter.dart';
import 'package:diaguia/datos/guias_sensor.dart';
import 'package:diaguia/modelos/paso.dart';

String textoDe(List<Paso> pasos) => pasos.map((p) => p.texto).join(' ');

void main() {
  group('Datos concretos tomados de los manuales', () {
    test('Omnipod: se avisa de la línea MÍN de la jeringa, sin dar cifras', () {
      final texto = textoDe(instruccionesCateter['bomnipod_cpod']!);
      expect(texto, contains('MÍN'));
      expect(texto, isNot(contains('85')));
    });

    test('Omnipod: distancia mínima al sensor Dexcom', () {
      expect(textoDe(instruccionesCateter['bomnipod_cpod']!), contains('8 cm'));
    });

    test('Tandem: conexión del tubo hermética (guía de 2025)', () {
      final texto = textoDe(instruccionesCateter['btandem_cautosoft90']!);
      expect(texto, contains('hermética'));
      expect(texto.toUpperCase(), isNot(contains('CUARTO DE VUELTA')));
    });

    test('YpsoPump myOrbit Soft: límite de 72 horas', () {
      expect(
        textoDe(instruccionesCateter['bypsopump_corbit']!),
        contains('72 horas'),
      );
    });

    test('YpsoPump myOrbit Micro: límite de 48 horas', () {
      expect(
        textoDe(instruccionesCateter['bypsopump_corbitmicro']!),
        contains('48 horas'),
      );
    });

    test('YpsoPump myInset: cambio cada dos o tres días', () {
      expect(
        textoDe(instruccionesCateter['bypsopump_cinset']!),
        contains('cada dos o tres días'),
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

    test('Medtronic recuerda medir la glucosa tras el cambio', () {
      expect(
        textoDe(instruccionesCateter['bmedtronic_cmio30']!).toLowerCase(),
        contains('glucosa'),
      );
    });
  });

  group('Lenguaje para quien empieza', () {
    /// Todos los textos que ve una persona en las guías y las alarmas.
    List<String> textosVisibles() => [
      for (final mapa in [
        instruccionesCateter,
        instruccionesSensor,
        instruccionesSoloReservorio,
      ])
        for (final pasos in mapa.values) ...pasos.map((p) => p.texto),
      for (final a in alarmas) ...[a.titulo, a.significado, ...a.queHacer],
    ];

    test('No se dan cantidades de insulina ni volúmenes', () {
      // "0,5 U", "1,6 ml", "45 unidades"…
      final cantidad = RegExp(
        r'\b\d+([.,]\d+)?\s?(u|ui|ml|unidades|unidad)\b',
        caseSensitive: false,
      );
      for (final texto in textosVisibles()) {
        expect(
          cantidad.hasMatch(texto),
          isFalse,
          reason: 'Lleva una cantidad: "${texto.split("\n").first}"',
        );
      }
    });

    test(
      'Se habla de pluma y no de jeringa fuera del llenado del cartucho',
      () {
        for (final texto in textosVisibles()) {
          final minusculas = texto.toLowerCase();
          final habla = minusculas.contains('jeringa');
          final esLlenado =
              minusculas.contains('llen') ||
              minusculas.contains('aire') ||
              minusculas.contains('aguja');
          expect(
            !habla || esLlenado,
            isTrue,
            reason: 'Usa "jeringa" sin ser del llenado: "$texto"',
          );
        }
      },
    );
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
