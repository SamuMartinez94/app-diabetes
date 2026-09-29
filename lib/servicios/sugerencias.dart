import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../datos/sugerencias.dart';

/// Abre el formulario de sugerencias con el contexto ya relleno.
class Sugerencias {
  static String _version = '';

  /// Lee la versión de la app; se llama una vez al arrancar.
  static Future<void> inicializar() async {
    try {
      final info = await PackageInfo.fromPlatform();
      _version = '${info.version}+${info.buildNumber}';
    } catch (e) {
      debugPrint('No se pudo leer la versión de la app: $e');
    }
  }

  static String get version => _version;

  /// Construye el enlace prerrellenado para una ubicación concreta.
  static Uri construirUrl(String ubicacion) {
    return Uri.parse(kFormularioUrl).replace(
      queryParameters: {
        'usp': 'pp_url',
        kCampoUbicacion: ubicacion,
        kCampoVersion: _version,
      },
    );
  }

  /// Abre el formulario. Devuelve `false` si no se pudo.
  static Future<bool> abrir(String ubicacion) async {
    if (!formularioConfigurado) return false;

    try {
      return await launchUrl(
        construirUrl(ubicacion),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('No se pudo abrir el formulario: $e');
      return false;
    }
  }
}
