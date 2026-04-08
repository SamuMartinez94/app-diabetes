import 'package:flutter/material.dart';

class CambioSensorScreen extends StatelessWidget {
  final String bomba;
  final String sensor;

  const CambioSensorScreen({
    super.key,
    required this.bomba,
    required this.sensor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // para que el texto sea visible
        elevation: 0, // sin sombra
        title: const Text('Cambio de Sensor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Configuración seleccionada:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (bomba.isNotEmpty)
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset(
                      'assets/images/$bomba.png',
                      fit: BoxFit.contain, // mantiene proporción
                    ),
                  ),
                const SizedBox(width: 10),
                if (sensor.isNotEmpty)
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset(
                      'assets/images/$sensor.png',
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              'Aquí irán las instrucciones para cambiar el sensor.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
