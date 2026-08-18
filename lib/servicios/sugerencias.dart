import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../datos/sugerencias.dart';

/// Abre el formulario de sugerencias con el contexto ya relleno.
///
/// La app no envía nada por su cuenta: construye una URL y la abre en el
/// navegador. Quien decide enviar, y qué texto envía, es siempre la persona.
class Sugerencias {
  static String _version = '';

  /// Se llama una vez al arrancar. Si falla, el campo queda vacío y el
  /// formulario se abre igual.
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
