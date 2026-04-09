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
          'Instrucciones',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
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
