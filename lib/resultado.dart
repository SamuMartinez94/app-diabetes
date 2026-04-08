import 'package:flutter/material.dart';
import 'cambio_cateter.dart';
import 'cambio_sensor.dart';
import 'errores.dart';

class ResultadoScreen extends StatelessWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  const ResultadoScreen({
    super.key,
    required this.bomba,
    required this.sensor,
    required this.cateter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Resultado'),
      ),
      // SingleChildScrollView para hacer scroll en móviles pequeños
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const Text(
                'Tu configuración:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (bomba.isNotEmpty) _buildConfigImage(bomba),
                  const SizedBox(width: 10),
                  if (sensor.isNotEmpty) _buildConfigImage(sensor),
                  const SizedBox(width: 10),
                  if (cateter.isNotEmpty) _buildConfigImage(cateter),
                ],
              ),

              const SizedBox(height: 25), // Espacio antes del menú

              const Text(
                '¿Qué quieres hacer?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // Menú de opciones
              _menuItem(
                context,
                'assets/images/cambio_cateter.png',
                CambioCateterScreen(bomba: bomba, cateter: cateter),
              ),

              const SizedBox(height: 15),

              _menuItem(
                context,
                'assets/images/cambio_sensor.png',
                CambioSensorScreen(bomba: bomba, sensor: sensor),
              ),

              const SizedBox(height: 15),

              _menuItem(
                context,
                'assets/images/errores.png',
                ErroresScreen(bomba: bomba, sensor: sensor, cateter: cateter),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigImage(String assetName) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset('assets/images/$assetName.png', fit: BoxFit.contain),
    );
  }

  Widget _menuItem(BuildContext context, String imagePath, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: Image.asset(imagePath, width: 140, height: 140),
    );
  }
}
