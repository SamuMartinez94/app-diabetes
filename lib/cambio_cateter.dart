import 'package:flutter/material.dart';

class CambioCateterScreen extends StatefulWidget {
  final String bomba;
  final String cateter;

  const CambioCateterScreen({
    super.key,
    required this.bomba,
    required this.cateter,
  });

  @override
  State<CambioCateterScreen> createState() => _CambioCateterScreenState();
}

class Paso {
  final String texto;
  final String? imagen;
  Paso({required this.texto, this.imagen});
}

class _CambioCateterScreenState extends State<CambioCateterScreen> {
  int pasoActual = 0;

  //Mapa con pasos
  static final Map<String, List<Paso>> instruccionesMap = {
    // BCA Maps
    'bcamaps_cextended': [
      Paso(texto: 'Lávate las manos'),
      Paso(texto: 'Prepara el material', imagen: 'assets/images/paso1.png'),
      Paso(texto: 'Inserta el catéter'),
    ],
    /*
    'bcamaps_cmio': [
      Paso(texto: 'Paso 1 BCA Maps + MIO', imagen: 'assets/images/paso1.png'),
    ],
    'bcamaps_cmio30': [
      Paso(texto: 'Paso 1 BCA Maps + MIO30', imagen: 'assets/images/paso1.png'),
    ],
    'bcamaps_cquickset': [
      Paso(
        texto: 'Paso 1 BCA Maps + Quickset',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bcamaps_csilhouette': [
      Paso(
        texto: 'Paso 1 BCA Maps + Silhouette',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bcamaps_csuret': [
      Paso(texto: 'Paso 1 BCA Maps + SureT', imagen: 'assets/images/paso1.png'),
    ],

    // BMedtronic
    'bmedtronic_cextended': [
      Paso(
        texto: 'Paso 1 Medtronic + Extended',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bmedtronic_cmio': [
      Paso(texto: 'Paso 1 Medtronic + MIO', imagen: 'assets/images/paso1.png'),
    ],
    'bmedtronic_cmio30': [
      Paso(
        texto: 'Paso 1 Medtronic + MIO30',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bmedtronic_cquickset': [
      Paso(
        texto: 'Paso 1 Medtronic + Quickset',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bmedtronic_csilhouette': [
      Paso(
        texto: 'Paso 1 Medtronic + Silhouette',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bmedtronic_csuret': [
      Paso(
        texto: 'Paso 1 Medtronic + SureT',
        imagen: 'assets/images/paso1.png',
      ),
    ],

    // BoMnipod
    'bomnipod_cextended': [
      Paso(
        texto: 'Paso 1 Omnipod + Extended',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bomnipod_cmio': [
      Paso(texto: 'Paso 1 Omnipod + MIO', imagen: 'assets/images/paso1.png'),
    ],
    'bomnipod_cmio30': [
      Paso(texto: 'Paso 1 Omnipod + MIO30', imagen: 'assets/images/paso1.png'),
    ],
    'bomnipod_cquickset': [
      Paso(
        texto: 'Paso 1 Omnipod + Quickset',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bomnipod_csilhouette': [
      Paso(
        texto: 'Paso 1 Omnipod + Silhouette',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'bomnipod_csuret': [
      Paso(texto: 'Paso 1 Omnipod + SureT', imagen: 'assets/images/paso1.png'),
    ],

    // BTandem
    'btandem_cextended': [
      Paso(
        texto: 'Paso 1 Tandem + Extended',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'btandem_cmio': [
      Paso(texto: 'Paso 1 Tandem + MIO', imagen: 'assets/images/paso1.png'),
    ],
    'btandem_cmio30': [
      Paso(texto: 'Paso 1 Tandem + MIO30', imagen: 'assets/images/paso1.png'),
    ],
    'btandem_cquickset': [
      Paso(
        texto: 'Paso 1 Tandem + Quickset',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'btandem_csilhouette': [
      Paso(
        texto: 'Paso 1 Tandem + Silhouette',
        imagen: 'assets/images/paso1.png',
      ),
    ],
    'btandem_csuret': [
      Paso(texto: 'Paso 1 Tandem + SureT', imagen: 'assets/images/paso1.png'),
    ],*/
  };

  List<Paso> getPasos() {
    final key = '${widget.bomba}_${widget.cateter}';
    return instruccionesMap[key] ??
        [
          Paso(
            texto: 'No hay instrucciones disponibles.',
            imagen: 'assets/images/error.png',
          ),
        ];
  }

  void siguientePaso() async {
    if (pasoActual < getPasos().length - 1) {
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
          'Instrucciones',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
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
                  child: SingleChildScrollView(
                    key: ValueKey(pasoActual),
                    child: Column(
                      // Cambiamos a start para controlar el espaciado manualmente
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Espacio inicial para que no pegue al indicador de arriba
                        const SizedBox(height: 20),

                        if (tieneImagen) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              paso.imagen!,
                              height: 220, // Un poco más pequeña para dar aire
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ] else ...[
                          // Si no hay imagen, añadimos un espacio extra arriba
                          // para que el texto grande baje un poco pero siga alto
                          const SizedBox(height: 60),
                        ],

                        Text(
                          paso.texto,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: tieneImagen
                                ? 22
                                : 34, // Texto sin imagen aún más grande
                            height: 1.2,
                            fontWeight: tieneImagen
                                ? FontWeight.w400
                                : FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: -0.8,
                          ),
                        ),

                        // Este es el "punto medio" que buscamos entre texto y botones
                        const SizedBox(height: 50),

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
                        const SizedBox(
                          height: 40,
                        ), // Espacio final para evitar cortes
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
