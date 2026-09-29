import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adiabetes/bombas.dart';
import 'package:adiabetes/servicios/preferencias.dart';
import 'package:adiabetes/buscador.dart';
import 'package:adiabetes/cambio_cateter.dart';
import 'package:adiabetes/cambio_sensor.dart';
import 'package:adiabetes/configuracion.dart';
import 'package:adiabetes/disclaimer.dart';
import 'package:adiabetes/errores.dart';
import 'package:adiabetes/kit_viaje.dart';
import 'package:adiabetes/resultado.dart';
import 'package:adiabetes/soporte.dart';
import 'package:adiabetes/tema.dart';
import 'package:adiabetes/zonas_insercion.dart';

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
