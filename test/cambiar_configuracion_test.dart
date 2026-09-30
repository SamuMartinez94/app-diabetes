import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diaguia/resultado.dart';
import 'package:diaguia/servicios/preferencias.dart';
import 'package:diaguia/tema.dart';

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

  testWidgets('Tocar un dispositivo ofrece cambiarlo', (tester) async {
    await tester.pumpWidget(panel());

    expect(find.text('TU CONFIGURACIÓN'), findsOneWidget);
    await tester.ensureVisible(find.text('Tandem'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tandem'));
    await tester.pumpAndSettle();

    expect(find.text('¿Elegir otra configuración?'), findsOneWidget);
  });

  testWidgets('Cambiar pide confirmación antes de nada', (tester) async {
    await tester.pumpWidget(panel());

    await tester.ensureVisible(find.text('Tandem'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tandem'));
    await tester.pumpAndSettle();

    expect(find.text('¿Elegir otra configuración?'), findsOneWidget);
    expect(find.text('Cancelar'), findsOneWidget);
    // La configuración sigue intacta mientras no se confirme.
    expect(Preferencias.hayConfiguracion, isTrue);
  });

  testWidgets('Cancelar deja todo como estaba', (tester) async {
    await tester.pumpWidget(panel());

    await tester.ensureVisible(find.text('Tandem'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tandem'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(find.text('¿Elegir otra configuración?'), findsNothing);
    expect(Preferencias.hayConfiguracion, isTrue);
    expect(find.text('Recambio de catéter'), findsOneWidget);
  });

  testWidgets('Confirmar borra la configuración y abre el asistente', (
    tester,
  ) async {
    await tester.pumpWidget(panel());

    await tester.ensureVisible(find.text('Tandem'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tandem'));
    await tester.pumpAndSettle();

    // El botón del diálogo, no el del panel que quedó debajo.
    await tester.tap(find.widgetWithText(FilledButton, 'Cambiar'));
    await tester.pumpAndSettle();

    expect(Preferencias.hayConfiguracion, isFalse);
    expect(find.text('¿Qué bomba usas?'), findsOneWidget);
  });
}
