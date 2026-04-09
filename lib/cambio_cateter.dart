import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

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
  final String imagen;

  Paso({required this.texto, required this.imagen});
}

class _CambioCateterScreenState extends State<CambioCateterScreen> {
  int pasoActual = 0;

  // Mapa con pasos
  static final Map<String, List<Paso>> instruccionesMap = {
    'bomba1_cateter1': [
      Paso(texto: 'Lávate las manos', imagen: 'assets/images/paso1.png'),
      Paso(texto: 'Prepara el material', imagen: 'assets/images/paso2.png'),
      Paso(texto: 'Inserta el catéter', imagen: 'assets/images/paso3.png'),
    ],
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
      //Vibración
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 50);
      }

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Cambio de Catéter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Paso ${pasoActual + 1} de ${pasos.length}',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            //ANIMACIÓN
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.3, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Column(
                key: ValueKey(pasoActual),
                children: [
                  //Imagen
                  Image.asset(paso.imagen, height: 200),

                  const SizedBox(height: 30),

                  //Texto
                  Text(
                    paso.texto,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (pasoActual > 0)
                  ElevatedButton(
                    onPressed: pasoAnterior,
                    child: const Text('Atrás'),
                  ),

                ElevatedButton(
                  onPressed: pasoActual < pasos.length - 1
                      ? siguientePaso
                      : null,
                  child: Text(
                    pasoActual < pasos.length - 1 ? 'Continuar' : 'Finalizado',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
