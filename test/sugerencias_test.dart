import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_diabetes/cambio_cateter.dart';
import 'package:app_diabetes/configuracion.dart';
import 'package:app_diabetes/datos/sugerencias.dart';
import 'package:app_diabetes/servicios/preferencias.dart';
import 'package:app_diabetes/servicios/sugerencias.dart';
import 'package:app_diabetes/tema.dart';

Future<void> prefs({bool modoSugerencias = false}) async {
  SharedPreferences.setMockInitialValues({});
  await Preferencias.inicializar();
  if (modoSugerencias) {
    await Preferencias.guardarModoSugerencias(true);
  }
}

Widget conTema(Widget hijo) =>
    MaterialApp(theme: temaClaro, darkTheme: temaOscuro, home: hijo);

Widget guia() => conTema(
  const CambioCateterScreen(bomba: 'bmedtronic', cateter: 'cmio30'),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Visibilidad del botón', () {
    testWidgets('Un usuario normal no ve el botón de sugerir', (tester) async {
      await prefs();
      await tester.pumpWidget(guia());

      expect(find.text('Sugerir un cambio aquí'), findsNothing);
    });

    testWidgets('En modo sugerencias aparece en la guía', (tester) async {
      await prefs(modoSugerencias: true);
      await tester.pumpWidget(guia());

      expect(find.text('Sugerir un cambio aquí'), findsOneWidget);
    });

    testWidgets('El distintivo solo sale en modo sugerencias', (tester) async {
      await prefs();
      await tester.pumpWidget(guia());
      expect(find.textContaining('Modo sugerencias activo'), findsNothing);
    });
  });

  group('Activación con código', () {
    testWidgets('Un código incorrecto no activa el modo', (tester) async {
      await prefs();
      await tester.pumpWidget(conTema(const ConfiguracionScreen()));

      await tester.scrollUntilVisible(find.text('Modo sugerencias'), 200);
      await tester.tap(find.text('Modo sugerencias'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '0000');
      await tester.tap(find.text('Activar'));
      await tester.pumpAndSettle();

      expect(Preferencias.modoSugerencias, isFalse);
      expect(find.text('Código incorrecto.'), findsOneWidget);
    });

    testWidgets('El código correcto activa el modo', (tester) async {
      await prefs();
      await tester.pumpWidget(conTema(const ConfiguracionScreen()));

      await tester.scrollUntilVisible(find.text('Modo sugerencias'), 200);
      await tester.tap(find.text('Modo sugerencias'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), kCodigoModoSugerencias);
      await tester.tap(find.text('Activar'));
      await tester.pumpAndSettle();

      expect(Preferencias.modoSugerencias, isTrue);
    });

    testWidgets('Cancelar no activa nada', (tester) async {
      await prefs();
      await tester.pumpWidget(conTema(const ConfiguracionScreen()));

      await tester.scrollUntilVisible(find.text('Modo sugerencias'), 200);
      await tester.tap(find.text('Modo sugerencias'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(Preferencias.modoSugerencias, isFalse);
    });

    testWidgets('Se puede desactivar desde el interruptor', (tester) async {
      await prefs(modoSugerencias: true);
      await tester.pumpWidget(conTema(const ConfiguracionScreen()));

      await tester.scrollUntilVisible(
        find.text('Modo sugerencias activo'),
        200,
      );
      await tester.tap(find.byType(Switch).last);
      await tester.pumpAndSettle();

      expect(Preferencias.modoSugerencias, isFalse);
    });
  });

  group('Configuración del formulario', () {
    test('El formulario está configurado', () {
      expect(formularioConfigurado, isTrue);
    });

    test('Los cuatro campos son distintos entre sí', () {
      final campos = {
        kCampoNombre,
        kCampoSugerencia,
        kCampoUbicacion,
        kCampoVersion,
      };
      expect(campos, hasLength(4), reason: 'Hay ids repetidos');
    });

    test('Todos los campos tienen el formato entry.NNNN', () {
      for (final campo in [
        kCampoNombre,
        kCampoSugerencia,
        kCampoUbicacion,
        kCampoVersion,
      ]) {
        expect(RegExp(r'^entry\.\d+$').hasMatch(campo), isTrue, reason: campo);
      }
    });

    test('La URL apunta a un formulario de Google, sin parámetros sueltos', () {
      final uri = Uri.parse(kFormularioUrl);

      expect(uri.scheme, 'https');
      expect(uri.host, 'docs.google.com');
      expect(uri.path, endsWith('/viewform'));
      expect(uri.queryParameters, isEmpty);
    });

    test('La URL construida lleva la ubicación en su campo', () {
      final uri = Sugerencias.construirUrl('Guía bmedtronic_cmio30 — paso 4');

      expect(uri.queryParameters[kCampoUbicacion],
          'Guía bmedtronic_cmio30 — paso 4');
      expect(uri.queryParameters['usp'], 'pp_url');
      // Nombre y sugerencia los escribe la persona, no la app.
      expect(uri.queryParameters.containsKey(kCampoNombre), isFalse);
      expect(uri.queryParameters.containsKey(kCampoSugerencia), isFalse);
    });

    test('El código de activación no está vacío', () {
      expect(kCodigoModoSugerencias.trim(), isNotEmpty);
    });
  });
}
