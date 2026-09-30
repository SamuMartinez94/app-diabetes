import 'package:flutter/material.dart';

import '../datos/dispositivos.dart';
import '../l10n/idioma.dart';
import '../tema.dart';

/// Fondo blanco fijo de los recuadros de dispositivos, en modo claro y oscuro.
const Color fondoDispositivo = Colors.white;

/// Imagen de un dispositivo por su identificador.
class ImagenDispositivo extends StatelessWidget {
  final String id;
  final double? ancho;
  final double? alto;

  const ImagenDispositivo({super.key, required this.id, this.ancho, this.alto});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$id.png',
      width: ancho,
      height: alto,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stack) => Icon(
        Icons.medical_services_outlined,
        size: (ancho ?? alto ?? 40) * 0.6,
        color: context.esquema.onSurfaceVariant,
      ),
    );
  }
}

/// Aviso de contenido pendiente de revisión.
class BannerRevision extends StatelessWidget {
  final String? mensaje;

  const BannerRevision({super.key, this.mensaje});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colores.porRevisarFondo,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colores.porRevisar.withAlpha(60)),
      ),
      child: Row(
        children: [
          Icon(Icons.edit_note, size: 18, color: colores.porRevisar),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              mensaje ??
                  t(
                    'Contenido en revisión. Contrasta estos pasos con el '
                    'manual oficial y con tu equipo médico.',
                  ),
              style: TextStyle(
                fontSize: 12,
                height: 1.3,
                fontWeight: FontWeight.w600,
                color: colores.porRevisar,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta de navegación con emoji (o icono), título y subtítulo.
class TarjetaMenu extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData? icono;
  final String? emoji;
  final Color color;
  final VoidCallback alPulsar;

  const TarjetaMenu({
    super.key,
    required this.titulo,
    required this.subtitulo,
    this.icono,
    this.emoji,
    required this.color,
    required this.alPulsar,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: color.withAlpha(24),
        borderRadius: BorderRadius.circular(26),
        child: InkWell(
          onTap: alPulsar,
          borderRadius: BorderRadius.circular(26),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withAlpha(40),
                    shape: BoxShape.circle,
                  ),
                  child: emoji != null
                      ? Text(emoji!, style: const TextStyle(fontSize: 26))
                      : Icon(icono, color: color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: esquema.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitulo,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: esquema.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bloque grande y colorido de la pantalla de inicio.
/// Con [destacado] va relleno de color; si no, teñido suavemente.
class BloqueAccion extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String? emoji;

  /// Icono en lugar del emoji: toma el color del texto y se integra en el bloque.
  final IconData? icono;
  final Color color;
  final bool destacado;
  final double alto;
  final VoidCallback alPulsar;

  const BloqueAccion({
    super.key,
    required this.titulo,
    required this.subtitulo,
    this.emoji,
    this.icono,
    required this.color,
    required this.alPulsar,
    this.destacado = false,
    this.alto = 170,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final fondo = destacado ? color : color.withAlpha(32);
    final texto = destacado ? esquema.onPrimary : esquema.onSurface;
    final secundario = destacado
        ? esquema.onPrimary.withAlpha(220)
        : esquema.onSurfaceVariant;
    final adorno = destacado ? Colors.white.withAlpha(30) : color.withAlpha(30);

    return Material(
      color: fondo,
      borderRadius: BorderRadius.circular(32),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: alPulsar,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: -30,
              bottom: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: adorno,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 14,
              child: icono != null
                  ? Icon(icono, size: 42, color: texto)
                  : Text(emoji!, style: const TextStyle(fontSize: 38)),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: alto),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                        color: texto,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.25,
                        color: secundario,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fila de iconos con la bomba, el sensor y el catéter del usuario.
class ResumenConfiguracion extends StatelessWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  /// Cabecera opcional dentro de la tarjeta (título y botón de cambiar).
  final Widget? encabezado;

  /// Si se indica, tocar un dispositivo llama a esta función.
  final VoidCallback? alPulsar;

  const ResumenConfiguracion({
    super.key,
    required this.bomba,
    required this.sensor,
    required this.cateter,
    this.encabezado,
    this.alPulsar,
  });

  @override
  Widget build(BuildContext context) {
    final esOmnipod = bomba == 'bomnipod';

    final esquema = context.esquema;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 16),
      decoration: BoxDecoration(
        color: esquema.primary.withAlpha(12),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: esquema.primary.withAlpha(90), width: 1.5),
      ),
      child: Column(
        children: [
          if (encabezado != null) ...[encabezado!, const SizedBox(height: 10)],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (bomba.isNotEmpty) _item(context, bomba, t('Bomba')),
              if (sensor.isNotEmpty) _item(context, sensor, t('Sensor')),
              if (cateter.isNotEmpty && !esOmnipod)
                _item(context, cateter, t('Catéter'), conNombre: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String id,
    String etiqueta, {
    bool conNombre = true,
  }) {
    return Expanded(
      child: InkWell(
        onTap: alPulsar,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              width: 65,
              height: 65,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: fondoDispositivo,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ImagenDispositivo(id: id),
            ),
            const SizedBox(height: 6),
            Text(
              etiqueta,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: context.esquema.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (conNombre) ...[
              const SizedBox(height: 2),
              Text(
                nombreDispositivo(id),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.2,
                  color: context.esquema.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
