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

  final List<String> bombas = ['bcamaps', 'bmedtronic', 'bomnipod', 'btandem'];
  final List<String> sensores = [
    'sdexg6',
    'sdexg7',
    'sfreelibre2',
    'sfreelibre3',
    'sguardian',
    'ssimplera',
  ];
  final List<String> cateteres = [
    'cextended',
    'cmio',
    'cmio30',
    'cquickset',
    'csilhouette',
    'csuret',
  ];

  Widget buildSelector({
    required String titulo,
    required List<String> opciones,
    required String? seleccionado,
    required Function(String) onSelect,
  }) {
    return Column(
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
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
                      ? Colors.blue.withOpacity(0.05)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: paso > 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () {
                  setState(() {
                    if (paso == 3) {
                      paso = 2;
                      cateterSeleccionado = null;
                    } else if (paso == 2) {
                      paso = 1;
                      sensorSeleccionado = null;
                    }
                  });
                },
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              // Barra de progreso
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: paso / 3,
                backgroundColor: Colors.grey[200],
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 25),

              // Resumen selección
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (bombaSeleccionada != null)
                      _buildMiniThumb(bombaSeleccionada!),
                    if (sensorSeleccionado != null)
                      _buildMiniThumb(sensorSeleccionado!),
                    if (cateterSeleccionado != null)
                      _buildMiniThumb(cateterSeleccionado!),
                  ],
                ),
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    key: ValueKey(paso),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
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
                            opciones: sensores,
                            seleccionado: sensorSeleccionado,
                            onSelect: (val) => setState(() {
                              sensorSeleccionado = val;
                              paso = 3;
                            }),
                          ),
                        if (paso == 3) ...[
                          buildSelector(
                            titulo: 'Elige tu catéter',
                            opciones: cateteres,
                            seleccionado: cateterSeleccionado,
                            onSelect: (val) =>
                                setState(() => cateterSeleccionado = val),
                          ),
                          const SizedBox(height: 50),
                          if (cateterSeleccionado != null)
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultadoScreen(
                                        bomba: bombaSeleccionada!,
                                        sensor: sensorSeleccionado!,
                                        cateter: cateterSeleccionado!,
                                      ),
                                    ),
                                  );
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.blueAccent[700],
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  'Ver resultados',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniThumb(String id) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        'assets/images/$id.png',
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
    );
  }
}
