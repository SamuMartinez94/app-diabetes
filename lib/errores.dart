import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 50,
        title: const Text(
          'Resolución de Problemas',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () {
            if (pasoActual > 0) {
              setState(() => pasoActual = 0);
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
              _buildHeaderConfig(),
              const SizedBox(height: 25),
              //Alternar entre menú y flujo de preguntas
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

  Widget _buildHeaderConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TU CONFIGURACIÓN',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.bomba.isNotEmpty)
                _buildConfigItem(widget.bomba, 'Bomba'),
              if (widget.sensor.isNotEmpty)
                _buildConfigItem(widget.sensor, 'Sensor'),
              if (widget.cateter.isNotEmpty)
                _buildConfigItem(widget.cateter, 'Catéter'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfigItem(String id, String label) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.08 * 255).round()),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset('assets/images/$id.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuErrores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Qué está ocurriendo?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 15),
        _buildErrorCard(
          "El sensor no conecta",
          "sensor_no_conecta",
          "Problemas de señal o sincronización.",
        ),
        _buildErrorCard(
          "Aviso de flujo obstruido",
          "flujo_obstruido",
          "La insulina no pasa correctamente.",
        ),
        _buildErrorCard(
          "Lecturas dudosas",
          "glucosa_error",
          "Diferencia con glucemia capilar.",
        ),
      ],
    );
  }

  Widget _buildErrorCard(String title, String id, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => setState(() {
          flujoActivo = id;
          pasoActual = 1;
        }),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sub,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlujoDiagnostico() {
    if (flujoActivo == "sensor_no_conecta") {
      if (pasoActual == 1) {
        return _buildPasoVisual(
          pregunta: "Comprueba el encaje",
          descripcion: "Asegúrate de que el transmisor haya hecho un 'clic'.",
          textoSi: "Está bien puesto",
          onSi: () => setState(() => pasoActual = 2),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: "¿Tiempo de uso?",
          descripcion: "¿Llevas más de 7 días con este sensor puesto?",
          textoSi: "Sí, más de 7 días",
          textoNo: "No, es reciente",
          onSi: () => _mostrarSolucion(
            "El sensor ha caducado. Debes sustituirlo por uno nuevo.",
          ),
          onNo: () => setState(() => pasoActual = 3),
        );
      }
    }
    return const Center(child: Text("Cargando pasos..."));
  }

  Widget _buildPasoVisual({
    required String pregunta,
    required String descripcion,
    required String textoSi,
    String textoNo = "Sigue fallando",
    required VoidCallback onSi,
    VoidCallback? onNo,
  }) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          pregunta,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          descripcion,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.3),
        ),
        const SizedBox(height: 30),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onSi,
          child: Text(
            textoSi,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            side: const BorderSide(color: Colors.blueAccent, width: 1.5),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onNo ?? () => setState(() => pasoActual++),
          child: Text(
            textoNo,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  void _mostrarSolucion(String mensaje) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Se ajusta al contenido
            children: [
              // Icono superior circular
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withAlpha((0.1 * 255).round()),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Colors.blueAccent,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),

              // Título centrado
              const Text(
                "Recomendación",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => pasoActual = 0);
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
