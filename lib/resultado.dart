import 'package:flutter/material.dart';

import 'bombas.dart';
import 'buscador.dart';
import 'cambio_cateter.dart';
import 'cambio_sensor.dart';
import 'configuracion.dart';
import 'errores.dart';
import 'kit_viaje.dart';
import 'l10n/idioma.dart';
import 'soporte.dart';
import 'tema.dart';
import 'widgets/boton_sugerencia.dart';
import 'widgets/comunes.dart';
import 'widgets/selector_idioma.dart';
import 'zonas_insercion.dart';

class ResultadoScreen extends StatelessWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  const ResultadoScreen({
    super.key,
    required this.bomba,
    required this.sensor,
    required this.cateter,
  });

  bool get esOmnipod => bomba == 'bomnipod';

  /// Apartados que el buscador puede encontrar, además de las alarmas.
  /// Las palabras clave están en castellano y se buscan siempre, sea cual sea
  /// el idioma de la app.
  List<Apartado> _apartados() => [
    Apartado(
      titulo: esOmnipod ? t('Recambio de Pod') : t('Recambio de catéter'),
      subtitulo: t('Guía paso a paso.'),
      icono: Icons.opacity,
      palabras: [
        'cateter',
        'pod',
        'reservorio',
        'canula',
        'infusion',
        'cambiar',
        'recambio',
      ],
      construir: (_) => CambioCateterScreen(bomba: bomba, cateter: cateter),
    ),
    Apartado(
      titulo: t('Recambio de sensor'),
      subtitulo: t('Instrucciones del sensor de glucosa.'),
      icono: Icons.sensors,
      palabras: [
        'sensor',
        'mcg',
        'monitor',
        'glucosa',
        'dexcom',
        'libre',
        'guardian',
        'calentamiento',
      ],
      construir: (_) => CambioSensorScreen(bomba: bomba, sensor: sensor),
    ),
    Apartado(
      titulo: t('Resolver problemas'),
      subtitulo: t('Te hacemos unas preguntas y te ayudamos.'),
      icono: Icons.warning_amber_rounded,
      palabras: ['error', 'problema', 'fallo', 'diagnostico', 'ayuda'],
      construir: (_) =>
          ErroresScreen(bomba: bomba, sensor: sensor, cateter: cateter),
    ),
    Apartado(
      titulo: t('Kit de viaje'),
      subtitulo: t('Qué llevar y qué papeles necesitas.'),
      icono: Icons.luggage_outlined,
      palabras: [
        'viaje',
        'kit',
        'maleta',
        'aeropuerto',
        'avion',
        'vacaciones',
        'emergencia',
        'repuesto',
        'equipaje',
      ],
      construir: (_) => const KitViajeScreen(),
    ),
    Apartado(
      titulo: t('Soporte y manuales'),
      subtitulo: t('Webs oficiales y urgencias.'),
      icono: Icons.support_agent,
      palabras: [
        'soporte',
        'telefono',
        'contacto',
        'manual',
        'fabricante',
        'urgencia',
        'ayuda',
      ],
      construir: (_) => const SoporteScreen(),
    ),
    Apartado(
      titulo: t('Rotación de zonas'),
      subtitulo: t('Dónde ponértelo la próxima vez.'),
      icono: Icons.place_outlined,
      palabras: [
        'zona',
        'rotacion',
        'lipo',
        'lipohipertrofia',
        'donde',
        'pinchar',
        'abdomen',
        'brazo',
        'muslo',
      ],
      construir: (_) => const ZonasScreen(),
    ),
    Apartado(
      titulo: t('Configuración'),
      subtitulo: t('Idioma, recordatorios, tema y dispositivos.'),
      icono: Icons.settings_outlined,
      palabras: [
        'configuracion',
        'ajustes',
        'notificaciones',
        'recordatorio',
        'tema',
        'oscuro',
        'privacidad',
        'idioma',
        'language',
      ],
      construir: (_) => const ConfiguracionScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;

    return Scaffold(
      appBar: AppBar(
        title: Text(t('Panel de Control')),
        actions: [
          const BotonIdioma(),
          IconButton(
            tooltip: t('Configuración'),
            icon: const Icon(Icons.settings_outlined, size: 22),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ConfiguracionScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            const DistintivoModoSugerencias(),
            // El buscador va arriba del todo: es la vía rápida cuando ya te
            // está pitando algo y no quieres navegar por menús.
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BuscadorScreen(apartados: _apartados()),
                ),
              ),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: esquema.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: esquema.onSurfaceVariant),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t('Buscar alarma o apartado…'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: esquema.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _rotulo(context, t('TU CONFIGURACIÓN'))),
                InkWell(
                  onTap: () => confirmarCambioDeConfiguracion(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 13, color: esquema.primary),
                        const SizedBox(width: 5),
                        Text(
                          t('Cambiar'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: esquema.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ResumenConfiguracion(
              bomba: bomba,
              sensor: sensor,
              cateter: cateter,
            ),

            const SizedBox(height: 25),
            Text(
              t('¿Qué necesitas hacer?'),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: esquema.onSurface,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 15),

            TarjetaMenu(
              titulo: esOmnipod
                  ? t('Recambio de Pod')
                  : t('Recambio de catéter'),
              subtitulo: esOmnipod
                  ? t('Instrucciones para poner un Pod nuevo.')
                  : t('Guía paso a paso.'),
              icono: Icons.opacity,
              color: esquema.primary,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CambioCateterScreen(bomba: bomba, cateter: cateter),
                ),
              ),
            ),
            TarjetaMenu(
              titulo: t('Recambio de sensor'),
              subtitulo: t('Instrucciones del sensor de glucosa.'),
              icono: Icons.sensors,
              color: colores.exito,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CambioSensorScreen(bomba: bomba, sensor: sensor),
                ),
              ),
            ),
            TarjetaMenu(
              titulo: t('Resolver problemas'),
              subtitulo: t('Te hacemos unas preguntas y te ayudamos.'),
              icono: Icons.warning_amber_rounded,
              color: colores.aviso,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ErroresScreen(
                    bomba: bomba,
                    sensor: sensor,
                    cateter: cateter,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
            _rotulo(context, t('MÁS')),
            const SizedBox(height: 12),

            TarjetaMenu(
              titulo: t('Kit de viaje'),
              subtitulo: t('Qué llevar y qué papeles necesitas.'),
              icono: Icons.luggage_outlined,
              color: esquema.primary,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const KitViajeScreen()),
              ),
            ),
            TarjetaMenu(
              titulo: t('Rotación de zonas'),
              subtitulo: t('Dónde ponértelo la próxima vez.'),
              icono: Icons.place_outlined,
              color: colores.exito,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ZonasScreen()),
              ),
            ),
            TarjetaMenu(
              titulo: t('Soporte y manuales'),
              subtitulo: t('Webs oficiales y urgencias.'),
              icono: Icons.support_agent,
              color: colores.aviso,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SoporteScreen()),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _rotulo(BuildContext context, String texto) => Text(
    texto,
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: context.esquema.primary,
      letterSpacing: 1.1,
    ),
  );
}
