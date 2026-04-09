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

  //Retroceder
  void _retroceder() {
    setState(() {
      if (paso == 3) {
        if (cateterSeleccionado != null) {
          cateterSeleccionado = null;
        } else {
          paso = 2;
          sensorSeleccionado = null;
        }
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
            // Barra de progreso
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

            //Resumen seleccion
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
                  if (cateterSeleccionado != null)
                    _buildMiniThumb(cateterSeleccionado!),
                ],
              ),
            ),

            const SizedBox(height: 10),

            //Contenido
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SingleChildScrollView(
                  key: ValueKey('$paso-$cateterSeleccionado'),
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
                          opciones: sensores,
                          seleccionado: sensorSeleccionado,
                          onSelect: (val) => setState(() {
                            sensorSeleccionado = val;
                            paso = 3;
                          }),
                        ),
                      if (paso == 3) ...[
                        //Si no se selecciona catéter, muestra la lista
                        if (cateterSeleccionado == null)
                          buildSelector(
                            titulo: 'Elige tu catéter',
                            opciones: cateteres,
                            seleccionado: cateterSeleccionado,
                            onSelect: (val) =>
                                setState(() => cateterSeleccionado = val),
                          )
                        else ...[
                          // Si se seleccionó, muestra botones
                          const SizedBox(height: 40),
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 80,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '¡Configuración lista!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 60),

                          //Botón
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

                          const SizedBox(height: 15),

                          //Boton atrás (Gris)
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: _retroceder,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[600],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                              child: const Text(
                                'Atrás',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 25),
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
                      ? Colors.blue.withAlpha((0.1 * 255).round())
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.03 * 255).round()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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
