import 'package:flutter/material.dart';

import 'bombas.dart';
import 'disclaimer.dart';
import 'datos/sugerencias.dart';
import 'servicios/notificaciones.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';
import 'zonas_insercion.dart';

class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({super.key});

  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  Future<void> _cambiarRecordatorios(bool activar) async {
    if (activar) {
      final concedido = await Notificaciones.pedirPermiso();
      if (!concedido) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Sin permiso de notificaciones no se pueden programar avisos. '
              'Actívalo en los ajustes del sistema.',
            ),
          ),
        );
        return;
      }
    }

    await Preferencias.guardarRecordatorios(activar);
    await Notificaciones.reprogramar();
    if (mounted) setState(() {});
  }

  Future<void> _elegirDias({
    required String titulo,
    required String descripcion,
    required int actual,
    required List<int> opciones,
    required Future<void> Function(int) guardar,
  }) async {
    final elegido = await showDialog<int>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(titulo),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            child: Text(
              descripcion,
              style: TextStyle(
                fontSize: 13,
                height: 1.35,
                color: context.esquema.onSurfaceVariant,
              ),
            ),
          ),
          RadioGroup<int>(
            groupValue: actual,
            onChanged: (v) => Navigator.pop(context, v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: opciones
                  .map(
                    (d) => RadioListTile<int>(
                      value: d,
                      title: Text('$d días'),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );

    if (elegido == null) return;
    await guardar(elegido);
    await Notificaciones.reprogramar();
    if (mounted) setState(() {});
  }

  Future<void> _pedirCodigo() async {
    // Sin TextEditingController a propósito: el TextField sigue vivo durante
    // la animación de cierre del diálogo, así que liberarlo al recibir el
    // valor provocaba un "used after being disposed".
    var introducido = '';

    final codigo = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Modo sugerencias'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pensado para quienes están revisando el contenido de la app. '
              'Añade un botón para reportar errores en cada guía y en cada '
              'alarma.',
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: context.esquema.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Código',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => introducido = v,
              onSubmitted: (v) => Navigator.pop(context, v),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, introducido),
            child: const Text('Activar'),
          ),
        ],
      ),
    );

    if (codigo == null || !mounted) return;

    if (codigo.trim() != kCodigoModoSugerencias) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código incorrecto.')),
      );
      return;
    }

    await Preferencias.guardarModoSugerencias(true);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          formularioConfigurado
              ? 'Modo sugerencias activado.'
              : 'Activado, pero falta configurar el formulario en '
                    'lib/datos/sugerencias.dart.',
        ),
      ),
    );
  }

  Future<void> _elegirHora() async {
    final minutos = Preferencias.horaAviso;
    final elegida = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: minutos ~/ 60, minute: minutos % 60),
    );

    if (elegida == null) return;
    await Preferencias.guardarHoraAviso(elegida.hour * 60 + elegida.minute);
    await Notificaciones.reprogramar();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final esquema = context.esquema;
    final recordatorios = Preferencias.recordatoriosActivos;
    final horaAviso = Preferencias.horaAviso;

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            _seccion(context, 'RECORDATORIOS DE RECAMBIO'),
            SwitchListTile(
              value: recordatorios,
              onChanged: _cambiarRecordatorios,
              contentPadding: EdgeInsets.zero,
              title: const Text('Avisarme de los cambios'),
              subtitle: Text(
                'Notificaciones programadas en el propio móvil. No se envía '
                'nada a ningún servidor.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.3,
                  color: esquema.onSurfaceVariant,
                ),
              ),
            ),
            if (recordatorios) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                enabled: recordatorios,
                title: const Text('Cambio de catéter'),
                subtitle: Text('Cada ${Preferencias.diasCateter} días'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _elegirDias(
                  titulo: 'Cambio de catéter',
                  descripcion:
                      'Lo habitual son 2 o 3 días. Sigue la pauta de tu equipo médico.',
                  actual: Preferencias.diasCateter,
                  opciones: const [1, 2, 3, 4],
                  guardar: Preferencias.guardarDiasCateter,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Cambio de sensor'),
                subtitle: Text('Cada ${Preferencias.diasSensor} días'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _elegirDias(
                  titulo: 'Cambio de sensor',
                  descripcion:
                      'Depende del modelo: 7, 10, 14 o 15 días. Consulta la caja de tu sensor.',
                  actual: Preferencias.diasSensor,
                  opciones: const [7, 10, 14, 15],
                  guardar: Preferencias.guardarDiasSensor,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Hora del aviso'),
                subtitle: Text(
                  '${(horaAviso ~/ 60).toString().padLeft(2, '0')}:'
                  '${(horaAviso % 60).toString().padLeft(2, '0')}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _elegirHora,
              ),
            ],

            const SizedBox(height: 20),
            _seccion(context, 'ROTACIÓN DE ZONAS'),
            SwitchListTile(
              value: Preferencias.rotacionActiva,
              onChanged: (v) async {
                await Preferencias.guardarRotacion(v);
                if (context.mounted) setState(() {});
              },
              contentPadding: EdgeInsets.zero,
              title: const Text('Preguntar dónde me lo pongo'),
              subtitle: Text(
                'Al terminar una guía, anota la zona para ayudarte a rotar y '
                'evitar que la piel se endurezca.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.3,
                  color: esquema.onSurfaceVariant,
                ),
              ),
            ),
            if (Preferencias.rotacionActiva)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Ver historial y sugerencias'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ZonasScreen()),
                ),
              ),

            const SizedBox(height: 20),
            _seccion(context, 'APARIENCIA'),
            RadioGroup<ThemeMode>(
              groupValue: Preferencias.tema,
              onChanged: (v) async {
                if (v == null) return;
                await Preferencias.guardarTema(v);
                if (mounted) setState(() {});
              },
              child: Column(
                children: ThemeMode.values
                    .map(
                      (modo) => RadioListTile<ThemeMode>(
                        value: modo,
                        contentPadding: EdgeInsets.zero,
                        title: Text(switch (modo) {
                          ThemeMode.system => 'Seguir al sistema',
                          ThemeMode.light => 'Claro',
                          ThemeMode.dark => 'Oscuro',
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 20),
            _seccion(context, 'MIS DISPOSITIVOS'),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Cambiar bomba, sensor o catéter'),
              subtitle: Text(
                'Vuelve a ejecutar el asistente de configuración.',
                style: TextStyle(
                  fontSize: 12,
                  color: esquema.onSurfaceVariant,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => confirmarCambioDeConfiguracion(context),
            ),

            const SizedBox(height: 20),
            _seccion(context, 'REVISIÓN DE CONTENIDO'),
            if (!Preferencias.modoSugerencias)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Modo sugerencias'),
                subtitle: Text(
                  'Para revisores. Requiere un código.',
                  style: TextStyle(
                    fontSize: 12,
                    color: esquema.onSurfaceVariant,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pedirCodigo,
              )
            else
              SwitchListTile(
                value: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Modo sugerencias activo'),
                subtitle: Text(
                  'En cada guía y cada alarma verás un botón para reportar '
                  'errores. Se abre un formulario externo; nada se envía sin '
                  'que lo confirmes.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: esquema.onSurfaceVariant,
                  ),
                ),
                onChanged: (_) async {
                  await Preferencias.guardarModoSugerencias(false);
                  if (context.mounted) setState(() {});
                },
              ),

            const SizedBox(height: 20),
            _seccion(context, 'PRIVACIDAD'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: esquema.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.lock_outline, size: 20, color: esquema.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'La app funciona entera sin conexión. No hay cuentas, ni '
                      'analítica: todo lo que anotas se queda en este '
                      'dispositivo y no se envía nada por su cuenta.\n\n'
                      'La única excepción es el modo sugerencias, y solo '
                      'cuando tú pulsas el botón: entonces se abre un '
                      'formulario externo donde ves y decides qué enviar.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: esquema.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Aviso médico'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const DisclaimerScreen(requiereAceptacion: false),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _seccion(BuildContext context, String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      texto,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
        color: context.esquema.primary,
      ),
    ),
  );
}
