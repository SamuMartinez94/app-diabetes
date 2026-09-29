import 'package:flutter/widgets.dart';

import 'ca.dart';
import 'en.dart';
import 'eu.dart';
import 'gl.dart';

/// Idiomas de la app. El castellano es el idioma de origen: todos los textos
/// del código están escritos en castellano y ese mismo texto sirve de clave
/// para buscar su traducción (ver [t]).
enum Idioma {
  es('es', 'Castellano'),
  en('en', 'English'),
  gl('gl', 'Galego'),
  ca('ca', 'Català'),
  eu('eu', 'Euskara');

  final String codigo;
  final String nombre;

  const Idioma(this.codigo, this.nombre);

  Locale get locale => Locale(codigo);

  static Idioma? deCodigo(String? codigo) {
    for (final idioma in values) {
      if (idioma.codigo == codigo) return idioma;
    }
    return null;
  }

  /// Idioma del sistema si la app lo tiene; si no, castellano.
  static Idioma delSistema() =>
      deCodigo(
        WidgetsBinding.instance.platformDispatcher.locale.languageCode,
      ) ??
      Idioma.es;
}

const Map<Idioma, Map<String, String>> _tablas = {
  Idioma.en: traduccionesEn,
  Idioma.gl: traduccionesGl,
  Idioma.ca: traduccionesCa,
  Idioma.eu: traduccionesEu,
};

/// Estado del idioma activo.
class Traductor {
  static Idioma actual = Idioma.es;

  /// Cambia el idioma y fuerza que se redibuje TODO lo que hay en pantalla,
  /// incluidas las pantallas que quedan debajo en la pila de navegación.
  ///
  /// Los textos son `const` y no dependen de ningún `InheritedWidget`, así
  /// que Flutter no sabe por sí solo que tienen que volver a leerse.
  static void cambiar(Idioma idioma) {
    actual = idioma;
    reconstruirTodo();
  }

  static void reconstruirTodo() {
    void visitar(Element elemento) {
      elemento.markNeedsBuild();
      elemento.visitChildren(visitar);
    }

    WidgetsBinding.instance.rootElement?.visitChildren(visitar);
  }
}

/// Traduce un texto escrito en castellano al idioma activo.
///
/// Si no hay traducción devuelve el castellano: es mejor mostrar un texto en
/// otro idioma que dejar un hueco vacío. Un test comprueba que no falte
/// ninguna.
String t(String es) {
  final idioma = Traductor.actual;
  if (idioma == Idioma.es) return es;
  return _tablas[idioma]?[es] ?? es;
}

/// Como [t], pero sustituyendo marcadores `{nombre}` por valores.
///
/// Ejemplo: `tf('Hace {n} días', {'n': 3})`.
String tf(String es, Map<String, Object> valores) {
  var texto = t(es);
  valores.forEach((clave, valor) {
    texto = texto.replaceAll('{$clave}', '$valor');
  });
  return texto;
}

/// Traducción de un texto, sin caer en castellano si no existe. Lo usa el
/// test de traducciones.
String? traduccionExacta(Idioma idioma, String es) => _tablas[idioma]?[es];

/// Tabla completa de un idioma. Lo usa el test de traducciones.
Map<String, String> todasLasTraducciones(Idioma idioma) =>
    _tablas[idioma] ?? const {};
