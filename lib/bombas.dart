import 'package:flutter/material.dart';
import 'resultado.dart';

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
  final List<String> sensores = [
    'sdexg6',
    'sdexg7',
    'sfreelibre2',
    'sfreelibre3',
    'sguardian',
    'ssimplera',
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
        return sensores;
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
      case 'bomnipod':
        return ['cpod'];
      case 'bypsopump':
        return ['corbit', 'cinset'];
      default:
        return [];
    }
  }

  // --- NAVEGACIÓN HACIA EL RESULTADO ---
  void _irAResultado(String ultimoCateter) {
    setState(() => cateterSeleccionado = ultimoCateter);

    // Pequeña pausa para que el usuario perciba su última selección
    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ResultadoScreen(
                bomba: bombaSeleccionada!,
                sensor: sensorSeleccionado!,
                cateter: cateterSeleccionado!,
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Combinación de Opacidad y Desplazamiento sutil hacia arriba
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
      );
    });
  }

  void _retroceder() {
    setState(() {
      if (paso == 3) {
        paso = 2;
        cateterSeleccionado = null;
      } else if (paso == 2) {
        paso = 1;
        bombaSeleccionada = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Configuración',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                backgroundColor: Colors.grey[100],
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            // Resumen selección
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          setState(() {
                            sensorSeleccionado = val;
                            if (bombaSeleccionada == 'bomnipod') {
                              _irAResultado(
                                'cpod',
                              ); // Salto directo si es Omnipod
                            } else {
                              paso = 3;
                            }
                          });
                        },
                      ),
                    if (paso == 3)
                      buildSelector(
                        titulo: 'Elige tu catéter',
                        opciones: cateteresFiltrados,
                        seleccionado: cateterSeleccionado,
                        onSelect: (val) => _irAResultado(val),
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
    required Function(String) onSelect,
  }) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
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
                      ? Colors.blue.withAlpha((0.05 * 255).toInt())
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? Colors.blueAccent : Colors.transparent,
                    width: 2.5,
                  ),
                ),
                child: Image.asset(
                  'assets/images/$id.png',
                  fit: BoxFit.contain,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMiniThumb(String id) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Image.asset(
        'assets/images/$id.png',
        width: 35,
        height: 35,
        fit: BoxFit.contain,
      ),
    );
  }
}
