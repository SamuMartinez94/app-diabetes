/// Fabricante con su web oficial de soporte.
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
    nombre: 'MiniMed',
    dispositivos: 'MiniMed 780G, Guardian, Simplera',
    web: 'https://www.minimed.com',
    bombas: ['bmedtronic'],
  ),
  Fabricante(
    id: 'tandem',
    nombre: 'Tandem Diabetes Care',
    dispositivos: 't:slim X2, Tandem Mobi, AutoSoft, VariSoft, TruSteel',
    web: 'https://www.tandemdiabetes.com',
    bombas: ['btandem', 'btandemmobi'],
  ),
  Fabricante(
    id: 'insulet',
    nombre: 'Insulet — Omnipod',
    dispositivos: 'Omnipod DASH, Omnipod 5',
    web: 'https://www.omnipod.com/es-es',
    bombas: ['bomnipod'],
  ),
  Fabricante(
    id: 'ypsomed',
    nombre: 'mylife Diabetes Care',
    dispositivos: 'YpsoPump, myOrbit, myInset',
    web: 'https://www.mylife-diabetescare.com/es-ES',
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
