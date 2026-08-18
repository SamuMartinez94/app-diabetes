import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../modelos/paso.dart';
import '../tema.dart';
import 'boton_sugerencia.dart';
import 'comunes.dart';

/// Recorrido paso a paso, compartido por las guías de catéter y de sensor.
///
/// Mantiene la pantalla encendida mientras está abierta: durante un recambio
/// tienes las manos ocupadas y no puedes ir despertando el móvil.
class PantallaGuia extends StatefulWidget {
  final String titulo;

  /// Clave de la guía (`bmedtronic_cmio30`). Viaja en las sugerencias para
  /// saber exactamente a qué guía se refiere el reporte.
  final String clave;

  final List<Paso> pasos;
  final bool porRevisar;

  /// Se llama al pulsar "Finalizar", para anotar la zona de inserción.
  final Future<void> Function(BuildContext context)? alFinalizar;

  const PantallaGuia({
    super.key,
    required this.titulo,
    required this.clave,
    required this.pasos,
    required this.porRevisar,
    this.alFinalizar,
  });

  @override
  State<PantallaGuia> createState() => _PantallaGuiaState();
}

class _PantallaGuiaState extends State<PantallaGuia> {
  int pasoActual = 0;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  void siguientePaso() {
    if (pasoActual < widget.pasos.length - 1) {
      setState(() => pasoActual++);
    }
  }

  void pasoAnterior() {
    if (pasoActual > 0) setState(() => pasoActual--);
  }

  Future<void> _finalizar() async {
    final alFinalizar = widget.alFinalizar;
    if (alFinalizar != null) await alFinalizar(context);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;
    final paso = widget.pasos[pasoActual];
    final tieneImagen = paso.imagen != null;
    final esUltimo = pasoActual == widget.pasos.length - 1;
    final acento = widget.porRevisar ? colores.porRevisar : esquema.primary;

    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: (pasoActual + 1) / widget.pasos.length,
                color: acento,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 15),
              Text(
                'PASO ${pasoActual + 1} DE ${widget.pasos.length}',
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: acento,
                ),
              ),
              if (widget.porRevisar) ...[
                const SizedBox(height: 12),
                const BannerRevision(),
              ],
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animacion) => FadeTransition(
                    opacity: animacion,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.05, 0),
                        end: Offset.zero,
                      ).animate(animacion),
                      child: child,
                    ),
                  ),
                  child: Center(
                    key: ValueKey(pasoActual),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: esquema.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: esquema.outlineVariant),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (tieneImagen) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset(
                                  paso.imagen!,
                                  height: 180,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, _, _) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                            Icon(
                              Icons.info_outline,
                              color: acento.withAlpha(77),
                              size: 30,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              paso.texto,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: widget.porRevisar
                                    ? colores.porRevisar
                                    : esquema.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BotonSugerencia(
                ubicacion:
                    'Guía ${widget.clave} — paso ${pasoActual + 1} de '
                    '${widget.pasos.length}',
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Row(
                  children: [
                    if (pasoActual > 0) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: pasoAnterior,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            side: BorderSide(color: esquema.outline),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Anterior',
                            style: TextStyle(
                              color: esquema.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: FilledButton(
                        onPressed: esUltimo ? _finalizar : siguientePaso,
                        style: FilledButton.styleFrom(
                          backgroundColor: esquema.primary,
                          foregroundColor: esquema.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          esUltimo ? 'Finalizar' : 'Siguiente',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
