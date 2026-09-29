import 'gesto.dart';

/// Un paso individual dentro de una guía (recambio de catéter o de sensor).
class Paso {
  final String texto;
  final String? imagen;

  /// Gesto fijado a mano. Si es null se deduce del texto (ver `datos/gestos`).
  final Gesto? gesto;

  /// Bloque al que pertenece el paso ("Preparación", "Inserción"…).
  final String? fase;

  const Paso({required this.texto, this.imagen, this.fase, this.gesto});

  Paso conFase(String nuevaFase) =>
      Paso(texto: texto, imagen: imagen, fase: nuevaFase, gesto: gesto);
}

/// Paso que se muestra cuando no hay guía para la combinación elegida.
const Paso pasoSinGuia = Paso(
  texto: 'No hay instrucciones específicas para esta combinación.',
  imagen: 'assets/images/errores.png',
);

/// Etiqueta una lista de pasos con la misma fase.
List<Paso> enFase(String fase, List<Paso> pasos) =>
    pasos.map((p) => p.conFase(fase)).toList();

/// Reparte una lista de pasos en fases consecutivas.
List<Paso> porTramos(List<Paso> pasos, List<(String, int)> tramos) {
  final salida = <Paso>[];
  var i = 0;
  for (final (fase, cuantos) in tramos) {
    final fin = (i + cuantos).clamp(0, pasos.length);
    salida.addAll(enFase(fase, pasos.sublist(i, fin)));
    i = fin;
  }
  if (i < pasos.length) {
    salida.addAll(enFase(tramos.last.$1, pasos.sublist(i)));
  }
  return salida;
}

/// Nombres de fase usados en las guías.
class Fases {
  static const preparacion = 'Preparación';
  static const reservorio = 'Reservorio';
  static const cebado = 'Llenar el tubo';
  static const insercion = 'Inserción';
  static const cierre = 'Finalizar';
  static const zona = 'Elegir zona';
  static const emparejar = 'Emparejar';
}
