import 'package:flutter/material.dart';

import 'datos/alarmas.dart';
import 'modelos/alarma.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';
import 'widgets/boton_sugerencia.dart';
import 'widgets/comunes.dart';

/// Un apartado de la app que el buscador puede encontrar.
class Apartado {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final List<String> palabras;
  final Widget Function(BuildContext) construir;

  const Apartado({
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.palabras,
    required this.construir,
  });

  String get textoBuscable =>
      '$titulo $subtitulo ${palabras.join(' ')}'.toLowerCase();
}

/// Quita tildes y pasa a minúsculas, para que "oclusion" encuentre "oclusión".
String normalizar(String texto) {
  const con = 'áàäâéèëêíìïîóòöôúùüûñç';
  const sin = 'aaaaeeeeiiiioooouuuunc';
  var salida = texto.toLowerCase();
  for (var i = 0; i < con.length; i++) {
    salida = salida.replaceAll(con[i], sin[i]);
  }
  return salida;
}

class BuscadorScreen extends StatefulWidget {
  /// Apartados navegables de la app, inyectados desde el panel de control.
  final List<Apartado> apartados;

  const BuscadorScreen({super.key, required this.apartados});

  @override
  State<BuscadorScreen> createState() => _BuscadorScreenState();
}

class _BuscadorScreenState extends State<BuscadorScreen> {
  final _controlador = TextEditingController();
  String consulta = '';

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  /// Alarmas de la bomba del usuario y las comunes, filtradas por la consulta.
  List<Alarma> get _alarmasFiltradas {
    final miBomba = Preferencias.bomba ?? '';
    final propias = alarmas
        .where((a) => a.bomba.isEmpty || a.bomba == miBomba)
        .toList();

    if (consulta.isEmpty) return propias;

    final q = normalizar(consulta);
    return propias
        .where((a) => normalizar(a.textoBuscable).contains(q))
        .toList();
  }

  List<Apartado> get _apartadosFiltrados {
    if (consulta.isEmpty) return widget.apartados;
    final q = normalizar(consulta);
    return widget.apartados
        .where((a) => normalizar(a.textoBuscable).contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final apartados = _apartadosFiltrados;
    final resultados = _alarmasFiltradas;
    final vacio = apartados.isEmpty && resultados.isEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: TextField(
                controller: _controlador,
                autofocus: true,
                textInputAction: TextInputAction.search,
                onChanged: (v) => setState(() => consulta = v.trim()),
                decoration: InputDecoration(
                  hintText: 'Alarma, síntoma o apartado…',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: consulta.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _controlador.clear();
                            setState(() => consulta = '');
                          },
                        ),
                  filled: true,
                  fillColor: esquema.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: vacio
                  ? _sinResultados(context)
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (apartados.isNotEmpty) ...[
                          _titulo(context, 'APARTADOS DE LA APP'),
                          ...apartados.map(
                            (a) => TarjetaMenu(
                              titulo: a.titulo,
                              subtitulo: a.subtitulo,
                              icono: a.icono,
                              color: esquema.primary,
                              alPulsar: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: a.construir),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                        if (resultados.isNotEmpty) ...[
                          _titulo(
                            context,
                            'ALARMAS Y AVISOS (${resultados.length})',
                          ),
                          ...resultados.map((a) => _FilaAlarma(alarma: a)),
                        ],
                        const SizedBox(height: 30),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titulo(BuildContext context, String texto) => Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 10),
    child: Text(
      texto,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
        color: context.esquema.primary,
      ),
    ),
  );

  Widget _sinResultados(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: context.esquema.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Nada coincide con "$consulta".',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: context.esquema.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Prueba con el texto que muestra tu dispositivo, o con lo que te '
            'está pasando: "no pasa insulina", "pitido", "batería".',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: context.esquema.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  );
}

class _FilaAlarma extends StatelessWidget {
  final Alarma alarma;

  const _FilaAlarma({required this.alarma});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;
    final porRevisar = alarmasPorRevisar.contains(alarma.id);

    final colorGravedad = switch (alarma.gravedad) {
      Gravedad.informativa => esquema.primary,
      Gravedad.atencion => colores.aviso,
      Gravedad.urgente => colores.porRevisar,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AlarmaScreen(alarma: alarma)),
        ),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: esquema.outlineVariant),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorGravedad.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  alarma.gravedad.icono,
                  color: colorGravedad,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alarma.titulo,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: porRevisar
                            ? colores.porRevisar
                            : esquema.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      alarma.gravedad.etiqueta,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colorGravedad,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: esquema.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlarmaScreen extends StatelessWidget {
  final Alarma alarma;

  const AlarmaScreen({super.key, required this.alarma});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;
    final porRevisar = alarmasPorRevisar.contains(alarma.id);
    final colorTexto = porRevisar ? colores.porRevisar : esquema.onSurface;

    final colorGravedad = switch (alarma.gravedad) {
      Gravedad.informativa => esquema.primary,
      Gravedad.atencion => colores.aviso,
      Gravedad.urgente => colores.porRevisar,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Alarma')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            if (porRevisar) ...[const BannerRevision(), const SizedBox(height: 20)],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorGravedad.withAlpha(26),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(alarma.gravedad.icono, size: 15, color: colorGravedad),
                  const SizedBox(width: 6),
                  Text(
                    alarma.gravedad.etiqueta.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: colorGravedad,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              alarma.titulo,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: colorTexto,
              ),
            ),
            if (alarma.codigo != null) ...[
              const SizedBox(height: 6),
              Text(
                'Código ${alarma.codigo}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: esquema.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text(
              'QUÉ SIGNIFICA',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: esquema.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              alarma.significado,
              style: TextStyle(fontSize: 16, height: 1.5, color: colorTexto),
            ),
            const SizedBox(height: 25),
            Text(
              'QUÉ HACER',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: esquema.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...alarma.queHacer.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: esquema.primary.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${e.key + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: esquema.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        e.value,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.45,
                          color: colorTexto,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: BotonSugerencia(ubicacion: 'Alarma ${alarma.id}'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
