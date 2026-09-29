import 'package:flutter/material.dart';

import 'datos/dispositivos.dart';
import 'datos/guias_cateter.dart';
import 'l10n/idioma.dart';
import 'modelos/paso.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';
import 'widgets/pantalla_guia.dart';
import 'zonas_insercion.dart';

PantallaGuia _guiaCompleta(String bomba, String cateter) {
  final clave = '${bomba}_$cateter';
  return PantallaGuia(
    titulo: t('Instrucciones'),
    clave: clave,
    pasos: instruccionesCateter[clave] ?? const [pasoSinGuia],
    porRevisar: guiasCateterPorRevisar.contains(clave),
    alFinalizar: Preferencias.rotacionActiva
        ? (context) => preguntarZona(context, 'cateter')
        : null,
  );
}

class CambioCateterScreen extends StatelessWidget {
  final String bomba;
  final String cateter;

  const CambioCateterScreen({
    super.key,
    required this.bomba,
    required this.cateter,
  });

  /// Los manuales de Medtronic, Tandem y YpsoPump permiten cambiar el
  /// reservorio sin tocar el catéter. En Omnipod no aplica: el Pod integra el
  /// catéter.
  bool get _admiteSoloReservorio =>
      instruccionesSoloReservorio.containsKey(bomba);

  @override
  Widget build(BuildContext context) {
    if (!_admiteSoloReservorio) return _guiaCompleta(bomba, cateter);
    return _SelectorTipoCambio(bomba: bomba, cateter: cateter);
  }
}

/// Pregunta qué se va a cambiar antes de abrir la guía: hacer el proceso
/// completo cuando solo tocaba el reservorio añade pasos que el manual dice
/// expresamente que no hay que hacer, como llenar la cánula.
class _SelectorTipoCambio extends StatelessWidget {
  final String bomba;
  final String cateter;

  const _SelectorTipoCambio({required this.bomba, required this.cateter});

  void _abrir(BuildContext context, {required bool completo}) {
    final clave = '${bomba}_$cateter';
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => completo
            ? _guiaCompleta(bomba, cateter)
            : PantallaGuia(
                titulo: t('Solo reservorio'),
                clave: '${bomba}_solo_reservorio',
                pasos: instruccionesSoloReservorio[bomba]!,
                porRevisar: guiasCateterPorRevisar.contains(clave),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final esMedtronic = bomba == 'bmedtronic';

    return Scaffold(
      appBar: AppBar(title: Text(t('¿Qué vas a cambiar?'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              t('El manual de tu bomba permite cambiarlos por separado.'),
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: esquema.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            _Opcion(
              titulo: t('Todo el equipo'),
              descripcion: esMedtronic
                  ? t(
                      'Cambias el reservorio y también el catéter: se pone '
                      'uno nuevo y se llena la cánula.',
                    )
                  : t(
                      'Cambias el cartucho y también el catéter: se pone '
                      'uno nuevo y se llena la cánula.',
                    ),
              icono: Icons.published_with_changes,
              destacada: true,
              alPulsar: () => _abrir(context, completo: true),
            ),
            const SizedBox(height: 12),
            _Opcion(
              titulo: esMedtronic
                  ? t('Solo el reservorio')
                  : t('Solo el cartucho'),
              descripcion: t(
                'Se te ha acabado la insulina pero el catéter sigue bien. '
                'No se llena la cánula.',
              ),
              icono: Icons.opacity,
              destacada: false,
              alPulsar: () => _abrir(context, completo: false),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: esquema.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: esquema.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t(
                        'Si dudas, elige "Todo el equipo": cambiar el catéter '
                        'de más nunca es un riesgo, dejarlo puesto de más sí.',
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: esquema.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                tf('Tu catéter: {nombre}', {
                  'nombre': nombreDispositivo(cateter),
                }),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: esquema.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Opcion extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final bool destacada;
  final VoidCallback alPulsar;

  const _Opcion({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.destacada,
    required this.alPulsar,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return InkWell(
      onTap: alPulsar,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          border: Border.all(
            color: destacada ? esquema.primary : esquema.outlineVariant,
            width: destacada ? 1.6 : 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: esquema.primary.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icono, color: esquema.primary, size: 24),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: esquema.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descripcion,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: esquema.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
