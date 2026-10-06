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

/// Posición del contenido en el hueco de la pantalla: -1 sería pegado arriba y
/// 0, centrado. Un poco por encima del centro queda equilibrado.
const _alineacionContenido = Alignment(0, -0.6);

/// Recorrido paso a paso, compartido por las guías de catéter y de sensor.
class PantallaGuia extends StatefulWidget {
  final String titulo;

  /// Clave de la guía (`bmedtronic_cmio30`); identifica el progreso guardado.
  final String clave;

  final List<Paso> pasos;

  /// Antes de empezar, muestra el aviso de contenido en revisión.
  final bool porRevisar;

  /// Se llama al pulsar "Finalizar", para anotar la zona de inserción.
  final Future<void> Function(BuildContext context)? alFinalizar;

  /// Paso por el que abrir la guía.
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

  /// El aviso de revisión se enseña una vez al abrir la guía.
  late bool _avisoPendiente = widget.porRevisar;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    final inicial = widget.pasoInicial;
    if (inicial != null && inicial >= 0 && inicial < widget.pasos.length) {
      pasoActual = inicial;
    } else if (!_avisoPendiente) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _ofrecerRetomar());
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  /// Quita el aviso y, si quedó un cambio a medias, pregunta si se retoma.
  void _aceptarAviso() {
    setState(() => _avisoPendiente = false);
    if (widget.pasoInicial == null) _ofrecerRetomar();
  }

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

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final acento = esquema.primary;

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
                actual: _avisoPendiente ? -1 : pasoActual,
                acento: acento,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _avisoPendiente
                    ? const _AvisoRevision()
                    : _pasoConGestos(acento),
              ),
              if (_avisoPendiente)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: FilledButton(
                    onPressed: _aceptarAviso,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      t('Entendido'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                ..._pie(acento),
            ],
          ),
        ),
      ),
    );
  }

  /// El paso actual, con transición lateral y deslizar para cambiar de paso.
  Widget _pasoConGestos(Color acento) {
    final paso = widget.pasos[pasoActual];
    final esUltimo = pasoActual == widget.pasos.length - 1;

    return GestureDetector(
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
        // El contenido va algo por encima del centro: así el hueco de abajo no
        // se ve vacío y arriba no queda demasiado espacio.
        layoutBuilder: (actual, anteriores) => Stack(
          alignment: _alineacionContenido,
          children: [...anteriores, ?actual],
        ),
        transitionBuilder: (child, animacion) {
          final entrando = child.key == ValueKey(pasoActual);
          final signo = (_avanzando ? 1.0 : -1.0) * (entrando ? 1.0 : -1.0);
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
          padding: const EdgeInsets.only(top: 6, bottom: 18),
          child: _ContenidoPaso(
            texto: t(paso.texto),
            imagen: paso.imagen,
            gesto: gestoDe(paso),
            acento: acento,
          ),
        ),
      ),
    );
  }

  /// Botón de sugerencias y botones de anterior / siguiente.
  List<Widget> _pie(Color acento) {
    final paso = widget.pasos[pasoActual];
    final esUltimo = pasoActual == widget.pasos.length - 1;

    return [
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
                  backgroundColor: acento.withAlpha(28),
                  foregroundColor: acento,
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
    ];
  }
}

/// Burbuja con el nombre del paso y el icono del gesto que pide.
class _EtiquetaGesto extends StatelessWidget {
  final Gesto gesto;
  final String texto;
  final Color acento;

  const _EtiquetaGesto({
    required this.gesto,
    required this.texto,
    required this.acento,
  });

  @override
  Widget build(BuildContext context) {
    final color = gesto == Gesto.advertencia ? context.colores.aviso : acento;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(gesto.icono, color: color, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
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

/// Un segmento por paso: los hechos y el actual se rellenan.
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

/// Aviso de contenido en revisión: una burbuja de advertencia que se quita al
/// aceptarla y deja empezar los pasos.
class _AvisoRevision extends StatelessWidget {
  const _AvisoRevision();

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final aviso = context.colores.aviso;
    final mensaje = t(
      'Contenido en revisión. Contrasta estos pasos con el '
      'manual oficial y con tu equipo médico.',
    );
    // La primera frase hace de título y el resto, de explicación.
    final corte = mensaje.indexOf('. ');
    final titulo = corte < 0 ? mensaje : mensaje.substring(0, corte);
    final resto = corte < 0 ? '' : mensaje.substring(corte + 2);

    return Align(
      alignment: _alineacionContenido,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 18, bottom: 18),
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
          decoration: BoxDecoration(
            color: aviso.withAlpha(24),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: aviso.withAlpha(110), width: 1.5),
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: aviso.withAlpha(36),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: aviso,
                  size: 34,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  height: 1.25,
                  fontWeight: FontWeight.w800,
                  color: esquema.onSurface,
                ),
              ),
              if (resto.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  resto,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: esquema.onSurface.withAlpha(220),
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

// ---------------------------------------------------------------------------
// TEXTO DE LOS PASOS
// ---------------------------------------------------------------------------

/// Palabras en mayúsculas seguidas ("CUARTO DE VUELTA EXTRA", "PULSA INICIO").
final _rachaDeMayusculas = RegExp(
  r'(?<![A-Za-zÁÉÍÓÚÜÑáéíóúüñ])[A-ZÁÉÍÓÚÜÑ]{3,}'
  r'(?:\s+(?:[A-ZÁÉÍÓÚÜÑ]{2,}|\d+)(?=[\s.,;:!?)"]|$))*',
);

/// Palabras tras las que una etiqueta de pantalla va con inicial mayúscula
/// ("pulsa Inicio", "toca Siguiente").
const _verbosDeBoton = {
  'pulsa',
  'pulsar',
  'toca',
  'tocar',
  'elige',
  'elegir',
  'selecciona',
  'seleccionar',
  'después',
  'entra',
};

/// Pasa a minúsculas una racha en mayúsculas. Lleva inicial mayúscula si
/// empieza una frase o es el nombre de un botón o de un menú.
String _aMinusculas(String racha, {required bool inicial}) {
  var texto = racha.toLowerCase().replaceAllMapped(
    RegExp(r'\bpod\b'),
    (_) => 'Pod',
  );
  if (inicial && texto.isNotEmpty) {
    texto = texto[0].toUpperCase() + texto.substring(1);
  }
  return texto;
}

/// Convierte el texto en trozos: las palabras en MAYÚSCULAS salen en minúsculas
/// y, si hay [enfasis], resaltadas.
List<InlineSpan> _sinGritar(String texto, {TextStyle? enfasis}) {
  final trozos = <InlineSpan>[];
  var pos = 0;
  for (final m in _rachaDeMayusculas.allMatches(texto)) {
    if (m.start > pos) {
      trozos.add(TextSpan(text: texto.substring(pos, m.start)));
    }

    final antes = texto.substring(0, m.start).trimRight();
    final ultima = antes.isEmpty ? '' : antes[antes.length - 1];
    final penultima = antes.split(RegExp(r'\s+')).last.toLowerCase();
    final inicial =
        antes.isEmpty ||
        '.:!?→¿¡'.contains(ultima) ||
        _verbosDeBoton.contains(penultima);

    trozos.add(
      TextSpan(
        text: _aMinusculas(m.group(0)!, inicial: inicial),
        style: enfasis,
      ),
    );
    pos = m.end;
  }
  if (pos < texto.length) trozos.add(TextSpan(text: texto.substring(pos)));
  return trozos;
}

/// Partes de un paso: título, frase principal, detalle y avisos.
class _PartesPaso {
  final String? titulo;
  final String principal;
  final List<String> detalle;
  final List<String> avisos;

  const _PartesPaso(this.titulo, this.principal, this.detalle, this.avisos);

  /// Los textos de las guías separan los párrafos con una línea en blanco.
  /// Una primera línea toda en mayúsculas es un título; un párrafo que empieza
  /// por una palabra en mayúsculas y dos puntos (ADVERTENCIA:) es un aviso.
  factory _PartesPaso.de(String texto) {
    final bloques = texto
        .trim()
        .split(RegExp(r'\n\s*\n'))
        .map((b) => b.trim())
        .where((b) => b.isNotEmpty);

    String? titulo;
    final normales = <String>[];
    final avisos = <String>[];
    for (final bloque in bloques) {
      var cuerpo = bloque;
      final primera = bloque.split('\n').first.trim();
      if (titulo == null && _esTitulo(primera)) {
        titulo = primera;
        final salto = bloque.indexOf('\n');
        cuerpo = salto < 0 ? '' : bloque.substring(salto + 1).trim();
        if (cuerpo.isEmpty) continue;
      }
      if (RegExp(r'^[A-ZÁÀÉÈÍÓÒÚÜÑÇ]{5,}:').hasMatch(cuerpo)) {
        avisos.add(cuerpo);
      } else {
        normales.add(cuerpo);
      }
    }

    if (normales.isEmpty) return _PartesPaso(titulo, '', const [], avisos);

    // La primera frase es la instrucción; el resto, el detalle.
    final primero = normales.first;
    final frase = RegExp(
      r'^(.+?[.!?])(\s+|$)',
      dotAll: true,
    ).firstMatch(primero);
    final principal = frase?.group(1)?.trim() ?? primero;
    final resto = frase == null ? '' : primero.substring(frase.end).trim();
    return _PartesPaso(titulo, principal, [
      if (resto.isNotEmpty) resto,
      ...normales.skip(1),
    ], avisos);
  }

  static bool _esTitulo(String linea) {
    if (linea.length < 5 || linea.length > 60 || linea.endsWith('.')) {
      return false;
    }
    return linea == linea.toUpperCase() &&
        linea != linea.toLowerCase() &&
        !RegExp(r'^[A-ZÁÀÉÈÍÓÒÚÜÑÇ]{5,}:').hasMatch(linea);
  }
}

/// Un paso de la guía: la burbuja con el icono y el nombre del paso arriba, la
/// instrucción en grande, el detalle en una tarjeta suave, los avisos
/// destacados y la imagen al final.
class _ContenidoPaso extends StatelessWidget {
  final String texto;
  final String? imagen;
  final Gesto gesto;
  final Color acento;

  const _ContenidoPaso({
    required this.texto,
    required this.imagen,
    required this.gesto,
    required this.acento,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final partes = _PartesPaso.de(texto);

    // Si el texto trae título, es el nombre del paso; si no, el del gesto.
    final nombre = partes.titulo != null
        ? _aMinusculas(partes.titulo!, inicial: true)
        : t(gesto.etiqueta);

    // La instrucción se hace más pequeña cuanto más larga es, para que no
    // ocupe media pantalla.
    final largo = partes.principal.length;
    final tamano = largo <= 60 ? 26.0 : (largo <= 110 ? 23.0 : 20.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: _EtiquetaGesto(gesto: gesto, texto: nombre, acento: acento),
        ),
        if (partes.principal.isNotEmpty) ...[
          const SizedBox(height: 22),
          Text.rich(
            TextSpan(children: _sinGritar(partes.principal)),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: tamano,
              height: 1.3,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w800,
              color: esquema.onSurface,
            ),
          ),
        ],
        if (partes.detalle.isNotEmpty) ...[
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            decoration: BoxDecoration(
              color: esquema.surfaceContainerLow,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < partes.detalle.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      children: _sinGritar(
                        partes.detalle[i],
                        enfasis: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16.5,
                      height: 1.5,
                      color: esquema.onSurface.withAlpha(220),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
        for (final aviso in partes.avisos) ...[
          const SizedBox(height: 14),
          _AvisoPaso(texto: aviso),
        ],
        if (imagen != null) ...[
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: fondoDispositivo,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: acento.withAlpha(30),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Image.asset(
              imagen!,
              height: 170,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const SizedBox(height: 60),
            ),
          ),
        ],
      ],
    );
  }
}

/// Aviso dentro de un paso (ADVERTENCIA: …), con el color de aviso de la app.
class _AvisoPaso extends StatelessWidget {
  final String texto;

  const _AvisoPaso({required this.texto});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final aviso = context.colores.aviso;
    final corte = texto.indexOf(':');
    final etiqueta = texto.substring(0, corte + 1);
    final resto = texto.substring(corte + 1).trim();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: aviso.withAlpha(24),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: aviso.withAlpha(100), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: aviso, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$etiqueta ',
                    style: TextStyle(fontWeight: FontWeight.w800, color: aviso),
                  ),
                  ..._sinGritar(
                    resto,
                    enfasis: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              style: TextStyle(
                fontSize: 16,
                height: 1.45,
                color: esquema.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
