import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_diabetes/bombas.dart';
import 'package:app_diabetes/buscador.dart';
import 'package:app_diabetes/cambio_sensor.dart';
import 'package:app_diabetes/datos/alarmas.dart';
import 'package:app_diabetes/datos/guias_cateter.dart';
import 'package:app_diabetes/datos/guias_sensor.dart';
import 'package:app_diabetes/disclaimer.dart';
import 'package:app_diabetes/modelos/registro_insercion.dart';
import 'package:app_diabetes/servicios/preferencias.dart';
import 'package:app_diabetes/tema.dart';

Future<void> prefsVacias() async {
  SharedPreferences.setMockInitialValues({});
  await Preferencias.inicializar();
}

/// Envuelve una pantalla con el tema de la app, que los widgets necesitan
/// para leer `context.colores`.
Widget conTema(Widget hijo, {ThemeMode modo = ThemeMode.light}) => MaterialApp(
  theme: temaClaro,
  darkTheme: temaOscuro,
  themeMode: modo,
  home: hijo,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Asistente de configuración', () {
    setUp(prefsVacias);

    testWidgets('La primera pantalla pregunta por la bomba', (tester) async {
      await tester.pumpWidget(conTema(const BombasScreen()));

      expect(find.text('¿Qué bomba usas?'), findsOneWidget);
    });

    testWidgets('Al elegir bomba se avanza a la selección de sensor', (
      tester,
    ) async {
      await tester.pumpWidget(conTema(const BombasScreen()));

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      expect(find.text('Selecciona tu sensor'), findsOneWidget);
    });

    testWidgets('El botón atrás limpia la selección de sensor', (tester) async {
      await tester.pumpWidget(conTema(const BombasScreen()));

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();

      expect(find.text('¿Qué bomba usas?'), findsOneWidget);
    });
  });

  group('Aviso médico', () {
    setUp(prefsVacias);

    testWidgets('Avisa al aceptar, para que lo gestione quien la abre', (
      tester,
    ) async {
      var aceptado = false;

      await tester.pumpWidget(
        conTema(DisclaimerScreen(alAceptar: () => aceptado = true)),
      );

      expect(aceptado, isFalse);

      await tester.tap(find.text('Entiendo y continúo'));
      await tester.pumpAndSettle();

      expect(aceptado, isTrue);
    });

    testWidgets('En modo consulta no muestra el botón de aceptar', (
      tester,
    ) async {
      await tester.pumpWidget(
        conTema(const DisclaimerScreen(requiereAceptacion: false)),
      );

      expect(find.text('Entiendo y continúo'), findsNothing);
      expect(find.text('Aviso importante'), findsOneWidget);
    });
  });

  group('Persistencia local', () {
    setUp(prefsVacias);

    test('Sin nada guardado no hay configuración', () {
      expect(Preferencias.hayConfiguracion, isFalse);
    });

    test('Se guarda y se recupera la configuración elegida', () async {
      await Preferencias.guardarConfiguracion(
        bomba: 'btandem',
        sensor: 'sdexg7',
        cateter: 'cautosoft90',
      );

      expect(Preferencias.hayConfiguracion, isTrue);
      expect(Preferencias.bomba, 'btandem');
      expect(Preferencias.sensor, 'sdexg7');
      expect(Preferencias.cateter, 'cautosoft90');
    });

    test('Al borrar la configuración se vuelve al estado inicial', () async {
      await Preferencias.guardarConfiguracion(
        bomba: 'bomnipod',
        sensor: 'sdexg6',
        cateter: 'cpod',
      );
      await Preferencias.borrarConfiguracion();

      expect(Preferencias.hayConfiguracion, isFalse);
    });

    test('El tema se guarda y se recupera', () async {
      expect(Preferencias.tema, ThemeMode.system);

      await Preferencias.guardarTema(ThemeMode.dark);
      expect(Preferencias.tema, ThemeMode.dark);
    });

    test('Los ajustes de recordatorio tienen valores por defecto sensatos', () {
      expect(Preferencias.recordatoriosActivos, isFalse);
      expect(Preferencias.diasCateter, 3);
      expect(Preferencias.diasSensor, 10);
    });

    test('Las inserciones se anotan y se limitan a las 20 últimas', () async {
      for (var i = 0; i < 25; i++) {
        await Preferencias.anotarInsercion(
          RegistroInsercion(
            zona: 'abdomen_sup_izq',
            tipo: 'cateter',
            fecha: DateTime.now().subtract(Duration(days: i)),
          ),
        );
      }

      expect(Preferencias.registros.length, 20);
      expect(Preferencias.registros.first.zona, 'abdomen_sup_izq');
    });

    test('Cada cambio incrementa la revisión para refrescar la interfaz', () async {
      final antes = Preferencias.revision.value;
      await Preferencias.guardarRotacion(false);

      expect(Preferencias.revision.value, greaterThan(antes));
    });
  });

  group('Contenido pendiente de revisar', () {
    test('Todas las guías de sensor están marcadas para revisión', () {
      expect(guiasSensorPorRevisar, hasLength(instruccionesSensor.length));
      for (final clave in instruccionesSensor.keys) {
        expect(
          guiasSensorPorRevisar.contains(clave),
          isTrue,
          reason: 'La guía de sensor "$clave" no está marcada para revisar',
        );
      }
    });

    test('Todas las guías de catéter están marcadas para revisión', () {
      expect(guiasCateterPorRevisar, hasLength(instruccionesCateter.length));
      for (final clave in instruccionesCateter.keys) {
        expect(
          guiasCateterPorRevisar.contains(clave),
          isTrue,
          reason: 'La guía de catéter "$clave" no está marcada para revisar',
        );
      }
    });

    test('Todas las alarmas están marcadas para revisión', () {
      for (final alarma in alarmas) {
        expect(
          alarmasPorRevisar.contains(alarma.id),
          isTrue,
          reason: 'La alarma "${alarma.id}" no está marcada para revisar',
        );
      }
    });

    test('No hay claves de revisión huérfanas', () {
      final idsAlarmas = alarmas.map((a) => a.id).toSet();
      expect(alarmasPorRevisar.difference(idsAlarmas), isEmpty);
      expect(
        guiasSensorPorRevisar.difference(instruccionesSensor.keys.toSet()),
        isEmpty,
      );
      expect(
        guiasCateterPorRevisar.difference(instruccionesCateter.keys.toSet()),
        isEmpty,
      );
    });

    testWidgets('Una guía sin revisar muestra el aviso de borrador', (
      tester,
    ) async {
      await tester.pumpWidget(
        conTema(const CambioSensorScreen(bomba: 'btandem', sensor: 'sdexg7')),
      );

      expect(find.textContaining('Borrador sin revisar'), findsOneWidget);
    });
  });

  group('Cobertura de guías', () {
    // Cada combinación que el asistente permite elegir debe tener guía.
    const combinacionesSensor = {
      'bmedtronic': ['sguardian', 'ssimplera'],
      'btandem': ['sdexg6', 'sdexg7'],
      'bomnipod': ['sdexg6', 'sdexg7'],
      'bypsopump': ['sdexg6', 'sfreelibre3'],
    };

    test('Todas las combinaciones bomba+sensor tienen guía', () {
      combinacionesSensor.forEach((bomba, sensores) {
        for (final sensor in sensores) {
          expect(
            instruccionesSensor.containsKey('${bomba}_$sensor'),
            isTrue,
            reason: 'Falta la guía de sensor ${bomba}_$sensor',
          );
        }
      });
    });

    test('El Pod tiene guía de catéter propia', () {
      expect(instruccionesCateter.containsKey('bomnipod_$kCateterPod'), isTrue);
    });
  });

  group('Buscador', () {
    setUp(prefsVacias);

    test('normalizar quita tildes y mayúsculas', () {
      expect(normalizar('Oclusión'), 'oclusion');
      expect(normalizar('BATERÍA'), 'bateria');
    });

    testWidgets('Encuentra una alarma escribiendo sin tildes', (tester) async {
      await tester.pumpWidget(conTema(const BuscadorScreen(apartados: [])));

      await tester.enterText(find.byType(TextField), 'oclusion');
      await tester.pumpAndSettle();

      expect(find.text('Oclusión / Flujo bloqueado'), findsOneWidget);
    });

    testWidgets('Encuentra una alarma por su sinónimo', (tester) async {
      await tester.pumpWidget(conTema(const BuscadorScreen(apartados: [])));

      await tester.enterText(find.byType(TextField), 'no pasa insulina');
      await tester.pumpAndSettle();

      expect(find.text('Oclusión / Flujo bloqueado'), findsOneWidget);
    });

    testWidgets('Encuentra apartados de la app, no solo alarmas', (
      tester,
    ) async {
      final apartados = [
        Apartado(
          titulo: 'Kit de viaje',
          subtitulo: 'Qué llevar.',
          icono: Icons.luggage_outlined,
          palabras: const ['viaje', 'maleta', 'aeropuerto'],
          construir: (_) => const SizedBox.shrink(),
        ),
      ];

      await tester.pumpWidget(conTema(BuscadorScreen(apartados: apartados)));

      await tester.enterText(find.byType(TextField), 'aeropuerto');
      await tester.pumpAndSettle();

      expect(find.text('Kit de viaje'), findsOneWidget);
    });

    testWidgets('Solo ofrece alarmas de la bomba del usuario', (tester) async {
      await Preferencias.guardarConfiguracion(
        bomba: 'bmedtronic',
        sensor: 'sguardian',
        cateter: 'cmio',
      );

      await tester.pumpWidget(conTema(const BuscadorScreen(apartados: [])));
      await tester.enterText(find.byType(TextField), 'pod');
      await tester.pumpAndSettle();

      // "Pod caducado" es de Omnipod: no debe aparecer con una Medtronic.
      expect(find.text('Pod caducado'), findsNothing);
    });

    testWidgets('Sin resultados muestra una explicación', (tester) async {
      await tester.pumpWidget(conTema(const BuscadorScreen(apartados: [])));

      await tester.enterText(find.byType(TextField), 'zzzzqqq');
      await tester.pumpAndSettle();

      expect(find.textContaining('Nada coincide'), findsOneWidget);
    });
  });

  group('Tema', () {
    test('Claro y oscuro definen los colores propios de la app', () {
      expect(temaClaro.extension<ColoresApp>(), isNotNull);
      expect(temaOscuro.extension<ColoresApp>(), isNotNull);
    });

    test('El fondo cambia entre claro y oscuro', () {
      expect(
        temaClaro.scaffoldBackgroundColor,
        isNot(temaOscuro.scaffoldBackgroundColor),
      );
    });

    testWidgets('En modo oscuro no se pintan fondos blancos fijos', (
      tester,
    ) async {
      await tester.pumpWidget(
        conTema(const BombasScreen(), modo: ThemeMode.dark),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, isNot(Colors.white));
    });
  });
}
