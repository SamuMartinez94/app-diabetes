import 'package:flutter/material.dart';

import 'datos/alarmas.dart';
import 'datos/guias_cateter.dart';
import 'datos/guias_sensor.dart';
import 'l10n/idioma.dart';
import 'modelos/alarma.dart';
import 'modelos/paso.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';
import 'widgets/boton_sugerencia.dart';
import 'widgets/comunes.dart';
import 'widgets/pantalla_guia.dart';

/// Un apartado de la app que el buscador puede encontrar.
/// Título y subtítulo llegan ya traducidos; las palabras clave, en castellano.
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

/// Un paso de guía encontrado por el buscador.
class PasoEncontrado {
  final String claveGuia;
  final String titulo;
  final int indice;
  final int total;
  final Paso paso;

  const PasoEncontrado({
    required this.claveGuia,
    required this.titulo,
    required this.indice,
    required this.total,
    required this.paso,
  });
}

/// Recorre solo las guías de los dispositivos del usuario: no tiene sentido
/// devolverle pasos de una bomba que no usa.
List<PasoEncontrado> buscarEnGuias(String consulta) {
  if (consulta.trim().isEmpty) return const [];

  final bomba = Preferencias.bomba;
  final sensor = Preferencias.sensor;
  final cateter = Preferencias.cateter;
  if (bomba == null) return const [];

  final fuentes = <String, ({String titulo, List<Paso> pasos})>{};

  final claveCateter = '${bomba}_$cateter';
  final guiaCateter = instruccionesCateter[claveCateter];
  if (guiaCateter != null) {
    fuentes[claveCateter] = (
      titulo: t('Recambio de catéter'),
      pasos: guiaCateter,
    );
  }

  final soloReservorio = instruccionesSoloReservorio[bomba];
  if (soloReservorio != null) {
    fuentes['${bomba}_solo_reservorio'] = (
      titulo: t('Solo reservorio'),
      pasos: soloReservorio,
    );
  }

  if (sensor != null) {
    final claveSensor = '${bomba}_$sensor';
    final guiaSensor = instruccionesSensor[claveSensor];
    if (guiaSensor != null) {
      fuentes[claveSensor] = (
        titulo: t('Recambio de sensor'),
        pasos: guiaSensor,
      );
    }
  }

  final q = normalizar(consulta);
  final resultados = <PasoEncontrado>[];
  fuentes.forEach((clave, fuente) {
    for (var i = 0; i < fuente.pasos.length; i++) {
      final paso = fuente.pasos[i];
      // Se busca en castellano y en el idioma activo.
      if (normalizar('${paso.texto} ${t(paso.texto)}').contains(q)) {
        resultados.add(
          PasoEncontrado(
            claveGuia: clave,
            titulo: fuente.titulo,
            indice: i,
            total: fuente.pasos.length,
            paso: paso,
          ),
        );
      }
    }
  });
  return resultados;
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

  List<PasoEncontrado> get _pasosFiltrados => buscarEnGuias(consulta);

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
    final pasos = _pasosFiltrados;
    final vacio = apartados.isEmpty && resultados.isEmpty && pasos.isEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(t('Buscar'))),
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
                  hintText: t('Alarma, síntoma o apartado…'),
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
                          _titulo(context, t('APARTADOS DE LA APP')),
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
                        if (pasos.isNotEmpty) ...[
                          _titulo(
                            context,
                            tf('PASOS DE TUS GUÍAS ({n})', {'n': pasos.length}),
                          ),
                          ...pasos.map(
                            (p) => _FilaPaso(resultado: p, consulta: consulta),
                          ),
                          const SizedBox(height: 10),
                        ],
                        if (resultados.isNotEmpty) ...[
                          _titulo(
                            context,
                            tf('ALARMAS Y AVISOS ({n})', {
                              'n': resultados.length,
                            }),
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
            tf('Nada coincide con "{consulta}".', {'consulta': consulta}),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: context.esquema.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t(
              'Prueba con el texto que muestra tu dispositivo, o con lo que '
              'te está pasando: "no pasa insulina", "pitido", "batería".',
            ),
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

/// Resultado de búsqueda dentro de una guía: muestra el fragmento y lleva
/// a la pantalla de la guía abierta por ese paso.
class _FilaPaso extends StatelessWidget {
  final PasoEncontrado resultado;
  final String consulta;

  const _FilaPaso({required this.resultado, required this.consulta});

  /// Recorta el texto alrededor de la coincidencia para no volcar el paso
  /// entero en la lista de resultados.
  String get _fragmento {
    final texto = t(resultado.paso.texto).replaceAll('\n', ' ');
    final pos = normalizar(texto).indexOf(normalizar(consulta));
    if (pos < 0) {
      return texto.length > 90 ? '${texto.substring(0, 90)}…' : texto;
    }
    final ini = (pos - 35).clamp(0, texto.length);
    final fin = (pos + consulta.length + 55).clamp(0, texto.length);
    return '${ini > 0 ? "…" : ""}${texto.substring(ini, fin).trim()}'
        '${fin < texto.length ? "…" : ""}';
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PantallaGuia(
              titulo: resultado.titulo,
              clave: resultado.claveGuia,
              pasos: _pasosDe(resultado.claveGuia) ?? const [],
              porRevisar: true,
              pasoInicial: resultado.indice,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: esquema.outlineVariant),
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
                child: Icon(
                  Icons.menu_book_outlined,
                  color: esquema.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tf('{titulo} · paso {i} de {total}', {
                        'titulo': resultado.titulo,
                        'i': resultado.indice + 1,
                        'total': resultado.total,
                      }),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: esquema.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _fragmento,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: esquema.onSurface,
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

/// Recupera la lista de pasos a partir de la clave, sea de catéter o sensor.
List<Paso>? _pasosDe(String clave) =>
    instruccionesCateter[clave] ??
    instruccionesSensor[clave] ??
    instruccionesSoloReservorio[clave.replaceAll('_solo_reservorio', '')];

Color _colorGravedad(BuildContext context, Gravedad gravedad) {
  return switch (gravedad) {
    Gravedad.informativa => context.esquema.primary,
    Gravedad.atencion => context.colores.aviso,
    Gravedad.urgente => context.colores.urgente,
  };
}

class _FilaAlarma extends StatelessWidget {
  final Alarma alarma;

  const _FilaAlarma({required this.alarma});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colorGravedad = _colorGravedad(context, alarma.gravedad);

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
                      t(alarma.titulo),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: esquema.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t(alarma.gravedad.etiqueta),
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
    final porRevisar = alarmasPorRevisar.contains(alarma.id);
    final colorGravedad = _colorGravedad(context, alarma.gravedad);

    return Scaffold(
      appBar: AppBar(title: Text(t('Alarma'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            if (porRevisar) ...[
              const BannerRevision(),
              const SizedBox(height: 20),
            ],
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
                    t(alarma.gravedad.etiqueta).toUpperCase(),
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
              t(alarma.titulo),
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: esquema.onSurface,
              ),
            ),
            if (alarma.codigo != null) ...[
              const SizedBox(height: 6),
              Text(
                tf('Código {codigo}', {'codigo': alarma.codigo!}),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: esquema.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text(
              t('QUÉ SIGNIFICA'),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                color: esquema.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t(alarma.significado),
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: esquema.onSurface,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              t('QUÉ HACER'),
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
                        t(e.value),
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.45,
                          color: esquema.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(child: BotonSugerencia(ubicacion: 'Alarma ${alarma.id}')),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
