/// Zona corporal donde se puede insertar un catéter o un sensor.
class Zona {
  final String id;
  final String nombre;

  /// Posición relativa sobre la silueta, de 0 a 1.
  final double x;
  final double y;

  /// `cateter`, `sensor` o `ambos`.
  final String apto;

  const Zona({
    required this.id,
    required this.nombre,
    required this.x,
    required this.y,
    required this.apto,
  });

  bool admite(String tipo) => apto == 'ambos' || apto == tipo;
}

/// Zonas habituales de inserción. La rotación evita la lipohipertrofia:
/// insertar siempre en el mismo sitio endurece la piel (aparecen bultos) y hace
/// que la insulina se absorba peor.
const List<Zona> zonas = [
  Zona(
    id: 'brazo_izq',
    nombre: 'Brazo izquierdo',
    x: 0.20,
    y: 0.26,
    apto: 'sensor',
  ),
  Zona(
    id: 'brazo_der',
    nombre: 'Brazo derecho',
    x: 0.80,
    y: 0.26,
    apto: 'sensor',
  ),
  Zona(
    id: 'abdomen_sup_izq',
    nombre: 'Barriga, arriba a la izquierda',
    x: 0.38,
    y: 0.42,
    apto: 'ambos',
  ),
  Zona(
    id: 'abdomen_sup_der',
    nombre: 'Barriga, arriba a la derecha',
    x: 0.62,
    y: 0.42,
    apto: 'ambos',
  ),
  Zona(
    id: 'abdomen_inf_izq',
    nombre: 'Barriga, abajo a la izquierda',
    x: 0.38,
    y: 0.52,
    apto: 'ambos',
  ),
  Zona(
    id: 'abdomen_inf_der',
    nombre: 'Barriga, abajo a la derecha',
    x: 0.62,
    y: 0.52,
    apto: 'ambos',
  ),
  Zona(
    id: 'flanco_izq',
    nombre: 'Costado izquierdo',
    x: 0.24,
    y: 0.48,
    apto: 'ambos',
  ),
  Zona(
    id: 'flanco_der',
    nombre: 'Costado derecho',
    x: 0.76,
    y: 0.48,
    apto: 'ambos',
  ),
  Zona(
    id: 'nalga_izq',
    nombre: 'Nalga izquierda',
    x: 0.38,
    y: 0.62,
    apto: 'cateter',
  ),
  Zona(
    id: 'nalga_der',
    nombre: 'Nalga derecha',
    x: 0.62,
    y: 0.62,
    apto: 'cateter',
  ),
  Zona(
    id: 'muslo_izq',
    nombre: 'Muslo izquierdo',
    x: 0.36,
    y: 0.76,
    apto: 'cateter',
  ),
  Zona(
    id: 'muslo_der',
    nombre: 'Muslo derecho',
    x: 0.64,
    y: 0.76,
    apto: 'cateter',
  ),
];
