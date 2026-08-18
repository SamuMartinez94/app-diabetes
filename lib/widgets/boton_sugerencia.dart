import 'package:flutter/material.dart';

import '../datos/sugerencias.dart';
import '../servicios/preferencias.dart';
import '../servicios/sugerencias.dart';
import '../tema.dart';

/// Botón "Sugerir un cambio", visible solo en modo sugerencias.
///
/// Se dibuja como un `SizedBox.shrink()` cuando el modo está desactivado, así
/// que se puede colocar sin condicionales en el sitio donde toque.
class BotonSugerencia extends StatelessWidget {
  /// Dónde está el usuario, tal y como llegará al correo.
  /// Por ejemplo: `Guía bmedtronic_cmio30 — paso 4 de 12`.
  final String ubicacion;

  const BotonSugerencia({super.key, required this.ubicacion});

  Future<void> _pulsar(BuildContext context) async {
    final mensajero = ScaffoldMessenger.of(context);

    if (!formularioConfigurado) {
      mensajero.showSnackBar(
        const SnackBar(
          content: Text(
            'Falta configurar el formulario en lib/datos/sugerencias.dart.',
          ),
        ),
      );
      return;
    }

    final abierto = await Sugerencias.abrir(ubicacion);
    if (!abierto) {
      mensajero.showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el formulario.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Preferencias.modoSugerencias) return const SizedBox.shrink();

    final colores = context.colores;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: TextButton.icon(
        onPressed: () => _pulsar(context),
        style: TextButton.styleFrom(
          foregroundColor: colores.porRevisar,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        icon: const Icon(Icons.rate_review_outlined, size: 18),
        label: const Text(
          'Sugerir un cambio aquí',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

/// Distintivo que recuerda que la app está en modo revisión.
class DistintivoModoSugerencias extends StatelessWidget {
  const DistintivoModoSugerencias({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Preferencias.modoSugerencias) return const SizedBox.shrink();

    final colores = context.colores;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colores.porRevisarFondo,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colores.porRevisar.withAlpha(60)),
      ),
      child: Row(
        children: [
          Icon(Icons.rate_review_outlined, size: 16, color: colores.porRevisar),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Modo sugerencias activo. Verás botones para reportar cambios.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colores.porRevisar,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
