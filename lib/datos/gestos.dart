/// VOCABULARIO DE GESTOS
///
/// Los 172 pasos de las guías repiten un puñado de acciones. En vez de una
/// ilustración por paso —inviable, y con los diagramas del fabricante bajo
/// copyright— cada paso se marca con el icono del gesto que pide.
///
/// El gesto se deduce del texto. El orden de la lista ES la prioridad: gana
/// la primera regla que encaja, así que las de seguridad van primero. Un paso
/// que empieza por "ADVERTENCIA" o por "NO ..." se marca como advertencia
/// aunque también hable de llenar o de insertar; poner ahí el icono de la
/// acción sería justo lo contrario de lo que dice el paso.
///
/// Si alguna deducción sale mal, el paso puede fijar su gesto a mano con
/// `Paso(gesto: Gesto.x)`.
library;

import '../modelos/gesto.dart';
import '../modelos/paso.dart';

/// Reglas en orden de prioridad. La primera que encaja decide.
final List<(Gesto, RegExp)> _reglas = [
  // Solo las advertencias reales del fabricante y las prohibiciones de
  // seguridad. Si esto abarca demasiado, el triangulo deja de significar nada.
  (
    Gesto.advertencia,
    RegExp(
      r'\b(advertencia|precaucion|nunca|no uses|no lo uses|no reutilices|'
      r'no dejes|sangrado|vigila si)\b',
    ),
  ),
  // Omisiones del procedimiento: pasos que dicen que algo NO se hace. Llevan
  // icono propio para no confundirse con una advertencia de seguridad.
  (
    Gesto.omitir,
    RegExp(
      r'no se llena|no hace falta|no llenes|no tiene canula|se salta|'
      r'omitir|no es necesario|no lleva transmisor|no se guarda|'
      r'no vuelvas a|no la quites|no toques|no compartas',
    ),
  ),
  (Gesto.glucosa, RegExp(r'glucemia|glucosa|cetonas|medidor')),
  (Gesto.higiene, RegExp(r'lavate|lava la zona|jabon|alcohol|toallita|limpia')),
  (
    Gesto.esperar,
    RegExp(r'espera|calentamiento|periodo de adaptacion|periodo de gracia'),
  ),
  (
    Gesto.emparejar,
    RegExp(
      r'empareja|codigo de emparejamiento|numero de serie|bluetooth|'
      r'vincula|\bcodigo\b|\bsn\b',
    ),
  ),
  (
    Gesto.zona,
    RegExp(
      r'elige la zona|zona de insercion|donde insertar|'
      r'parte posterior del brazo|distancias minimas|elige una zona|'
      r'evita lunares|evita cicatrices|la zona debe estar|'
      r'cambia de sitio|no lo insertes en musculo',
    ),
  ),
  (Gesto.desconectar, RegExp(r'desconect')),
  (Gesto.burbujas, RegExp(r'burbuja')),
  (Gesto.cebar, RegExp(r'cebar|cebado|llenar|llena el|llenado|purga')),
  (Gesto.girar, RegExp(r'\bgira|sentido horario|antihorario|vuelta')),
  (Gesto.encajar, RegExp(r'\bclic\b|encaj|hasta oir|hasta que oigas')),
  (
    Gesto.insertar,
    RegExp(r'inserta|dispara|aplicador|insercion|pincha|sujeta'),
  ),
  (Gesto.retirar, RegExp(r'retira|extrae|despega|quita|desecha|sustituye')),
  (Gesto.adhesivo, RegExp(r'adhesivo|parche|cinta|sobreparche')),
  (
    Gesto.pantalla,
    RegExp(
      r'selecciona|menu principal|men[uú]|toca |pulsa|pantalla|'
      r'opciones|configura el recordatorio',
    ),
  ),
];

/// Quita tildes y pasa a minúsculas, para que las reglas no dependan de la
/// acentuación del texto.
String _normalizar(String texto) {
  const con = 'áàäâéèëêíìïîóòöôúùüûñç';
  const sin = 'aaaaeeeeiiiioooouuuunc';
  var salida = texto.toLowerCase();
  for (var i = 0; i < con.length; i++) {
    salida = salida.replaceAll(con[i], sin[i]);
  }
  return salida;
}

/// Gesto de un paso: el que traiga fijado, o el deducido de su texto.
Gesto gestoDe(Paso paso) {
  if (paso.gesto != null) return paso.gesto!;

  final texto = _normalizar(paso.texto);
  for (final (gesto, patron) in _reglas) {
    if (patron.hasMatch(texto)) return gesto;
  }
  return Gesto.informacion;
}
