import 'package:flutter/material.dart';

import 'datos/guias_cateter.dart';
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

class CambioCateterScreen extends StatelessWidget {
  final String bomba;
  final String cateter;

  const CambioCateterScreen({
    super.key,
    required this.bomba,
    required this.cateter,
  });

  String get _clave => '${bomba}_$cateter';

  @override
  Widget build(BuildContext context) {
    final pasos = instruccionesCateter[_clave] ?? _sinGuia;

    return PantallaGuia(
      titulo: 'Instrucciones',
      clave: _clave,
      pasos: pasos,
      porRevisar: guiasCateterPorRevisar.contains(_clave),
      alFinalizar: Preferencias.rotacionActiva
          ? (context) => preguntarZona(context, 'cateter')
          : null,
    );
  }
}
