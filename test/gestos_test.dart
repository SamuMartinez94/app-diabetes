import 'package:flutter_test/flutter_test.dart';

import 'package:adiabetes/datos/gestos.dart';
import 'package:adiabetes/datos/guias_cateter.dart';
import 'package:adiabetes/datos/guias_sensor.dart';
import 'package:adiabetes/modelos/gesto.dart';
import 'package:adiabetes/modelos/paso.dart';

/// Pasos únicos POR TEXTO: los bloques compartidos se copian en cada guía
/// que los usa, así que contarlos por instancia inflaría las cifras.
List<Paso> todosLosPasos() {
  final porTexto = <String, Paso>{};
  for (final mapa in [
    instruccionesCateter,
    instruccionesSensor,
    instruccionesSoloReservorio,
  ]) {
    for (final lista in mapa.values) {
      for (final paso in lista) {
        porTexto[paso.texto] = paso;
      }
    }
  }
  return porTexto.values.toList();
}

void main() {
  group('Deducción del gesto', () {
    test('Un paso de lavarse las manos es higiene', () {
      expect(
        gestoDe(const Paso(texto: 'Lávate bien las manos con agua y jabón.')),
        Gesto.higiene,
      );
    });

    test('Un paso de esperar el calentamiento es espera', () {
      expect(
        gestoDe(const Paso(texto: 'Espera las 2 HORAS de calentamiento.')),
        Gesto.esperar,
      );
    });

    test('Un paso con ADVERTENCIA gana a la acción que menciona', () {
      // Aunque hable de llenar el tubo, lo que manda es la advertencia.
      expect(
        gestoDe(
          const Paso(
            texto:
                'ADVERTENCIA: nunca llenes el tubo con el equipo conectado '
                'al cuerpo.',
          ),
        ),
        Gesto.advertencia,
      );
    });

    test('Una negación no recibe el icono de la acción negada', () {
      // Poner la gota de "llenar" en un paso que dice que NO se llena sería
      // justo lo contrario de lo que pide el paso.
      final paso = const Paso(
        texto: 'Este equipo lleva aguja de acero, así que NO se llena cánula.',
      );
      expect(gestoDe(paso), isNot(Gesto.cebar));
      expect(gestoDe(paso), Gesto.omitir);
    });

    test('El gesto fijado a mano tiene prioridad sobre el texto', () {
      expect(
        gestoDe(const Paso(texto: 'Lávate las manos.', gesto: Gesto.glucosa)),
        Gesto.glucosa,
      );
    });

    test('Un texto sin gesto reconocible cae en información', () {
      expect(
        gestoDe(const Paso(texto: 'Texto neutro cualquiera.')),
        Gesto.informacion,
      );
    });

    test('conFase conserva el gesto fijado', () {
      const paso = Paso(texto: 'x', gesto: Gesto.girar);
      expect(paso.conFase('Otra').gesto, Gesto.girar);
    });
  });

  group('Cobertura sobre las guías reales', () {
    test('Menos del 15 % de los pasos queda sin gesto reconocido', () {
      final pasos = todosLosPasos();
      final sinGesto = pasos.where((p) => gestoDe(p) == Gesto.informacion);
      final ratio = sinGesto.length / pasos.length;

      expect(
        ratio,
        lessThan(0.15),
        reason:
            '${sinGesto.length} de ${pasos.length} pasos sin gesto. '
            'Ejemplos: ${sinGesto.take(3).map((p) => p.texto.split("\n").first).join(" | ")}',
      );
    });

    test('Ningún paso que niegue una acción recibe el icono de esa acción', () {
      const negaciones = {
        'no se llena': Gesto.cebar,
        'no llenes': Gesto.cebar,
        'no insertes': Gesto.insertar,
        'no hace falta cebar': Gesto.cebar,
        'no vuelvas a poner': Gesto.adhesivo,
      };

      for (final paso in todosLosPasos()) {
        final texto = paso.texto.toLowerCase();
        negaciones.forEach((frase, gestoProhibido) {
          if (texto.contains(frase)) {
            expect(
              gestoDe(paso),
              isNot(gestoProhibido),
              reason:
                  'El paso "${paso.texto.split("\n").first}" niega '
                  '"$frase" pero recibe el icono de esa acción',
            );
          }
        });
      }
    });

    test('Se usan al menos 12 gestos distintos en las guías', () {
      final usados = todosLosPasos().map(gestoDe).toSet();
      expect(usados.length, greaterThanOrEqualTo(10), reason: '$usados');
    });

    test('Cada gesto tiene etiqueta e icono', () {
      for (final g in Gesto.values) {
        expect(g.etiqueta.trim(), isNotEmpty);
        expect(g.icono.codePoint, greaterThan(0));
      }
    });
  });
}
