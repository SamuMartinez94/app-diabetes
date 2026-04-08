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

  Widget buildSelector({
    required String titulo,
    required int cantidad,
    required String tipo,
    required Function(String) onSelect,
  }) {
    return Column(
      children: [
        Text(titulo, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(cantidad, (index) {
            String id = '$tipo${index + 1}';

            return GestureDetector(
              onTap: () => onSelect(id),
              child: Container(
                width: 130,
                height: 130,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/$tipo${index + 1}.png',
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildSeleccion(String? valor, String tipo) {
    if (valor == null) return const SizedBox();

    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('Tu selección', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Image.asset('assets/images/$valor.png', width: 100),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // para que el texto sea visible
        elevation: 0, // sin sombra
        title: const Text('Selección'),
        leading: paso > 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
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
      body: Column(
        children: [
          const SizedBox(height: 20),

          // SELECCIONADOS
          const Text(
            'Seleccionados:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (bombaSeleccionada != null)
                Image.asset('assets/images/$bombaSeleccionada.png', width: 60),
              if (sensorSeleccionado != null)
                Image.asset('assets/images/$sensorSeleccionado.png', width: 60),
              if (cateterSeleccionado != null)
                Image.asset(
                  'assets/images/$cateterSeleccionado.png',
                  width: 60,
                ),
            ],
          ),

          const SizedBox(height: 20),

          // CONTENIDO
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Column(
                  key: ValueKey(paso),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (paso == 1)
                      buildSelector(
                        titulo: 'Selecciona tu bomba',
                        cantidad: 4,
                        tipo: 'bomba',
                        onSelect: (value) {
                          setState(() {
                            bombaSeleccionada = value;
                            paso = 2;
                          });
                        },
                      ),

                    if (paso == 2)
                      buildSelector(
                        titulo: 'Selecciona tu sensor',
                        cantidad: 6,
                        tipo: 'sensor',
                        onSelect: (value) {
                          setState(() {
                            sensorSeleccionado = value;
                            paso = 3;
                          });
                        },
                      ),

                    if (paso == 3)
                      cateterSeleccionado == null
                          ? buildSelector(
                              titulo: 'Selecciona tu catéter',
                              cantidad: 6,
                              tipo: 'cateter',
                              onSelect: (value) {
                                setState(() {
                                  cateterSeleccionado = value;
                                });
                              },
                            )
                          // BOTÓN
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
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
                                  child: const Text(
                                    'Siguiente',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
