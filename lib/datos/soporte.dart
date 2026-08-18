/// Fabricante con su web oficial de soporte.
///
/// A propósito no se incluyen números de teléfono precargados: un número
/// equivocado en una urgencia es peor que no tener ninguno. Cada usuario
/// guarda el suyo desde la app (se almacena solo en el dispositivo).
class Fabricante {
  final String id;
  final String nombre;
  final String dispositivos;
  final String web;

  /// Bombas a las que aplica, para poder ordenar por la del usuario.
  final List<String> bombas;

  const Fabricante({
    required this.id,
    required this.nombre,
    required this.dispositivos,
    required this.web,
    required this.bombas,
  });
}

const List<Fabricante> fabricantes = [
  Fabricante(
    id: 'medtronic',
    nombre: 'Medtronic Diabetes',
    dispositivos: 'MiniMed, Guardian, Simplera',
    web: 'https://www.medtronic-diabetes.com',
    bombas: ['bmedtronic'],
  ),
  Fabricante(
    id: 'tandem',
    nombre: 'Tandem Diabetes Care',
    dispositivos: 't:slim X2, AutoSoft, TruSteel',
    web: 'https://www.tandemdiabetes.com',
    bombas: ['btandem'],
  ),
  Fabricante(
    id: 'insulet',
    nombre: 'Insulet — Omnipod',
    dispositivos: 'Omnipod DASH, Omnipod 5',
    web: 'https://www.omnipod.com',
    bombas: ['bomnipod'],
  ),
  Fabricante(
    id: 'ypsomed',
    nombre: 'Ypsomed — mylife',
    dispositivos: 'YpsoPump, Orbit, Inset',
    web: 'https://www.mylife-diabetescare.com',
    bombas: ['bypsopump'],
  ),
  Fabricante(
    id: 'dexcom',
    nombre: 'Dexcom',
    dispositivos: 'Dexcom G6, Dexcom G7',
    web: 'https://www.dexcom.com',
    bombas: [],
  ),
  Fabricante(
    id: 'abbott',
    nombre: 'Abbott — FreeStyle',
    dispositivos: 'FreeStyle Libre 3',
    web: 'https://www.freestyle.abbott',
    bombas: [],
  ),
];
