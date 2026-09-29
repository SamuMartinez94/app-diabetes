/// VOCABULARIO DE GESTOS
///
/// El gesto de cada paso se deduce de su texto en castellano con las reglas de
/// esta lista: gana la primera que encaja, así que las de seguridad van primero.
/// Un paso puede fijar su gesto a mano con `Paso(gesto: ...)`.
library;

import '../modelos/gesto.dart';
import '../modelos/paso.dart';

/// Reglas en orden de prioridad. La primera que encaja decide.
final List<(Gesto, RegExp)> _reglas = [
  (
    Gesto.advertencia,
    RegExp(
      r'\b(advertencia|precaucion|nunca|no uses|no lo uses|no reutilices|'
      r'no dejes|sangrado|vigila si)\b',
    ),
  ),
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

/// Quita tildes y pasa a minúsculas.
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
