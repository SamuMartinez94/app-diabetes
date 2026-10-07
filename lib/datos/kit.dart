/// Un apartado del checklist de viaje.
class GrupoKit {
  final String titulo;
  final String nota;
  final List<String> elementos;

  const GrupoKit({
    required this.titulo,
    required this.nota,
    required this.elementos,
  });
}

/// Checklist de viaje y kit de emergencia.
const List<GrupoKit> kitViaje = [
  GrupoKit(
    titulo: 'Insulina y material de repuesto',
    nota:
        'Lleva más de lo que creas que vas a necesitar: los viajes se alargan '
        'y las cosas se pierden o se estropean.',
    elementos: [
      'Insulina de repuesto',
      'Catéteres de repuesto',
      'Reservorios o cartuchos de repuesto',
      'Sensores de repuesto',
      'Adhesivos extra o parches para sujetar',
      'Toallitas de alcohol',
    ],
  ),
  GrupoKit(
    titulo: 'Plan B sin bomba',
    nota:
        'Si la bomba falla lejos de casa, tienes que poder pasar a ponerte '
        'la insulina con pluma.',
    elementos: [
      'Plumas de insulina rápida',
      'Insulina lenta de respaldo',
      'Agujas para la pluma',
      'Instrucciones escritas por tu equipo médico sobre cómo ponerte la insulina con pluma',
    ],
  ),
  GrupoKit(
    titulo: 'Medir la glucosa',
    nota: 'El sensor puede fallar: no dependas solo de él.',
    elementos: [
      'Medidor de glucosa (el del pinchazo en el dedo)',
      'Tiras reactivas',
      'Lancetas (las agujitas del pinchazo)',
      'Tiras para medir cetonas',
    ],
  ),
  GrupoKit(
    titulo: 'Glucosa baja (hipoglucemia)',
    nota: 'Repártelo en varios sitios, no todo en la misma bolsa.',
    elementos: [
      'Azúcar de acción rápida (geles, tabletas o zumo)',
      'Hidratos de absorción lenta para después',
      'Glucagón de rescate, sin caducar',
      'Alguien de tu entorno que sepa usarlo',
    ],
  ),
  GrupoKit(
    titulo: 'Energía',
    nota: 'Una bomba sin batería no te da insulina.',
    elementos: [
      'Cargador de la bomba y del móvil',
      'Pilas de repuesto del modelo correcto',
      'Batería externa',
      'Adaptador de enchufe del país al que vas',
    ],
  ),
  GrupoKit(
    titulo: 'Papeles y aeropuerto',
    nota:
        'Lo que puede pasar por el arco, el escáner corporal o los rayos X '
        'depende de cada dispositivo. Al final tienes lo que dicen los '
        'manuales de los tuyos.',
    elementos: [
      'Informe médico que justifique el material (mejor en inglés)',
      'Receta de la insulina',
      'Tarjeta sanitaria y seguro de viaje',
      'Teléfono de soporte del fabricante en tu destino',
      'Nevera portátil o funda isotérmica para la insulina',
    ],
  ),
];
