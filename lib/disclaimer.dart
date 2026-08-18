import 'package:flutter/material.dart';

import 'tema.dart';

/// Un apartado del aviso médico.
class _Apartado {
  final String titulo;
  final String texto;

  const _Apartado(this.titulo, this.texto);
}

const String _entradilla =
    'Esta aplicación te acompaña en el manejo diario de tu bomba de insulina, '
    'pero no reemplaza a la documentación oficial ni al criterio de tu equipo '
    'médico. Léelo antes de usarla.';

const List<_Apartado> _apartados = [
  _Apartado(
    'Proyecto informativo',
    'Es un proyecto personal sin ánimo de lucro. No es un producto sanitario, '
        'ni está vinculado, patrocinado o avalado por los fabricantes de los '
        'dispositivos que aparecen en la app.',
  ),
  _Apartado(
    'No sustituye al manual',
    'Las guías son un apoyo visual. El manual oficial de tu dispositivo y las '
        'indicaciones de tu equipo médico tienen siempre prioridad sobre lo '
        'que leas aquí.',
  ),
  _Apartado(
    'Sin cálculo de dosis',
    'La app no calcula dosis de insulina ni emite recomendaciones de '
        'tratamiento. Consulta a tu profesional sanitario ante cualquier duda '
        'sobre tu pauta.',
  ),
  _Apartado(
    'Contenido en revisión',
    'Las guías y las fichas de alarmas están pendientes de validación '
        'clínica. Mientras lo estén, se muestran en rojo dentro de la app.',
  ),
  _Apartado(
    'En caso de urgencia',
    'Ante una hipoglucemia grave, pérdida de consciencia o sospecha de '
        'cetoacidosis, llama al 112.',
  ),
];

class DisclaimerScreen extends StatelessWidget {
  /// Cuando es `true` la pantalla exige aceptar para continuar (primer
  /// arranque). Cuando es `false` es solo de lectura.
  final bool requiereAceptacion;
  final VoidCallback? alAceptar;

  const DisclaimerScreen({
    super.key,
    this.requiereAceptacion = true,
    this.alAceptar,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Scaffold(
      appBar: requiereAceptacion
          ? null
          : AppBar(title: const Text('Aviso importante')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: requiereAceptacion ? 48 : 24),
                  Text(
                    'AVISO IMPORTANTE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                      color: esquema.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Antes de empezar',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      letterSpacing: -0.8,
                      color: esquema.onSurface,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _entradilla,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: esquema.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  ..._apartados.map((a) => _Bloque(apartado: a)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (requiereAceptacion)
              Container(
                padding: const EdgeInsets.fromLTRB(28, 14, 28, 22),
                decoration: BoxDecoration(
                  color: esquema.surface,
                  border: Border(
                    top: BorderSide(color: esquema.outlineVariant),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: esquema.primary,
                      foregroundColor: esquema.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: alAceptar,
                    child: const Text(
                      'Entiendo y continúo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Bloque extends StatelessWidget {
  final _Apartado apartado;

  const _Bloque({required this.apartado});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 7),
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: esquema.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  apartado.titulo,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    color: esquema.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Text(
              apartado.texto,
              style: TextStyle(
                fontSize: 15,
                height: 1.55,
                color: esquema.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
