import 'package:flutter/material.dart';

import 'datos/guias_sensor.dart';
import 'l10n/idioma.dart';
import 'modelos/paso.dart';
import 'servicios/preferencias.dart';
import 'widgets/pantalla_guia.dart';
import 'zonas_insercion.dart';

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
    final pasos = instruccionesSensor[_clave] ?? const [pasoSinGuia];

    return PantallaGuia(
      titulo: t('Cambio de sensor'),
      clave: _clave,
      pasos: pasos,
      porRevisar: guiasSensorPorRevisar.contains(_clave),
      alFinalizar: Preferencias.rotacionActiva
          ? (context) => preguntarZona(context, 'sensor')
          : null,
    );
  }
}
