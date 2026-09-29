import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diaguia/bombas.dart';
import 'package:diaguia/servicios/preferencias.dart';
import 'package:diaguia/buscador.dart';
import 'package:diaguia/cambio_cateter.dart';
import 'package:diaguia/cambio_sensor.dart';
import 'package:diaguia/configuracion.dart';
import 'package:diaguia/disclaimer.dart';
import 'package:diaguia/errores.dart';
import 'package:diaguia/kit_viaje.dart';
import 'package:diaguia/resultado.dart';
import 'package:diaguia/soporte.dart';
import 'package:diaguia/tema.dart';
import 'package:diaguia/zonas_insercion.dart';

/// Envuelve la pantalla forzando un escalado de texto y un móvil pequeño.
/// Cualquier desbordamiento de layout hace fallar el test.
Widget conEscala(
  Widget hijo,
  double escala, {
  ThemeMode modo = ThemeMode.light,
}) => MaterialApp(
  theme: temaClaro,
  darkTheme: temaOscuro,
  themeMode: modo,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(
      context,
    ).copyWith(textScaler: TextScaler.linear(escala)),
    child: child!,
  ),
  home: hijo,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Preferencias.inicializar();
    await Preferencias.guardarConfiguracion(
      bomba: 'bmedtronic',
      sensor: 'sguardian',
      cateter: 'cmio30',
    );
  });

  final pantallas = <String, Widget Function()>{
    'Aviso médico': () => const DisclaimerScreen(),
    'Asistente': () => const BombasScreen(),
    'Panel de control': () => const ResultadoScreen(
      bomba: 'bmedtronic',
      sensor: 'sguardian',
      cateter: 'cmio30',
    ),
    'Guía de catéter': () =>
        const CambioCateterScreen(bomba: 'bmedtronic', cateter: 'cmio30'),
    'Guía de sensor': () =>
        const CambioSensorScreen(bomba: 'bmedtronic', sensor: 'sguardian'),
    'Errores': () => const ErroresScreen(
      bomba: 'bmedtronic',
      sensor: 'sguardian',
      cateter: 'cmio30',
    ),
    'Buscador': () => const BuscadorScreen(apartados: []),
    'Configuración': () => const ConfiguracionScreen(),
    'Kit de viaje': () => const KitViajeScreen(),
    'Soporte': () => const SoporteScreen(),
    'Zonas': () => const ZonasScreen(),
  };

  for (final escala in [1.0, 1.5, 2.0]) {
    group('Escala de texto x$escala', () {
      pantallas.forEach((nombre, construir) {
        testWidgets('$nombre no desborda', (tester) async {
          tester.view.physicalSize = const Size(360, 720);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(conEscala(construir(), escala));
          await tester.pumpAndSettle();
        });
      });
    });
  }

  group('Modo oscuro con texto grande', () {
    pantallas.forEach((nombre, construir) {
      testWidgets('$nombre no desborda en oscuro', (tester) async {
        tester.view.physicalSize = const Size(360, 720);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          conEscala(construir(), 1.6, modo: ThemeMode.dark),
        );
        await tester.pumpAndSettle();
      });
    });
  });
}
