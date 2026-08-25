import 'package:flutter/material.dart';

import '../datos/dispositivos.dart';
import '../tema.dart';

/// Imagen de un dispositivo por su identificador.
///
/// Si el asset no existe muestra un icono neutro en vez del recuadro de error
/// de Flutter: algunas combinaciones (como el Pod) no tienen ilustración.
class ImagenDispositivo extends StatelessWidget {
  final String id;
  final double? ancho;
  final double? alto;

  const ImagenDispositivo({
    super.key,
    required this.id,
    this.ancho,
    this.alto,
  });

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

/// Aviso de contenido todavía no validado por un profesional sanitario.
class BannerRevision extends StatelessWidget {
  final String mensaje;

  const BannerRevision({
    super.key,
    this.mensaje =
        'Borrador sin revisar. Contrasta estos pasos con el manual oficial y '
        'con tu equipo médico.',
  });

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
              mensaje,
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

/// Tarjeta de navegación con icono, título y subtítulo.
class TarjetaMenu extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final Color color;
  final VoidCallback alPulsar;

  const TarjetaMenu({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.color,
    required this.alPulsar,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: alPulsar,
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
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icono, color: color, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: esquema.onSurface,
                      ),
                    ),
                    Text(
                      subtitulo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: esquema.onSurfaceVariant,
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

/// Fila de iconos con la bomba, el sensor y el catéter del usuario.
class ResumenConfiguracion extends StatelessWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  const ResumenConfiguracion({
    super.key,
    required this.bomba,
    required this.sensor,
    required this.cateter,
  });

  @override
  Widget build(BuildContext context) {
    // El Pod integra el catéter: no se muestra como pieza aparte.
    final esOmnipod = bomba == 'bomnipod';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: context.esquema.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bomba.isNotEmpty) _item(context, bomba, 'Bomba'),
          if (sensor.isNotEmpty) _item(context, sensor, 'Sensor'),
          // El catéter va sin nombre: los modelos son crípticos y ocupan
          // demasiado al lado de la bomba y el sensor.
          if (cateter.isNotEmpty && !esOmnipod)
            _item(context, cateter, 'Catéter', conNombre: false),
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
      child: Column(
      children: [
        Container(
          width: 65,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.esquema.surface,
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
    );
  }
}
