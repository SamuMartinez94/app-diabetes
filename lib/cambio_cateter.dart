import 'package:flutter/material.dart';

class CambioCateterScreen extends StatefulWidget {
  final String bomba;
  final String cateter;

  const CambioCateterScreen({
    super.key,
    required this.bomba,
    required this.cateter,
  });

  @override
  State<CambioCateterScreen> createState() => _CambioCateterScreenState();
}

class Paso {
  final String texto;
  final String? imagen;
  Paso({required this.texto, this.imagen});
}

class _CambioCateterScreenState extends State<CambioCateterScreen> {
  int pasoActual = 0;

  //Mapa con pasos
  static final Map<String, List<Paso>> instruccionesMap = {
    /*//--------------------- Ypsopump
    'bypsopump_cextended': [
      Paso(texto: 'Lávate las manos'),
      Paso(texto: 'Prepara el material', imagen: 'assets/images/paso1.png'),
      Paso(texto: 'Inserta el catéter'),
    ],
    
    */
    //------------------------BMedtronic
    //MEDTRONIC_EXTENDED
    'bmedtronic_cextended': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto: '''
Retira el reservorio usado y selecciona 
"Reservorio y equipo de inf."

Selecciona "Nueva configuración" en tu bomba para rebobinar el pistón.''',
      ),
      Paso(
        texto:
            'Llena el nuevo reservorio con insulina, eliminando las burbujas de aire.',
      ),
      Paso(
        texto:
            'Conecta el tubo del equipo de infusión de Medtronic al reservorio.',
      ),
      Paso(
        texto: '''
'Inserta el reservorio en la bomba y gíralo para bloquearlo.

Selecciona "Colocar" y mantén pulsado hasta que aparezca la marca de verificación.',''',
      ),
      Paso(
        texto:
            'IMPORTANTE: Asegúrate de que el equipo de infusión esté DESCONECTADO de tu cuerpo antes de llenar el tubo.',
      ),
      Paso(
        texto:
            'Mantén pulsado "Llenar" hasta que veas gotas en el extremo del tubo y no queden burbujas.',
      ),
      Paso(
        texto: '''
'Inserta el equipo de infusión en la zona elegida (abdomen, muslo, nalgas o brazo) siguiendo las instrucciones de su insertador.',
      ''',
      ),
      Paso(
        texto: '''
'Selecciona "Llenar cánula" e introduce la cantidad de unidades necesaria 
según tu tipo de catéter (consulta su caja).',
      ''',
      ),
    ],

    //MEDTRONIC_MIO
    'bmedtronic_cmio': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto: '''
Retira el reservorio usado y selecciona 
"Reservorio y equipo de inf."

Selecciona "Nueva configuración" en tu bomba para rebobinar el pistón.''',
      ),
      Paso(
        texto:
            'Llena el nuevo reservorio con insulina, eliminando todas las burbujas de aire.',
      ),
      Paso(
        texto:
            'Conecta el tubo del Quick-set al reservorio mediante la conexión MiniMed.',
      ),
      Paso(
        texto: '''
Inserta el reservorio en la bomba y gíralo para bloquearlo.

Selecciona "Colocar" y mantén pulsado hasta que aparezca la marca de verificación.''',
      ),
      Paso(
        texto:
            'IMPORTANTE: Asegúrate de que el equipo esté DESCONECTADO de tu cuerpo antes de llenar el tubo.',
      ),
      Paso(
        texto:
            'Selecciona "Llenar tubo" y mantén pulsado hasta que veas gotas en la punta de la aguja.',
      ),
      Paso(
        texto: '''
PREPARAR EL DISPOSITIVO:
Coloca el Quick-set dentro del insertador azul (Quick-serter) y presiona hacia abajo hasta que encaje.''',
      ),
      Paso(
        texto:
            'Retira el papel protector del adhesivo y el protector de plástico de la aguja.',
      ),
      Paso(
        texto: '''
TENSAR Y COLOCAR:
Tira del mango verde del insertador hacia atrás hasta que oigas un clic. 

Apóyalo en la zona de inserción y presiona los botones laterales.''',
      ),
      Paso(
        texto: '''
Retira el insertador azul con cuidado. 

Presiona el adhesivo con el dedo para que quede bien pegado a la piel.''',
      ),
      Paso(
        texto: '''
Selecciona "Llenar cánula" e introduce la cantidad necesaria. 

(Suele ser 0.3 unidades para cánula de 6mm o 0.5 unidades para cánula de 9mm).''',
      ),
    ],

    //MEDTRONIC_MIO30
    'bmedtronic_cmio30': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto: '''
Retira el reservorio usado y selecciona 
"Reservorio y equipo de inf."

Selecciona "Nueva configuración" en tu bomba para rebobinar el pistón.''',
      ),
      Paso(
        texto:
            'Llena el nuevo reservorio con insulina, eliminando todas las burbujas de aire.',
      ),
      Paso(
        texto:
            'Conecta el tubo del Mio 30 al reservorio mediante la conexión MiniMed.',
      ),
      Paso(
        texto: '''
Inserta el reservorio en la bomba y gíralo para bloquearlo.

Selecciona "Colocar" y mantén pulsado hasta que aparezca la marca de verificación.''',
      ),
      Paso(
        texto:
            'IMPORTANTE: Asegúrate de que el equipo esté DESCONECTADO de tu cuerpo antes de llenar el tubo.',
      ),
      Paso(
        texto:
            'Selecciona "Llenar tubo" y mantén pulsado hasta que veas gotas en la punta de la aguja',
      ),
      Paso(
        texto: '''
PREPARAR EL MIO 30:
Retira el papel del adhesivo.
Retira el protector de la aguja con cuidado''',
      ),
      Paso(
        texto: '''
TENSAR EL DISPOSITIVO
Sujeta las protuberancias laterales y tira hacia atrás hasta que oigas un CLIC. 
(Verás que la aguja queda expuesta en un ángulo inclinado)''',
      ),
      Paso(
        texto: '''
INSERCIÓN ANGULADA
Coloca el dispositivo plano sobre la piel. 
El diseño ya viene con el ángulo de 30 grados incorporado. 
Presiona los botones laterales para insertar.
''',
      ),
      Paso(
        texto:
            'Presiona el centro del insertador para fijar el adhesivo y retira el envase de plástico hacia atrás, siguiendo la línea de la aguja',
      ),
      Paso(
        texto: 'Selecciona "Llenar cánula" e introduce la cantidad necesaria.',
      ),
    ],

    //MEDTRONIC_QUICKSET
    'bmedtronic_cquickset': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto: '''
Retira el reservorio usado y selecciona "Reservorio y equipo de inf."

Selecciona "Nueva configuración" en tu bomba para rebobinar el pistón.''',
      ),
      Paso(
        texto:
            'Llena el nuevo reservorio con insulina, eliminando todas las burbujas de aire.',
      ),
      Paso(
        texto:
            'Conecta el tubo del Quick-set al reservorio mediante la conexión MiniMed.',
      ),
      Paso(
        texto: '''
Inserta el reservorio en la bomba y gíralo para bloquearlo.

Selecciona "Colocar" y mantén pulsado hasta que aparezca la marca de verificación.''',
      ),
      Paso(
        texto:
            'IMPORTANTE: Asegúrate de que el equipo esté DESCONECTADO de tu cuerpo antes de llenar el tubo.',
      ),
      Paso(
        texto:
            'Selecciona "Llenar tubo" y mantén pulsado hasta que veas gotas en la punta de la aguja.',
      ),
      Paso(
        texto: '''
PREPARAR EL DISPOSITIVO:
Coloca el Quick-set dentro del insertador azul (Quick-serter) y presiona hacia abajo hasta que encaje.''',
      ),
      Paso(
        texto:
            'Retira el papel protector del adhesivo y el protector de plástico de la aguja',
      ),
      Paso(
        texto: '''
TENSAR Y COLOCAR
Tira del mango verde del insertador hacia atrás hasta que oigas un clic. Apóyalo en la zona de inserción y presiona los botones laterales.''',
      ),
      Paso(
        texto:
            'Retira el insertador azul con cuidado. Presiona el adhesivo con el dedo para que quede bien pegado a la piel.',
      ),
      Paso(
        texto: 'Selecciona "Llenar cánula" e introduce la cantidad necesaria.',
      ),
    ],

    //MEDTRONIC_SILHUETTE
    'bmedtronic_csilhouette': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto: '''
Retira el reservorio usado y selecciona "Reservorio y equipo de inf."

Selecciona "Nueva configuración" en tu bomba para rebobinar el pistón.''',
      ),
      Paso(
        texto:
            'Llena el nuevo reservorio con insulina, eliminando todas las burbujas de aire.',
      ),
      Paso(
        texto:
            'Conecta el tubo del Silhouette al reservorio mediante la conexión MiniMed.',
      ),
      Paso(
        texto: '''
Inserta el reservorio en la bomba y gíralo para bloquearlo.

Selecciona "Colocar" y mantén pulsado hasta que aparezca la marca de verificación.''',
      ),
      Paso(
        texto:
            'IMPORTANTE: Asegúrate de que el equipo esté DESCONECTADO de tu cuerpo antes de llenar el tubo.',
      ),
      Paso(
        texto:
            'Selecciona "Llenar tubo" y mantén pulsado hasta que veas gotas en la punta de la aguja.',
      ),
      Paso(
        texto: '''
PREPARACIÓN:
Retira el papel protector del adhesivo y quita el protector de la aguja. 
(Puedes insertarlo manualmente o usar el dispositivo Sil-serter).''',
      ),
      Paso(
        texto: '''
INSERCIÓN ANGULADA
Pellizca la piel e inserta la aguja de forma inclinada, buscando un ángulo de entre 30 y 45 grados respecto a la piel.''',
      ),
      Paso(
        texto:
            'RETIRAR LA AGUJA: Sujeta el catéter con un dedo para que no se mueva y retira la aguja guía con cuidado.',
      ),
      Paso(texto: 'Selecciona "Llenar cánula" en la bomba.'),
    ],

    //MEDTRONIC_SURET
    'bmedtronic_csuret': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto: '''
Retira el reservorio usado y selecciona "Reservorio y equipo de inf."

Selecciona "Nueva configuración" en tu bomba para rebobinar el pistón.''',
      ),
      Paso(
        texto:
            'Llena el nuevo reservorio con insulina, eliminando todas las burbujas de aire.',
      ),
      Paso(
        texto:
            'Conecta el tubo del Sure-T al reservorio mediante la conexión MiniMed.',
      ),
      Paso(
        texto: '''
Inserta el reservorio en la bomba y gíralo para bloquearlo.

Selecciona "Colocar" y mantén pulsado hasta que aparezca la marca de verificación.''',
      ),
      Paso(
        texto:
            'IMPORTANTE: Asegúrate de que el equipo esté DESCONECTADO de tu cuerpo antes de llenar el tubo.',
      ),
      Paso(
        texto:
            'Selecciona "Llenar tubo" y mantén pulsado hasta que veas gotas en la punta de la aguja de acero.',
      ),
      Paso(
        texto: '''
PREPARAR LA AGUJA:
Retira el papel protector del adhesivo grande y quita el protector de plástico de la aguja de acero.''',
      ),
      Paso(
        texto: '''
INSERCIÓN MANUAL:
Pellizca suavemente la piel en la zona elegida e inserta la aguja de acero directamente. Presiona el adhesivo firmemente contra la piel.''',
      ),
      Paso(
        texto:
            'Retira el papel del adhesivo pequeño (el que está en el tubo) y pégalo a unos pocos centímetros del lugar de inserción.',
      ),
      Paso(
        texto:
            'En la pantalla de la bomba, selecciona "Omitir llenado de cánula" o pulsa "Atrás".',
      ),
    ],

    //--------------------------BoMnipod
    //OMNIPOD_POD
    'bomnipod_cpod': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto: '''
Saca un nuevo Pod de su embalaje. 
IMPORTANTE: No quites todavía el protector azul de la aguja/cánula.''',
      ),
      Paso(
        texto: '''
Usa la jeringa que viene en la caja para extraer la insulina del vial. 
Introduce la aguja de la jeringa en el puerto de llenado (el círculo de goma) en la parte trasera del Pod.''',
      ),
      Paso(
        texto: '''
Llena el Pod.
Escucharás DOS PITIDOS que indican que el Pod está listo para ser activado.''',
      ),
      Paso(
        texto:
            'En tu mando (PDM), selecciona "Configurar nuevo Pod". El PDM se comunicará con el Pod y realizará el cebado automático. Espera a que termine.',
      ),
      Paso(
        texto:
            'Ahora sí, retira el protector azul de la cánula y el papel de los adhesivos.',
      ),
      Paso(
        texto:
            'Pega el Pod en la piel de forma firme. En el PDM, pulsa "Insertar cánula". El Pod disparará la cánula automáticamente.',
      ),
      Paso(
        texto:
            'Observa a través de la ventana transparente del Pod si la cánula rosa está bien insertada en la piel. Confirma en el PDM que la inserción ha sido correcta.',
      ),
    ],

    //------------------------YPSOPUMP
    //YPSOPUMP_ORBIT
    'bypsopump_corbit': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto:
            'Asegúrate de que tu cartucho de insulina esté bien colocado en la bomba.',
      ),
      Paso(
        texto:
            'Conecta el tubo del catéter Orbit a la punta del cartucho de la bomba.',
      ),
      Paso(
        texto:
            'En el menú de la bomba, selecciona la función de cebado. Mantén pulsado hasta que la insulina salga por la punta del conector del catéter.',
      ),
      Paso(
        texto: '''
Limpia la zona de inserción.
Retira el papel protector del adhesivo del Orbit.
Inserta el parche (usando el insertador Orbit-Inserter o manualmente).''',
      ),
      Paso(
        texto:
            'Retira la aguja guía (si es el modelo Soft) y haz clic con el conector del tubo sobre el parche ya pegado. Puedes orientar el tubo en cualquier dirección.',
      ),
      Paso(
        texto: 'En la bomba, selecciona "Llenar cánula". Introduce insulina.',
      ),
    ],

    //YPSOPUMP_INSET
    'bypsopump_cinset': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto:
            'Conecta el tubo al cartucho de la YpsoPump y purga el sistema hasta que la insulina asome por la aguja.',
      ),
      Paso(
        texto: '''
Retira el precinto de plástico.
Quita el papel protector del adhesivo.
Retira con cuidado el protector de la aguja.''',
      ),
      Paso(
        texto:
            'Sujeta el dispositivo por las muescas laterales y tira de la parte superior hacia atrás hasta que oigas un CLIC.',
      ),
      Paso(
        texto:
            'Coloca el Inset sobre la piel y presiona los botones laterales para disparar la cánula.',
      ),
      Paso(
        texto: '''
RETIRAR INSERTADOR
Presiona suavemente el centro del dispositivo y tira del insertador de plástico hacia arriba, dejando el catéter pegado.''',
      ),
      Paso(
        texto:
            'Selecciona en la bomba la opción de llenar cánula. Introduce insulina.',
      ),
    ],

    //--------------------------------BTandem
    //TANDEM_AUTOSOFT90
    'btandem_cautosoft90': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto:
            'En la pantalla de tu Tandem, selecciona: OPCIONES > CARGA > LLENAR TUBO. Asegúrate de tener el cartucho ya preparado con insulina.',
      ),
      Paso(
        texto:
            'Conecta el tubo del AutoSoft 90 al conector t:lock del cartucho.',
      ),
      Paso(
        texto: '''
LLENADO DEL TUBO
Selecciona INICIAR y espera a que aparezcan 3 gotas de insulina en la punta de la aguja. Pulsa DETENER y luego CONTINUAR.''',
      ),
      Paso(
        texto:
            'IMPORTANTE: No conectes el equipo a tu cuerpo hasta que el tubo esté lleno.',
      ),
      Paso(
        texto: '''
Retira el papel del adhesivo.
Quita el protector de la aguja.
Tira de la parte central del insertador hacia arriba hasta que oigas un CLIC.''',
      ),
      Paso(
        texto:
            'Coloca el dispositivo en la zona elegida y presiona los huecos laterales para disparar. Presiona el centro del insertador y retíralo con cuidado.',
      ),
      Paso(texto: 'En la pantalla, selecciona LLENAR CÁNULA.'),
    ],

    //TANDEM_AUTOSOFT30
    'btandem_cautosoft30': [
      Paso(texto: 'Lávate bien las manos con agua y jabón.'),
      Paso(
        texto:
            'Conecta el tubo al cartucho (t:lock) y realiza el proceso de LLENAR TUBO en la bomba hasta ver 3 gotas.',
      ),
      Paso(
        texto: '''
PREPARAR EL DISPOSITIVO
Retira los protectores y tira hacia atrás del insertador hasta oír el CLIC. Verás que el diseño ya tiene la inclinación de 30 grados.''',
      ),
      Paso(
        texto: '''
INSERCIÓN
Coloca el dispositivo plano sobre la piel y dispara. Retira el insertador deslizándolo hacia atrás con cuidado siguiendo el ángulo de la aguja.''',
      ),
      Paso(texto: 'Selecciona LLENAR CÁNULA en la bomba.'),
    ],

    //TANDEM_TRUSTEEL
    'btandem_ctrusteel': [
      Paso(texto: 'Lávate bien las manos.'),
      Paso(
        texto:
            'Llena el tubo en la bomba hasta que la insulina salga por la punta de la aguja de acero.',
      ),
      Paso(
        texto: '''
INSERCIÓN
Retira los protectores e inserta la aguja de acero manualmente a 90 grados. Fija el adhesivo principal.''',
      ),
      Paso(
        texto:
            'Pega el segundo adhesivo (el del tubo) a unos centímetros de la aguja para evitar tirones accidentales.',
      ),
      Paso(
        texto:
            'Cuando la bomba pregunte si deseas "LLENAR CÁNULA", selecciona "HECHO" o pulsa el botón de cerrar. NO LLENES CÁNULA. La aguja de acero ya está lista para administrar insulina.',
      ),
    ],
  };

  List<Paso> getPasos() {
    final key = '${widget.bomba}_${widget.cateter}';
    return instruccionesMap[key] ??
        [
          Paso(
            texto: 'No hay instrucciones específicas para esta combinación.',
            imagen: 'assets/images/error.png',
          ),
        ];
  }

  void siguientePaso() {
    final pasos = getPasos();
    if (pasoActual < pasos.length - 1) {
      setState(() => pasoActual++);
    }
  }

  void pasoAnterior() {
    if (pasoActual > 0) {
      setState(() => pasoActual--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pasos = getPasos();
    final paso = pasos[pasoActual];
    final bool tieneImagen = paso.imagen != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 50,
        title: const Text(
          'Instrucciones',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: (pasoActual + 1) / pasos.length,
                backgroundColor: Colors.grey[100],
                color: Colors.blueAccent,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 15),
              Text(
                'PASO ${pasoActual + 1} DE ${pasos.length}',
                style: const TextStyle(
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Colors.blueAccent,
                ),
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  // Animación
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.05, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                  child: Center(
                    key: ValueKey(pasoActual),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        // ESTILO DE LA TARJETA
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.05 * 255).toInt(),
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                          border: Border.all(color: Colors.grey[100]!),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, // La tarjeta se ajusta al contenido
                          children: [
                            if (tieneImagen) ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset(
                                  paso.imagen!,
                                  height: 180,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],

                            // Icono decorativo
                            Icon(
                              Icons.info_outline,
                              color: Colors.blueAccent.withAlpha(
                                (0.3 * 255).toInt(),
                              ),
                              size: 30,
                            ),
                            const SizedBox(height: 15),

                            Text(
                              paso.texto,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 19,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Sección de botones
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Row(
                  children: [
                    if (pasoActual > 0) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: pasoAnterior,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Anterior',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: FilledButton(
                        onPressed: pasoActual < pasos.length - 1
                            ? siguientePaso
                            : () => Navigator.pop(context),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.blueAccent[700],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          pasoActual < pasos.length - 1
                              ? 'Siguiente'
                              : 'Finalizar',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
