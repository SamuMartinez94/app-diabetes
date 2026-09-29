import 'package:flutter/material.dart';

import 'datos/zonas.dart';
import 'l10n/idioma.dart';
import 'modelos/registro_insercion.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';

/// Días que se considera que una zona sigue "reciente" y conviene evitar.
const int _diasDescanso = 14;

/// Pregunta al usuario dónde ha insertado, al terminar una guía.
Future<void> preguntarZona(BuildContext context, String tipo) async {
  final zonaElegida = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _HojaZonas(tipo: tipo),
  );

  if (zonaElegida == null) return;

  await Preferencias.anotarInsercion(
    RegistroInsercion(zona: zonaElegida, tipo: tipo, fecha: DateTime.now()),
  );
}

/// Cuántos días hace que se usó cada zona. Ausente = nunca usada.
Map<String, int> _diasDesdeUso(String tipo) {
  final ahora = DateTime.now();
  final resultado = <String, int>{};

  for (final registro in Preferencias.registros) {
    if (registro.tipo != tipo) continue;
    final dias = ahora.difference(registro.fecha).inDays;
    // Los registros vienen del más reciente al más antiguo.
    resultado.putIfAbsent(registro.zona, () => dias);
  }
  return resultado;
}

class _HojaZonas extends StatelessWidget {
  final String tipo;

  const _HojaZonas({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final disponibles = zonas.where((z) => z.admite(tipo)).toList();
    final usos = _diasDesdeUso(tipo);

    return Container(
      decoration: BoxDecoration(
        color: esquema.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(25, 12, 25, 25),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: esquema.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              t('¿Dónde te lo has puesto?'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: esquema.onSurface,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t(
                'Anotarlo te ayuda a ir cambiando de sitio para que la piel '
                'no se endurezca.',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                color: esquema.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: disponibles
                      .map((z) => _Chip(zona: z, diasDesdeUso: usos[z.id]))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                t('Ahora no'),
                style: TextStyle(color: esquema.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final Zona zona;
  final int? diasDesdeUso;

  const _Chip({required this.zona, this.diasDesdeUso});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;
    final reciente = diasDesdeUso != null && diasDesdeUso! < _diasDescanso;

    return InkWell(
      onTap: () => Navigator.pop(context, zona.id),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: reciente
              ? colores.aviso.withAlpha(26)
              : esquema.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: reciente
                ? colores.aviso.withAlpha(90)
                : esquema.outlineVariant,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t(zona.nombre),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: esquema.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              switch (diasDesdeUso) {
                null => t('Sin usar'),
                0 => t('Usada hoy'),
                1 => t('Hace 1 día'),
                final d => tf('Hace {n} días', {'n': d}),
              },
              style: TextStyle(
                fontSize: 11,
                fontWeight: reciente ? FontWeight.w700 : FontWeight.w400,
                color: reciente ? colores.aviso : esquema.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Historial de zonas usadas, con sugerencia de la próxima.
class ZonasScreen extends StatefulWidget {
  const ZonasScreen({super.key});

  @override
  State<ZonasScreen> createState() => _ZonasScreenState();
}

class _ZonasScreenState extends State<ZonasScreen> {
  String tipo = 'cateter';

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;
    final disponibles = zonas.where((z) => z.admite(tipo)).toList();
    final usos = _diasDesdeUso(tipo);

    // La mejor zona es la que lleva más tiempo sin usarse.
    final sugerida = disponibles.reduce((a, b) {
      final da = usos[a.id] ?? 9999;
      final db = usos[b.id] ?? 9999;
      return da >= db ? a : b;
    });

    final registros = Preferencias.registros
        .where((r) => r.tipo == tipo)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(t('Rotación de zonas'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'cateter', label: Text(t('Catéter'))),
                ButtonSegment(value: 'sensor', label: Text(t('Sensor'))),
              ],
              selected: {tipo},
              onSelectionChanged: (s) => setState(() => tipo = s.first),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colores.exito.withAlpha(26),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colores.exito.withAlpha(70)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        size: 18,
                        color: colores.exito,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          t('PRÓXIMA ZONA SUGERIDA'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            color: colores.exito,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    t(sugerida.nombre),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: esquema.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    usos[sugerida.id] == null
                        ? t('Todavía no la has usado.')
                        : t('Es la que lleva más tiempo sin usarse.'),
                    style: TextStyle(
                      fontSize: 13,
                      color: esquema.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              t('ESTADO DE CADA ZONA'),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: esquema.primary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: disponibles
                  .map(
                    (z) => IgnorePointer(
                      child: _Chip(zona: z, diasDesdeUso: usos[z.id]),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    t('HISTORIAL'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: esquema.primary,
                    ),
                  ),
                ),
                if (registros.isNotEmpty)
                  TextButton(
                    onPressed: () async {
                      await Preferencias.borrarRegistros();
                      if (context.mounted) setState(() {});
                    },
                    child: Text(t('Borrar')),
                  ),
              ],
            ),
            if (registros.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  t(
                    'Todavía no has anotado ningún cambio. Al terminar una '
                    'guía se te preguntará dónde te lo has puesto.',
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: esquema.onSurfaceVariant,
                  ),
                ),
              ),
            ...registros.map((r) {
              final zona = zonas.firstWhere(
                (z) => z.id == r.zona,
                orElse: () =>
                    Zona(id: r.zona, nombre: r.zona, x: 0, y: 0, apto: 'ambos'),
              );
              final dias = DateTime.now().difference(r.fecha).inDays;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.place_outlined,
                  color: esquema.onSurfaceVariant,
                ),
                title: Text(
                  t(zona.nombre),
                  style: TextStyle(fontSize: 15, color: esquema.onSurface),
                ),
                subtitle: Text(
                  switch (dias) {
                    0 => t('Hoy'),
                    1 => t('Ayer'),
                    final d => tf('Hace {n} días', {'n': d}),
                  },
                  style: TextStyle(
                    fontSize: 12,
                    color: esquema.onSurfaceVariant,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
