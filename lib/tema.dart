import 'package:flutter/material.dart';

/// Colores propios de la app que no encajan en el [ColorScheme] de Material.
@immutable
class ColoresApp extends ThemeExtension<ColoresApp> {
  /// Guías todavía sin validar por un profesional.
  final Color porRevisar;
  final Color porRevisarFondo;

  /// Avisos y resolución de problemas.
  final Color aviso;

  /// Acciones correctas o completadas.
  final Color exito;

  const ColoresApp({
    required this.porRevisar,
    required this.porRevisarFondo,
    required this.aviso,
    required this.exito,
  });

  static const claro = ColoresApp(
    porRevisar: Color(0xFFD32F2F),
    porRevisarFondo: Color(0x14D32F2F),
    aviso: Color(0xFFF57C00),
    exito: Color(0xFF00A152),
  );

  static const oscuro = ColoresApp(
    porRevisar: Color(0xFFFF6B6B),
    porRevisarFondo: Color(0x26FF6B6B),
    aviso: Color(0xFFFFB74D),
    exito: Color(0xFF4CD98A),
  );

  @override
  ColoresApp copyWith({
    Color? porRevisar,
    Color? porRevisarFondo,
    Color? aviso,
    Color? exito,
  }) => ColoresApp(
    porRevisar: porRevisar ?? this.porRevisar,
    porRevisarFondo: porRevisarFondo ?? this.porRevisarFondo,
    aviso: aviso ?? this.aviso,
    exito: exito ?? this.exito,
  );

  @override
  ColoresApp lerp(ColoresApp? otro, double t) {
    if (otro == null) return this;
    return ColoresApp(
      porRevisar: Color.lerp(porRevisar, otro.porRevisar, t)!,
      porRevisarFondo: Color.lerp(porRevisarFondo, otro.porRevisarFondo, t)!,
      aviso: Color.lerp(aviso, otro.aviso, t)!,
      exito: Color.lerp(exito, otro.exito, t)!,
    );
  }
}

/// Atajo para leer los colores propios: `context.colores.porRevisar`.
extension TemaContexto on BuildContext {
  ColoresApp get colores => Theme.of(this).extension<ColoresApp>()!;
  ColorScheme get esquema => Theme.of(this).colorScheme;
}

const _azul = Color(0xFF2962FF);
const _azulClaro = Color(0xFF82B1FF);

ThemeData _construir(ColorScheme esquema, ColoresApp colores) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: esquema,
    scaffoldBackgroundColor: esquema.surface,
    extensions: [colores],
    appBarTheme: AppBarTheme(
      backgroundColor: esquema.surface,
      foregroundColor: esquema.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 50,
      titleTextStyle: TextStyle(
        color: esquema.onSurface,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: esquema.surface,
      surfaceTintColor: Colors.transparent,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: esquema.primary,
      linearTrackColor: esquema.surfaceContainerHighest,
    ),
    listTileTheme: ListTileThemeData(iconColor: esquema.onSurfaceVariant),
    dividerTheme: DividerThemeData(color: esquema.outlineVariant),
  );
}

final ThemeData temaClaro = _construir(
  const ColorScheme.light(
    primary: _azul,
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xDD000000),
    surfaceContainerLow: Color(0xFFFAFAFA),
    surfaceContainerHighest: Color(0xFFF5F5F5),
    onSurfaceVariant: Color(0xFF757575),
    outline: Color(0xFFBDBDBD),
    outlineVariant: Color(0xFFEEEEEE),
  ),
  ColoresApp.claro,
);

final ThemeData temaOscuro = _construir(
  const ColorScheme.dark(
    primary: _azulClaro,
    onPrimary: Color(0xFF00224D),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFECECEC),
    surfaceContainerLow: Color(0xFF1C1C1E),
    surfaceContainerHighest: Color(0xFF2C2C2E),
    onSurfaceVariant: Color(0xFF9E9E9E),
    outline: Color(0xFF5C5C5E),
    outlineVariant: Color(0xFF323234),
  ),
  ColoresApp.oscuro,
);
