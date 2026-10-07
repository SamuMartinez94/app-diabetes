import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:diaguia/cambio_cateter.dart';
import 'package:diaguia/datos/guias_cateter.dart';
import 'package:diaguia/datos/guias_sensor.dart';
import 'package:diaguia/modelos/paso.dart';
import 'package:diaguia/servicios/preferencias.dart';
import 'package:diaguia/tema.dart';
import 'package:diaguia/widgets/pantalla_guia.dart';

/// Primeras letras de la primera instrucción de un paso: sirven para
/// comprobar en qué paso está la pantalla, que no muestra su número.
String arranque(Paso paso) {
  final linea = paso.texto
      .split('\n')
      .map((l) => l.trim())
      .firstWhere((l) => l.isNotEmpty && l != l.toUpperCase());
  return linea.substring(0, 20).toLowerCase();
}

/// Texto de la pantalla que contiene [inicio], sin distinguir mayúsculas.
Finder conTexto(String inicio) => find.byWidgetPredicate(
  (w) => w is RichText && w.text.toPlainText().toLowerCase().contains(inicio),
);

Widget conTema(Widget hijo) =>
    MaterialApp(theme: temaClaro, darkTheme: temaOscuro, home: hijo);

Future<void> configurar({String bomba = 'bmedtronic'}) async {
  SharedPreferences.setMockInitialValues({});
  await Preferencias.inicializar();
  await Preferencias.guardarConfiguracion(
    bomba: bomba,
    sensor: bomba == 'bmedtronic' ? 'sguardian' : 'sdexg7',
    cateter: bomba == 'bmedtronic' ? 'cmio30' : 'cautosoft90',
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Progreso dentro de la guía', () {
    setUp(configurar);

    testWidgets('Avanzar guarda el paso', (tester) async {
      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: instruccionesCateter['bmedtronic_cmio30']!,
            porRevisar: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();

      expect(Preferencias.progresoGuia('prueba'), 1);
    });

    testWidgets('Si hay progreso guardado, se ofrece retomar', (tester) async {
      await Preferencias.guardarProgresoGuia('prueba', 4);

      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: instruccionesCateter['bmedtronic_cmio30']!,
            porRevisar: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('¿Retomar donde lo dejaste?'), findsOneWidget);
      await tester.tap(find.text('Ir al paso 5'));
      await tester.pumpAndSettle();

      expect(
        conTexto(arranque(instruccionesCateter['bmedtronic_cmio30']![4])),
        findsOneWidget,
      );
    });

    testWidgets('Empezar de nuevo borra el progreso', (tester) async {
      await Preferencias.guardarProgresoGuia('prueba', 4);

      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: instruccionesCateter['bmedtronic_cmio30']!,
            porRevisar: false,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Empezar de nuevo'));
      await tester.pumpAndSettle();

      expect(Preferencias.progresoGuia('prueba'), 0);
    });

    testWidgets('Abrir por un paso concreto no pregunta nada', (tester) async {
      await Preferencias.guardarProgresoGuia('prueba', 4);

      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: instruccionesCateter['bmedtronic_cmio30']!,
            porRevisar: false,
            pasoInicial: 2,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('¿Retomar donde lo dejaste?'), findsNothing);
      expect(
        conTexto(arranque(instruccionesCateter['bmedtronic_cmio30']![2])),
        findsOneWidget,
      );
    });
  });

  group('Fases', () {
    test('Todos los pasos de catéter tienen fase asignada', () {
      instruccionesCateter.forEach((clave, pasos) {
        for (var i = 0; i < pasos.length; i++) {
          expect(pasos[i].fase, isNotNull, reason: '$clave paso ${i + 1}');
        }
      });
    });

    test('Todos los pasos de sensor Dexcom tienen fase', () {
      for (final clave in ['btandem_sdexg6', 'btandem_sdexg7']) {
        for (final paso in instruccionesSensor[clave]!) {
          expect(paso.fase, isNotNull, reason: clave);
        }
      }
    });

    testWidgets('La guía no repite la cuenta de pasos', (tester) async {
      await configurar();
      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: instruccionesCateter['bmedtronic_cmio30']!,
            porRevisar: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // El progreso lo da la barra de arriba: ni "Paso 1 de 5" ni "1/21".
      expect(find.textContaining('en total'), findsNothing);
      expect(find.textContaining('Paso 1'), findsNothing);
    });

    testWidgets('Un título en mayúsculas pasa al nombre del paso', (
      tester,
    ) async {
      await configurar();
      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: const [
              Paso(texto: '\nELIGE LA ZONA\n\nElige una zona limpia.'),
            ],
            porRevisar: false,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Elige la zona'), findsOneWidget);
      expect(find.text('ELIGE LA ZONA'), findsNothing);
    });
  });

  group('Aviso de contenido en revisión', () {
    setUp(configurar);

    testWidgets('Sale antes de los pasos y se quita al aceptarlo', (
      tester,
    ) async {
      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: instruccionesCateter['bmedtronic_cmio30']!,
            porRevisar: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Contenido en revisión'), findsOneWidget);
      expect(find.text('Siguiente'), findsNothing);

      await tester.tap(find.text('Entendido'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Contenido en revisión'), findsNothing);
      expect(find.text('Siguiente'), findsOneWidget);
    });

    testWidgets('Aceptarlo antes de preguntar si se retoma', (tester) async {
      await Preferencias.guardarProgresoGuia('prueba', 4);
      await tester.pumpWidget(
        conTema(
          PantallaGuia(
            titulo: 'Prueba',
            clave: 'prueba',
            pasos: instruccionesCateter['bmedtronic_cmio30']!,
            porRevisar: true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('¿Retomar donde lo dejaste?'), findsNothing);

      await tester.tap(find.text('Entendido'));
      await tester.pumpAndSettle();

      expect(find.text('¿Retomar donde lo dejaste?'), findsOneWidget);
    });
  });

  group('Cambio completo o solo reservorio', () {
    testWidgets('Medtronic ofrece elegir', (tester) async {
      await configurar();
      await tester.pumpWidget(
        conTema(
          const CambioCateterScreen(bomba: 'bmedtronic', cateter: 'cmio30'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('¿Qué vas a cambiar?'), findsOneWidget);
      expect(find.text('Todo el equipo'), findsOneWidget);
      expect(find.text('Solo el reservorio'), findsOneWidget);
    });

    testWidgets('Omnipod entra directo, sin elegir', (tester) async {
      await configurar(bomba: 'bomnipod');
      await tester.pumpWidget(
        conTema(const CambioCateterScreen(bomba: 'bomnipod', cateter: 'cpod')),
      );
      await tester.pumpAndSettle();

      expect(find.text('¿Qué vas a cambiar?'), findsNothing);
      expect(find.text('Instrucciones'), findsOneWidget);
    });

    test('La variante de solo reservorio no llena cánula', () {
      instruccionesSoloReservorio.forEach((bomba, pasos) {
        final texto = pasos.map((p) => p.texto).join(' ').toLowerCase();
        expect(
          texto.contains('no ') && texto.contains('cánula'),
          isTrue,
          reason: '$bomba debe advertir que no se llena cánula',
        );
      });
    });

    test('Omnipod no tiene variante de solo reservorio', () {
      expect(instruccionesSoloReservorio.containsKey('bomnipod'), isFalse);
    });
  });
}
