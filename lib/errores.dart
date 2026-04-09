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
        title: const Text(
          'Resolución de Problemas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            if (pasoActual > 0) {
              setState(() => pasoActual = 0);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderConfig(),
              const SizedBox(height: 40),

              // Alternancia entre menú principal y flujo de preguntas
              pasoActual == 0 ? _buildMenuErrores() : _buildFlujoDiagnostico(),
            ],
          ),
        ),
      ),
    );
  }

  //Diseño

  Widget _buildHeaderConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tu configuración',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(24),
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
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset('assets/images/$id.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Menú de errores

  Widget _buildMenuErrores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Qué está ocurriendo?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        _buildErrorCard(
          "El sensor no conecta con la bomba",
          "sensor_no_conecta",
          "Problemas de sincronización o señal.",
        ),
        _buildErrorCard(
          "Aviso de flujo obstruido",
          "flujo_obstruido",
          "La insulina no está pasando correctamente.",
        ),
        _buildErrorCard(
          "Lecturas de glucosa dudosas",
          "glucosa_error",
          "Diferencia entre sensor y capilar.",
        ),
      ],
    );
  }

  Widget _buildErrorCard(String title, String id, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => setState(() {
          flujoActivo = id;
          pasoActual = 1;
        }),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(20),
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
                    const SizedBox(height: 4),
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

  //Flujo diagnostico

  Widget _buildFlujoDiagnostico() {
    if (flujoActivo == "sensor_no_conecta") {
      if (pasoActual == 1) {
        return _buildPasoVisual(
          pregunta: "Comprueba el encaje",
          descripcion:
              "Asegúrate de que el transmisor esté bien encajado y haya hecho un 'clic' audible.",
          textoSi: "Está bien puesto",
          onSi: () => setState(() => pasoActual = 2),
        );
      } else if (pasoActual == 2) {
        return _buildPasoVisual(
          pregunta: "¿Tiempo de uso?",
          descripcion: "¿Llevas más de 7 días con este mismo sensor puesto?",
          textoSi: "Sí, más de 7 días",
          textoNo: "No, es reciente",
          onSi: () => _mostrarSolucion(
            "El sensor ha caducado. Debes sustituirlo por uno nuevo.",
          ),
          onNo: () => setState(() => pasoActual = 3),
        );
      }
      //PASOSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    }
    return const Center(child: Text("Selecciona un error para comenzar."));
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
        const SizedBox(height: 15),
        Text(
          descripcion,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.4),
        ),
        const SizedBox(height: 40),

        // Botón Principal
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onSi,
          child: Text(
            textoSi,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 15),

        // Botón Secundario
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            side: const BorderSide(color: Colors.blueAccent, width: 1.5),
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onNo ?? () => setState(() => pasoActual++),
          child: Text(
            textoNo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  void _mostrarSolucion(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Recomendación",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(mensaje, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => pasoActual = 0);
            },
            child: const Text(
              "ENTENDIDO",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
