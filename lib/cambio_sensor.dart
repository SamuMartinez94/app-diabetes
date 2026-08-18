import 'package:flutter/material.dart';

import 'datos/guias_sensor.dart';
import 'modelos/paso.dart';
import 'servicios/preferencias.dart';
import 'widgets/pantalla_guia.dart';
import 'zonas_insercion.dart';

const List<Paso> _sinGuia = [
  Paso(
    texto: 'No hay instrucciones específicas para esta combinación.',
    imagen: 'assets/images/errores.png',
  ),
];

class CambioSensorScreen extends StatelessWidget {
  final String bomba;
  final String sensor;

  const CambioSensorScreen({
    super.key,
    required this.bomba,
    required this.sensor,
  });

  String get _clave => '${bomba}_$sensor';

  @override
  Widget build(BuildContext context) {
    final pasos = instruccionesSensor[_clave] ?? _sinGuia;

    return PantallaGuia(
      titulo: 'Cambio de Sensor',
      clave: _clave,
      pasos: pasos,
      porRevisar: guiasSensorPorRevisar.contains(_clave),
      alFinalizar: Preferencias.rotacionActiva
          ? (context) => preguntarZona(context, 'sensor')
          : null,
    );
  }
}
