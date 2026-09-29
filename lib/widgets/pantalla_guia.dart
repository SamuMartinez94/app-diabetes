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
///
/// Mantiene la pantalla encendida mientras está abierta: durante un recambio
/// tienes las manos ocupadas y no puedes ir despertando el móvil.
class PantallaGuia extends StatefulWidget {
  /// Ya traducido.
  final String titulo;

  /// Clave de la guía (`bmedtronic_cmio30`). Identifica el progreso guardado
  /// y viaja en las sugerencias.
  final String clave;

  final List<Paso> pasos;

  /// Si la guía todavía no la ha validado un profesional, se muestra un aviso
  /// discreto arriba.
  final bool porRevisar;

  /// Se llama al pulsar "Finalizar", para anotar la zona de inserción.
  final Future<void> Function(BuildContext context)? alFinalizar;

  /// Paso por el que abrir la guía. Lo usa el buscador para saltar
  /// directamente al resultado; en ese caso no se pregunta por retomar.
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

  /// Si quedó un recambio a medias, pregunta antes de continuar. No se retoma
  /// en silencio: caer de golpe en el paso 14 de un procedimiento que crees
  /// que estás empezando es peligroso.
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
    setState(() => pasoActual = paso);
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
              LinearProgressIndicator(
                value: (pasoActual + 1) / widget.pasos.length,
                color: acento,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 12),
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
                  child: SingleChildScrollView(
                    key: ValueKey(pasoActual),
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
                          // El gesto se deduce del texto en castellano (el
                          // idioma de origen), no del traducido.
                          _EtiquetaGesto(gesto: gestoDe(paso), acento: acento),
                          const SizedBox(height: 18),
                          Text(
                            t(paso.texto),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
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
                            t('Anterior'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                          esUltimo ? t('Finalizar') : t('Siguiente'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

/// Icono y nombre del gesto que pide el paso. Sustituye al icono genérico:
/// da una pista visual de qué hay que hacer antes de leer el texto.
class _EtiquetaGesto extends StatelessWidget {
  final Gesto gesto;
  final Color acento;

  const _EtiquetaGesto({required this.gesto, required this.acento});

  @override
  Widget build(BuildContext context) {
    // Las advertencias se salen del color de la guía: son lo único que debe
    // destacar.
    final color = gesto == Gesto.advertencia ? context.colores.aviso : acento;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(gesto.icono, color: color, size: 18),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              t(gesto.etiqueta).toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.9,
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
