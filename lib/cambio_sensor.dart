import 'package:flutter/material.dart';

class CambioSensorScreen extends StatefulWidget {
  final String bomba;
  final String sensor;

  const CambioSensorScreen({
    super.key,
    required this.bomba,
    required this.sensor,
  });

  @override
  State<CambioSensorScreen> createState() => _CambioSensorScreenState();
}

class Paso {
  final String texto;
  final String? imagen;
  Paso({required this.texto, this.imagen});
}

class _CambioSensorScreenState extends State<CambioSensorScreen> {
  int pasoActual = 0;

  static final Map<String, List<Paso>> instruccionesMap = {
    'bcamaps_sdexg6': [
      Paso(texto: 'Lávate las manos y limpia la zona con alcohol'),
      Paso(
        texto: 'Prepara el aplicador del Dexcom G6',
        imagen: 'assets/images/sdexg6.png',
      ),
      Paso(texto: 'Inserta el sensor y coloca el transmisor'),
    ],
    'bmedtronic_sguardian': [
      Paso(texto: 'Inserta el sensor Guardian 4'),
      Paso(
        texto: 'Espera a que se inicie el periodo de calentamiento',
        imagen: 'assets/images/paso1.png',
      ),
    ],
  };

  List<Paso> getPasos() {
    final key = '${widget.bomba}_${widget.sensor}';
    return instruccionesMap[key] ??
        [
          Paso(
            texto:
                'No hay instrucciones específicas para esta combinación de sensor.',
            imagen: 'assets/images/error.png',
          ),
        ];
  }

  void siguientePaso() {
    final pasos = getPasos();
    if (pasoActual < pasos.length - 1) {
      setState(() {
        pasoActual++;
      });
    }
  }

  void pasoAnterior() {
    if (pasoActual > 0) {
      setState(() {
        pasoActual--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pasos = getPasos();
    final paso = pasos[pasoActual];
    final bool tieneImagen = paso.imagen != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cambio de Sensor',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Barra de progreso
              LinearProgressIndicator(
                value: (pasoActual + 1) / pasos.length,
                backgroundColor: Colors.grey[200],
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),
              Text(
                'PASO ${pasoActual + 1} DE ${pasos.length}',
                style: const TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.blueAccent,
                ),
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                  child: SingleChildScrollView(
                    key: ValueKey(pasoActual),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        //Imagen
                        if (tieneImagen) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              paso.imagen!,
                              height: 220,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ] else ...[
                          const SizedBox(height: 60),
                        ],

                        //Texto instruccion
                        Text(
                          paso.texto,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: tieneImagen ? 22 : 32,
                            height: 1.2,
                            fontWeight: tieneImagen
                                ? FontWeight.w400
                                : FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: -0.8,
                          ),
                        ),

                        // Espaciado
                        const SizedBox(height: 40),

                        // Botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (pasoActual > 0)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: pasoAnterior,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Anterior',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ),
                            if (pasoActual > 0) const SizedBox(width: 15),
                            Expanded(
                              child: FilledButton(
                                onPressed: pasoActual < pasos.length - 1
                                    ? siguientePaso
                                    : () => Navigator.pop(context),
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.blueAccent[700],
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  pasoActual < pasos.length - 1
                                      ? 'Siguiente'
                                      : 'Finalizar',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
}
