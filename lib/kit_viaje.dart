import 'package:flutter/material.dart';

import 'datos/kit.dart';
import 'tema.dart';
import 'widgets/comunes.dart';

/// Checklist de viaje. Las marcas son de un solo uso: no se guardan, porque
/// cada viaje se prepara de cero.
class KitViajeScreen extends StatefulWidget {
  const KitViajeScreen({super.key});

  @override
  State<KitViajeScreen> createState() => _KitViajeScreenState();
}

class _KitViajeScreenState extends State<KitViajeScreen> {
  final Set<String> marcados = {};

  int get _total =>
      kitViaje.fold(0, (suma, grupo) => suma + grupo.elementos.length);

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;
    final completo = marcados.length == _total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kit de viaje'),
        actions: [
          if (marcados.isNotEmpty)
            TextButton(
              onPressed: () => setState(marcados.clear),
              child: const Text('Reiniciar'),
            ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            const BannerRevision(
              mensaje:
                  'Lista orientativa sin revisar. Ajústala con tu equipo médico '
                  'según tu tratamiento y tu destino.',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: completo
                    ? colores.exito.withAlpha(26)
                    : esquema.surfaceContainerLow,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    completo
                        ? Icons.check_circle
                        : Icons.checklist_rtl_rounded,
                    color: completo ? colores.exito : esquema.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      completo
                          ? 'Todo listo. Buen viaje.'
                          : '${marcados.length} de $_total preparados',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: completo ? colores.exito : esquema.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...kitViaje.map((grupo) => _Grupo(
                  grupo: grupo,
                  marcados: marcados,
                  alCambiar: (clave, valor) => setState(() {
                    if (valor) {
                      marcados.add(clave);
                    } else {
                      marcados.remove(clave);
                    }
                  }),
                )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _Grupo extends StatelessWidget {
  final GrupoKit grupo;
  final Set<String> marcados;
  final void Function(String clave, bool valor) alCambiar;

  const _Grupo({
    required this.grupo,
    required this.marcados,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            grupo.titulo.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: esquema.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            grupo.nota,
            style: TextStyle(
              fontSize: 13,
              height: 1.35,
              color: esquema.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          ...grupo.elementos.map((elemento) {
            final clave = '${grupo.titulo}|$elemento';
            final marcado = marcados.contains(clave);
            return CheckboxListTile(
              value: marcado,
              onChanged: (v) => alCambiar(clave, v ?? false),
              contentPadding: EdgeInsets.zero,
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                elemento,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.3,
                  color: marcado
                      ? esquema.onSurfaceVariant
                      : esquema.onSurface,
                  decoration: marcado ? TextDecoration.lineThrough : null,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
