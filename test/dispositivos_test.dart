import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_diabetes/datos/dispositivos.dart';
import 'package:app_diabetes/datos/guias_cateter.dart';
import 'package:app_diabetes/datos/guias_sensor.dart';
import 'package:app_diabetes/resultado.dart';
import 'package:app_diabetes/servicios/preferencias.dart';
import 'package:app_diabetes/tema.dart';

Widget panel({
  required String bomba,
  required String sensor,
  required String cateter,
}) => MaterialApp(
  theme: temaClaro,
  home: ResultadoScreen(bomba: bomba, sensor: sensor, cateter: cateter),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Preferencias.inicializar();
  });

  group('Nombres en el panel', () {
    testWidgets('La bomba muestra su etiqueta y su nombre', (tester) async {
      await tester.pumpWidget(
        panel(bomba: 'btandem', sensor: 'sdexg7', cateter: 'cautosoft90'),
      );

      expect(find.text('Bomba'), findsOneWidget);
      expect(find.text('Tandem'), findsOneWidget);
    });

    testWidgets('El sensor muestra su etiqueta y su nombre', (tester) async {
      await tester.pumpWidget(
        panel(bomba: 'btandem', sensor: 'sdexg7', cateter: 'cautosoft90'),
      );

      expect(find.text('Sensor'), findsOneWidget);
      expect(find.text('Dexcom G7'), findsOneWidget);
    });

    testWidgets('El catéter muestra etiqueta pero no nombre', (tester) async {
      await tester.pumpWidget(
        panel(bomba: 'btandem', sensor: 'sdexg7', cateter: 'cautosoft90'),
      );

      expect(find.text('Catéter'), findsOneWidget);
      expect(find.text('AutoSoft 90'), findsNothing);
    });

    testWidgets('Con Omnipod no se muestra el catéter', (tester) async {
      await tester.pumpWidget(
        panel(bomba: 'bomnipod', sensor: 'sdexg6', cateter: 'cpod'),
      );

      expect(find.text('Omnipod'), findsOneWidget);
      expect(find.text('Catéter'), findsNothing);
    });

    testWidgets('Un nombre largo no desborda la fila', (tester) async {
      // Un desbordamiento haría fallar el test con excepción de layout.
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        panel(bomba: 'bypsopump', sensor: 'sfreelibre3', cateter: 'corbit'),
      );

      expect(find.text('YpsoPump'), findsOneWidget);
      expect(find.text('FreeStyle Libre 3'), findsOneWidget);
    });
  });

  group('Cobertura del mapa de nombres', () {
    /// Todos los ids que aparecen en las claves de las guías.
    Set<String> idsDeGuias(Iterable<String> claves, {required bool bomba}) =>
        claves.map((c) => bomba ? c.split('_').first : c.split('_').last).toSet();

    test('Todas las bombas tienen nombre', () {
      final bombas = idsDeGuias(instruccionesCateter.keys, bomba: true);
      for (final id in bombas) {
        expect(nombresDispositivos.containsKey(id), isTrue, reason: id);
      }
    });

    test('Todos los sensores tienen nombre', () {
      final sensores = idsDeGuias(instruccionesSensor.keys, bomba: false);
      for (final id in sensores) {
        expect(nombresDispositivos.containsKey(id), isTrue, reason: id);
      }
    });

    test('Todos los catéteres tienen nombre', () {
      final cateteres = idsDeGuias(instruccionesCateter.keys, bomba: false);
      for (final id in cateteres) {
        expect(nombresDispositivos.containsKey(id), isTrue, reason: id);
      }
    });

    test('Un id desconocido se devuelve tal cual, sin romper', () {
      expect(nombreDispositivo('sinventado'), 'sinventado');
    });
  });
}
