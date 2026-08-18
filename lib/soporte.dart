import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'datos/soporte.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';

class SoporteScreen extends StatefulWidget {
  const SoporteScreen({super.key});

  @override
  State<SoporteScreen> createState() => _SoporteScreenState();
}

class _SoporteScreenState extends State<SoporteScreen> {
  Future<void> _abrir(Uri destino) async {
    if (!await launchUrl(destino, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;
    final miBomba = Preferencias.bomba ?? '';

    // Primero el fabricante de la bomba del usuario.
    final ordenados = [...fabricantes]
      ..sort((a, b) {
        final ma = a.bombas.contains(miBomba) ? 0 : 1;
        final mb = b.bombas.contains(miBomba) ? 0 : 1;
        return ma.compareTo(mb);
      });

    return Scaffold(
      appBar: AppBar(title: const Text('Soporte y manuales')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colores.porRevisarFondo,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colores.porRevisar.withAlpha(70)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency_outlined,
                        color: colores.porRevisar,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'URGENCIAS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          color: colores.porRevisar,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ante una hipoglucemia grave, pérdida de consciencia o '
                    'cetoacidosis, llama al 112.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: esquema.onSurface,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: colores.porRevisar,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => _abrir(Uri.parse('tel:112')),
                      icon: const Icon(Icons.call, size: 20),
                      label: const Text(
                        'Llamar al 112',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'FABRICANTES',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: esquema.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Los teléfonos de soporte cambian según el país, así que no vienen '
              'precargados: un número equivocado en una urgencia es peor que '
              'ninguno. Busca el tuyo en la web oficial.',
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: esquema.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            ...ordenados.map(
              (f) => _FichaFabricante(
                fabricante: f,
                esLaMia: f.bombas.contains(miBomba),
                alAbrir: _abrir,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _FichaFabricante extends StatelessWidget {
  final Fabricante fabricante;
  final bool esLaMia;
  final Future<void> Function(Uri) alAbrir;

  const _FichaFabricante({
    required this.fabricante,
    required this.esLaMia,
    required this.alAbrir,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: esLaMia ? esquema.primary : esquema.outlineVariant,
            width: esLaMia ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    fabricante.nombre,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: esquema.onSurface,
                    ),
                  ),
                ),
                if (esLaMia)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: esquema.primary.withAlpha(26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'TU BOMBA',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: esquema.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              fabricante.dispositivos,
              style: TextStyle(
                fontSize: 13,
                color: esquema.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => alAbrir(Uri.parse(fabricante.web)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: esquema.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Web oficial y manuales'),
            ),
          ],
        ),
      ),
    );
  }
}
