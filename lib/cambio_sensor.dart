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
    'bypsopump_sdexg6': [
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
    //------------------------ Sensor Simplera Sync
    'bmedtronic_simplerasync': [
      Paso(
        texto:
            'Lávate las manos y limpia la zona de inserción del brazo con alcohol.', //[cite: 113, 116]
      ),
      Paso(
        texto:
            'IMPORTANTE: El sensor Simplera Sync está indicado para insertarse ÚNICAMENTE en la parte posterior del brazo.',
      ),
      Paso(
        texto:
            'Utiliza el dispositivo de inserción para colocar el sensor en la zona preparada.', //[cite: 113]
      ),
      Paso(
        texto:
            'Retira el papel adhesivo y presiona suavemente para que se pegue bien a la piel.', //[cite: 113]
      ),
      Paso(
        texto:
            'En la bomba, ve a "Sensores emparejados" y asegúrate de que el nuevo sensor esté vinculado.', //[cite: 113]
      ),
      Paso(
        texto:
            'Espera a que finalice el periodo de calentamiento. La bomba te avisará cuando empiece a mostrar lecturas de glucosa.', //[cite: 113, 11]
      ),
    ],
    'btandem_sdexg6': [
      Paso(texto: 'En la bomba, ve a Opciones > Mi MCG > Detener Sensor.'),
      Paso(
        texto:
            'Despega el adhesivo del sensor viejo. Guarda el transmisor (la pieza gris reutilizable) y limpia los restos de sangre con alcohol.',
      ),
      Paso(
        texto:
            'Lávate las manos y limpia la nueva zona de inserción con alcohol.',
      ),
      Paso(
        texto:
            'Coloca el aplicador del nuevo sensor sobre la piel, retira la pestaña de seguridad y presiona el botón naranja.',
      ),
      Paso(
        texto:
            'Encaja el transmisor en el soporte del nuevo sensor hasta oír dos "clics".',
      ),
      Paso(
        texto:
            'Ve a Opciones > Mi MCG > Iniciar Sensor. Introduce el código de 4 dígitos que viene en el papel del adhesivo del sensor.',
      ),
      Paso(
        texto: 'Espera a que termine el periodo de calentamiento de 2 horas.',
      ),
    ],
  };

  List<Paso> getPasos() {
    final key = '${widget.bomba}_${widget.sensor}';
    return instruccionesMap[key] ??
        [
          Paso(
            texto: 'No hay instrucciones específicas para esta combinación.',
            imagen: 'assets/images/error.png',
          ),
        ];
  }

  void siguientePaso() {
    final pasos = getPasos();
    if (pasoActual < pasos.length - 1) {
      setState(() => pasoActual++);
    }
  }

  void pasoAnterior() {
    if (pasoActual > 0) {
      setState(() => pasoActual--);
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
        toolbarHeight: 50,
        title: const Text(
          'Cambio de Sensor',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              //Barra de progreso
              LinearProgressIndicator(
                value: (pasoActual + 1) / pasos.length,
                backgroundColor: Colors.grey[100],
                color: Colors.blueAccent,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 15),
              Text(
                'PASO ${pasoActual + 1} DE ${pasos.length}',
                style: const TextStyle(
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.blueAccent,
                ),
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: SingleChildScrollView(
                    key: ValueKey(pasoActual),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),

                        if (tieneImagen) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              paso.imagen!,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ] else ...[
                          const SizedBox(height: 40),
                        ],

                        //Texto instrucción
                        Text(
                          paso.texto,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: tieneImagen ? 20 : 26,
                            height: 1.25,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 25),

                        //Botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (pasoActual > 0) ...[
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: pasoAnterior,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    side: BorderSide(color: Colors.grey[300]!),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'Anterior',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            Expanded(
                              child: FilledButton(
                                onPressed: pasoActual < pasos.length - 1
                                    ? siguientePaso
                                    : () => Navigator.pop(context),
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.blueAccent[700],
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  pasoActual < pasos.length - 1
                                      ? 'Siguiente'
                                      : 'Finalizar',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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
