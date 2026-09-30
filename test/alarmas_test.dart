import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diaguia/datos/alarmas.dart';
import 'package:diaguia/errores.dart';
import 'package:diaguia/l10n/idioma.dart';
import 'package:diaguia/servicios/preferencias.dart';
import 'package:diaguia/tema.dart';

/// Combinaciones que se pueden elegir en la app (ver `bombas.dart`).
const _combinaciones = {
  'bmedtronic': ['sguardian', 'ssimplera'],
  'btandem': ['sdexg6', 'sdexg7'],
  'bomnipod': ['sdexg6', 'sdexg7'],
  'bypsopump': ['sdexg6', 'sfreelibre3'],
};

Widget _app(Widget hijo) => MaterialApp(theme: temaClaro, home: hijo);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Traductor.actual = Idioma.es;
    SharedPreferences.setMockInitialValues({});
    await Preferencias.inicializar();
  });

  group('Alarmas por dispositivo', () {
    test('Toda bomba y todo sensor tienen avisos que mostrar', () {
      _combinaciones.forEach((bomba, sensores) {
        for (final sensor in sensores) {
          final lista = alarmasPara(bomba: bomba, sensor: sensor);
          expect(
            lista.any((a) => !a.deSensor),
            isTrue,
            reason: 'Sin avisos de bomba para $bomba + $sensor',
          );
          expect(
            lista.any((a) => a.deSensor),
            isTrue,
            reason: 'Sin avisos de sensor para $bomba + $sensor',
          );
        }
      });
    });

    test('Los avisos de una bomba no aparecen con otra', () {
      final ids = alarmasPara(
        bomba: 'btandem',
        sensor: 'sdexg7',
      ).map((a) => a.id);
      expect(ids, contains('tandem_oclusion'));
      expect(ids.any((id) => id.startsWith('mm_')), isFalse);
      expect(ids.any((id) => id.startsWith('pod_')), isFalse);
    });

    test('Los avisos de un sensor no aparecen con otro', () {
      final ids = alarmasPara(
        bomba: 'btandem',
        sensor: 'sdexg7',
      ).map((a) => a.id);
      expect(ids, contains('g7_perdida_senal'));
      expect(ids.any((id) => id.startsWith('g6_')), isFalse);
      expect(ids.any((id) => id.startsWith('libre')), isFalse);
    });

    test('Los avisos de Simplera y Guardian solo salen con una MiniMed', () {
      final conTandem = alarmasPara(bomba: 'btandem', sensor: 'ssimplera');
      expect(conTandem.any((a) => a.id.startsWith('mm_')), isFalse);

      final conMedtronic = alarmasPara(
        bomba: 'bmedtronic',
        sensor: 'ssimplera',
      );
      expect(conMedtronic.any((a) => a.id == 'mm_senal_perdida'), isTrue);
    });
  });

  group('Asistente de resolver problemas', () {
    Future<void> abrir(WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          const ErroresScreen(
            bomba: 'btandem',
            sensor: 'sdexg7',
            cateter: 'cautosoft90',
          ),
        ),
      );
    }

    testWidgets('Ofrece elegir entre bomba y sensor', (tester) async {
      await abrir(tester);

      expect(
        find.textContaining('Cuéntame qué problema tienes'),
        findsOneWidget,
      );
      expect(find.textContaining('Problema con la bomba'), findsOneWidget);
      expect(find.textContaining('Problema con el sensor'), findsOneWidget);
    });

    testWidgets('Enseña el significado, los pasos y la fuente', (tester) async {
      await abrir(tester);

      await tester.tap(find.textContaining('Problema con la bomba'));
      await tester.pumpAndSettle();
      expect(
        find.text('Elige el aviso que sale en la pantalla'),
        findsOneWidget,
      );

      final cartucho = find.textContaining('Cartucho vacío').first;
      await tester.ensureVisible(cartucho);
      await tester.tap(cartucho);
      await tester.pumpAndSettle();

      expect(find.text('QUÉ SIGNIFICA'), findsOneWidget);
      expect(find.text('QUÉ HACER'), findsOneWidget);
      expect(find.textContaining('Tandem t:slim X2'), findsOneWidget);
      expect(find.text('Ver otro aviso'), findsOneWidget);
    });

    testWidgets('Entendido vuelve al principio', (tester) async {
      await abrir(tester);

      await tester.tap(find.textContaining('Problema con el sensor'));
      await tester.pumpAndSettle();
      final perdida = find.textContaining('Pérdida de señal').first;
      await tester.ensureVisible(perdida);
      await tester.tap(perdida);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Entendido'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Problema con la bomba'), findsOneWidget);
    });
  });
}
