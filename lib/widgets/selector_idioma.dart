import 'package:flutter/material.dart';

import '../l10n/idioma.dart';
import '../servicios/notificaciones.dart';
import '../servicios/preferencias.dart';
import '../tema.dart';

/// Cambia el idioma al instante, lo guarda y reprograma los avisos.
Future<void> elegirIdioma(Idioma idioma) async {
  if (idioma == Traductor.actual) return;
  await Preferencias.guardarIdioma(idioma);
  await Notificaciones.reprogramar();
}

/// Bandera de un idioma dibujada con código.
class Bandera extends StatelessWidget {
  final Idioma idioma;
  final double ancho;

  const Bandera({super.key, required this.idioma, this.ancho = 36});

  @override
  Widget build(BuildContext context) {
    final alto = ancho * 2 / 3;
    return Container(
      width: ancho,
      height: alto,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(alto * 0.14),
        border: Border.all(color: Colors.black.withAlpha(40)),
      ),
      clipBehavior: Clip.antiAlias,
      child: CustomPaint(painter: _PintorBandera(idioma)),
    );
  }
}

class _PintorBandera extends CustomPainter {
  final Idioma idioma;

  const _PintorBandera(this.idioma);

  @override
  void paint(Canvas canvas, Size s) {
    switch (idioma) {
      case Idioma.es:
        _espana(canvas, s);
      case Idioma.en:
        _reinoUnido(canvas, s);
      case Idioma.gl:
        _galicia(canvas, s);
      case Idioma.ca:
        _cataluna(canvas, s);
      case Idioma.eu:
        _euskadi(canvas, s);
    }
  }

  Paint _relleno(Color c) => Paint()..color = c;

  Paint _trazo(Color c, double grosor) => Paint()
    ..color = c
    ..style = PaintingStyle.stroke
    ..strokeWidth = grosor;

  void _espana(Canvas canvas, Size s) {
    const rojo = Color(0xFFC60B1E);
    const amarillo = Color(0xFFFFC400);
    canvas.drawRect(Offset.zero & s, _relleno(rojo));
    canvas.drawRect(
      Rect.fromLTWH(0, s.height * 0.25, s.width, s.height * 0.5),
      _relleno(amarillo),
    );
  }

  void _reinoUnido(Canvas canvas, Size s) {
    const azul = Color(0xFF012169);
    const rojo = Color(0xFFC8102E);
    canvas.drawRect(Offset.zero & s, _relleno(azul));

    final a = Offset.zero;
    final b = Offset(s.width, s.height);
    final c = Offset(s.width, 0);
    final d = Offset(0, s.height);

    canvas.drawLine(a, b, _trazo(Colors.white, s.height * 0.2));
    canvas.drawLine(c, d, _trazo(Colors.white, s.height * 0.2));
    canvas.drawLine(a, b, _trazo(rojo, s.height * 0.07));
    canvas.drawLine(c, d, _trazo(rojo, s.height * 0.07));

    final medio = s.center(Offset.zero);
    canvas.drawLine(
      Offset(0, medio.dy),
      Offset(s.width, medio.dy),
      _trazo(Colors.white, s.height * 0.33),
    );
    canvas.drawLine(
      Offset(medio.dx, 0),
      Offset(medio.dx, s.height),
      _trazo(Colors.white, s.height * 0.33),
    );
    canvas.drawLine(
      Offset(0, medio.dy),
      Offset(s.width, medio.dy),
      _trazo(rojo, s.height * 0.2),
    );
    canvas.drawLine(
      Offset(medio.dx, 0),
      Offset(medio.dx, s.height),
      _trazo(rojo, s.height * 0.2),
    );
  }

  void _galicia(Canvas canvas, Size s) {
    canvas.drawRect(Offset.zero & s, _relleno(Colors.white));
    canvas.drawLine(
      Offset.zero,
      Offset(s.width, s.height),
      _trazo(const Color(0xFF0B5FA5), s.height * 0.38),
    );
  }

  void _cataluna(Canvas canvas, Size s) {
    const amarillo = Color(0xFFFCDD09);
    const rojo = Color(0xFFDA121A);
    canvas.drawRect(Offset.zero & s, _relleno(amarillo));
    final franja = s.height / 9;
    for (var i = 1; i < 9; i += 2) {
      canvas.drawRect(
        Rect.fromLTWH(0, franja * i, s.width, franja),
        _relleno(rojo),
      );
    }
  }

  void _euskadi(Canvas canvas, Size s) {
    const rojo = Color(0xFFD52B1E);
    const verde = Color(0xFF009B48);
    canvas.drawRect(Offset.zero & s, _relleno(rojo));

    final medio = s.center(Offset.zero);
    canvas.drawLine(
      Offset(0, medio.dy),
      Offset(s.width, medio.dy),
      _trazo(Colors.white, s.height * 0.1),
    );
    canvas.drawLine(
      Offset(medio.dx, 0),
      Offset(medio.dx, s.height),
      _trazo(Colors.white, s.height * 0.1),
    );
    canvas.drawLine(
      Offset.zero,
      Offset(s.width, s.height),
      _trazo(verde, s.height * 0.1),
    );
    canvas.drawLine(
      Offset(s.width, 0),
      Offset(0, s.height),
      _trazo(verde, s.height * 0.1),
    );
    canvas.drawLine(
      Offset(0, medio.dy),
      Offset(s.width, medio.dy),
      _trazo(Colors.white, s.height * 0.1),
    );
    canvas.drawLine(
      Offset(medio.dx, 0),
      Offset(medio.dx, s.height),
      _trazo(Colors.white, s.height * 0.1),
    );
  }

  @override
  bool shouldRepaint(_PintorBandera viejo) => viejo.idioma != idioma;
}

/// Fila de banderas para elegir idioma; caben las cinco en una sola fila.
class SelectorIdioma extends StatelessWidget {
  /// Si es `true`, cada bandera lleva debajo el nombre del idioma.
  final bool conNombre;

  const SelectorIdioma({super.key, this.conNombre = true});

  static const double _separacion = 6;

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final idiomas = Idioma.values;

    return LayoutBuilder(
      builder: (context, restricciones) {
        final casilla =
            (restricciones.maxWidth - _separacion * (idiomas.length - 1)) /
            idiomas.length;
        final ancho = (casilla - 12).clamp(20.0, 44.0);

        return Row(
          children: [
            for (var i = 0; i < idiomas.length; i++) ...[
              if (i > 0) const SizedBox(width: _separacion),
              SizedBox(
                width: casilla,
                child: _Casilla(
                  idioma: idiomas[i],
                  activo: idiomas[i] == Traductor.actual,
                  ancho: ancho,
                  conNombre: conNombre,
                  esquema: esquema,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _Casilla extends StatelessWidget {
  final Idioma idioma;
  final bool activo;
  final double ancho;
  final bool conNombre;
  final ColorScheme esquema;

  const _Casilla({
    required this.idioma,
    required this.activo,
    required this.ancho,
    required this.conNombre,
    required this.esquema,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: activo,
      label: idioma.nombre,
      child: InkWell(
        onTap: () => elegirIdioma(idioma),
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: activo
                ? esquema.primary.withAlpha(26)
                : esquema.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: activo ? esquema.primary : esquema.outlineVariant,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Bandera(idioma: idioma, ancho: ancho),
              if (conNombre) ...[
                const SizedBox(height: 5),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    idioma.nombre,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: activo ? FontWeight.w700 : FontWeight.w500,
                      color: activo ? esquema.primary : esquema.onSurface,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Botón compacto con la bandera del idioma activo; abre el selector.
class BotonIdioma extends StatelessWidget {
  const BotonIdioma({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: Traductor.actual.nombre,
      icon: Bandera(idioma: Traductor.actual, ancho: 28),
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) => const SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SelectorIdioma(),
          ),
        ),
      ),
    );
  }
}
