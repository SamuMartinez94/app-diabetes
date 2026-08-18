import 'package:flutter/material.dart';

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
        title: const Text('Resolución de Problemas'),
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
                'TU CONFIGURACIÓN',
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
          '¿Qué está ocurriendo?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: context.esquema.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 15),
        TarjetaMenu(
          titulo: "El sensor no conecta",
          subtitulo: "Problemas de señal o sincronización.",
          icono: Icons.sensors_off,
          color: colores.aviso,
          alPulsar: () => _abrirFlujo("sensor_no_conecta"),
        ),
        TarjetaMenu(
          titulo: esOmnipod
              ? "Aviso de oclusión en el Pod"
              : "Aviso de flujo obstruido",
          subtitulo: esOmnipod
              ? "El Pod ha detectado un problema."
              : "La insulina no pasa correctamente.",
          icono: Icons.water_drop_outlined,
          color: colores.aviso,
          alPulsar: () => _abrirFlujo("flujo_obstruido"),
        ),
        TarjetaMenu(
          titulo: "Lecturas dudosas",
          subtitulo: "Diferencia con glucemia capilar.",
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
          pregunta: "Comprueba el encaje",
          descripcion:
              "Presiona el transmisor sobre el soporte del sensor. ¿Notas que "
              "está bien asentado y ha hecho clic?",
          textoSi: "Sí, está bien puesto",
          textoNo: "No, se mueve o no encaja",
          onSi: () => setState(() => pasoActual = 2),
          onNo: () => _mostrarSolucion(
            "Retira el transmisor, limpia los contactos y el soporte con un "
            "paño seco y vuelve a encajarlo hasta oír los clics. Si el soporte "
            "está dañado, tendrás que cambiar el sensor.",
          ),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: "¿Tiempo de uso?",
          descripcion:
              "¿Llevas más de 7 o 10 días con este sensor, según tu modelo?",
          textoSi: "Sí, ya lleva tiempo",
          textoNo: "No, es reciente",
          onSi: () => _mostrarSolucion(
            "El sensor ha caducado o está cerca de hacerlo. Debes sustituirlo.",
          ),
          onNo: () => setState(() => pasoActual = 3),
        );
      } else if (pasoActual == 3) {
        return _buildPasoVisual(
          pregunta: "Reinicia la conexión",
          descripcion:
              "Apaga y vuelve a encender el Bluetooth del receptor, acércalo "
              "al sensor y espera 15 minutos sin alejarte.",
          textoSi: "Ya vuelve a dar lecturas",
          textoNo: "Sigue sin conectar",
          onSi: () => _mostrarSolucion(
            "Perfecto. Si vuelve a pasarte a menudo, evita llevar el receptor "
            "en el lado opuesto del cuerpo: el propio cuerpo bloquea la señal.",
          ),
          onNo: () => _mostrarSolucion(
            "Sustituye el sensor y, si el problema se repite con el nuevo, "
            "contacta con el soporte del fabricante: puede ser el transmisor.",
          ),
        );
      }
    }

    // FLUJO OCLUSIÓN / FLUJO OBSTRUIDO
    if (flujoActivo == "flujo_obstruido") {
      if (pasoActual == 1) {
        return _buildPasoVisual(
          pregunta: esOmnipod ? "¿Alarma sonora?" : "¿Doblado o acodado?",
          descripcion: esOmnipod
              ? "Si el Pod emite un pitido constante, es una oclusión interna."
              : "Revisa si el tubo tiene burbujas o si el catéter parece doblado.",
          textoSi: "Hay problemas visibles",
          textoNo: "Todo parece normal",
          onSi: () => _mostrarSolucion(
            esOmnipod
                ? "El Pod está bloqueado. Desactívalo y coloca uno nuevo. "
                      "Mídete la glucosa: llevas tiempo sin basal."
                : "Cambia el set de infusión completo (catéter y reservorio) "
                      "y mídete la glucosa.",
          ),
          onNo: () => setState(() => pasoActual = 2),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: "¿Cómo está tu glucosa?",
          descripcion:
              "Una oclusión sin señales visibles se confirma por la glucosa: "
              "sin insulina, sube y no baja con las correcciones.",
          textoSi: "Alta y no baja",
          textoNo: "En rango",
          onSi: () => _mostrarSolucion(
            "Trátalo como una oclusión real: cambia todo el set de infusión, "
            "corrige con pluma si tu equipo médico te lo ha indicado y "
            "comprueba cetonas.",
          ),
          onNo: () => _mostrarSolucion(
            "Puede haber sido un falso positivo. Vigila la glucosa las "
            "próximas 2 horas y cambia el set si el aviso se repite.",
          ),
        );
      }
    }

    // FLUJO LECTURAS DUDOSAS
    if (flujoActivo == "glucosa_error") {
      if (pasoActual == 1) {
        return _buildPasoVisual(
          pregunta: "¿Cuánto lleva puesto el sensor?",
          descripcion:
              "Durante las primeras horas tras la inserción las lecturas "
              "suelen ser menos precisas.",
          textoSi: "Menos de 24 horas",
          textoNo: "Más de 24 horas",
          onSi: () => _mostrarSolucion(
            "Es normal cierta imprecisión al inicio. Guíate por la glucemia "
            "capilar para tomar decisiones y espera a que se estabilice.",
          ),
          onNo: () => setState(() => pasoActual = 2),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: "¿La diferencia es grande?",
          descripcion:
              "Compara la lectura del sensor con una glucemia capilar hecha "
              "con las manos limpias y secas.",
          textoSi: "Sí, se desvía mucho",
          textoNo: "No, es una diferencia pequeña",
          onSi: () => _mostrarSolucion(
            "Calibra el sensor si tu modelo lo permite. Si tras la calibración "
            "sigue desviado, sustitúyelo y contacta con el fabricante.",
          ),
          onNo: () => _mostrarSolucion(
            "Una diferencia pequeña es esperable: el sensor mide glucosa "
            "intersticial y va con unos minutos de retraso respecto a la sangre.",
          ),
        );
      }
    }

    return const Center(child: Text("Cargando pasos..."));
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
                "Recomendación",
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
                  child: const Text(
                    "Entendido",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
