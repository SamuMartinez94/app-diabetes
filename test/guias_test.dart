import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:adiabetes/buscador.dart';
import 'package:adiabetes/cambio_cateter.dart';
import 'package:adiabetes/datos/guias_cateter.dart';
import 'package:adiabetes/datos/guias_sensor.dart';
import 'package:adiabetes/modelos/paso.dart';
import 'package:adiabetes/servicios/preferencias.dart';
import 'package:adiabetes/tema.dart';
import 'package:adiabetes/widgets/pantalla_guia.dart';

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

      expect(find.textContaining('5/'), findsOneWidget);
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
      expect(find.textContaining('3/'), findsOneWidget);
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

    testWidgets('La guía muestra el nombre de la fase', (tester) async {
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

      expect(find.text(Fases.preparacion.toUpperCase()), findsOneWidget);
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

  group('Buscador dentro de las guías', () {
    setUp(configurar);

    test('Encuentra un paso por su texto', () {
      final r = buscarEnGuias('burbujas');
      expect(r, isNotEmpty);
      expect(r.first.paso.texto.toLowerCase(), contains('burbuja'));
    });

    test('Funciona sin tildes', () {
      expect(buscarEnGuias('canula'), isNotEmpty);
    });

    test('Solo devuelve guías de los dispositivos del usuario', () {
      for (final r in buscarEnGuias('insulina')) {
        expect(r.claveGuia, startsWith('bmedtronic'));
      }
    });

    test('Sin configuración no devuelve nada', () async {
      SharedPreferences.setMockInitialValues({});
      await Preferencias.inicializar();
      expect(buscarEnGuias('insulina'), isEmpty);
    });

    test('Una consulta vacía no devuelve nada', () {
      expect(buscarEnGuias('   '), isEmpty);
    });
  });
}
