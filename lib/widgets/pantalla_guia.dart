import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../datos/gestos.dart';
import '../l10n/idioma.dart';
import '../modelos/gesto.dart';
import '../modelos/paso.dart';
import '../servicios/preferencias.dart';
import '../tema.dart';
import 'boton_sugerencia.dart';
import 'comunes.dart';

/// Recorrido paso a paso, compartido por las guías de catéter y de sensor.
class PantallaGuia extends StatefulWidget {
  final String titulo;

  /// Clave de la guía (`bmedtronic_cmio30`); identifica el progreso guardado.
  final String clave;

  final List<Paso> pasos;

  /// Muestra el aviso de contenido en revisión.
  final bool porRevisar;

  /// Se llama al pulsar "Finalizar", para anotar la zona de inserción.
  final Future<void> Function(BuildContext context)? alFinalizar;

  /// Paso por el que abrir la guía (lo usa el buscador).
  final int? pasoInicial;

  const PantallaGuia({
    super.key,
    required this.titulo,
    required this.clave,
    required this.pasos,
    required this.porRevisar,
    this.alFinalizar,
    this.pasoInicial,
  });

  @override
  State<PantallaGuia> createState() => _PantallaGuiaState();
}

class _PantallaGuiaState extends State<PantallaGuia> {
  int pasoActual = 0;
  bool _avanzando = true;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    final inicial = widget.pasoInicial;
    if (inicial != null && inicial >= 0 && inicial < widget.pasos.length) {
      pasoActual = inicial;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _ofrecerRetomar());
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  /// Si quedó un cambio a medias, pregunta si se quiere retomar.
  Future<void> _ofrecerRetomar() async {
    final guardado = Preferencias.progresoGuia(widget.clave);
    if (guardado <= 0 || guardado >= widget.pasos.length || !mounted) return;

    final retomar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(t('¿Retomar donde lo dejaste?')),
        content: Text(
          tf('Dejaste este recambio a medias, en el paso {n} de {total}.', {
            'n': guardado + 1,
            'total': widget.pasos.length,
          }),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t('Empezar de nuevo')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(tf('Ir al paso {n}', {'n': guardado + 1})),
          ),
        ],
      ),
    );

    if (!mounted) return;
    if (retomar == true) {
      setState(() => pasoActual = guardado);
    } else {
      await Preferencias.borrarProgresoGuia(widget.clave);
    }
  }

  Future<void> _irA(int paso) async {
    HapticFeedback.selectionClick();
    setState(() {
      _avanzando = paso > pasoActual;
      pasoActual = paso;
    });
    await Preferencias.guardarProgresoGuia(widget.clave, paso);
  }

  void siguientePaso() {
    if (pasoActual < widget.pasos.length - 1) _irA(pasoActual + 1);
  }

  void pasoAnterior() {
    if (pasoActual > 0) _irA(pasoActual - 1);
  }

  Future<void> _finalizar() async {
    HapticFeedback.mediumImpact();
    await Preferencias.borrarProgresoGuia(widget.clave);
    if (!mounted) return;

    final alFinalizar = widget.alFinalizar;
    if (alFinalizar != null) await alFinalizar(context);
    if (mounted) Navigator.pop(context);
  }

  /// Posición dentro de la fase actual, para no mostrar solo "paso 14 de 21".
  ({int indice, int total}) _posicionEnFase(String? fase) {
    if (fase == null) {
      return (indice: pasoActual + 1, total: widget.pasos.length);
    }
    final deLaFase = <int>[];
    for (var i = 0; i < widget.pasos.length; i++) {
      if (widget.pasos[i].fase == fase) deLaFase.add(i);
    }
    return (indice: deLaFase.indexOf(pasoActual) + 1, total: deLaFase.length);
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final paso = widget.pasos[pasoActual];
    final tieneImagen = paso.imagen != null;
    final esUltimo = pasoActual == widget.pasos.length - 1;
    final acento = esquema.primary;
    final pos = _posicionEnFase(paso.fase);

    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _ProgresoSegmentos(
                total: widget.pasos.length,
                actual: pasoActual,
                acento: acento,
              ),
              const SizedBox(height: 14),
              _Cabecera(
                fase: paso.fase,
                indiceFase: pos.indice,
                totalFase: pos.total,
                pasoGlobal: pasoActual + 1,
                totalGlobal: widget.pasos.length,
                acento: acento,
              ),
              if (widget.porRevisar) ...[
                const SizedBox(height: 12),
                const BannerRevision(),
              ],
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragEnd: (d) {
                    final v = d.primaryVelocity ?? 0;
                    if (v < -300 && !esUltimo) siguientePaso();
                    if (v > 300) pasoAnterior();
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animacion) {
                      final entrando = child.key == ValueKey(pasoActual);
                      final signo =
                          (_avanzando ? 1.0 : -1.0) * (entrando ? 1.0 : -1.0);
                      return FadeTransition(
                        opacity: animacion,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0.08 * signo, 0),
                            end: Offset.zero,
                          ).animate(animacion),
                          child: child,
                        ),
                      );
                    },
                    child: SingleChildScrollView(
                      key: ValueKey(pasoActual),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (tieneImagen) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: fondoDispositivo,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: acento.withAlpha(30),
                                    blurRadius: 18,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                paso.imagen!,
                                height: 190,
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) =>
                                    const SizedBox(height: 60),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          Row(
                            children: [
                              _NumeroPaso(
                                numero: pasoActual + 1,
                                acento: acento,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: _EtiquetaGesto(
                                  gesto: gestoDe(paso),
                                  acento: acento,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            t(paso.texto),
                            style: TextStyle(
                              fontSize: 22,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                              color: esquema.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BotonSugerencia(
                ubicacion:
                    'Guía ${widget.clave} — paso ${pasoActual + 1} de '
                    '${widget.pasos.length}'
                    '${paso.fase != null ? " (${paso.fase})" : ""}',
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Row(
                  children: [
                    if (pasoActual > 0) ...[
                      IconButton.filledTonal(
                        onPressed: pasoAnterior,
                        tooltip: t('Anterior'),
                        icon: const Icon(Icons.arrow_back_rounded),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(56, 56),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: FilledButton(
                        onPressed: esUltimo ? _finalizar : siguientePaso,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          esUltimo ? t('Finalizar') : t('Siguiente'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
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

/// Icono y nombre del gesto que pide el paso.
class _EtiquetaGesto extends StatelessWidget {
  final Gesto gesto;
  final Color acento;

  const _EtiquetaGesto({required this.gesto, required this.acento});

  @override
  Widget build(BuildContext context) {
    final color = gesto == Gesto.advertencia ? context.colores.aviso : acento;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(gesto.icono, color: color, size: 20),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              t(gesto.etiqueta),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Nombre de la fase y posición, dentro de la fase y en el total.
class _Cabecera extends StatelessWidget {
  final String? fase;
  final int indiceFase;
  final int totalFase;
  final int pasoGlobal;
  final int totalGlobal;
  final Color acento;

  const _Cabecera({
    required this.fase,
    required this.indiceFase,
    required this.totalFase,
    required this.pasoGlobal,
    required this.totalGlobal,
    required this.acento,
  });

  @override
  Widget build(BuildContext context) {
    final estiloFase = TextStyle(
      letterSpacing: 1.1,
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: acento,
    );

    if (fase == null) {
      return Text(
        tf('PASO {n} DE {total}', {'n': pasoGlobal, 'total': totalGlobal}),
        style: estiloFase,
      );
    }

    return Column(
      children: [
        Text(
          t(fase!).toUpperCase(),
          style: estiloFase,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          tf('Paso {i} de {total} · {global}/{totalGlobal} en total', {
            'i': indiceFase,
            'total': totalFase,
            'global': pasoGlobal,
            'totalGlobal': totalGlobal,
          }),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: context.esquema.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ProgresoSegmentos extends StatelessWidget {
  final int total;
  final int actual;
  final Color acento;

  const _ProgresoSegmentos({
    required this.total,
    required this.actual,
    required this.acento,
  });

  @override
  Widget build(BuildContext context) {
    final vacio = context.esquema.surfaceContainerHighest;
    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: 3),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 6,
              decoration: BoxDecoration(
                color: i <= actual ? acento : vacio,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _NumeroPaso extends StatelessWidget {
  final int numero;
  final Color acento;

  const _NumeroPaso({required this.numero, required this.acento});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 34),
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: acento,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Text(
        '$numero',
        style: TextStyle(
          color: context.esquema.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
