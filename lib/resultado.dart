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
import 'zonas_insercion.dart';

/// Pantalla principal, con tres pestañas abajo: Inicio, Buscar y Más.
class ResultadoScreen extends StatefulWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  const ResultadoScreen({
    super.key,
    required this.bomba,
    required this.sensor,
    required this.cateter,
  });

  @override
  State<ResultadoScreen> createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> {
  int _pestana = 0;

  bool get esOmnipod => widget.bomba == 'bomnipod';

  /// Apartados que el buscador puede encontrar, además de las alarmas.
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
      construir: (_) =>
          CambioCateterScreen(bomba: widget.bomba, cateter: widget.cateter),
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
      construir: (_) =>
          CambioSensorScreen(bomba: widget.bomba, sensor: widget.sensor),
    ),
    Apartado(
      titulo: t('Resolver problemas'),
      subtitulo: t('Te hacemos unas preguntas y te ayudamos.'),
      icono: Icons.warning_amber_rounded,
      palabras: ['error', 'problema', 'fallo', 'diagnostico', 'ayuda'],
      construir: (_) => ErroresScreen(
        bomba: widget.bomba,
        sensor: widget.sensor,
        cateter: widget.cateter,
      ),
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
    return Scaffold(
      body: IndexedStack(
        index: _pestana,
        children: [
          _Inicio(
            bomba: widget.bomba,
            sensor: widget.sensor,
            cateter: widget.cateter,
          ),
          BuscadorScreen(apartados: _apartados(), esPestana: true),
          const _Mas(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _pestana,
        onDestinationSelected: (i) {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() => _pestana = i);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t('Inicio'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: t('Buscar'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.apps_outlined),
            selectedIcon: const Icon(Icons.apps),
            label: t('Más'),
          ),
        ],
      ),
    );
  }
}

/// Pestaña de inicio: tu configuración y lo que necesitas hacer.
class _Inicio extends StatelessWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  const _Inicio({
    required this.bomba,
    required this.sensor,
    required this.cateter,
  });

  bool get esOmnipod => bomba == 'bomnipod';

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DiaGuía'),
        actions: [
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
            const SizedBox(height: 6),
            Text(
              t('¿Qué necesitas hacer?'),
              style: TextStyle(
                fontSize: 30,
                height: 1.1,
                fontWeight: FontWeight.w800,
                color: esquema.onSurface,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 18),
            BloqueAccion(
              destacado: true,
              alto: 150,
              emoji: '🔄',
              color: esquema.primary,
              titulo: esOmnipod
                  ? t('Recambio de Pod')
                  : t('Recambio de catéter'),
              subtitulo: esOmnipod
                  ? t('Instrucciones para poner un Pod nuevo.')
                  : t('Guía paso a paso.'),
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CambioCateterScreen(bomba: bomba, cateter: cateter),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BloqueAccion(
                    emoji: '📡',
                    color: colores.exito,
                    titulo: t('Recambio de sensor'),
                    subtitulo: t('Instrucciones del sensor de glucosa.'),
                    alPulsar: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CambioSensorScreen(bomba: bomba, sensor: sensor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BloqueAccion(
                    emoji: '🛟',
                    color: colores.aviso,
                    titulo: t('Resolver problemas'),
                    subtitulo: t('Te hacemos unas preguntas y te ayudamos.'),
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
                ),
              ],
            ),
            const SizedBox(height: 28),
            ResumenConfiguracion(
              bomba: bomba,
              sensor: sensor,
              cateter: cateter,
              encabezado: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: _rotulo(context, t('TU CONFIGURACIÓN'))),
                  const SizedBox(width: 6),
                  Icon(Icons.edit, size: 12, color: esquema.primary),
                ],
              ),
              alPulsar: () => confirmarCambioDeConfiguracion(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _rotulo(BuildContext context, String texto) => Text(
    texto,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: context.esquema.primary,
      letterSpacing: 1.1,
    ),
  );
}

/// Pestaña "Más": lo que no se usa cada día.
class _Mas extends StatelessWidget {
  const _Mas();

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final colores = context.colores;

    return Scaffold(
      appBar: AppBar(title: Text(t('Más'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            TarjetaMenu(
              titulo: t('Kit de viaje'),
              subtitulo: t('Qué llevar y qué papeles necesitas.'),
              emoji: '🧳',
              color: esquema.primary,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const KitViajeScreen()),
              ),
            ),
            TarjetaMenu(
              titulo: t('Rotación de zonas'),
              subtitulo: t('Dónde ponértelo la próxima vez.'),
              emoji: '📍',
              color: colores.exito,
              alPulsar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ZonasScreen()),
              ),
            ),
            TarjetaMenu(
              titulo: t('Soporte y manuales'),
              subtitulo: t('Webs oficiales y urgencias.'),
              emoji: '📞',
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
}
