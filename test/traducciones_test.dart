import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:adiabetes/datos/alarmas.dart';
import 'package:adiabetes/datos/guias_cateter.dart';
import 'package:adiabetes/datos/guias_sensor.dart';
import 'package:adiabetes/datos/kit.dart';
import 'package:adiabetes/datos/zonas.dart';
import 'package:adiabetes/l10n/idioma.dart';
import 'package:adiabetes/modelos/alarma.dart';
import 'package:adiabetes/modelos/gesto.dart';
import 'package:adiabetes/modelos/paso.dart';

/// Textos en castellano que salen de los datos (guías, alarmas, kit…) y se
/// traducen al mostrarlos con `t(variable)`.
List<String> clavesDeDatos() {
  final claves = <String>[];

  for (final g in Gravedad.values) {
    claves.add(g.etiqueta);
  }
  for (final g in Gesto.values) {
    claves.add(g.etiqueta);
  }
  claves.addAll([
    Fases.preparacion,
    Fases.reservorio,
    Fases.cebado,
    Fases.insercion,
    Fases.cierre,
    Fases.zona,
    Fases.emparejar,
  ]);

  for (final a in alarmas) {
    claves
      ..add(a.titulo)
      ..add(a.significado)
      ..add(a.textoSinonimos)
      ..addAll(a.queHacer);
  }

  claves.add(pasoSinGuia.texto);
  for (final mapa in [
    instruccionesCateter,
    instruccionesSensor,
    instruccionesSoloReservorio,
  ]) {
    for (final pasos in mapa.values) {
      for (final p in pasos) {
        claves.add(p.texto);
      }
    }
  }

  for (final grupo in kitViaje) {
    claves
      ..add(grupo.titulo)
      ..add(grupo.nota)
      ..addAll(grupo.elementos);
  }

  for (final z in zonas) {
    claves.add(z.nombre);
  }

  return claves;
}

/// Textos que están escritos como literal dentro de una llamada `t('…')` o
/// `tf('…')` en el código de la app. Admite literales pegados
/// (`'uno ' 'dos'`), comillas simples, dobles y triples.
List<String> clavesDeInterfaz() {
  final claves = <String>[];
  final llamada = RegExp(r'(?<![\w.])tf?\(');

  final ficheros =
      Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => !f.path.replaceAll('\\', '/').contains('/l10n/'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  for (final fichero in ficheros) {
    final fuente = fichero.readAsStringSync();
    for (final m in llamada.allMatches(fuente)) {
      final clave = _literalDesde(fuente, m.end);
      if (clave != null) claves.add(clave);
    }
  }
  return claves;
}

/// Lee uno o varios literales seguidos empezando en [pos]. Devuelve `null` si
/// lo que hay no es un literal (por ejemplo, una variable).
String? _literalDesde(String s, int pos) {
  final salida = StringBuffer();
  var i = pos;
  var leidos = 0;

  while (true) {
    while (i < s.length && ' \n\r\t'.contains(s[i])) {
      i++;
    }
    if (i >= s.length) break;

    final c = s[i];
    if (c != "'" && c != '"') break;

    final triple = s.startsWith(c * 3, i);
    final cierre = triple ? c * 3 : c;
    i += cierre.length;
    if (triple && i < s.length && s[i] == '\n') i++;

    while (i < s.length && !s.startsWith(cierre, i)) {
      if (s[i] == r'\') {
        final siguiente = s[i + 1];
        salida.write(switch (siguiente) {
          'n' => '\n',
          't' => '\t',
          _ => siguiente,
        });
        i += 2;
      } else {
        salida.write(s[i]);
        i++;
      }
    }
    i += cierre.length;
    leidos++;
  }

  if (leidos == 0) return null;

  // Solo vale si la llamada termina ahí: `t('a' + b)` no es un literal.
  while (i < s.length && ' \n\r\t'.contains(s[i])) {
    i++;
  }
  if (i >= s.length || (s[i] != ')' && s[i] != ',')) return null;

  return salida.toString();
}

Set<String> marcadores(String texto) =>
    RegExp(r'\{(\w+)\}').allMatches(texto).map((m) => m.group(1)!).toSet();

void main() {
  final volcado = Platform.environment['VOLCAR_CLAVES'];
  if (volcado != null) {
    test('Volcar claves', () {
      final unicas = <String>{...clavesDeDatos(), ...clavesDeInterfaz()};
      File(volcado).writeAsStringSync(
        const JsonEncoder.withIndent(' ').convert(unicas.toList()),
      );
    });
  }

  final claves = <String>{...clavesDeDatos(), ...clavesDeInterfaz()};

  test('Se han encontrado textos que traducir', () {
    expect(claves.length, greaterThan(300));
  });

  test('Ningún texto de interfaz lleva interpolación de Dart', () {
    for (final clave in clavesDeInterfaz()) {
      expect(clave.contains(r'$'), isFalse, reason: 'Usa tf(): "$clave"');
    }
  });

  for (final idioma in Idioma.values.where((i) => i != Idioma.es)) {
    group('Traducción al ${idioma.nombre}', () {
      test('No falta ningún texto', () {
        final faltan = claves
            .where((c) => (traduccionExacta(idioma, c) ?? '').trim().isEmpty)
            .toList();
        expect(
          faltan,
          isEmpty,
          reason:
              'Faltan ${faltan.length} textos. Primeros: '
              '${faltan.take(5).map((c) => c.split("\n").first).join(" | ")}',
        );
      });

      test('Los marcadores {…} coinciden con el original', () {
        for (final clave in claves) {
          final traduccion = traduccionExacta(idioma, clave);
          if (traduccion == null) continue;
          expect(
            marcadores(traduccion),
            marcadores(clave),
            reason: 'En "${clave.split("\n").first}"',
          );
        }
      });

      test('Conserva los saltos de párrafo', () {
        for (final clave in claves) {
          final traduccion = traduccionExacta(idioma, clave);
          if (traduccion == null) continue;
          expect(
            '\n\n'.allMatches(traduccion).length,
            '\n\n'.allMatches(clave).length,
            reason: 'En "${clave.split("\n").first}"',
          );
        }
      });

      test('No hay traducciones que sobren', () {
        // Una clave que ya no existe en el código es una traducción muerta.
        final tabla = todasLasTraducciones(idioma);
        final sobran = tabla.keys.where((k) => !claves.contains(k)).toList();
        expect(
          sobran,
          isEmpty,
          reason: sobran.take(3).map((c) => c.split("\n").first).join(" | "),
        );
      });
    });
  }
}
