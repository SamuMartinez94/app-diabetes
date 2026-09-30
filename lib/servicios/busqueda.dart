/// Quita tildes y pasa a minúsculas, para que "oclusion" encuentre "oclusión".
String normalizar(String texto) {
  const con = 'áàäâéèëêíìïîóòöôúùüûñç';
  const sin = 'aaaaeeeeiiiioooouuuunc';
  var salida = texto.toLowerCase();
  for (var i = 0; i < con.length; i++) {
    salida = salida.replaceAll(con[i], sin[i]);
  }
  return salida;
}
