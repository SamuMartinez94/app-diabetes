import 'package:flutter/material.dart';
import 'bombas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart'; // <--- Nuevo
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // CONFIGURACIÓN DE REMOTE CONFIG
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      // Durante el desarrollo, ponemos 0 para ver los cambios al instante.
      // En producción se suele subir a 1 hora o más.
      minimumFetchInterval: Duration.zero,
    ),
  );

  // Definimos valores por defecto por si el usuario no tiene internet
  await remoteConfig.setDefaults({
    "mensaje_bienvenida": "Bienvenido",
    "mostrar_banner_alerta": false,
  });

  // Descargamos los valores actuales de Firebase
  await remoteConfig.fetchAndActivate();

  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Diabetes',
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      home: const PantallaBienvenida(),
    );
  }
}

class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    // Leemos el valor del Flag de Firebase
    final String tituloRemoto = FirebaseRemoteConfig.instance.getString(
      "mensaje_bienvenida",
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tituloRemoto, // <--- Ahora es dinámico
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Conceptos básicos sobre bombas de insulina.',
                style: TextStyle(
                  color: Color.fromARGB(179, 255, 255, 255),
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BombasScreen(),
                    ),
                  );
                },
                child: const Text('Comenzar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
