import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diaguia/bombas.dart';
import 'package:diaguia/errores.dart';
import 'package:diaguia/l10n/idioma.dart';
import 'package:diaguia/servicios/preferencias.dart';
import 'package:diaguia/tema.dart';
import 'package:diaguia/widgets/selector_idioma.dart';

Future<void> prefsVacias() async {
  SharedPreferences.setMockInitialValues({});
  await Preferencias.inicializar();
}

Widget app(Widget hijo) => ValueListenableBuilder<int>(
  valueListenable: Preferencias.revision,
  builder: (context, _, _) => MaterialApp(
    theme: temaClaro,
    locale: Traductor.actual.locale,
    supportedLocales: Idioma.values.map((i) => i.locale).toList(),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: hijo,
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(prefsVacias);
  tearDown(() => Traductor.actual = Idioma.es);

  group('Traductor', () {
    test('En castellano devuelve el texto tal cual', () {
      expect(t('Cancelar'), 'Cancelar');
    });

    test('Traduce a cada idioma', () {
      Traductor.actual = Idioma.en;
      expect(t('Cancelar'), 'Cancel');
      Traductor.actual = Idioma.gl;
      expect(t('Cancelar'), 'Cancelar');
      Traductor.actual = Idioma.ca;
      expect(t('Cancelar'), 'Cancel·lar');
      Traductor.actual = Idioma.eu;
      expect(t('Cancelar'), 'Utzi');
    });

    test(
      'Un texto sin traducción cae en castellano en vez de quedar vacío',
      () {
        Traductor.actual = Idioma.eu;
        expect(t('Texto que no existe'), 'Texto que no existe');
      },
    );

    test('tf rellena los marcadores', () {
      Traductor.actual = Idioma.en;
      expect(tf('Hace {n} días', {'n': 3}), '3 days ago');
      Traductor.actual = Idioma.es;
      expect(tf('Hace {n} días', {'n': 3}), 'Hace 3 días');
    });

    test('Idioma.deCodigo reconoce los cinco idiomas y rechaza el resto', () {
      for (final idioma in Idioma.values) {
        expect(Idioma.deCodigo(idioma.codigo), idioma);
      }
      expect(Idioma.deCodigo('fr'), isNull);
      expect(Idioma.deCodigo(null), isNull);
    });
  });

  group('Persistencia', () {
    test('Sin nada guardado arranca en castellano', () {
      expect(Preferencias.hayIdiomaGuardado, isFalse);
      expect(Traductor.actual, Idioma.es);
    });

    test('El idioma elegido se recuerda al reabrir la app', () async {
      await Preferencias.guardarIdioma(Idioma.eu);
      expect(Traductor.actual, Idioma.eu);

      Traductor.actual = Idioma.es;
      await Preferencias.inicializar();

      expect(Preferencias.hayIdiomaGuardado, isTrue);
      expect(Traductor.actual, Idioma.eu);
    });
  });

  group('Cambio instantáneo', () {
    testWidgets('Las banderas cambian el texto sin cerrar la pantalla', (
      tester,
    ) async {
      await tester.pumpWidget(app(const BombasScreen()));
      expect(find.text('¿Qué bomba usas?'), findsOneWidget);

      await tester.tap(find.byType(BotonIdioma));
      await tester.pumpAndSettle();
      expect(find.byType(Bandera), findsNWidgets(Idioma.values.length + 1));

      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      expect(find.text('Which pump do you use?'), findsOneWidget);
      expect(find.text('¿Qué bomba usas?'), findsNothing);
    });

    testWidgets('Las pantallas que quedan debajo también se actualizan', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(
          const ErroresScreen(
            bomba: 'btandem',
            sensor: 'sdexg7',
            cateter: 'cautosoft90',
          ),
        ),
      );
      // Se abre una pantalla encima y se cambia el idioma desde ella: al
      // volver, la de debajo ya tiene que estar en el idioma nuevo.
      final navegador = tester.state<NavigatorState>(find.byType(Navigator));
      navegador.push(MaterialPageRoute<void>(builder: (_) => const Scaffold()));
      await tester.pumpAndSettle();

      await Preferencias.guardarIdioma(Idioma.ca);
      await tester.pumpAndSettle();

      navegador.pop();
      await tester.pumpAndSettle();

      expect(find.text('Resoldre problemes'), findsOneWidget);
    });

    testWidgets('Elegir un idioma lo guarda', (tester) async {
      await tester.pumpWidget(app(const Scaffold(body: SelectorIdioma())));

      await tester.tap(find.text('Galego'));
      await tester.pumpAndSettle();

      expect(Traductor.actual, Idioma.gl);
      expect(Preferencias.hayIdiomaGuardado, isTrue);
    });
  });
}
