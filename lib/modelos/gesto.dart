import 'package:flutter/material.dart';

/// Acción que pide un paso; se muestra como icono junto al texto.
/// Las reglas que la deducen están en `datos/gestos.dart`.
enum Gesto {
  advertencia('Atención', Icons.warning_amber_rounded),
  omitir('Esto no se hace', Icons.do_not_disturb_on_outlined),
  glucosa('Mide la glucosa', Icons.bloodtype_outlined),
  higiene('Higiene', Icons.clean_hands_outlined),
  esperar('Espera', Icons.hourglass_top_rounded),
  emparejar('Emparejar', Icons.bluetooth_searching),
  zona('Elige la zona', Icons.person_pin_circle_outlined),
  desconectar('Desconéctate', Icons.link_off),
  burbujas('Sin burbujas', Icons.bubble_chart_outlined),
  cebar('Llenar y cebar', Icons.water_drop_outlined),
  girar('Girar', Icons.rotate_right_rounded),
  encajar('Hasta el clic', Icons.compress),
  insertar('Insertar', Icons.vaccines_outlined),
  retirar('Retirar', Icons.remove_circle_outline),
  adhesivo('Adhesivo', Icons.healing_outlined),
  pantalla('En el dispositivo', Icons.touch_app_outlined),
  informacion('Información', Icons.info_outline);

  final String etiqueta;
  final IconData icono;

  const Gesto(this.etiqueta, this.icono);
}
