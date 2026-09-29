import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bombas.dart';
import 'disclaimer.dart';
import 'l10n/idioma.dart';
import 'resultado.dart';
import 'servicios/notificaciones.dart';
import 'servicios/preferencias.dart';
import 'servicios/sugerencias.dart';
import 'tema.dart';
import 'widgets/selector_idioma.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferencias.inicializar();

  if (!Preferencias.hayIdiomaGuardado) Traductor.actual = Idioma.delSistema();

  await Notificaciones.inicializar();
  await Sugerencias.inicializar();
  await Notificaciones.reprogramar();

  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: Preferencias.revision,
      builder: (context, _, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DiaGuía',
        theme: temaClaro,
        darkTheme: temaOscuro,
        themeMode: Preferencias.tema,
        locale: Traductor.actual.locale,
        supportedLocales: Idioma.values.map((i) => i.locale).toList(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const PuntoDeEntrada(),
      ),
    );
  }
}

/// Decide la pantalla inicial. El aviso médico se muestra en cada arranque.
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
      body: SafeArea(
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Padding(padding: EdgeInsets.all(8), child: BotonIdioma()),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t('Bienvenido a'),
                      style: TextStyle(
                        color: esquema.onSurfaceVariant,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Traductor.actual == Idioma.gl ? 'A DiaGuía' : 'DiaGuía',
                      style: TextStyle(
                        color: esquema.primary,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t('Guía para bombas de insulina y sensores de glucosa.'),
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
                      child: Text(
                        t('Comenzar'),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
