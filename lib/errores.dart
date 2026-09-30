import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'datos/alarmas.dart';
import 'l10n/idioma.dart';
import 'modelos/alarma.dart';
import 'tema.dart';
import 'widgets/comunes.dart';

/// Asistente de "Resolver problemas": una conversación guiada con respuestas
/// de botón. No usa IA ni red: enseña, para el aviso que elijas, lo que dice
/// el manual oficial de tu bomba o tu sensor.
class ErroresScreen extends StatefulWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  const ErroresScreen({
    super.key,
    required this.bomba,
    required this.sensor,
    required this.cateter,
  });

  @override
  State<ErroresScreen> createState() => _ErroresScreenState();
}

class _ErroresScreenState extends State<ErroresScreen> {
  final _scroll = ScrollController();

  /// Qué se ha elegido hasta ahora: el tipo de aviso y, dentro de él, el aviso.
  bool? _deSensor;
  Alarma? _alarma;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  /// Los avisos de un tipo que le pueden salir a esta persona, según su bomba
  /// y su sensor, con los más graves primero.
  List<Alarma> _avisos(bool deSensor) {
    final lista = alarmasPara(
      bomba: widget.bomba,
      sensor: widget.sensor,
    ).where((a) => a.deSensor == deSensor).toList();
    // sort no es estable: se desempata por la posición en el catálogo.
    final orden = {for (var i = 0; i < lista.length; i++) lista[i]: i};
    lista.sort((a, b) {
      final porGravedad = b.gravedad.index.compareTo(a.gravedad.index);
      return porGravedad != 0 ? porGravedad : orden[a]!.compareTo(orden[b]!);
    });
    return lista;
  }

  void _cambiar(VoidCallback cambio) {
    HapticFeedback.selectionClick();
    setState(cambio);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _atras() {
    if (_alarma != null) {
      _cambiar(() => _alarma = null);
    } else if (_deSensor != null) {
      _cambiar(() => _deSensor = null);
    } else {
      Navigator.pop(context);
    }
  }

  void _reiniciar() => _cambiar(() {
    _deSensor = null;
    _alarma = null;
  });

  Color _colorGravedad(BuildContext context, Gravedad g) => switch (g) {
    Gravedad.urgente => context.colores.urgente,
    Gravedad.atencion => context.colores.aviso,
    Gravedad.informativa => context.esquema.primary,
  };

  @override
  Widget build(BuildContext context) {
    final burbujas = <Widget>[
      _Burbuja.asistente(
        child: Text(
          t('¡Hola! Cuéntame qué problema tienes y te ayudo a resolverlo.'),
          style: _estiloAsistente(context, negrita: true),
        ),
      ),
    ];

    var opciones = <_Opcion>[];
    final deSensor = _deSensor;
    final alarma = _alarma;

    if (deSensor == null) {
      opciones = [
        if (_avisos(false).isNotEmpty)
          _Opcion(
            t('Problema con la bomba'),
            () => _cambiar(() => _deSensor = false),
          ),
        if (_avisos(true).isNotEmpty)
          _Opcion(
            t('Problema con el sensor'),
            () => _cambiar(() => _deSensor = true),
          ),
      ];
    } else {
      burbujas.add(
        _Burbuja.usuario(
          texto: deSensor
              ? t('Problema con el sensor')
              : t('Problema con la bomba'),
        ),
      );

      if (alarma == null) {
        burbujas.add(
          _Burbuja.asistente(
            child: Text(
              t('Elige el aviso que sale en la pantalla'),
              style: _estiloAsistente(context, negrita: true),
            ),
          ),
        );
        opciones = [
          for (final a in _avisos(deSensor))
            _Opcion(
              t(a.titulo),
              () => _cambiar(() => _alarma = a),
              color: _colorGravedad(context, a.gravedad),
            ),
        ];
      } else {
        burbujas
          ..add(_Burbuja.usuario(texto: t(alarma.titulo)))
          ..add(_RespuestaAlarma(alarma: alarma));
        opciones = [
          _Opcion(t('Ver otro aviso'), () => _cambiar(() => _alarma = null)),
          _Opcion(t('Entendido'), _reiniciar),
        ];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t('Resolver problemas')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: _atras,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: _scroll,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                itemCount: burbujas.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, i) => burbujas[i],
              ),
            ),
            _PanelRespuestas(
              opciones: opciones,
              destacarPrimera: alarma != null,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _estiloAsistente(BuildContext context, {bool negrita = false}) =>
      TextStyle(
        fontSize: negrita ? 17 : 15,
        height: 1.4,
        fontWeight: negrita ? FontWeight.w700 : FontWeight.w400,
        color: negrita
            ? context.esquema.onSurface
            : context.esquema.onSurfaceVariant,
      );
}

class _Opcion {
  final String texto;
  final VoidCallback alPulsar;

  /// Color suave del marco (por ejemplo, el de la gravedad de un aviso).
  final Color? color;

  const _Opcion(this.texto, this.alPulsar, {this.color});
}

class _Burbuja extends StatelessWidget {
  final bool delUsuario;
  final Widget child;

  const _Burbuja._({required this.delUsuario, required this.child});

  factory _Burbuja.asistente({required Widget child}) =>
      _Burbuja._(delUsuario: false, child: child);

  factory _Burbuja.usuario({required String texto}) => _Burbuja._(
    delUsuario: true,
    child: Builder(
      builder: (context) => Text(
        texto,
        style: TextStyle(
          fontSize: 15,
          height: 1.35,
          fontWeight: FontWeight.w600,
          color: context.esquema.onPrimary,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    const radio = Radius.circular(22);
    const esquina = Radius.circular(6);

    final burbuja = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: delUsuario ? esquema.primary : esquema.surfaceContainerLow,
        borderRadius: BorderRadius.only(
          topLeft: radio,
          topRight: radio,
          bottomLeft: delUsuario ? radio : esquina,
          bottomRight: delUsuario ? esquina : radio,
        ),
      ),
      child: child,
    );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      builder: (context, v, hijo) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 12 * (1 - v)),
          child: hijo,
        ),
      ),
      child: Row(
        mainAxisAlignment: delUsuario
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!delUsuario) ...[
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: esquema.primary.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_rounded,
                size: 20,
                color: esquema.primary,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(child: burbuja),
        ],
      ),
    );
  }
}

/// Respuesta del asistente: qué significa el aviso y qué hacer.
class _RespuestaAlarma extends StatelessWidget {
  final Alarma alarma;

  const _RespuestaAlarma({required this.alarma});

  Color _color(BuildContext context) => switch (alarma.gravedad) {
    Gravedad.urgente => context.colores.urgente,
    Gravedad.atencion => context.colores.aviso,
    Gravedad.informativa => context.esquema.primary,
  };

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final color = _color(context);
    final etiqueta = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
      color: color,
    );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
      builder: (context, v, hijo) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 14 * (1 - v)),
          child: hijo,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withAlpha(28),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (alarma.porRevisar) ...[
              const BannerRevision(),
              const SizedBox(height: 14),
            ],
            Text(t('QUÉ SIGNIFICA'), style: etiqueta),
            const SizedBox(height: 6),
            Text(
              t(alarma.significado),
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: esquema.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(t('QUÉ HACER'), style: etiqueta),
            const SizedBox(height: 8),
            for (var i = 0; i < alarma.queHacer.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.withAlpha(40),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        t(alarma.queHacer[i]),
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,
                          color: esquema.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (alarma.manual != null) ...[
              const SizedBox(height: 4),
              Text(
                tf('Fuente: manual oficial de {manual}, p. {pagina}', {
                  'manual': alarma.manual!,
                  'pagina': alarma.pagina ?? '',
                }),
                style: TextStyle(fontSize: 12, color: esquema.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PanelRespuestas extends StatelessWidget {
  final List<_Opcion> opciones;
  final bool destacarPrimera;

  const _PanelRespuestas({
    required this.opciones,
    required this.destacarPrimera,
  });

  @override
  Widget build(BuildContext context) {
    if (opciones.isEmpty) return const SizedBox.shrink();
    final esquema = context.esquema;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.5,
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: esquema.surface,
        border: Border(top: BorderSide(color: esquema.outlineVariant)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < opciones.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: (destacarPrimera && i == 0)
                    ? FilledButton(
                        onPressed: opciones[i].alPulsar,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                        child: _texto(opciones[i].texto),
                      )
                    : OutlinedButton(
                        onPressed: opciones[i].alPulsar,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          foregroundColor: opciones[i].color == null
                              ? esquema.primary
                              : esquema.onSurface,
                          backgroundColor: opciones[i].color?.withAlpha(16),
                          side: BorderSide(
                            color:
                                opciones[i].color?.withAlpha(120) ??
                                esquema.primary,
                            width: 1.5,
                          ),
                        ),
                        child: _texto(opciones[i].texto),
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _texto(String texto) => Text(
    texto,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  );
}
