import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modelos/registro_insercion.dart';

/// Almacenamiento local del dispositivo. No sale nada de aquí: sin cuentas,
/// sin servidor, sin analítica y sin identificadores de usuario.
class Preferencias {
  static const _kBomba = 'config_bomba';
  static const _kSensor = 'config_sensor';
  static const _kCateter = 'config_cateter';
  static const _kTema = 'ajuste_tema';
  static const _kRecordatorios = 'ajuste_recordatorios';
  static const _kDiasCateter = 'ajuste_dias_cateter';
  static const _kDiasSensor = 'ajuste_dias_sensor';
  static const _kHoraAviso = 'ajuste_hora_aviso';
  static const _kRotacion = 'ajuste_rotacion';
  static const _kRegistros = 'registros_insercion';
  static const _kModoSugerencias = 'modo_sugerencias';

  static late SharedPreferences _prefs;

  /// Se incrementa con cada cambio para que la interfaz se reconstruya.
  static final ValueNotifier<int> revision = ValueNotifier(0);

  static void _notificar() => revision.value++;

  static Future<void> inicializar() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- CONFIGURACIÓN DE DISPOSITIVOS ---

  static bool get hayConfiguracion =>
      _prefs.getString(_kBomba) != null && _prefs.getString(_kSensor) != null;

  static String? get bomba => _prefs.getString(_kBomba);
  static String? get sensor => _prefs.getString(_kSensor);
  static String get cateter => _prefs.getString(_kCateter) ?? '';

  static Future<void> guardarConfiguracion({
    required String bomba,
    required String sensor,
    required String cateter,
  }) async {
    await _prefs.setString(_kBomba, bomba);
    await _prefs.setString(_kSensor, sensor);
    await _prefs.setString(_kCateter, cateter);
    _notificar();
  }

  static Future<void> borrarConfiguracion() async {
    await _prefs.remove(_kBomba);
    await _prefs.remove(_kSensor);
    await _prefs.remove(_kCateter);
    _notificar();
  }

  // --- APARIENCIA ---

  static ThemeMode get tema => switch (_prefs.getString(_kTema)) {
    'claro' => ThemeMode.light,
    'oscuro' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  static Future<void> guardarTema(ThemeMode modo) async {
    await _prefs.setString(_kTema, switch (modo) {
      ThemeMode.light => 'claro',
      ThemeMode.dark => 'oscuro',
      ThemeMode.system => 'sistema',
    });
    _notificar();
  }

  // --- RECORDATORIOS ---

  static bool get recordatoriosActivos =>
      _prefs.getBool(_kRecordatorios) ?? false;

  static Future<void> guardarRecordatorios(bool activos) async {
    await _prefs.setBool(_kRecordatorios, activos);
    _notificar();
  }

  static int get diasCateter => _prefs.getInt(_kDiasCateter) ?? 3;
  static int get diasSensor => _prefs.getInt(_kDiasSensor) ?? 10;

  static Future<void> guardarDiasCateter(int dias) async {
    await _prefs.setInt(_kDiasCateter, dias);
    _notificar();
  }

  static Future<void> guardarDiasSensor(int dias) async {
    await _prefs.setInt(_kDiasSensor, dias);
    _notificar();
  }

  /// Hora del día del aviso, en minutos desde medianoche.
  static int get horaAviso => _prefs.getInt(_kHoraAviso) ?? 10 * 60;

  static Future<void> guardarHoraAviso(int minutos) async {
    await _prefs.setInt(_kHoraAviso, minutos);
    _notificar();
  }

  // --- MODO SUGERENCIAS ---

  /// Modo revisor: muestra botones para reportar errores en cada guía.
  static bool get modoSugerencias =>
      _prefs.getBool(_kModoSugerencias) ?? false;

  static Future<void> guardarModoSugerencias(bool activo) async {
    await _prefs.setBool(_kModoSugerencias, activo);
    _notificar();
  }

  // --- ROTACIÓN DE ZONAS ---

  static bool get rotacionActiva => _prefs.getBool(_kRotacion) ?? true;

  static Future<void> guardarRotacion(bool activa) async {
    await _prefs.setBool(_kRotacion, activa);
    _notificar();
  }

  static List<RegistroInsercion> get registros {
    final crudo = _prefs.getStringList(_kRegistros) ?? const [];
    return crudo
        .map((e) => RegistroInsercion.desdeJson(jsonDecode(e)))
        .toList();
  }

  /// Guarda una inserción y conserva solo las 20 últimas.
  static Future<void> anotarInsercion(RegistroInsercion registro) async {
    final lista = registros..insert(0, registro);
    await _prefs.setStringList(
      _kRegistros,
      lista.take(20).map((e) => jsonEncode(e.aJson())).toList(),
    );
    _notificar();
  }

  static Future<void> borrarRegistros() async {
    await _prefs.remove(_kRegistros);
    _notificar();
  }
}
