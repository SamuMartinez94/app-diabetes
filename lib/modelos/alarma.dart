import 'package:flutter/material.dart';

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
    this.codigo,
    this.sinonimos = const [],
  });

  String get textoBuscable =>
      '$titulo ${codigo ?? ''} $significado ${sinonimos.join(' ')}'
          .toLowerCase();
}
