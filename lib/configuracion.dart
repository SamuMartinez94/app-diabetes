import 'package:flutter/material.dart';

import 'bombas.dart';
import 'datos/sugerencias.dart';
import 'disclaimer.dart';
import 'l10n/idioma.dart';
import 'servicios/notificaciones.dart';
import 'servicios/preferencias.dart';
import 'tema.dart';
import 'widgets/selector_idioma.dart';
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
          SnackBar(
            content: Text(
              t(
                'Sin permiso de notificaciones no se pueden programar avisos. '
                'Actívalo en los ajustes del sistema.',
              ),
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
                      title: Text(tf('{n} días', {'n': d})),
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
        title: Text(t('Modo sugerencias')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t(
                'Pensado para quienes están revisando el contenido de la app. '
                'Añade un botón para avisar de errores en cada guía y en cada '
                'alarma.',
              ),
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
              decoration: InputDecoration(
                labelText: t('Código'),
                border: const OutlineInputBorder(),
              ),
              onChanged: (v) => introducido = v,
              onSubmitted: (v) => Navigator.pop(context, v),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t('Cancelar')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, introducido),
            child: Text(t('Activar')),
          ),
        ],
      ),
    );

    if (codigo == null || !mounted) return;

    if (codigo.trim() != kCodigoModoSugerencias) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t('Código incorrecto.'))));
      return;
    }

    await Preferencias.guardarModoSugerencias(true);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          formularioConfigurado
              ? t('Modo sugerencias activado.')
              : t(
                  'Activado, pero falta configurar el formulario en '
                  'lib/datos/sugerencias.dart.',
                ),
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
      appBar: AppBar(title: Text(t('Configuración'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            _seccion(context, t('IDIOMA')),
            const SizedBox(height: 6),
            const SelectorIdioma(),
            const SizedBox(height: 24),

            _seccion(context, t('RECORDATORIOS DE CAMBIO')),
            SwitchListTile(
              value: recordatorios,
              onChanged: _cambiarRecordatorios,
              contentPadding: EdgeInsets.zero,
              title: Text(t('Avisarme de los cambios')),
              subtitle: Text(
                t(
                  'Notificaciones programadas en el propio móvil. No se envía '
                  'nada a ningún servidor.',
                ),
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
                title: Text(t('Cambio de catéter')),
                subtitle: Text(
                  tf('Cada {n} días', {'n': Preferencias.diasCateter}),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _elegirDias(
                  titulo: t('Cambio de catéter'),
                  descripcion: t(
                    'Lo habitual son 2 o 3 días. Sigue la pauta de tu equipo '
                    'médico.',
                  ),
                  actual: Preferencias.diasCateter,
                  opciones: const [1, 2, 3, 4],
                  guardar: Preferencias.guardarDiasCateter,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t('Cambio de sensor')),
                subtitle: Text(
                  tf('Cada {n} días', {'n': Preferencias.diasSensor}),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _elegirDias(
                  titulo: t('Cambio de sensor'),
                  descripcion: t(
                    'Depende del modelo: 7, 10, 14 o 15 días. Mira la caja de '
                    'tu sensor.',
                  ),
                  actual: Preferencias.diasSensor,
                  opciones: const [7, 10, 14, 15],
                  guardar: Preferencias.guardarDiasSensor,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t('Hora del aviso')),
                subtitle: Text(
                  '${(horaAviso ~/ 60).toString().padLeft(2, '0')}:'
                  '${(horaAviso % 60).toString().padLeft(2, '0')}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _elegirHora,
              ),
            ],

            const SizedBox(height: 20),
            _seccion(context, t('ROTACIÓN DE ZONAS')),
            SwitchListTile(
              value: Preferencias.rotacionActiva,
              onChanged: (v) async {
                await Preferencias.guardarRotacion(v);
                if (context.mounted) setState(() {});
              },
              contentPadding: EdgeInsets.zero,
              title: Text(t('Preguntarme dónde me lo pongo')),
              subtitle: Text(
                t(
                  'Al terminar una guía, apunta la zona para ayudarte a ir '
                  'cambiando de sitio y evitar que la piel se endurezca.',
                ),
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
                title: Text(t('Ver historial y sugerencias')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ZonasScreen()),
                ),
              ),

            const SizedBox(height: 20),
            _seccion(context, t('APARIENCIA')),
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
                          ThemeMode.system => t('Seguir al sistema'),
                          ThemeMode.light => t('Claro'),
                          ThemeMode.dark => t('Oscuro'),
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 20),
            _seccion(context, t('MIS DISPOSITIVOS')),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t('Cambiar bomba, sensor o catéter')),
              subtitle: Text(
                t('Vuelve a abrir el asistente de configuración.'),
                style: TextStyle(fontSize: 12, color: esquema.onSurfaceVariant),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => confirmarCambioDeConfiguracion(context),
            ),

            const SizedBox(height: 20),
            _seccion(context, t('REVISIÓN DE CONTENIDO')),
            if (!Preferencias.modoSugerencias)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(t('Modo sugerencias')),
                subtitle: Text(
                  t('Para quienes revisan la app. Hace falta un código.'),
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
                title: Text(t('Modo sugerencias activo')),
                subtitle: Text(
                  t(
                    'En cada guía y en cada alarma verás un botón para avisar '
                    'de errores. Se abre un formulario externo; no se envía '
                    'nada sin que tú lo confirmes.',
                  ),
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
            _seccion(context, t('PRIVACIDAD')),
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
                      t(
                        'La app funciona entera sin conexión. No hay cuentas ni '
                        'análisis de uso: todo lo que apuntas se queda en este '
                        'dispositivo y no se envía nada por su cuenta.\n\n'
                        'La única excepción es el modo sugerencias, y solo '
                        'cuando tú pulsas el botón: entonces se abre un '
                        'formulario externo donde ves y decides qué enviar.',
                      ),
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
              title: Text(t('Aviso médico')),
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
