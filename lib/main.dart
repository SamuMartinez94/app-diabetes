import 'package:flutter/material.dart';

import 'bombas.dart';
import 'disclaimer.dart';
import 'resultado.dart';
import 'servicios/notificaciones.dart';
import 'servicios/preferencias.dart';
import 'servicios/sugerencias.dart';
import 'tema.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // La app es 100% offline: no hay red, ni cuentas, ni analítica.
  await Preferencias.inicializar();
  await Notificaciones.inicializar();
  await Sugerencias.inicializar();
  await Notificaciones.reprogramar();

  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Reconstruye el MaterialApp para que `themeMode` siga a las preferencias.
    return ValueListenableBuilder<int>(
      valueListenable: Preferencias.revision,
      builder: (context, _, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Diabetes',
        theme: temaClaro,
        darkTheme: temaOscuro,
        themeMode: Preferencias.tema,
        home: const PuntoDeEntrada(),
      ),
    );
  }
}

/// Decide la pantalla inicial.
///
/// El aviso médico se muestra en CADA arranque: la aceptación vive solo en
/// memoria, no se guarda. Así queda constancia de que el usuario acepta las
/// condiciones cada vez que abre la app, no una única vez al instalarla.
class PuntoDeEntrada extends StatefulWidget {
  const PuntoDeEntrada({super.key});

  @override
  State<PuntoDeEntrada> createState() => _PuntoDeEntradaState();
}

class _PuntoDeEntradaState extends State<PuntoDeEntrada> {
  bool _aceptado = false;

  @override
  Widget build(BuildContext context) {
    if (!_aceptado) {
      return DisclaimerScreen(
        alAceptar: () => setState(() => _aceptado = true),
      );
    }

    return ValueListenableBuilder<int>(
      valueListenable: Preferencias.revision,
      builder: (context, _, _) {
        if (Preferencias.hayConfiguracion) {
          return ResultadoScreen(
            bomba: Preferencias.bomba!,
            sensor: Preferencias.sensor!,
            cateter: Preferencias.cateter,
          );
        }

        return const PantallaBienvenida();
      },
    );
  }
}

class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bienvenido',
                style: TextStyle(
                  color: esquema.onSurface,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Conceptos básicos sobre bombas de insulina.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: esquema.onSurfaceVariant,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: esquema.primary,
                  foregroundColor: esquema.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BombasScreen()),
                ),
                child: const Text(
                  'Comenzar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
