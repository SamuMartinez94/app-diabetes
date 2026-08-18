import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'preferencias.dart';

/// Recordatorios de recambio. Se programan en el propio dispositivo: no hay
/// push, ni servidor, ni token de usuario.
class Notificaciones {
  static const _idCateter = 1001;
  static const _idSensor = 1002;

  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _disponible = false;

  static const _canal = AndroidNotificationDetails(
    'recambios',
    'Recordatorios de recambio',
    channelDescription:
        'Avisos para cambiar el catéter y el sensor a tiempo.',
    importance: Importance.high,
    priority: Priority.high,
  );

  static Future<void> inicializar() async {
    // En web no hay notificaciones programadas; la app funciona igual.
    if (kIsWeb) return;

    try {
      tz.initializeTimeZones();
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
      );
      _disponible = true;
    } catch (e) {
      debugPrint('Notificaciones no disponibles: $e');
    }
  }

  /// Devuelve `true` si el usuario concede el permiso del sistema.
  static Future<bool> pedirPermiso() async {
    if (!_disponible) return false;

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }

    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    return false;
  }

  /// Reprograma los dos avisos según los ajustes actuales.
  ///
  /// Se llama al cambiar cualquier ajuste y al anotar un recambio, de forma
  /// que el aviso siempre cuenta desde el último cambio real.
  static Future<void> reprogramar() async {
    if (!_disponible) return;

    await cancelarTodo();
    if (!Preferencias.recordatoriosActivos) return;

    await _programar(
      id: _idCateter,
      dias: Preferencias.diasCateter,
      titulo: 'Toca cambiar el catéter',
      cuerpo:
          'Han pasado ${Preferencias.diasCateter} días desde el último recambio.',
    );

    await _programar(
      id: _idSensor,
      dias: Preferencias.diasSensor,
      titulo: 'Toca cambiar el sensor',
      cuerpo:
          'Han pasado ${Preferencias.diasSensor} días desde el último recambio.',
    );
  }

  static Future<void> _programar({
    required int id,
    required int dias,
    required String titulo,
    required String cuerpo,
  }) async {
    final minutos = Preferencias.horaAviso;
    final ahora = tz.TZDateTime.now(tz.local);

    var cuando = tz.TZDateTime(
      tz.local,
      ahora.year,
      ahora.month,
      ahora.day,
      minutos ~/ 60,
      minutos % 60,
    ).add(Duration(days: dias));

    if (cuando.isBefore(ahora)) cuando = cuando.add(const Duration(days: 1));

    try {
      await _plugin.zonedSchedule(
        id: id,
        title: titulo,
        body: cuerpo,
        scheduledDate: cuando,
        notificationDetails: const NotificationDetails(
          android: _canal,
          iOS: DarwinNotificationDetails(),
        ),
        // Inexacto a propósito: no necesita precisión de minuto y así evita
        // pedir el permiso restringido de alarmas exactas en Android 14+.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint('No se pudo programar el aviso $id: $e');
    }
  }

  static Future<void> cancelarTodo() async {
    if (!_disponible) return;
    try {
      await _plugin.cancel(id: _idCateter);
      await _plugin.cancel(id: _idSensor);
    } catch (e) {
      debugPrint('No se pudieron cancelar los avisos: $e');
    }
  }
}
