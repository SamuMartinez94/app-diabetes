import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_diabetes/resultado.dart';
import 'package:app_diabetes/servicios/preferencias.dart';
import 'package:app_diabetes/tema.dart';

Future<void> conConfiguracion() async {
  SharedPreferences.setMockInitialValues({});
  await Preferencias.inicializar();
  await Preferencias.guardarConfiguracion(
    bomba: 'btandem',
    sensor: 'sdexg7',
    cateter: 'cautosoft90',
  );
}

Widget panel() => MaterialApp(
  theme: temaClaro,
  home: const ResultadoScreen(
    bomba: 'btandem',
    sensor: 'sdexg7',
    cateter: 'cautosoft90',
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(conConfiguracion);

  testWidgets('El panel ofrece el botón Cambiar a mano', (tester) async {
    await tester.pumpWidget(panel());

    expect(find.text('Cambiar'), findsOneWidget);
    expect(find.text('TU CONFIGURACIÓN'), findsOneWidget);
  });

  testWidgets('Cambiar pide confirmación antes de nada', (tester) async {
    await tester.pumpWidget(panel());

    await tester.tap(find.text('Cambiar'));
    await tester.pumpAndSettle();

    expect(find.text('¿Elegir otra configuración?'), findsOneWidget);
    expect(find.text('Cancelar'), findsOneWidget);
    // La configuración sigue intacta mientras no se confirme.
    expect(Preferencias.hayConfiguracion, isTrue);
  });

  testWidgets('Cancelar deja todo como estaba', (tester) async {
    await tester.pumpWidget(panel());

    await tester.tap(find.text('Cambiar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(find.text('¿Elegir otra configuración?'), findsNothing);
    expect(Preferencias.hayConfiguracion, isTrue);
    expect(find.text('Panel de Control'), findsOneWidget);
  });

  testWidgets('Confirmar borra la configuración y abre el asistente', (
    tester,
  ) async {
    await tester.pumpWidget(panel());

    await tester.tap(find.text('Cambiar'));
    await tester.pumpAndSettle();

    // El botón del diálogo, no el del panel que quedó debajo.
    await tester.tap(find.widgetWithText(FilledButton, 'Cambiar'));
    await tester.pumpAndSettle();

    expect(Preferencias.hayConfiguracion, isFalse);
    expect(find.text('¿Qué bomba usas?'), findsOneWidget);
  });
}
