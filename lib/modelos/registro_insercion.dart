/// Una inserción anotada por el usuario para llevar la rotación de zonas.
class RegistroInsercion {
  /// Identificador de la zona corporal (ver `datos/zonas.dart`).
  final String zona;

  /// `cateter` o `sensor`.
  final String tipo;
  final DateTime fecha;

  const RegistroInsercion({
    required this.zona,
    required this.tipo,
    required this.fecha,
  });

  Map<String, dynamic> aJson() => {
    'zona': zona,
    'tipo': tipo,
    'fecha': fecha.toIso8601String(),
  };

  factory RegistroInsercion.desdeJson(Map<String, dynamic> json) =>
      RegistroInsercion(
        zona: json['zona'] as String,
        tipo: json['tipo'] as String,
        fecha: DateTime.parse(json['fecha'] as String),
      );
}
