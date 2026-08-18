import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_diabetes/main.dart';
import 'package:app_diabetes/servicios/preferencias.dart';

Future<void> arrancarCon(Map<String, Object> valores) async {
  SharedPreferences.setMockInitialValues(valores);
  await Preferencias.inicializar();
}

const _configGuardada = {
  'config_bomba': 'btandem',
  'config_sensor': 'sdexg7',
  'config_cateter': 'cautosoft90',
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('El aviso médico abre la app', (tester) async {
    await arrancarCon({});
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();

    expect(find.text('Antes de empezar'), findsOneWidget);
    expect(find.text('Entiendo y continúo'), findsOneWidget);
  });

  testWidgets('Aceptar el aviso avanza a la bienvenida', (tester) async {
    await arrancarCon({});
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entiendo y continúo'));
    await tester.pumpAndSettle();

    expect(find.text('Entiendo y continúo'), findsNothing);
    expect(find.text('Comenzar'), findsOneWidget);
  });

  testWidgets('El aviso vuelve a salir en el siguiente arranque', (
    tester,
  ) async {
    await arrancarCon(_configGuardada);

    // Primer arranque: se acepta y se entra al panel.
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Entiendo y continúo'));
    await tester.pumpAndSettle();
    expect(find.text('Panel de Control'), findsOneWidget);

    // Desmontar el árbol simula cerrar la app: sin esto, pumpWidget reutiliza
    // el State existente y `_aceptado` seguiría en true.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();

    // Segundo arranque con las mismas preferencias en disco.
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();

    expect(find.text('Entiendo y continúo'), findsOneWidget);
    expect(find.text('Panel de Control'), findsNothing);
  });

  testWidgets('La aceptación no se guarda en disco', (tester) async {
    await arrancarCon({});
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Entiendo y continúo'));
    await tester.pumpAndSettle();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getKeys().where((k) => k.contains('disclaimer')), isEmpty);
  });

  testWidgets('Tras aceptar, con configuración guardada se abre el panel', (
    tester,
  ) async {
    await arrancarCon(_configGuardada);
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Entiendo y continúo'));
    await tester.pumpAndSettle();

    expect(find.text('Panel de Control'), findsOneWidget);
    expect(find.text('Comenzar'), findsNothing);
  });

  testWidgets('El aviso no muestra ningún icono', (tester) async {
    await arrancarCon({});
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();

    expect(find.byType(Icon), findsNothing);
  });

  testWidgets('El aviso muestra sus cinco apartados', (tester) async {
    await arrancarCon({});
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();

    for (final titulo in const [
      'Proyecto informativo',
      'No sustituye al manual',
      'Sin cálculo de dosis',
      'Contenido en revisión',
      'En caso de urgencia',
    ]) {
      await tester.scrollUntilVisible(find.text(titulo), 120);
      expect(find.text(titulo), findsOneWidget);
    }
  });

  testWidgets('El aviso cabe en una pantalla de móvil pequeña', (tester) async {
    // Un desbordamiento haría fallar el test con una excepción de layout.
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await arrancarCon({});
    await tester.pumpWidget(const MiApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entiendo y continúo'));
    await tester.pumpAndSettle();

    expect(find.text('Comenzar'), findsOneWidget);
  });
}
