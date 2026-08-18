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

/// Checklist para viajes y para el kit de emergencia del día a día.
/// Pendiente de revisar con un profesional.
const List<GrupoKit> kitViaje = [
  GrupoKit(
    titulo: 'Insulina y fungible',
    nota: 'Lleva el doble de lo que calcules necesitar. Los viajes se alargan.',
    elementos: [
      'Insulina de repuesto (el doble de los días de viaje)',
      'Catéteres / equipos de infusión de repuesto',
      'Reservorios o cartuchos de repuesto',
      'Sensores de repuesto',
      'Adhesivos extra o parches de sujeción',
      'Toallitas de alcohol',
    ],
  ),
  GrupoKit(
    titulo: 'Plan B sin bomba',
    nota:
        'Si la bomba falla lejos de casa, necesitas poder pasar a inyecciones.',
    elementos: [
      'Plumas o jeringas de insulina rápida',
      'Insulina lenta de respaldo',
      'Agujas para pluma',
      'Pauta de dosis en inyecciones escrita por tu equipo médico',
    ],
  ),
  GrupoKit(
    titulo: 'Medición',
    nota: 'El sensor puede fallar: no dependas solo de él.',
    elementos: [
      'Glucómetro capilar',
      'Tiras reactivas',
      'Lancetas',
      'Tiras de cetonas',
    ],
  ),
  GrupoKit(
    titulo: 'Hipoglucemias',
    nota: 'Repartido en varios sitios, no todo en la misma bolsa.',
    elementos: [
      'Azúcar de acción rápida (geles, tabletas o zumos)',
      'Hidratos de absorción lenta para después',
      'Glucagón de rescate, sin caducar',
      'Alguien de tu entorno que sepa usarlo',
    ],
  ),
  GrupoKit(
    titulo: 'Energía',
    nota: 'Una bomba sin batería no administra basal.',
    elementos: [
      'Cargador de la bomba y del móvil',
      'Pilas de repuesto del modelo correcto',
      'Batería externa',
      'Adaptador de enchufe del país de destino',
    ],
  ),
  GrupoKit(
    titulo: 'Papeles y aeropuerto',
    nota:
        'Las bombas y sensores no deben pasar por escáner de rayos X ni por el '
        'escáner corporal de cuerpo entero. Pide inspección manual.',
    elementos: [
      'Informe médico que justifique el material (mejor en inglés)',
      'Receta o volante de la insulina',
      'Tarjeta sanitaria y seguro de viaje',
      'Teléfono de soporte del fabricante en destino',
      'Nevera portátil o funda isotérmica para la insulina',
    ],
  ),
];
