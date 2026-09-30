import 'package:flutter/material.dart';

import '../l10n/idioma.dart';

enum Gravedad {
  informativa('Informativa', Icons.info_outline),
  atencion('Requiere atención', Icons.warning_amber_rounded),
  urgente('Actúa ya', Icons.priority_high_rounded);

  final String etiqueta;
  final IconData icono;
  const Gravedad(this.etiqueta, this.icono);
}

/// Una alarma o aviso que puede mostrar el dispositivo.
class Alarma {
  final String id;

  /// Bomba a la que aplica, o cadena vacía si es común a todas.
  final String bomba;

  /// Sensores a los que aplica, o lista vacía si vale para cualquiera.
  final List<String> sensores;

  /// Aviso del sensor o de la glucosa, no de la bomba.
  final bool deSensor;

  /// Manual oficial del que sale y página, para poder comprobarlo. Si falta,
  /// el texto aún no está contrastado con ningún manual.
  final String? manual;
  final String? pagina;

  /// Texto tal y como lo muestra el dispositivo.
  final String titulo;

  /// Código del fabricante, cuando existe y está confirmado.
  final String? codigo;

  final String significado;
  final List<String> queHacer;
  final Gravedad gravedad;

  /// Términos alternativos por los que el usuario podría buscarla.
  final List<String> sinonimos;

  const Alarma({
    required this.id,
    required this.bomba,
    required this.titulo,
    required this.significado,
    required this.queHacer,
    required this.gravedad,
    this.sensores = const [],
    this.deSensor = false,
    this.manual,
    this.pagina,
    this.codigo,
    this.sinonimos = const [],
  });

  bool get porRevisar => manual == null;

  /// Los sinónimos en una sola cadena (es la clave de su traducción).
  String get textoSinonimos => sinonimos.join(', ');

  /// Texto por el que se puede encontrar la alarma.
  String get textoBuscable =>
      '$titulo ${codigo ?? ''} $significado $textoSinonimos '
              '${t(titulo)} ${t(significado)} ${t(textoSinonimos)}'
          .toLowerCase();
}
