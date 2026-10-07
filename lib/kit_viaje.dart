import 'package:flutter/material.dart';

import 'datos/aeropuerto.dart';
import 'datos/dispositivos.dart';
import 'datos/kit.dart';
import 'l10n/idioma.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';
import 'widgets/comunes.dart';

/// Checklist de viaje (las marcas no se guardan).
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
        title: Text(t('Kit de viaje')),
        actions: [
          if (marcados.isNotEmpty)
            TextButton(
              onPressed: () => setState(marcados.clear),
              child: Text(t('Reiniciar')),
            ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            BannerRevision(
              mensaje: t(
                'Lista orientativa en revisión. Ajústala con tu equipo médico '
                'según tu tratamiento y tu destino.',
              ),
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
                    completo ? Icons.check_circle : Icons.checklist_rtl_rounded,
                    color: completo ? colores.exito : esquema.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      completo
                          ? t('Todo listo. Buen viaje.')
                          : tf('{n} de {total} preparados', {
                              'n': marcados.length,
                              'total': _total,
                            }),
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
            ...kitViaje.map(
              (grupo) => _Grupo(
                grupo: grupo,
                marcados: marcados,
                alCambiar: (clave, valor) => setState(() {
                  if (valor) {
                    marcados.add(clave);
                  } else {
                    marcados.remove(clave);
                  }
                }),
              ),
            ),
            const _Aeropuerto(),
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
            t(grupo.titulo).toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: esquema.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t(grupo.nota),
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
                t(elemento),
                style: TextStyle(
                  fontSize: 15,
                  height: 1.3,
                  color: marcado ? esquema.onSurfaceVariant : esquema.onSurface,
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

/// Lo que dicen los manuales de la bomba y el sensor del usuario sobre los
/// controles del aeropuerto y el avión.
class _Aeropuerto extends StatelessWidget {
  const _Aeropuerto();

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final ids = [Preferencias.bomba, Preferencias.sensor];
    final dispositivos = [
      for (final id in ids)
        if (id != null && avisosAeropuerto[id] != null)
          (id, avisosAeropuerto[id]!),
    ];
    if (dispositivos.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t('En el control del aeropuerto').toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: esquema.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          t(
            'Lo que dicen los manuales de tus dispositivos. Las normas de cada '
            'aeropuerto pueden cambiar: consúltalas antes de viajar.',
          ),
          style: TextStyle(
            fontSize: 13,
            height: 1.35,
            color: esquema.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        for (final (id, aviso) in dispositivos)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: esquema.surfaceContainerLow,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombreDispositivo(id),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: esquema.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                for (final punto in aviso.puntos)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6, right: 8),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: esquema.primary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            t(punto),
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.35,
                              color: esquema.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  tf('Fuente: manual de {manual}, p. {pagina}', {
                    'manual': aviso.manual,
                    'pagina': aviso.pagina,
                  }),
                  style: TextStyle(
                    fontSize: 12,
                    color: esquema.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
