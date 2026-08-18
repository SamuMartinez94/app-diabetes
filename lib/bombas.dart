import 'package:flutter/material.dart';

import 'resultado.dart';
import 'servicios/notificaciones.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';
import 'widgets/comunes.dart';

/// El Omnipod integra el catéter en el propio Pod, así que no es una pieza
/// que el usuario elija: se asigna sola al saltarse el paso 3.
const String kCateterPod = 'cpod';

/// Pregunta antes de reiniciar el asistente y, si se confirma, lo abre.
///
/// Lo usan tanto el panel de control como la pantalla de configuración, para
/// que el aviso sea el mismo desde los dos sitios.
Future<void> confirmarCambioDeConfiguracion(BuildContext context) async {
  final confirmado = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Text('¿Elegir otra configuración?'),
      content: const Text(
        'Volverás a seleccionar tu bomba, tu sensor y tu catéter.\n\n'
        'Tus recordatorios y el historial de zonas de inserción se mantienen.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Cambiar'),
        ),
      ],
    ),
  );

  if (confirmado != true || !context.mounted) return;

  await Preferencias.borrarConfiguracion();
  if (!context.mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const BombasScreen()),
    (route) => false,
  );
}

class BombasScreen extends StatefulWidget {
  const BombasScreen({super.key});

  @override
  State<BombasScreen> createState() => _BombasScreenState();
}

class _BombasScreenState extends State<BombasScreen> {
  String? bombaSeleccionada;
  String? sensorSeleccionado;
  String? cateterSeleccionado;
  int paso = 1;

  final List<String> bombas = [
    'bypsopump',
    'bmedtronic',
    'bomnipod',
    'btandem',
  ];

  // --- LÓGICA DE FILTRADO ---

  List<String> get sensoresFiltrados {
    switch (bombaSeleccionada) {
      case 'bmedtronic':
        return ['sguardian', 'ssimplera'];
      case 'btandem':
        return ['sdexg6', 'sdexg7'];
      case 'bomnipod':
        return ['sdexg6', 'sdexg7'];
      case 'bypsopump':
        return ['sdexg6', 'sfreelibre3'];
      default:
        return const [];
    }
  }

  List<String> get cateteresFiltrados {
    switch (bombaSeleccionada) {
      case 'bmedtronic':
        return [
          'cextended',
          'cmio',
          'cmio30',
          'cquickset',
          'csilhouette',
          'csuret',
        ];
      case 'btandem':
        return ['cautosoft90', 'cautosoft30', 'ctrusteel'];
      case 'bypsopump':
        return ['corbit', 'cinset'];
      default:
        return const [];
    }
  }

  // --- NAVEGACIÓN HACIA EL RESULTADO ---

  Future<void> _irAResultado(String ultimoCateter) async {
    setState(() => cateterSeleccionado = ultimoCateter);

    await Preferencias.guardarConfiguracion(
      bomba: bombaSeleccionada!,
      sensor: sensorSeleccionado!,
      cateter: ultimoCateter,
    );
    // Los intervalos por defecto pueden haber cambiado con la nueva bomba.
    await Notificaciones.reprogramar();

    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;

      // Se sustituye toda la pila: desde el panel de control, "atrás" debe
      // salir de la app, no volver a repetir el asistente.
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ResultadoScreen(
                bomba: bombaSeleccionada!,
                sensor: sensorSeleccionado!,
                cateter: cateterSeleccionado!,
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(0, 0.03),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeOut)),
                ),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 450),
        ),
        (route) => false,
      );
    });
  }

  void _retroceder() {
    setState(() {
      if (paso == 3) {
        paso = 2;
        cateterSeleccionado = null;
        sensorSeleccionado = null;
      } else if (paso == 2) {
        paso = 1;
        bombaSeleccionada = null;
        sensorSeleccionado = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: esquema.onSurface,
        ),
        leading: paso > 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: _retroceder,
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: LinearProgressIndicator(
                value: paso / 3,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (bombaSeleccionada != null)
                    _buildMiniThumb(bombaSeleccionada!),
                  if (sensorSeleccionado != null)
                    _buildMiniThumb(sensorSeleccionado!),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (paso == 1)
                      buildSelector(
                        titulo: '¿Qué bomba usas?',
                        opciones: bombas,
                        seleccionado: bombaSeleccionada,
                        onSelect: (val) => setState(() {
                          bombaSeleccionada = val;
                          paso = 2;
                        }),
                      ),
                    if (paso == 2)
                      buildSelector(
                        titulo: 'Selecciona tu sensor',
                        opciones: sensoresFiltrados,
                        seleccionado: sensorSeleccionado,
                        onSelect: (val) {
                          setState(() => sensorSeleccionado = val);
                          if (bombaSeleccionada == 'bomnipod') {
                            _irAResultado(kCateterPod);
                          } else {
                            setState(() => paso = 3);
                          }
                        },
                      ),
                    if (paso == 3)
                      buildSelector(
                        titulo: 'Elige tu catéter',
                        opciones: cateteresFiltrados,
                        seleccionado: cateterSeleccionado,
                        onSelect: _irAResultado,
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

  // --- WIDGETS AUXILIARES ---

  Widget buildSelector({
    required String titulo,
    required List<String> opciones,
    required String? seleccionado,
    required void Function(String) onSelect,
  }) {
    final esquema = context.esquema;

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: esquema.onSurface,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 15,
          runSpacing: 15,
          children: opciones.map((id) {
            final isSelected = id == seleccionado;
            return GestureDetector(
              onTap: () => onSelect(id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 140,
                height: 140,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? esquema.primary.withAlpha(20)
                      : esquema.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? esquema.primary : Colors.transparent,
                    width: 2.5,
                  ),
                ),
                child: ImagenDispositivo(id: id),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMiniThumb(String id) {
    final esquema = context.esquema;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: esquema.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: esquema.outlineVariant),
      ),
      child: ImagenDispositivo(id: id, ancho: 35, alto: 35),
    );
  }
}
