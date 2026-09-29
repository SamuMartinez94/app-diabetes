import 'package:flutter/material.dart';

import 'l10n/idioma.dart';
import 'tema.dart';
import 'widgets/comunes.dart';

class ErroresScreen extends StatefulWidget {
  final String bomba;
  final String sensor;
  final String cateter;

  const ErroresScreen({
    super.key,
    required this.bomba,
    required this.sensor,
    required this.cateter,
  });

  @override
  State<ErroresScreen> createState() => _ErroresScreenState();
}

class _ErroresScreenState extends State<ErroresScreen> {
  int pasoActual = 0;
  String flujoActivo = "";

  bool get esOmnipod => widget.bomba == 'bomnipod';

  void _volverAlMenu() => setState(() {
    pasoActual = 0;
    flujoActivo = "";
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t('Resolver problemas')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () {
            if (pasoActual > 0) {
              _volverAlMenu();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t('TU CONFIGURACIÓN'),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: context.esquema.primary,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10),
              ResumenConfiguracion(
                bomba: widget.bomba,
                sensor: widget.sensor,
                cateter: widget.cateter,
              ),
              const SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: pasoActual == 0
                      ? _buildMenuErrores()
                      : _buildFlujoDiagnostico(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuErrores() {
    final colores = context.colores;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t('¿Qué está pasando?'),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: context.esquema.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 15),
        TarjetaMenu(
          titulo: t('El sensor no conecta'),
          subtitulo: t('Problemas de señal o de conexión.'),
          icono: Icons.sensors_off,
          color: colores.aviso,
          alPulsar: () => _abrirFlujo("sensor_no_conecta"),
        ),
        TarjetaMenu(
          titulo: esOmnipod
              ? t('Aviso de bloqueo en el Pod')
              : t('Aviso de insulina bloqueada'),
          subtitulo: esOmnipod
              ? t('El Pod ha detectado un problema.')
              : t('La insulina no pasa bien.'),
          icono: Icons.water_drop_outlined,
          color: colores.aviso,
          alPulsar: () => _abrirFlujo("flujo_obstruido"),
        ),
        TarjetaMenu(
          titulo: t('No me fío de las lecturas'),
          subtitulo: t('El sensor y el dedo no coinciden.'),
          icono: Icons.query_stats,
          color: colores.aviso,
          alPulsar: () => _abrirFlujo("glucosa_error"),
        ),
      ],
    );
  }

  void _abrirFlujo(String id) => setState(() {
    flujoActivo = id;
    pasoActual = 1;
  });

  Widget _buildFlujoDiagnostico() {
    // FLUJO SENSOR
    if (flujoActivo == "sensor_no_conecta") {
      if (pasoActual == 1) {
        return _buildPasoVisual(
          pregunta: t('Comprueba que está bien encajado'),
          descripcion: t(
            'Presiona el transmisor sobre el soporte del sensor. ¿Notas que '
            'está bien colocado y ha hecho clic?',
          ),
          textoSi: t('Sí, está bien puesto'),
          textoNo: t('No, se mueve o no encaja'),
          onSi: () => setState(() => pasoActual = 2),
          onNo: () => _mostrarSolucion(
            t(
              'Quita el transmisor, limpia los contactos y el soporte con un '
              'paño seco y vuelve a encajarlo hasta oír los clics. Si el '
              'soporte está dañado, tendrás que cambiar el sensor.',
            ),
          ),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: t('¿Cuánto tiempo lleva puesto?'),
          descripcion: t(
            '¿Llevas más de 7 o 10 días con este sensor, según tu modelo?',
          ),
          textoSi: t('Sí, ya lleva tiempo'),
          textoNo: t('No, es reciente'),
          onSi: () => _mostrarSolucion(
            t(
              'El sensor ha caducado o está a punto de hacerlo. Hay que '
              'cambiarlo.',
            ),
          ),
          onNo: () => setState(() => pasoActual = 3),
        );
      } else if (pasoActual == 3) {
        return _buildPasoVisual(
          pregunta: t('Reinicia la conexión'),
          descripcion: t(
            'Apaga y vuelve a encender el Bluetooth del móvil o del receptor, '
            'acércalo al sensor y espera 15 minutos sin alejarte.',
          ),
          textoSi: t('Ya vuelve a dar lecturas'),
          textoNo: t('Sigue sin conectar'),
          onSi: () => _mostrarSolucion(
            t(
              'Perfecto. Si te pasa a menudo, evita llevar el móvil o el '
              'receptor en el lado contrario del cuerpo: el propio cuerpo '
              'tapa la señal.',
            ),
          ),
          onNo: () => _mostrarSolucion(
            t(
              'Cambia el sensor y, si el problema se repite con el nuevo, '
              'contacta con el soporte del fabricante: puede ser el '
              'transmisor.',
            ),
          ),
        );
      }
    }

    // FLUJO BLOQUEO / INSULINA BLOQUEADA
    if (flujoActivo == "flujo_obstruido") {
      if (pasoActual == 1) {
        return _buildPasoVisual(
          pregunta: esOmnipod
              ? t('¿Suena una alarma?')
              : t('¿Hay algo doblado?'),
          descripcion: esOmnipod
              ? t(
                  'Si el Pod pita sin parar, es un bloqueo dentro del propio '
                  'Pod.',
                )
              : t(
                  'Mira si el tubo tiene burbujas o si el catéter parece '
                  'doblado.',
                ),
          textoSi: t('Veo algún problema'),
          textoNo: t('Todo parece normal'),
          onSi: () => _mostrarSolucion(
            esOmnipod
                ? t(
                    'El Pod está bloqueado. Desactívalo y pon uno nuevo. '
                    'Mide tu glucosa: llevas un rato sin insulina de fondo.',
                  )
                : t(
                    'Cambia el catéter entero (catéter y reservorio) y mide '
                    'tu glucosa.',
                  ),
          ),
          onNo: () => setState(() => pasoActual = 2),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: t('¿Cómo tienes la glucosa?'),
          descripcion: t(
            'Un bloqueo que no se ve se nota en la glucosa: sin insulina, '
            'sube y no baja aunque te corrijas.',
          ),
          textoSi: t('Alta y no baja'),
          textoNo: t('En rango'),
          onSi: () => _mostrarSolucion(
            t(
              'Trátalo como un bloqueo de verdad: cambia todo el catéter, '
              'corrige con la pluma si tu equipo médico te lo ha indicado y '
              'comprueba las cetonas.',
            ),
          ),
          onNo: () => _mostrarSolucion(
            t(
              'Puede haber sido una falsa alarma. Vigila tu glucosa las '
              'próximas 2 horas y cambia el catéter si el aviso se repite.',
            ),
          ),
        );
      }
    }

    // FLUJO LECTURAS DUDOSAS
    if (flujoActivo == "glucosa_error") {
      if (pasoActual == 1) {
        return _buildPasoVisual(
          pregunta: t('¿Cuánto lleva puesto el sensor?'),
          descripcion: t(
            'Durante las primeras horas tras ponerlo, las lecturas suelen '
            'ser menos precisas.',
          ),
          textoSi: t('Menos de 24 horas'),
          textoNo: t('Más de 24 horas'),
          onSi: () => _mostrarSolucion(
            t(
              'Es normal que al principio sea menos exacto. Guíate por el '
              'pinchazo en el dedo para tomar decisiones y espera a que se '
              'estabilice.',
            ),
          ),
          onNo: () => setState(() => pasoActual = 2),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: t('¿La diferencia es grande?'),
          descripcion: t(
            'Compara la lectura del sensor con un pinchazo en el dedo hecho '
            'con las manos limpias y secas.',
          ),
          textoSi: t('Sí, se desvía mucho'),
          textoNo: t('No, es una diferencia pequeña'),
          onSi: () => _mostrarSolucion(
            t(
              'Calibra el sensor si tu modelo lo permite. Si después sigue '
              'desviado, cámbialo y contacta con el fabricante.',
            ),
          ),
          onNo: () => _mostrarSolucion(
            t(
              'Una diferencia pequeña es normal: el sensor mide la glucosa '
              'que hay entre las células y va unos minutos por detrás de la '
              'sangre.',
            ),
          ),
        );
      }
    }

    return Center(child: Text(t('Cargando pasos...')));
  }

  Widget _buildPasoVisual({
    required String pregunta,
    required String descripcion,
    required String textoSi,
    required String textoNo,
    required VoidCallback onSi,
    required VoidCallback onNo,
  }) {
    final esquema = context.esquema;

    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          pregunta,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: esquema.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          descripcion,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: esquema.onSurfaceVariant,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: esquema.primary,
            foregroundColor: esquema.onPrimary,
            elevation: 0,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onSi,
          child: Text(
            textoSi,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: esquema.primary,
            side: BorderSide(color: esquema.primary, width: 1.5),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onNo,
          child: Text(
            textoNo,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  void _mostrarSolucion(String mensaje) {
    final esquema = context.esquema;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: esquema.primary.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lightbulb_outline_rounded,
                  color: esquema.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                t('Recomendación'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: esquema.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: esquema.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: esquema.primary,
                    foregroundColor: esquema.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _volverAlMenu();
                  },
                  child: Text(
                    t('Entendido'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
