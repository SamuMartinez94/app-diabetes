/// ---------------------------------------------------------------------------
/// CONFIGURACIÓN DEL FORMULARIO DE SUGERENCIAS
///
/// Este es el único archivo que hay que editar para conectar el modo
/// sugerencias con tu formulario de Google. Instrucciones en el README.
/// ---------------------------------------------------------------------------
library;

/// Código que activa el modo sugerencias desde Configuración.
///
/// No es una contraseña: cualquiera puede encontrarlo abriendo el APK o el
/// bundle web. Es solo un interruptor para que la app siga limpia de botones
/// de revisión para el usuario normal.
const String kCodigoModoSugerencias = '1357';

/// Enlace del formulario, en su forma "viewform".
///
/// Lo obtienes en tu formulario con  Enviar → icono de enlace.
/// Debe quedar algo como:
/// https://docs.google.com/forms/d/e/1FAIpQLSc.../viewform
const String kFormularioUrl =
    'https://docs.google.com/forms/d/e/1FAIpQLScEVA0MADWQL_L4PV2ZO-EzOakQWOGnRolWjInScTvCqkZWhw/viewform';

/// Identificadores de cada campo del formulario.
///
/// Se obtienen con  ⋮ → Obtener enlace prerrellenado:  rellenas los campos con
/// cualquier texto, pulsas "Obtener enlace" y copias. En la URL resultante
/// aparece un `entry.NNNNNNNNN=` por cada campo; ese es el identificador.
const String kCampoNombre = 'entry.440175640';
const String kCampoSugerencia = 'entry.1968866231';
const String kCampoUbicacion = 'entry.1312113764';
const String kCampoVersion = 'entry.1036226408';

/// `true` cuando ya se han rellenado los datos de arriba.
///
/// Mientras sea `false`, el modo sugerencias avisa en pantalla en vez de
/// abrir un enlace roto.
bool get formularioConfigurado =>
    !kFormularioUrl.contains('PENDIENTE') &&
    !kCampoNombre.contains('PENDIENTE') &&
    !kCampoSugerencia.contains('PENDIENTE') &&
    !kCampoUbicacion.contains('PENDIENTE') &&
    !kCampoVersion.contains('PENDIENTE');
