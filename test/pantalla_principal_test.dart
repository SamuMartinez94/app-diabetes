import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diaguia/bombas.dart';
import 'package:diaguia/l10n/idioma.dart';
import 'package:diaguia/resultado.dart';
import 'package:diaguia/servicios/preferencias.dart';
import 'package:diaguia/tema.dart';
import 'package:diaguia/widgets/comunes.dart';
import 'package:diaguia/widgets/selector_idioma.dart';

Widget app(Widget hijo, {ThemeMode modo = ThemeMode.light}) => MaterialApp(
  theme: temaClaro,
  darkTheme: temaOscuro,
  themeMode: modo,
  home: hijo,
);

/// Color de fondo de todos los `Container` con forma de tarjeta o círculo que
/// contienen una imagen de dispositivo.
Iterable<Color?> fondosDeDispositivos(WidgetTester tester) {
  return tester
      .widgetList<ImagenDispositivo>(find.byType(ImagenDispositivo))
      .map((imagen) {
        final contenedor = tester.widget<Container>(
          find
              .ancestor(
                of: find.byWidget(imagen),
                matching: find.byType(Container),
              )
              .first,
        );
        return (contenedor.decoration as BoxDecoration?)?.color;
      });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Preferencias.inicializar();
  });

  group('Banderas', () {
    for (final ancho in [320.0, 360.0, 411.0]) {
      testWidgets('Caben en una sola fila con $ancho px de ancho', (
        tester,
      ) async {
        tester.view.physicalSize = Size(ancho, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          app(
            const Scaffold(
              body: Padding(
                padding: EdgeInsets.all(20),
                child: SelectorIdioma(),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
        final alturas = tester
            .widgetList<Bandera>(find.byType(Bandera))
            .map((b) => tester.getTopLeft(find.byWidget(b)).dy)
            .toList();
        final diferencia =
            alturas.reduce((a, b) => a > b ? a : b) -
            alturas.reduce((a, b) => a < b ? a : b);
        // Una segunda fila estaría decenas de píxeles más abajo.
        expect(
          diferencia,
          lessThan(4),
          reason: 'Hay más de una fila: $alturas',
        );
        expect(find.byType(Bandera), findsNWidgets(Idioma.values.length));
      });
    }
  });

  group('Pestañas de la pantalla principal', () {
    Future<void> abrir(WidgetTester tester) async {
      await tester.pumpWidget(
        app(
          const ResultadoScreen(
            bomba: 'btandem',
            sensor: 'sdexg6',
            cateter: 'cautosoft90',
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('No hay barra de pestañas', (tester) async {
      await abrir(tester);

      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('Hay cuatro accesos y la configuración', (tester) async {
      await abrir(tester);

      expect(find.text('Recambio de catéter'), findsOneWidget);
      expect(find.text('Recambio de sensor'), findsOneWidget);
      expect(find.text('Resolver problemas'), findsOneWidget);
      expect(find.text('Más'), findsOneWidget);
      expect(find.text('TU CONFIGURACIÓN'), findsOneWidget);
    });

    testWidgets('Inicio solo tiene tu configuración y qué necesitas hacer', (
      tester,
    ) async {
      await abrir(tester);

      expect(find.text('TU CONFIGURACIÓN'), findsOneWidget);
      expect(find.text('¿Qué necesitas hacer?'), findsOneWidget);
      expect(find.text('Recambio de catéter'), findsOneWidget);
      // Kit, zonas y soporte se han ido a "Más".
      expect(find.text('Kit de viaje').hitTestable(), findsNothing);
      expect(find.text('Soporte y manuales').hitTestable(), findsNothing);
    });

    testWidgets('Más contiene kit de viaje, zonas y soporte', (tester) async {
      await abrir(tester);
      await tester.tap(find.text('Más'));
      await tester.pumpAndSettle();

      expect(find.text('Kit de viaje'), findsOneWidget);
      expect(find.text('Rotación de zonas'), findsOneWidget);
      expect(find.text('Soporte y manuales'), findsOneWidget);
    });

    testWidgets('Los accesos siguen el idioma', (tester) async {
      await abrir(tester);
      await Preferencias.guardarIdioma(Idioma.en);
      await tester.pumpAndSettle();

      expect(find.text('More'), findsOneWidget);
      Traductor.actual = Idioma.es;
    });
  });

  group('Fondo blanco fijo de los dispositivos', () {
    for (final modo in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('Selección de bomba, en modo ${modo.name}', (tester) async {
        await tester.pumpWidget(app(const BombasScreen(), modo: modo));

        final fondos = fondosDeDispositivos(tester).toList();
        expect(fondos, isNotEmpty);
        expect(fondos, everyElement(Colors.white));
      });

      testWidgets('Tu configuración, en modo ${modo.name}', (tester) async {
        await tester.pumpWidget(
          app(
            const Scaffold(
              body: ResumenConfiguracion(
                bomba: 'btandem',
                sensor: 'sdexg6',
                cateter: 'cautosoft90',
              ),
            ),
            modo: modo,
          ),
        );

        final fondos = fondosDeDispositivos(tester).toList();
        expect(fondos, hasLength(3));
        expect(fondos, everyElement(Colors.white));
      });
    }
  });
}
