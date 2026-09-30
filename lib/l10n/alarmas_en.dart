/// Traducciones de las alarmas y avisos sacados de los manuales oficiales.
/// Es traducción automática pendiente de revisión por una persona nativa.
const Map<String, String> traduccionesAlarmasEn = {
  'Bloqueo de insulina (oclusión)': 'Insulin blockage (occlusion)',
  'La bomba ha detectado que la insulina no puede pasar y ha detenido todo el suministro. Puede tardar un rato en detectar el bloqueo.':
      'The pump has detected that insulin cannot get through and has stopped all delivery. It may take a while to detect the blockage.',
  'oclusion, bloqueo, obstruido, atasco, no pasa insulina, tubo doblado':
      'occlusion, blockage, blocked, jam, no insulin getting through, kinked tubing',
  'Pulsa OK.': 'Press OK.',
  'Revisa el cartucho, el tubo y el sitio de infusión por si hay daños, dobleces o bloqueos, y corrígelo.':
      'Check the cartridge, the tubing and the infusion site for damage, kinks or blockages, and fix it.',
  'Para reanudar la insulina: Opciones → Reanudar insulina y confirma.':
      'To resume insulin: Options → Resume insulin and confirm.',
  'Si salta una segunda alarma de bloqueo seguida, cambia el cartucho, el tubo y el sitio de infusión, y reanuda la insulina después.':
      'If a second blockage alarm goes off right after, change the cartridge, the tubing and the infusion site, and resume insulin afterwards.',
  'Si saltó durante un bolo, la pantalla te dice cuánto se llegó a poner antes del bloqueo.':
      'If it went off during a bolus, the screen tells you how much was delivered before the blockage.',
  'El cartucho se ha quedado sin insulina y se han detenido todos los suministros. La alarma se repite cada 3 minutos hasta que lo cambies.':
      'The cartridge has run out of insulin and all delivery has stopped. The alarm repeats every 3 minutes until you change it.',
  'cartucho, vacio, sin insulina, se acabo':
      'cartridge, empty, no insulin, ran out',
  'Cambia el cartucho ya: en la pantalla de inicio pulsa Opciones → Cargar y sigue los pasos (mira la guía de cambio de esta app).':
      'Change the cartridge now: on the home screen press Options → Load and follow the steps (see this app\'s change guide).',
  'Error de cartucho': 'Cartridge error',
  'La bomba no ha podido usar el cartucho y ha detenido todos los suministros. Puede ser un cartucho defectuoso, un llenado mal hecho o un cartucho demasiado lleno.':
      'The pump could not use the cartridge and has stopped all delivery. It may be a faulty cartridge, a filling done wrong or an overfilled cartridge.',
  'cartucho defectuoso, error cartucho, sobrellenado':
      'faulty cartridge, cartridge error, overfilled',
  'Cambia el cartucho ya: Opciones → Cargar y sigue los pasos.':
      'Change the cartridge now: Options → Load and follow the steps.',
  'Al llenar el nuevo, sigue el procedimiento del manual y no lo llenes por encima de su capacidad.':
      'When filling the new one, follow the manual\'s procedure and do not fill it beyond its capacity.',
  'Cartucho extraído': 'Cartridge removed',
  'La bomba ha detectado que se ha sacado el cartucho y ha detenido todos los suministros.':
      'The pump has detected that the cartridge has been taken out and has stopped all delivery.',
  'cartucho fuera, sacado, desconectado':
      'cartridge out, taken out, disconnected',
  'Pulsa Conectar si quieres volver a conectar el mismo cartucho.':
      'Press Connect if you want to reconnect the same cartridge.',
  'Pulsa Instalar si vas a poner un cartucho nuevo.':
      'Press Install if you are going to put in a new cartridge.',
  'Mide tu glucosa si tardas en reanudar la insulina.':
      'Check your glucose if you take a while to resume insulin.',
  'Batería casi agotada (alarma)': 'Battery almost empty (alarm)',
  'A la bomba le queda un 1 % de carga o menos y se han detenido todos los suministros. Se repite cada 3 minutos hasta que se apague.':
      'The pump has 1% charge or less left and all delivery has stopped. It repeats every 3 minutes until it switches off.',
  'sin bateria, apagada, cargar, no enciende':
      'no battery, off, charge, won\'t turn on',
  'Carga la bomba de inmediato para reanudar la insulina.':
      'Charge the pump immediately to resume insulin.',
  'Batería baja (alerta)': 'Low battery (alert)',
  'Queda menos del 25 % de batería (primera alerta) o menos del 5 % (segunda alerta). Con la segunda, la insulina sigue durante unos 30 minutos y después la bomba se apaga.':
      'Less than 25% battery left (first alert) or less than 5% (second alert). With the second one, insulin continues for about 30 minutes and then the pump switches off.',
  'poca bateria, bateria baja, baja energia, cargar':
      'low battery, battery low, low power, charge',
  'Carga la bomba lo antes posible para evitar la segunda alerta.':
      'Charge the pump as soon as possible to avoid the second alert.',
  'Si ya es la segunda, cárgala de inmediato para evitar que se apague.':
      'If it is already the second one, charge it immediately to stop it switching off.',
  'Queda muy poca insulina en el cartucho. El aviso se repite cada 5 minutos hasta que lo confirmes.':
      'Very little insulin is left in the cartridge. The notice repeats every 5 minutes until you confirm it.',
  'poca insulina, queda poco, cartucho bajo, barra roja':
      'low insulin, running low, low cartridge, red bar',
  'Cambia el cartucho lo antes posible para evitar la alarma de cartucho vacío y quedarte sin insulina.':
      'Change the cartridge as soon as possible to avoid the empty cartridge alarm and running out of insulin.',
  'Reanuda la insulina': 'Resume insulin',
  'Detuviste la insulina desde el menú Opciones y llevas más de 15 minutos sin reanudarla. La alarma vuelve a sonar cada 3 minutos.':
      'You stopped insulin from the Options menu and it has been more than 15 minutes without resuming it. The alarm sounds again every 3 minutes.',
  'reanudar, detenida, parada, stop, detener insulina':
      'resume, stopped, paused, stop, stop insulin',
  'Apagado automático': 'Automatic shut-off',
  'Has puesto un tiempo (entre 5 y 24 horas) tras el cual, si no tocas la bomba, esta deja de dar insulina. Antes salta un aviso con una cuenta atrás de 60 segundos.':
      'You set a time (between 5 and 24 hours) after which, if you do not touch the pump, it stops giving insulin. Before that, a notice appears with a 60-second countdown.',
  'apagado automatico, auto off, se paro sola, sin tocar':
      'automatic shut-off, auto off, stopped by itself, not touched',
  'Si ves la advertencia previa, pulsa No apagar y la bomba sigue con normalidad.':
      'If you see the warning beforehand, press Don\'t shut off and the pump carries on as normal.',
  'Si ya ha saltado la alarma, pulsa OK: verás "Todos los suministros detenidos".':
      'If the alarm has already gone off, press OK: you will see "All deliveries stopped".',
  'Reanuda la insulina: Opciones → Reanudar insulina.':
      'Resume insulin: Options → Resume insulin.',
  'La bomba o su batería están fuera del rango de temperatura seguro y se han detenido todos los suministros.':
      'The pump or its battery is outside the safe temperature range and all delivery has stopped.',
  'Cuando vuelva a temperatura normal, reanuda la insulina.':
      'When it is back at normal temperature, resume insulin.',
  'La insulina se estropea con el frío y con el calor: si ha estado expuesta mucho rato, cámbiala.':
      'Insulin spoils with cold and with heat: if it has been exposed for a long time, replace it.',
  'Cambio de altitud o de presión': 'Altitude or pressure change',
  'La bomba ha notado una diferencia de presión entre el interior del cartucho y el aire de alrededor, y ha detenido los suministros.':
      'The pump has noticed a pressure difference between the inside of the cartridge and the surrounding air, and has stopped delivery.',
  'altitud, avion, presion, montana, vuelo':
      'altitude, plane, pressure, mountain, flight',
  'Saca el cartucho de la bomba para que se ventile del todo y vuelve a conectarlo.':
      'Take the cartridge out of the pump so it can vent fully and reconnect it.',
  'Reanuda la insulina.': 'Resume insulin.',
  'Botón de arriba atascado': 'Top button stuck',
  'El botón Activar pantalla / Bolo rápido (el de arriba de la bomba) está atascado o no funciona bien, y se han detenido todos los suministros.':
      'The Wake screen / Quick bolus button (the one on top of the pump) is stuck or not working properly, and all delivery has stopped.',
  'boton, atascado, bolo rapido, no funciona':
      'button, stuck, quick bolus, not working',
  'Ponte en contacto con el servicio de atención al cliente.':
      'Contact customer support.',
  'Mide tu glucosa: mientras esté detenida no recibes insulina.':
      'Check your glucose: while it is stopped you are not getting insulin.',
  'Fallo o reinicio de la bomba': 'Pump failure or restart',
  'La bomba ha detectado un error del sistema, o uno de sus procesadores se ha reiniciado, y ha detenido todos los suministros. El fallo suena al volumen más alto y con vibración.':
      'The pump has detected a system error, or one of its processors has restarted, and has stopped all delivery. The failure sounds at the highest volume and with vibration.',
  'fallo, error, codigo de fallo, reinicio, reseteo':
      'failure, error, failure code, restart, reset',
  'Anota el número de código de fallo que sale en la pantalla.':
      'Write down the failure code number shown on the screen.',
  'Pulsa Silenciar alarma (la pantalla de fallo se queda aunque la silencies).':
      'Press Silence alarm (the failure screen stays even if you silence it).',
  'Llama al servicio de atención al cliente y dales el código.':
      'Call customer support and give them the code.',
  'No dependas de la bomba mientras tanto: mide tu glucosa y actúa como te haya indicado tu equipo médico.':
      'Do not rely on the pump in the meantime: check your glucose and act as your medical team has told you.',
  'Has dejado algo a medias': 'You left something half done',
  'La bomba avisa si empiezas un bolo o un régimen temporal y no lo terminas en 90 segundos, o si dejas a medias un cambio de cartucho, un llenado de tubo o de cánula (3 minutos) o una configuración (5 minutos).':
      'The pump warns you if you start a bolus or a temporary rate and don\'t finish it within 90 seconds, or if you leave a cartridge change, a tubing or cannula fill (3 minutes) or a setup (5 minutes) half done.',
  'incompleto, a medias, bolo incompleto, no terminado':
      'incomplete, half done, incomplete bolus, not finished',
  'Pulsa OK: vuelves a la pantalla donde lo dejaste.':
      'Press OK: you go back to the screen where you left it.',
  'Termina el proceso, o cancélalo si ya no lo quieres.':
      'Finish the process, or cancel it if you no longer want it.',
  'No dejes a medias un cambio de cartucho: mientras tanto no recibes insulina.':
      'Don\'t leave a cartridge change half done: meanwhile you are not getting insulin.',
  'Aviso de límite de bolo o de basal': 'Bolus or basal limit notice',
  'Has pedido un bolo mayor que tu límite de bolo máximo (o más de lo previsto en la última hora), o un régimen temporal que supera tu límite de basal máxima o queda por debajo de la mitad de tu basal más baja.':
      'You asked for a bolus larger than your maximum bolus limit (or more than expected in the last hour), or a temporary rate that goes above your maximum basal limit or falls below half of your lowest basal.',
  'bolo maximo, basal maxima, basal minima, limite':
      'maximum bolus, maximum basal, minimum basal, limit',
  'Vuelve atrás y ajusta la cantidad, o confírmala solo si estás seguro.':
      'Go back and adjust the amount, or confirm it only if you are sure.',
  'Antes de confirmar, piensa si tus necesidades de insulina han cambiado desde que pediste el bolo.':
      'Before confirming, think about whether your insulin needs have changed since you asked for the bolus.',
  'Con un régimen temporal, pulsa OK para aceptar el valor reducido y revisa tu régimen temporal en el menú Actividad.':
      'With a temporary rate, press OK to accept the reduced value and check your temporary rate in the Activity menu.',
  'Control-IQ: el sensor está fuera de alcance':
      'Control-IQ: the sensor is out of range',
  'El transmisor y la bomba no se comunican, así que la bomba no recibe lecturas. Control-IQ sigue ajustando la insulina durante los primeros 20 minutos y después vuelve a la basal de tu perfil.':
      'The transmitter and the pump are not communicating, so the pump is not receiving readings. Control-IQ keeps adjusting insulin for the first 20 minutes and then goes back to your profile\'s basal.',
  'fuera de limites, sin senal, no conecta, control iq':
      'out of range, no signal, not connecting, control iq',
  'Acerca la bomba y el transmisor, o quita lo que haya entre ellos.':
      'Bring the pump and the transmitter closer, or remove whatever is between them.',
  'Control-IQ prevé una glucosa baja': 'Control-IQ predicts low glucose',
  'Control-IQ predice que tu glucosa estará por debajo de 70 mg/dL (80 si usas la función Ejercicio) en los próximos 15 minutos.':
      'Control-IQ predicts your glucose will be below 70 mg/dL (80 if you use the Exercise feature) in the next 15 minutes.',
  'hipo, baja, prediccion, control iq, nivel bajo':
      'hypo, low, prediction, control iq, low level',
  'Toma hidratos de carbono de acción rápida y mide tu glucosa.':
      'Take fast-acting carbohydrates and check your glucose.',
  'Pulsa OK para cerrar la alerta.': 'Press OK to close the alert.',
  'Control-IQ: glucosa alta que no baja':
      'Control-IQ: high glucose that isn\'t coming down',
  'Control-IQ ha subido la insulina, pero ve una glucosa por encima de 200 mg/dL y no prevé que baje en los próximos 30 minutos.':
      'Control-IQ has increased insulin, but sees a glucose above 200 mg/dL and doesn\'t expect it to come down in the next 30 minutes.',
  'hiper, alta, control iq, nivel alto, no baja':
      'hyper, high, control iq, high level, not coming down',
  'Revisa el cartucho, el tubo y el sitio de infusión.':
      'Check the cartridge, the tubing and the infusion site.',
  'Mide tu glucosa y trata la glucosa alta según te haya indicado tu equipo médico.':
      'Check your glucose and treat the high glucose as your medical team has told you.',
  'Control-IQ: máximo de insulina alcanzado':
      'Control-IQ: maximum insulin reached',
  'La bomba ha dado el máximo de insulina permitido en 2 horas (la mitad de tu dosis diaria total). Control-IQ pausa la insulina un mínimo de 5 minutos y después la reanuda.':
      'The pump has delivered the maximum insulin allowed in 2 hours (half of your total daily dose). Control-IQ pauses insulin for at least 5 minutes and then resumes it.',
  'maximo, insulina maxima, control iq, dosis diaria':
      'maximum, maximum insulin, control iq, daily dose',
  'Si tu glucosa sigue alta, revisa el catéter y consúltalo con tu equipo médico.':
      'If your glucose stays high, check the infusion set and talk to your medical team.',
  'Flujo de insulina bloqueado': 'Insulin flow blocked',
  'La bomba ha detectado que la insulina no pasa: puede ser un bloqueo en el catéter, que el reservorio esté vacío o un fallo al llenar el tubo o la cánula.':
      'The pump has detected that insulin is not getting through: it could be a blockage in the infusion set, an empty reservoir or a failure when filling the tubing or cannula.',
  'oclusion, bloqueo, obstruido, no pasa insulina, flujo bloqueado, reservorio vacio':
      'occlusion, blockage, blocked, no insulin getting through, flow blocked, empty reservoir',
  'Mide tu glucosa y comprueba las cetonas; si hace falta, usa la pluma de respaldo como te haya indicado tu equipo médico.':
      'Check your glucose and check for ketones; if needed, use your backup pen as your medical team has told you.',
  'Quita el catéter y el reservorio.':
      'Remove the infusion set and the reservoir.',
  'En el menú elige Reservorio y equipo y empieza de nuevo con un catéter y un reservorio nuevos.':
      'In the menu choose Reservoir & Set and start again with a new infusion set and reservoir.',
  'Si saltó durante un bolo, mira en el Historial diario cuánto se llegó a poner antes de la alarma.':
      'If it went off during a bolus, check the Daily History for how much was delivered before the alarm.',
  'Pila baja': 'Low battery',
  'A la pila AA le quedan 10 horas o menos. La bomba sigue funcionando con normalidad.':
      'The AA battery has 10 hours or less left. The pump keeps working as normal.',
  'pila baja, poca bateria, pila, bateria baja':
      'low battery, low power, battery, battery low',
  'Cambia la pila AA lo antes posible; si no, la insulina se detendrá.':
      'Change the AA battery as soon as possible; otherwise insulin will stop.',
  'Si la bomba está poniendo un bolo o llenando la cánula, espera a que termine antes de cambiarla.':
      'If the pump is giving a bolus or filling the cannula, wait until it finishes before changing it.',
  'Pila agotada: cámbiala ya': 'Battery empty: change it now',
  'A la pila le queda menos de media hora o ya se ha agotado, y la bomba ha dejado de dar insulina.':
      'The battery has less than half an hour left or has already run out, and the pump has stopped giving insulin.',
  'sin pila, pila agotada, apagada, no enciende':
      'no battery, empty battery, off, won\'t turn on',
  'Quita la pila vieja y pon una pila AA nueva de inmediato para reanudar la insulina.':
      'Remove the old battery and put in a new AA battery immediately to resume insulin.',
  'Sin pila o pila no compatible': 'No battery or incompatible battery',
  'Has quitado la pila, o la que has puesto no es compatible. La bomba ha dejado de dar insulina y se apaga a los 10 minutos si no pones otra. Si pasan más de 10 minutos sin pila, pierde la hora y la fecha.':
      'You have removed the battery, or the one you put in is not compatible. The pump has stopped giving insulin and switches off after 10 minutes if you don\'t put in another one. If more than 10 minutes pass without a battery, it loses the time and date.',
  'insertar pila, pila no compatible, hora perdida, sin bateria':
      'insert battery, incompatible battery, lost time, no battery',
  'Pon una pila AA nueva: la alarma se apaga sola.':
      'Put in a new AA battery: the alarm switches off by itself.',
  'Si la pila no es compatible, quítala y pon otra AA.':
      'If the battery is not compatible, take it out and put in another AA.',
  'Si te sale "¿Reanudar bolo?", mira cuánto del bolo se puso y elige Reanudar o Cancelar.':
      'If you see "Resume bolus?", check how much of the bolus was delivered and choose Resume or Cancel.',
  'Si la bomba ha perdido la hora, pulsa OK e introduce la hora y la fecha.':
      'If the pump has lost the time, press OK and enter the time and date.',
  'Error de la bomba': 'Pump error',
  'La bomba ha tenido un error y tiene que reiniciarse. Según el caso conserva tus ajustes o vuelve a los valores de fábrica.':
      'The pump has had an error and needs to restart. Depending on the case it keeps your settings or goes back to factory values.',
  'error, reinicio, ajustes borrados, revisar ajustes, restaurar ajustes':
      'error, restart, settings deleted, check settings, restore settings',
  'Pulsa OK para reiniciar la bomba.': 'Press OK to restart the pump.',
  'Cuando reinicie, sigue las instrucciones de la pantalla y revisa que tus ajustes son los tuyos; si tenías una copia guardada, usa Restaurar ajustes.':
      'When it restarts, follow the on-screen instructions and check that your settings are yours; if you had a saved copy, use Restore Settings.',
  'Si estaba poniendo un bolo o llenando la cánula, mira el Historial diario y valora si necesitas insulina.':
      'If it was giving a bolus or filling the cannula, check the Daily History and assess whether you need insulin.',
  'Si se repite a menudo, anota el código de error de la pantalla y llama al soporte técnico de 24 horas.':
      'If it keeps happening, write down the error code on the screen and call 24-hour technical support.',
  'Error crítico de la bomba': 'Critical pump error',
  'La bomba tiene un fallo que no se puede resolver (por ejemplo, un problema mecánico) y no puede dar insulina. Suena la sirena.':
      'The pump has a failure that cannot be resolved (for example, a mechanical problem) and cannot give insulin. The siren sounds.',
  'critico, sirena, no funciona, averia, fallo grave':
      'critical, siren, not working, breakdown, serious failure',
  'Desconecta el equipo de infusión de tu cuerpo y deja de usar la bomba.':
      'Disconnect the infusion set from your body and stop using the pump.',
  'Usa otra forma de dar la insulina (pluma) como te haya indicado tu equipo médico.':
      'Use another way of giving insulin (pen) as your medical team has told you.',
  'Mide tu glucosa y trátala si hace falta.':
      'Check your glucose and treat it if needed.',
  'Anota el código de error de la pantalla y llama al soporte técnico de 24 horas.':
      'Write down the error code on the screen and call 24-hour technical support.',
  'Límite de entrega superado': 'Delivery limit exceeded',
  'La bomba ha parado la insulina porque se ha alcanzado el límite por hora (según tu bolo máximo y tu basal máxima). Si saltó durante un bolo, ese bolo se cancela.':
      'The pump has stopped insulin because the hourly limit has been reached (based on your maximum bolus and maximum basal). If it went off during a bolus, that bolus is cancelled.',
  'limite, entrega detenida, bolo maximo, basal maxima':
      'limit, delivery stopped, maximum bolus, maximum basal',
  'Elige Reanudar basal.': 'Choose Resume Basal.',
  'Mira el Historial de bolos y vuelve a valorar tus necesidades de insulina.':
      'Check the Bolus History and reassess your insulin needs.',
  'Sigue vigilando tu glucosa.': 'Keep monitoring your glucose.',
  'Suspensión automática': 'Automatic suspend',
  'La bomba ha parado la insulina porque no has pulsado ningún botón durante el tiempo que configuraste.':
      'The pump has stopped insulin because you have not pressed any button for the time you set.',
  'auto suspend, suspendida, parada, sin tocar':
      'auto suspend, suspended, stopped, not touched',
  'Elige Reanudar basal para apagar la alarma y volver a dar insulina.':
      'Choose Resume Basal to switch off the alarm and start giving insulin again.',
  'Insulina activa a cero': 'Active insulin at zero',
  'La bomba muestra 0 de insulina activa porque la has borrado o porque se ha reiniciado. La insulina anterior ya no cuenta en los cálculos del asistente de bolo.':
      'The pump shows 0 active insulin because you cleared it or because it restarted. The previous insulin no longer counts in the bolus wizard calculations.',
  'insulina activa, iob, reset, asistente de bolo':
      'active insulin, iob, reset, bolus wizard',
  'Antes de ponerte un bolo, mira en el Historial diario cuándo y cuánto te has puesto.':
      'Before giving yourself a bolus, check the Daily History for when and how much you took.',
  'No te fíes de la insulina activa que muestre la bomba hasta que tu equipo médico te diga cuánto esperar: podrías ponerte demasiada.':
      'Don\'t rely on the active insulin the pump shows until your medical team tells you how long to wait: you could give yourself too much.',
  'Bolo interrumpido o no entregado': 'Bolus interrupted or not delivered',
  'Un bolo se ha cancelado: pasaron 30 segundos sin confirmarlo, se quedó sin pila o la bomba tuvo un error durante la entrega.':
      'A bolus has been cancelled: 30 seconds passed without confirming it, the battery ran out or the pump had an error during delivery.',
  'bolo cancelado, bolo no entregado, reanudar bolo':
      'cancelled bolus, bolus not delivered, resume bolus',
  'Pulsa OK y mira en el mensaje cuánto del bolo se llegó a poner.':
      'Press OK and check in the message how much of the bolus was delivered.',
  'Si te sale "¿Reanudar bolo?", elige Reanudar para terminarlo o Cancelar. Solo se puede reanudar dentro de los 10 minutos siguientes.':
      'If you see "Resume bolus?", choose Resume to finish it or Cancel. You can only resume within the next 10 minutes.',
  'Si querías ponerte el bolo, mide tu glucosa y vuelve a programarlo.':
      'If you wanted the bolus, check your glucose and program it again.',
  'Queda poca insulina en el reservorio':
      'Little insulin left in the reservoir',
  'El reservorio está bajo según el aviso que configuraste, o el nivel estimado ha llegado a cero.':
      'The reservoir is low according to the notice you set, or the estimated level has reached zero.',
  'poca insulina, reservorio bajo, queda poco, reservorio':
      'low insulin, low reservoir, running low, reservoir',
  'Cambia el reservorio pronto. Si no lo cambias, saltará un segundo aviso cuando quede la mitad de lo previsto.':
      'Change the reservoir soon. If you don\'t, a second notice will appear when half of the expected amount is left.',
  'Cuando vayas a cambiarlo, en el menú elige Reservorio y equipo.':
      'When you are ready to change it, choose Reservoir & Set in the menu.',
  'No se detecta el reservorio': 'Reservoir not detected',
  'No hay reservorio en la bomba o no está bien encajado.':
      'There is no reservoir in the pump or it is not properly seated.',
  'sin reservorio, reservorio mal puesto, no detecta':
      'no reservoir, badly placed reservoir, not detected',
  'Comprueba que el reservorio está lleno de insulina.':
      'Check that the reservoir is filled with insulin.',
  'Elige Reservorio y equipo y, cuando te lo pida, confirma que está bien puesto y bloqueado.':
      'Choose Reservoir & Set and, when prompted, confirm that it is properly placed and locked.',
  'Carga del reservorio incompleta o llenado de más':
      'Incomplete reservoir load or overfilling',
  'La bomba no ha terminado de cargar el reservorio, o de llenar el tubo o la cánula: ha pasado la cantidad esperada sin ver insulina, o ha habido un error al rebobinar. La pantalla ¿Llenar cánula? también avisa si lleva 15 minutos abierta.':
      'The pump has not finished loading the reservoir, or filling the tubing or cannula: the expected amount has passed without seeing insulin, or there was an error while rewinding. The Fill cannula? screen also warns you if it has been open for 15 minutes.',
  'cebar, llenar canula, gotas, carga incompleta, rebobinar, llenado':
      'prime, fill cannula, drops, incomplete load, rewind, filling',
  'Si te pregunta si ves gotas en la punta del tubo, elige Sí si las ves y No si no.':
      'If it asks whether you see drops at the tip of the tubing, choose Yes if you do and No if you don\'t.',
  'Si no hay gotas: quita el reservorio, mira que aún tenga insulina, comprueba que el tubo no está doblado y repite Reservorio y equipo.':
      'If there are no drops: remove the reservoir, check that it still has insulin, check that the tubing is not kinked and repeat Reservoir & Set.',
  'Si te pregunta por la cánula, elige Llenar (con la cantidad que indica la caja de tu catéter) o Hecho si tu catéter no necesita llenarla.':
      'If it asks about the cannula, choose Fill (with the amount shown on your infusion set\'s box) or Done if your infusion set doesn\'t need it filled.',
  'Si vuelve a saltar, cambia el catéter. Si se repite a menudo, llama al soporte técnico de 24 horas.':
      'If it goes off again, change the infusion set. If it keeps happening, call 24-hour technical support.',
  'Botón atascado': 'Stuck button',
  'La bomba ha detectado un botón pulsado durante más de 3 minutos. En un avión, el cambio de presión puede atascar los botones hasta 45 minutos.':
      'The pump has detected a button pressed for more than 3 minutes. On a plane, the pressure change can stick the buttons for up to 45 minutes.',
  'boton, atascado, avion, pulsado': 'button, stuck, plane, pressed',
  'Pulsa OK para apagar la alarma.': 'Press OK to switch off the alarm.',
  'En un avión, espera a que se arregle sola, o quita la tapa de la pila y vuelve a ponerla.':
      'On a plane, wait for it to sort itself out, or remove the battery cap and put it back on.',
  'Si vuelve a saltar, llama al soporte técnico de 24 horas.':
      'If it goes off again, call 24-hour technical support.',
  'Si no puedes quitar la alarma, piensa en otra forma de dar la insulina: la bomba no está funcionando.':
      'If you can\'t clear the alarm, think of another way of giving insulin: the pump is not working.',
  'Basal demasiado alta': 'Basal too high',
  'La bomba detecta que un patrón de basal en modo manual da mucha más insulina de la que sueles necesitar.':
      'The pump detects that a basal pattern in manual mode gives much more insulin than you usually need.',
  'basal alta, patron basal, demasiada insulina':
      'high basal, basal pattern, too much insulin',
  'Revisa todos tus patrones de basal con tu equipo médico.':
      'Review all your basal patterns with your medical team.',
  'Puedes posponer el aviso, pero volverá a salir si no se resuelve.':
      'You can postpone the notice, but it will come back if it isn\'t resolved.',
  'La bomba ha parado la insulina porque tu glucosa está en el límite bajo o se acerca a él (función Suspender antes de bajo o Suspender en bajo, en modo manual). La reanuda sola como mucho a las 2 horas.':
      'The pump has stopped insulin because your glucose is at the low limit or approaching it (Suspend before low or Suspend on low feature, in manual mode). It resumes by itself after 2 hours at most.',
  'suspension, hipo, suspender antes de bajo, suspender en bajo, parada por baja':
      'suspension, hypo, suspend before low, suspend on low, stopped for low',
  'Mide tu glucosa y, si hace falta, trátala como te haya indicado tu equipo médico.':
      'Check your glucose and, if needed, treat it as your medical team has told you.',
  'Cuando la bomba reanude la insulina te lo avisa: vuelve a medir tu glucosa.':
      'The pump tells you when it resumes insulin: check your glucose again.',
  'Si a las 2 horas sigue por debajo del límite, la alarma sale de nuevo: vuelve a medir.':
      'If after 2 hours it is still below the limit, the alarm goes off again: check again.',
  'Pide ayuda de emergencia': 'Ask for emergency help',
  'La bomba está parada por glucosa baja y no has respondido a la alarma en 10 minutos. Puede ser una emergencia.':
      'The pump is stopped because of low glucose and you have not responded to the alarm within 10 minutes. It may be an emergency.',
  'emergencia, ayuda, 112, inconsciente, llamar':
      'emergency, help, 112, unconscious, call',
  'Llama al 112 o pide ayuda de inmediato.':
      'Call 112 or ask for help immediately.',
  'Si estás en condiciones, toma hidratos de carbono de acción rápida.':
      'If you are able to, take fast-acting carbohydrates.',
  'Toca Descartar cuando la situación esté controlada.':
      'Tap Dismiss once the situation is under control.',
  'SmartGuard pide una glucemia': 'SmartGuard asks for a blood glucose reading',
  'SmartGuard necesita que introduzcas una glucemia (medida con el dedo): lleva mucho rato dando la insulina máxima o mínima, o tiene que comprobar que el sensor es fiable.':
      'SmartGuard needs you to enter a blood glucose reading (measured with your finger): it has been giving the maximum or minimum insulin for a long time, or it has to check that the sensor is reliable.',
  'smartguard, introducir glucemia, modo automatico, bg':
      'smartguard, enter blood glucose, automatic mode, bg',
  'Lávate las manos, mide con el medidor e introduce el valor para volver al modo automático.':
      'Wash your hands, measure with the meter and enter the value to return to automatic mode.',
  'Sigue las indicaciones de tu equipo médico y vigila tu glucosa.':
      'Follow your medical team\'s instructions and keep an eye on your glucose.',
  'Salida del modo automático (SmartGuard)':
      'Exit from automatic mode (SmartGuard)',
  'La bomba ha salido del modo automático porque se apagó el sensor, llevaba hasta cuatro horas sin lecturas o un aviso de suspensión no se atendió. Ahora sigue tu basal en modo manual.':
      'The pump has left automatic mode because the sensor was switched off, it had spent up to four hours without readings or a suspend notice was not dealt with. It now follows your basal in manual mode.',
  'smartguard, modo manual, automatico, salida':
      'smartguard, manual mode, automatic, exit',
  'Introduce una glucemia medida con el dedo.':
      'Enter a blood glucose reading measured with your finger.',
  'Si la insulina sigue suspendida, reanuda la basal cuando corresponda.':
      'If insulin is still suspended, resume basal when appropriate.',
  'Revisa la lista de comprobación de SmartGuard para volver al modo automático.':
      'Go through the SmartGuard checklist to return to automatic mode.',
  'Han pasado 30 minutos sin señal del sensor, o hay interferencias. Sin señal no tienes lecturas del sensor.':
      '30 minutes have passed without a sensor signal, or there is interference. Without a signal you have no sensor readings.',
  'no conecta, sin senal, interferencia, comprobar conexion, sin lecturas':
      'not connecting, no signal, interference, check connection, no readings',
  'Acerca la bomba al sensor (con Guardian 4, al transmisor) y pulsa OK. La bomba puede tardar hasta 15 minutos en encontrar la señal.':
      'Bring the pump close to the sensor (with Guardian 4, to the transmitter) and press OK. The pump can take up to 15 minutes to find the signal.',
  'Aléjate de aparatos electrónicos que puedan interferir.':
      'Move away from electronic devices that could interfere.',
  'Con Guardian 4, comprueba que el transmisor y el sensor están bien conectados. Si no lo están, o el sensor no está bien insertado, cambia el sensor.':
      'With Guardian 4, check that the transmitter and the sensor are properly connected. If they are not, or the sensor is not properly inserted, change the sensor.',
  'Si no la encuentra en 15 minutos o sale "Señal del sensor no encontrada", llama al soporte técnico de 24 horas.':
      'If it can\'t find it within 15 minutes or "Sensor signal not found" appears, call 24-hour technical support.',
  'Cambia el sensor': 'Change the sensor',
  'La bomba indica que el sensor no funciona bien y no se puede arreglar: puede haber fallado la calibración dos veces seguidas, el sensor puede no estar bien insertado o tener un problema.':
      'The pump indicates that the sensor is not working properly and it can\'t be fixed: the calibration may have failed twice in a row, the sensor may not be properly inserted or it may have a problem.',
  'cambiar sensor, sensor no funciona, sensor mal puesto':
      'change sensor, sensor not working, sensor badly placed',
  'Quita el sensor y pon uno nuevo (mira la guía de cambio de sensor de esta app).':
      'Remove the sensor and put in a new one (see this app\'s sensor change guide).',
  'Si el problema sigue con el sensor nuevo, llama al soporte técnico de 24 horas.':
      'If the problem continues with the new sensor, call 24-hour technical support.',
  'Calibración no aceptada o introduce una glucemia':
      'Calibration not accepted or enter a blood glucose reading',
  'El sistema usa cada glucemia que introduces para calibrar el sensor. No ha podido usar la última o te pide una nueva. Solo vale un valor entre 50 y 400 mg/dL.':
      'The system uses every blood glucose reading you enter to calibrate the sensor. It could not use the last one or it is asking for a new one. Only a value between 50 and 400 mg/dL is valid.',
  'calibrar, calibracion, introducir glucemia, medidor':
      'calibrate, calibration, enter blood glucose, meter',
  'Lávate y sécate bien las manos y vuelve a medir con el dedo, esperando al menos 30 minutos desde la anterior.':
      'Wash and dry your hands well and measure again with your finger, waiting at least 30 minutes since the last one.',
  'Comprueba que el valor era correcto: no debe diferir demasiado de la última lectura del sensor.':
      'Check that the value was correct: it should not differ too much from the last sensor reading.',
  'Introdúcelo antes de la hora que indica la bomba, para no perder las lecturas.':
      'Enter it before the time the pump shows, so you don\'t lose readings.',
  'Si falla también la segunda vez, saldrá "Cambiar sensor".':
      'If it also fails the second time, "Change sensor" will appear.',
  'Sensor calentando o actualizándose': 'Sensor warming up or updating',
  'Un sensor nuevo tarda un tiempo en dar lecturas (con Guardian 4, unas 2 horas). También puede haber una pausa temporal mientras el sensor hace comprobaciones de calidad: no hace falta cambiarlo.':
      'A new sensor takes a while to give readings (with Guardian 4, about 2 hours). There can also be a temporary pause while the sensor does quality checks: you don\'t need to change it.',
  'calentamiento, actualizando, sin lecturas, iniciando, warm up':
      'warm-up, updating, no readings, starting, warm up',
  'Pulsa OK y sigue las instrucciones de la pantalla.':
      'Press OK and follow the instructions on the screen.',
  'Espera: las lecturas pueden tardar hasta 3 horas en volver.':
      'Wait: readings can take up to 3 hours to come back.',
  'Mientras tanto, usa el medidor de glucosa para decidir tu tratamiento.':
      'In the meantime, use the glucose meter to decide your treatment.',
  'Si la bomba dice que no ha empezado el calentamiento y el sensor está puesto, cámbialo si han pasado más de 30 minutos.':
      'If the pump says warm-up has not started and the sensor is on, change it if more than 30 minutes have passed.',
  'El sensor termina pronto, ha caducado o el transmisor no tiene batería':
      'Sensor ending soon, expired, or transmitter has no battery',
  'El sensor llega al final de su vida útil: Simplera Sync dura hasta 6 días más 24 horas de gracia (en las que sigue funcionando igual) y Guardian 4, hasta 7 días. Con Guardian 4, el transmisor también avisa cuando hay que recargarlo.':
      'The sensor reaches the end of its life: Simplera Sync lasts up to 6 days plus 24 hours of grace (during which it keeps working the same) and Guardian 4 up to 7 days. With Guardian 4, the transmitter also warns you when it needs recharging.',
  'sensor caducado, fin de sensor, periodo de gracia, bateria transmisor, recargar transmisor':
      'expired sensor, end of sensor, grace period, transmitter battery, recharge transmitter',
  'Ten un sensor de repuesto preparado y cámbialo cuando toque (mira la guía de cambio de sensor).':
      'Have a spare sensor ready and change it when the time comes (see the sensor change guide).',
  'Si tienes Guardian 4 y el transmisor avisa de batería baja, recárgalo lo antes posible: con la batería agotada no hay lecturas.':
      'If you have Guardian 4 and the transmitter warns of low battery, recharge it as soon as possible: with a flat battery there are no readings.',
  'Glucosa baja: alarma que no se puede quitar':
      'Low glucose: alarm that can\'t be turned off',
  'La lectura del sensor está por debajo de 64 mg/dL. Esta alarma es de fábrica: no se puede silenciar ni desactivar, y no suspende la insulina por sí sola.':
      'The sensor reading is below 64 mg/dL. This alarm is factory-set: it can\'t be silenced or turned off, and it doesn\'t suspend insulin by itself.',
  'hipo, baja, hipoglucemia, alarma baja, bajada':
      'hypo, low, hypoglycemia, low alarm, drop',
  'Mide tu glucosa y trátala como te haya indicado tu equipo médico.':
      'Check your glucose and treat it as your medical team has told you.',
  'Pulsa OK para quitar la alarma.': 'Press OK to clear the alarm.',
  'Si tú o quien cuidas tiene entre 7 y 13 años, no te fíes solo del sensor a estos niveles: confirma con el medidor.':
      'If you or the person you care for is between 7 and 13 years old, don\'t rely on the sensor alone at these levels: confirm with the meter.',
  'Aviso de glucosa alta, baja o cambiando rápido':
      'Alert for high glucose, low glucose or rapid change',
  'El sensor marca una glucosa en el límite (o cerca) de lo que configuraste, subiendo rápido, o por encima de 250 mg/dL durante más de 3 horas.':
      'The sensor shows a glucose at (or near) the limit you set, rising quickly, or above 250 mg/dL for more than 3 hours.',
  'hiper, alta, baja, subida rapida, alerta glucosa':
      'hyper, high, low, rapid rise, glucose alert',
  'Pulsa OK y mide tu glucosa.': 'Press OK and check your glucose.',
  'Si lleva más de 3 horas alta, revisa el catéter y comprueba las cetonas.':
      'If it has been high for more than 3 hours, check the infusion set and check for ketones.',
  'Oclusión (vía de infusión bloqueada)': 'Occlusion (infusion line blocked)',
  'La vía de infusión está bloqueada (adaptador, tubo o cánula). Al quitarse el bloqueo de golpe, podría entrar de golpe insulina en tu cuerpo, por eso hay que desconectarse.':
      'The infusion line is blocked (adapter, tubing or cannula). When the blockage suddenly clears, a rush of insulin could enter your body, which is why you must disconnect.',
  'Cambia el catéter y llena el tubo (cebar) con la cantidad que indica su caja.':
      'Change the infusion set and fill the tubing (prime) with the amount shown on its box.',
  'Si el bloqueo salta otra vez al llenar el catéter nuevo, cambia también el cartucho y vuelve a llenar.':
      'If the blockage goes off again when filling the new infusion set, also change the cartridge and fill again.',
  'Si sigue saltando aun con cartucho nuevo, la bomba está defectuosa: contacta con el servicio de atención al cliente.':
      'If it keeps going off even with a new cartridge, the pump is faulty: contact customer service.',
  'Nivel de cartucho bajo': 'Low cartridge level',
  'Es una advertencia: con lo que queda en el cartucho no llega para las próximas 12 horas de basal y el bolo en curso. Si no lo cambias, pasará a la alarma de cartucho vacío.':
      'It is a warning: what is left in the cartridge is not enough for the next 12 hours of basal and the bolus in progress. If you don\'t change it, it will become the empty cartridge alarm.',
  'poca insulina, queda poco, cartucho bajo, advertencia':
      'low insulin, running low, low cartridge, warning',
  'Confirma la advertencia.': 'Confirm the warning.',
  'Cambia el cartucho lo antes posible (mira la guía de cambio).':
      'Change the cartridge as soon as possible (see the change guide).',
  'Después de retraer la varilla roscada pasaron 5 minutos sin llenar el tubo (cebar), o el llenado ha fallado o se ha cancelado. La bomba no te está dando insulina.':
      'After retracting the threaded rod, 5 minutes passed without filling the tubing (priming), or the filling failed or was cancelled. The pump is not giving you insulin.',
  'Comprueba que el cartucho está bien puesto y que el adaptador está bien conectado a la bomba.':
      'Check that the cartridge is properly inserted and that the adapter is properly connected to the pump.',
  'Es una advertencia: la varilla roscada no ha podido retraerse bien. Puede haber suciedad (arena, insulina seca) en el compartimento del cartucho, un fallo mecánico, o algo que ha tocado la varilla.':
      'It is a warning: the threaded rod could not retract properly. There may be dirt (sand, dried insulin) in the cartridge compartment, a mechanical failure, or something has touched the rod.',
  'Saca primero el cartucho y comprueba que no hay suciedad en el compartimento.':
      'First take the cartridge out and check that there is no dirt in the compartment.',
  'No toques la varilla con ningún objeto y repite la retracción.':
      'Don\'t touch the rod with any object and repeat the retraction.',
  'Queda poca batería o batería vacía': 'Low battery or empty battery',
  'Con la advertencia "Queda poca batería" aún puedes usar la bomba al menos dos días. Si no cambias la pila, pasa a la alarma "Batería vacía", que sí detiene la insulina.':
      'With the "Low battery" warning you can still use the pump for at least two days. If you don\'t change the battery, it becomes the "Battery empty" alarm, which does stop insulin.',
  'pila, bateria baja, bateria vacia, poca bateria':
      'battery, low battery, empty battery, little battery',
  'Confirma el aviso.': 'Confirm the notice.',
  'Pon una pila alcalina AAA (LR03) nueva cuanto antes.':
      'Put in a new AAA (LR03) alkaline battery as soon as possible.',
  'Si ya es la alarma de batería vacía, mide tu glucosa: puede que hayas estado sin insulina de fondo.':
      'If it is already the empty battery alarm, check your glucose: you may have been without background insulin.',
  'Cargar la batería interna recargable':
      'Charge the internal rechargeable battery',
  'La batería interna recargable de la bomba se ha descargado por un uso intenso. Se cancelan las entregas en curso: bolos, basal temporal y basal.':
      'The pump\'s internal rechargeable battery has run down from heavy use. Deliveries in progress are cancelled: boluses, temporary basal and basal.',
  'bateria interna, recargable, uso intenso, cargar':
      'internal battery, rechargeable, heavy use, charge',
  'Confirma la alarma: la batería interna se carga con la pila alcalina que llevas puesta (unos 20 minutos).':
      'Confirm the alarm: the internal battery charges from the alkaline battery you have inserted (about 20 minutes).',
  'Después de confirmar, la bomba te avisa de los bolos y de la basal temporal que se han cancelado.':
      'After confirming, the pump tells you about the boluses and temporary basal that were cancelled.',
  'Mide tu glucosa y vuelve a programar lo que necesites.':
      'Check your glucose and reprogram what you need.',
  'Bomba parada más de una hora': 'Pump stopped for more than an hour',
  'Es una advertencia: la bomba lleva más de una hora en modo de parada, sin dar insulina.':
      'It is a warning: the pump has been in stop mode for more than an hour, without giving insulin.',
  'parada, stop, modo parada, una hora': 'stopped, stop, stop mode, one hour',
  'Si ya no quieres la bomba parada, ponla en marcha de nuevo.':
      'If you no longer want the pump stopped, start it again.',
  'Bolo o basal temporal cancelados': 'Bolus or temporary basal cancelled',
  'Es una advertencia: un bolo o una basal temporal se han cancelado antes de tiempo por una alarma o porque pusiste la bomba en modo de parada, o la basal temporal ha terminado.':
      'It is a warning: a bolus or a temporary basal was cancelled early because of an alarm or because you put the pump in stop mode, or the temporary basal has ended.',
  'bolo cancelado, basal temporal, cancelado':
      'cancelled bolus, temporary basal, cancelled',
  'Mira en los datos de terapia cuánta insulina se llegó a poner.':
      'Check the therapy data for how much insulin was delivered.',
  'Si quieres seguir con el bolo o con la basal temporal, tienes que volver a programarlos.':
      'If you want to continue with the bolus or the temporary basal, you have to program them again.',
  'Error de conexión Bluetooth': 'Bluetooth connection error',
  'Es una advertencia: pasaron más de 30 segundos al escribir el código de emparejamiento, lo escribiste mal, o se cortó una conexión Bluetooth activa.':
      'It is a warning: more than 30 seconds passed while typing the pairing code, you typed it wrong, or an active Bluetooth connection was cut.',
  'bluetooth, emparejar, codigo, conexion': 'bluetooth, pair, code, connection',
  'Vuelve a emparejar la bomba con el dispositivo.':
      'Pair the pump with the device again.',
  'Se ha caído, mojado o ensuciado la bomba':
      'The pump has been dropped, got wet or dirty',
  'Una caída, agua en la pila o el cartucho, burbujas de aire o suciedad en el compartimento pueden alterar la administración de insulina, aunque no salte ninguna alarma.':
      'A fall, water in the battery or cartridge, air bubbles or dirt in the compartment can affect insulin delivery, even if no alarm goes off.',
  'caida, agua, mojada, burbujas, suciedad, golpe':
      'fall, water, wet, bubbles, dirt, knock',
  'Mide tu glucosa y pon la bomba en modo de parada.':
      'Check your glucose and put the pump in stop mode.',
  'Si hay agua: saca la pila o el cartucho y seca el compartimento con un paño de algodón seco. Si hay suciedad, quítala golpeando suavemente la bomba contra la palma de la mano (nunca contra una superficie dura) y limpia con un paño húmedo y luego seco.':
      'If there is water: take out the battery or the cartridge and dry the compartment with a dry cotton cloth. If there is dirt, remove it by gently tapping the pump against the palm of your hand (never against a hard surface) and clean with a damp cloth and then a dry one.',
  'Después de una caída, cambia el cartucho y el catéter: puede haber microgrietas que no se ven.':
      'After a fall, change the cartridge and the infusion set: there may be micro-cracks you can\'t see.',
  'Si hay burbujas de aire, llena de nuevo el tubo sin burbujas desconectado de tu cuerpo.':
      'If there are air bubbles, fill the tubing again without bubbles, disconnected from your body.',
  'Si la bomba tiene daños visibles o no funciona, contacta con el servicio de atención al cliente.':
      'If the pump has visible damage or doesn\'t work, contact customer service.',
  'Bloqueo detectado en el Pod': 'Blockage detected in the Pod',
  'El sistema ha detectado un bloqueo (oclusión) en la cánula del Pod y ha detenido la administración de insulina. Es una alarma de peligro.':
      'The system has detected a blockage (occlusion) in the Pod\'s cannula and has stopped insulin delivery. It is a hazard alarm.',
  'oclusion, bloqueo, no pasa insulina, canula, peligro':
      'occlusion, blockage, no insulin getting through, cannula, hazard',
  'Quita el Pod.': 'Remove the Pod.',
  'Pon un Pod nuevo (mira la guía de cambio de Pod).':
      'Put on a new Pod (see the Pod change guide).',
  'Reconoce la alarma en la aplicación.': 'Acknowledge the alarm in the app.',
  'Error del Pod': 'Pod error',
  'El sistema ha detectado un error del Pod y ha detenido la administración de insulina. Es una alarma de peligro.':
      'The system has detected a Pod error and has stopped insulin delivery. It is a hazard alarm.',
  'fallo pod, error, alarma de peligro, pitido':
      'pod failure, error, hazard alarm, beep',
  'El Pod ha llegado al final de su vida útil. Primero avisa una vez por hora (advertencia) y, si no lo cambias, deja de dar insulina (alarma de peligro).':
      'The Pod has reached the end of its life. First it warns you once an hour (warning) and, if you don\'t change it, it stops giving insulin (hazard alarm).',
  'caducado, expirado, pod viejo, fin de vida':
      'expired, out of date, old pod, end of life',
  'Cambia el Pod pronto: mira la guía de cambio de Pod de esta app.':
      'Change the Pod soon: see this app\'s Pod change guide.',
  'Si ya ha saltado la alarma de peligro, quita el Pod: ha dejado de dar insulina.':
      'If the hazard alarm has already gone off, remove the Pod: it has stopped giving insulin.',
  'El Pod se queda sin insulina': 'The Pod is running out of insulin',
  'Con el aviso "Pod con insulina baja", la insulina del Pod está por debajo del valor que pusiste en Ajustes. Si lo ignoras, pasa a la alarma de peligro "Pod sin insulina": está vacío y la insulina se ha detenido.':
      'With the "Pod low on insulin" notice, the Pod\'s insulin is below the value you set in Settings. If you ignore it, it becomes the "Pod out of insulin" hazard alarm: it is empty and insulin has stopped.',
  'poca insulina, vacio, sin insulina, insulina baja':
      'low insulin, empty, no insulin, insulin low',
  'Si es el aviso, cambia el Pod pronto para que no llegue a la alarma de peligro.':
      'If it is the notice, change the Pod soon so it doesn\'t reach the hazard alarm.',
  'Si ya está vacío, quita el Pod y pon uno nuevo.':
      'If it is already empty, remove the Pod and put on a new one.',
  'Apagado del Pod': 'Pod switch-off',
  'Configuraste una hora de apagado del Pod. Antes de que llegue, la aplicación te avisa; si no respondes, el Pod deja de dar insulina (alarma de peligro).':
      'You set a Pod switch-off time. Before it arrives, the app warns you; if you don\'t respond, the Pod stops giving insulin (hazard alarm).',
  'apagado, hora de apagado, pod apagado, sin respuesta':
      'switch-off, switch-off time, pod off, no response',
  'Si es el aviso, toca OK para reconocerlo y evitar que el Pod se apague.':
      'If it is the notice, tap OK to acknowledge it and stop the Pod from switching off.',
  'Si ya ha saltado la alarma de peligro, quita el Pod y pon uno nuevo.':
      'If the hazard alarm has already gone off, remove the Pod and put on a new one.',
  'Error de la aplicación Omnipod 5': 'Omnipod 5 app error',
  'El sistema ha detectado un error en la aplicación. En algunos casos el Controlador se reinicia y se borran todos los ajustes.':
      'The system has detected an error in the app. In some cases the Controller restarts and all settings are deleted.',
  'error aplicacion, controlador, memoria, reinicio':
      'app error, controller, memory, restart',
  'Si el aviso dice que quites el Pod, quítalo y pon uno nuevo.':
      'If the notice says to remove the Pod, remove it and put on a new one.',
  'Si el Controlador se reinicia y se borran los ajustes, vuelve a introducirlos con tu equipo médico.':
      'If the Controller restarts and the settings are deleted, enter them again with your medical team.',
  'Reinicia la insulina': 'Restart insulin',
  'Ha terminado el tiempo que pusiste para pausar la insulina.':
      'The time you set to pause insulin has ended.',
  'pausa, iniciar insulina, pausada, reanudar':
      'pause, start insulin, paused, resume',
  'Toca Iniciar la insulina para reanudarla y evitar la hiperglucemia.':
      'Tap Start insulin to resume it and avoid hyperglycemia.',
  'Glucosa baja urgente': 'Urgent low glucose',
  'La glucosa del sensor es de 55 mg/dL o menos.':
      'The sensor glucose is 55 mg/dL or below.',
  'hipo, baja, urgente, hipoglucemia, 55':
      'hypo, low, urgent, hypoglycemia, 55',
  'Considera comer hidratos de carbono de acción rápida para tratar la hipoglucemia.':
      'Consider having fast-acting carbohydrates to treat the hypoglycemia.',
  'Aviso del modo automático': 'Automatic mode notice',
  'En modo automático, el Pod no ha recibido valores del sensor durante una hora, o el sistema no ve que tu glucosa cambie como esperaba y te pide que revises el sensor, el Pod y tu glucosa (avisos "Faltan los valores del sensor", "Revise la glucosa en sangre" o "Restricción de entrega automatizada").':
      'In automatic mode, the Pod has not received sensor values for an hour, or the system does not see your glucose changing as expected and asks you to check the sensor, the Pod and your glucose ("Sensor values missing", "Check blood glucose" or "Automated delivery restriction" notices).',
  'modo automatico, automatizado limitado, faltan valores, revise glucosa, restriccion':
      'automatic mode, automated limited, missing values, check glucose, restriction',
  'Comprueba el sensor y el Pod.': 'Check the sensor and the Pod.',
  'Mide tu glucosa con el medidor.': 'Check your glucose with the meter.',
  'Si el aviso lo pide (Restricción de entrega automatizada), cambia a modo manual durante 5 minutos o más para reconocerlo.':
      'If the notice asks for it (Automated delivery restriction), switch to manual mode for 5 minutes or more to acknowledge it.',
  'Sin valores del sensor, el sistema funciona en "Automatizado: Limitado" hasta que vuelvan a llegar.':
      'Without sensor values, the system works in "Automated: Limited" until they arrive again.',
  'Mensajes del sensor en Omnipod 5': 'Sensor messages in Omnipod 5',
  'La aplicación te avisa si el sensor está demasiado frío o caliente, no puede enviar valores por un momento, tiene un error, ha terminado o hay que reemplazarlo, o no se ha podido conectar. Sin sensor, el modo automático no funciona.':
      'The app warns you if the sensor is too cold or too hot, can\'t send values for a moment, has an error, has ended or needs replacing, or could not connect. Without a sensor, automatic mode does not work.',
  'sensor, demasiado frio, demasiado caliente, error del sensor, reemplazar sensor, sin sensor':
      'sensor, too cold, too hot, sensor error, replace sensor, no sensor',
  'Demasiado frío o caliente: muévete a un sitio con una temperatura más suave.':
      'Too cold or too hot: move to a place with a milder temperature.',
  'Problema temporal del sensor: vuelve a comprobarlo en 10 minutos.':
      'Temporary sensor problem: check again in 10 minutes.',
  'Sensor finalizado o "Reemplazar sensor": pon un sensor nuevo (mira la guía de cambio de sensor).':
      'Sensor ended or "Replace sensor": put on a new sensor (see the sensor change guide).',
  'No se pudo conectar: vuelve a intentarlo.': 'Could not connect: try again.',
  'Para usar el modo automático necesitas un sensor y un Pod activo.':
      'To use automatic mode you need a sensor and an active Pod.',
  'Valor bajo urgente': 'Urgent low value',
  'La lectura del sensor es de 55 mg/dL o menos. Es una alerta de seguridad que suena aunque tengas el móvil en silencio.':
      'The sensor reading is 55 mg/dL or below. It is a safety alert that sounds even if your phone is on silent.',
  'Mide tu glucosa con el medidor y trátala ya, como te haya indicado tu equipo médico.':
      'Check your glucose with the meter and treat it right away, as your medical team has told you.',
  'Toma hidratos de carbono de acción rápida (azúcar, zumo…).':
      'Take fast-acting carbohydrates (sugar, juice…).',
  'Valor bajo urgente inminente': 'Imminent urgent low value',
  'Tu glucosa va a llegar a 55 mg/dL o menos en unos 20 minutos, aunque ahora esté dentro de rango. Es una bajada rápida.':
      'Your glucose will reach 55 mg/dL or less in about 20 minutes, even if it is in range now. It is a rapid drop.',
  'bajada rapida, a punto de bajar, inminente, hipo':
      'rapid drop, about to drop, imminent, hypo',
  'Actúa ahora para evitar la bajada: come o bebe hidratos de carbono de acción rápida como te haya enseñado tu equipo médico.':
      'Act now to prevent the drop: eat or drink fast-acting carbohydrates as your medical team has taught you.',
  'Mide tu glucosa y vuelve a medirte a los 15 minutos.':
      'Check your glucose and check again after 15 minutes.',
  'Ojo: si recibes esta alerta, no recibirás la de glucosa baja durante un rato; funcionan juntas.':
      'Note: if you receive this alert, you won\'t receive the low glucose one for a while; they work together.',
  'Alerta de glucosa baja': 'Low glucose alert',
  'La lectura del sensor es igual o menor que el límite bajo que configuraste (por defecto, 70 mg/dL en el G7 y 80 en el G6).':
      'The sensor reading is equal to or below the low limit you set (by default, 70 mg/dL on the G7 and 80 on the G6).',
  'hipo, baja, hipoglucemia, bajada, nivel bajo':
      'hypo, low, hypoglycemia, drop, low level',
  'Alerta de glucosa alta': 'High glucose alert',
  'La lectura del sensor es igual o mayor que el límite alto que configuraste (por defecto, 250 mg/dL en el G7 y 200 en el G6).':
      'The sensor reading is equal to or above the high limit you set (by default, 250 mg/dL on the G7 and 200 on the G6).',
  'hiper, alta, hiperglucemia, subida, nivel alto':
      'hyper, high, hyperglycemia, rise, high level',
  'Glucosa subiendo o bajando rápido': 'Glucose rising or falling quickly',
  'Son avisos opcionales: tu glucosa sube o baja más rápido de lo que configuraste (por ejemplo, 3 mg/dL por minuto o más).':
      'These are optional alerts: your glucose is rising or falling faster than you set (for example, 3 mg/dL per minute or more).',
  'subiendo rapido, bajando rapido, flecha, tendencia':
      'rising fast, falling fast, arrow, trend',
  'Mira la flecha de tendencia y, si hace falta, mide tu glucosa.':
      'Look at the trend arrow and, if needed, check your glucose.',
  'Si la glucosa llega a 55 mg/dL o menos, recibirás la alerta de valor bajo urgente en su lugar.':
      'If your glucose reaches 55 mg/dL or below, you will get the urgent low alert instead.',
  'La lectura no coincide con el medidor o con cómo me siento':
      'The reading doesn\'t match the meter or how I feel',
  'El sensor mide la glucosa del líquido que hay entre las células y el medidor la de la sangre: es normal que no den exactamente el mismo número, sobre todo si la glucosa cambia rápido.':
      'The sensor measures the glucose in the fluid between the cells and the meter measures it in blood: it is normal for them not to give exactly the same number, especially if glucose is changing quickly.',
  'precision, no coincide, diferente, no me fio, lecturas raras, dedo':
      'accuracy, doesn\'t match, different, don\'t trust, odd readings, finger',
  'Lávate las manos con agua y jabón (no con gel desinfectante), sécalas y vuelve a medir con el dedo.':
      'Wash your hands with soap and water (not hand sanitiser), dry them and measure again with your finger.',
  'El primer día del sensor las diferencias pueden ser mayores.':
      'On the first day of the sensor the differences can be bigger.',
  'Si estás tumbado sobre el sensor, la presión puede bajar la lectura: cambia de postura y vuelve a comparar.':
      'If you are lying on the sensor, the pressure can lower the reading: change position and compare again.',
  'Comprueba que las tiras no han caducado y que están bien guardadas.':
      'Check that the test strips have not expired and are stored properly.',
  'Si tus síntomas no coinciden con el sensor, decide con el valor del medidor.':
      'If your symptoms don\'t match the sensor, decide using the meter value.',
  'Pérdida de señal': 'Signal loss',
  'El móvil o el receptor no reciben lecturas del sensor por un momento. Tras unos 20 minutos sin lecturas también suena o vibra. No hay lecturas ni alertas hasta que se arregle.':
      'The phone or the receiver is not getting readings from the sensor for a moment. After about 20 minutes without readings it also sounds or vibrates. There are no readings or alerts until it is fixed.',
  'sin senal, no conecta, bluetooth, sin lecturas':
      'no signal, not connecting, bluetooth, no readings',
  'Usa el medidor de glucosa para decidir tu tratamiento.':
      'Use the glucose meter to decide your treatment.',
  'Apaga y vuelve a encender el Bluetooth del móvil y déjalo encendido. Mantén abierta la app (no la fuerces a cerrar).':
      'Turn the phone\'s Bluetooth off and on again and leave it on. Keep the app open (don\'t force it to close).',
  'Mantén el móvil a menos de 10 metros del sensor, sin nada en medio (paredes, agua) y en el mismo lado del cuerpo.':
      'Keep the phone less than 10 metres from the sensor, with nothing in between (walls, water) and on the same side of the body.',
  'Si no funciona, reinicia el móvil y abre la app. Mantén el móvil con al menos un 20 % de batería.':
      'If it doesn\'t work, restart the phone and open the app. Keep the phone at least 20% charged.',
  'Espera hasta 30 minutos. Si sigue igual, llama al soporte técnico de Dexcom.':
      'Wait up to 30 minutes. If it stays the same, call Dexcom technical support.',
  'Problema temporal del sensor': 'Temporary sensor problem',
  'El sensor no puede medir la glucosa por ahora. Suele pasar durante el primer día, pero puede ocurrir en cualquier momento y casi siempre se arregla solo en menos de 3 horas.':
      'The sensor can\'t measure glucose for now. It usually happens during the first day, but it can happen at any time and almost always fixes itself in under 3 hours.',
  'problema temporal, sin lecturas, no mide, espera':
      'temporary problem, no readings, not measuring, wait',
  'No quites el sensor.': 'Don\'t remove the sensor.',
  'Toca Ayuda en la app para ver más consejos.':
      'Tap Help in the app for more tips.',
  'Si dura más de 3 horas, llama al soporte técnico de Dexcom.':
      'If it lasts more than 3 hours, call Dexcom technical support.',
  'El sensor ha fallado': 'The sensor has failed',
  'Ya no habrá lecturas ni alertas hasta que empieces un sensor nuevo. Puede llegar después de un problema temporal.':
      'There will be no readings or alerts until you start a new sensor. It can come after a temporary problem.',
  'fallo, sensor fallado, extraer sensor, error del sensor':
      'failure, failed sensor, remove sensor, sensor error',
  'Quita el sensor ya: despega el parche por el borde.':
      'Remove the sensor now: peel the patch off from the edge.',
  'Pon y empareja un sensor nuevo (mira la guía de cambio de sensor de esta app).':
      'Put on and pair a new sensor (see this app\'s sensor change guide).',
  'Mientras tanto usa el medidor de glucosa.':
      'In the meantime, use the glucose meter.',
  'Cambia el sensor ahora': 'Change the sensor now',
  'La sesión del sensor (hasta 10 días) y su periodo de gracia de 12 horas han terminado. Ya no habrá lecturas ni alertas hasta que uses un sensor nuevo.':
      'The sensor session (up to 10 days) and its 12-hour grace period have ended. There will be no readings or alerts until you use a new sensor.',
  'sensor caducado, periodo de gracia, fin de sesion, cambiar sensor':
      'expired sensor, grace period, end of session, change sensor',
  'Toca Aceptar y sigue las instrucciones de la pantalla (en el receptor, Iniciar sensor nuevo).':
      'Tap Accept and follow the on-screen instructions (on the receiver, Start new sensor).',
  'Quita el sensor viejo y pon uno nuevo (mira la guía de cambio de sensor).':
      'Remove the old sensor and put on a new one (see the sensor change guide).',
  'Recuerda que el sensor nuevo tarda unos 30 minutos en empezar a dar lecturas.':
      'Remember that the new sensor takes about 30 minutes to start giving readings.',
  'Buscando el sensor (el emparejamiento tarda)':
      'Looking for the sensor (pairing is taking a while)',
  'El emparejamiento suele tardar menos de 5 minutos con el móvil y menos de 10 con el receptor. Si tarda más, prueba estos consejos.':
      'Pairing usually takes less than 5 minutes with the phone and less than 10 with the receiver. If it takes longer, try these tips.',
  'emparejar, buscando, codigo, vincular, no empareja':
      'pair, looking, code, link, won\'t pair',
  'Mantén el móvil cerca del sensor (a menos de 10 metros; el receptor, a menos de 1 metro).':
      'Keep the phone close to the sensor (less than 10 metres; the receiver, less than 1 metre).',
  'Comprueba que el sensor está puesto y que el código de emparejamiento es el del aplicador.':
      'Check that the sensor is on and that the pairing code is the one on the applicator.',
  'Aléjate de otras personas que lleven sensores para evitar interferencias.':
      'Move away from other people wearing sensors to avoid interference.',
  'Recuerda que un sensor solo se empareja con un móvil, un receptor y un reloj. Mantén abierta la app.':
      'Remember that a sensor only pairs with one phone, one receiver and one watch. Keep the app open.',
  'Calibración no utilizada': 'Calibration not used',
  'En el G7 calibrar es opcional. Si sale este aviso, el sistema no ha usado el valor que introdujiste.':
      'On the G7 calibrating is optional. If this notice appears, the system did not use the value you entered.',
  'calibrar, calibracion, medidor, capilar':
      'calibrate, calibration, meter, capillary',
  'Lávate las manos con agua y jabón, sécalas y mide con el dedo.':
      'Wash your hands with soap and water, dry them and measure with your finger.',
  'Introduce el valor antes de que pasen 5 minutos, solo si está entre 40 y 400 mg/dL.':
      'Enter the value within 5 minutes, only if it is between 40 and 400 mg/dL.',
  'Calibra en el móvil o en el receptor, no en los dos.':
      'Calibrate on the phone or on the receiver, not on both.',
  'No calibres si la glucosa cambia rápido o si estás apoyado sobre el sensor.':
      'Don\'t calibrate if glucose is changing quickly or if you are leaning on the sensor.',
  'Comprobación del sistema (error del receptor)':
      'System check (receiver error)',
  'El receptor ha encontrado un error y no recibirás lecturas ni alertas del sensor. Aparece un código de error.':
      'The receiver has found an error and you won\'t receive sensor readings or alerts. An error code appears.',
  'receptor, error, codigo, evaluacion del sistema':
      'receiver, error, code, system evaluation',
  'Anota el código de error que sale en la pantalla.':
      'Write down the error code shown on the screen.',
  'Llama al soporte técnico de Dexcom y dales el código.':
      'Call Dexcom technical support and give them the code.',
  'Sin lecturas del G6': 'No G6 readings',
  'No recibes lecturas del G6 desde hace 20 minutos (en el receptor, aparece como error de sensor). No hay alarma ni alertas de glucosa hasta que se solucione.':
      'You haven\'t received G6 readings for 20 minutes (on the receiver, it appears as a sensor error). There is no alarm or glucose alerts until it is fixed.',
  'sin lecturas, no lecturas, error de sensor, no hay datos':
      'no readings, no readings alert, sensor error, no data',
  'Toca la alerta para ver más información.':
      'Tap the alert for more information.',
  'Comprueba que el transmisor está bien encajado en su soporte.':
      'Check that the transmitter is properly seated in its holder.',
  'Espera: en la app, hasta 3 horas; en el receptor, 30 minutos. Si no se arregla, saldrá "Fallo del sensor": llama al servicio técnico de Dexcom.':
      'Wait: on the app, up to 3 hours; on the receiver, 30 minutes. If it isn\'t fixed, "Sensor failure" will appear: call Dexcom technical service.',
  'Pérdida de señal (G6)': 'Signal loss (G6)',
  'El dispositivo de visualización y el transmisor no se conectan, así que no hay lecturas, alarma ni alertas de glucosa.':
      'The display device and the transmitter are not connecting, so there are no readings, alarm or glucose alerts.',
  'sin senal, perdida de senal, no conecta, bluetooth':
      'no signal, signal loss, not connecting, bluetooth',
  'Usa el medidor de glucosa.': 'Use the glucose meter.',
  'Acerca el transmisor y el móvil o receptor a menos de 6 metros, sin obstáculos (paredes, metales). Bajo el agua, en la ducha o nadando, acércalos aún más.':
      'Bring the transmitter and the phone or receiver within 6 metres of each other, with no obstacles (walls, metal). Underwater, in the shower or swimming, bring them even closer.',
  'En la app: reinicia el móvil. Si sigue, abre los ajustes de Bluetooth, elimina todas las entradas de Dexcom y empareja de nuevo el transmisor.':
      'On the app: restart the phone. If it continues, open the Bluetooth settings, delete all Dexcom entries and pair the transmitter again.',
  'Espera hasta 30 minutos: puede arreglarse solo. Si pasan más, llama al servicio técnico de Dexcom.':
      'Wait up to 30 minutes: it can fix itself. If more time passes, call Dexcom technical service.',
  'Fallo del sensor (G6)': 'Sensor failure (G6)',
  'El sensor ha dejado de funcionar: no hay lecturas, alarma ni alertas.':
      'The sensor has stopped working: there are no readings, alarm or alerts.',
  'fallo, error del sensor, sensor fallado, parar sesion':
      'failure, sensor error, failed sensor, stop session',
  'Antes de parar una sesión antes de tiempo, llama siempre al servicio técnico de Dexcom. Una sesión detenida no se puede reanudar.':
      'Before stopping a session early, always call Dexcom technical service. A stopped session can\'t be resumed.',
  'Para volver a tener lecturas, pon un sensor nuevo e inicia la sesión.':
      'To get readings again, put on a new sensor and start the session.',
  'Si un hilo del sensor se rompe y no lo ves, no intentes sacarlo: consulta a tu equipo médico.':
      'If a sensor wire breaks and you can\'t see it, don\'t try to remove it: consult your medical team.',
  'Transmisor no encontrado': 'Transmitter not found',
  'El transmisor no se ha emparejado con tu móvil o receptor, así que no hay lecturas, alarma ni alertas.':
      'The transmitter has not paired with your phone or receiver, so there are no readings, alarm or alerts.',
  'transmisor, no encontrado, numero de serie, emparejar':
      'transmitter, not found, serial number, pair',
  'Comprueba que el número de serie del transmisor que introdujiste coincide con el de la caja.':
      'Check that the transmitter serial number you entered matches the one on the box.',
  'Asegúrate de que el transmisor está bien encajado en su soporte.':
      'Make sure the transmitter is properly seated in its holder.',
  'Si nada funciona, puede que el sensor esté mal insertado: llama al servicio técnico de Dexcom.':
      'If nothing works, the sensor may be badly inserted: call Dexcom technical service.',
  'Repetir calibración': 'Repeat calibration',
  'El sistema no ha aceptado tu calibración, o el valor estaba fuera de lo esperado. No hay lecturas hasta solucionarlo.':
      'The system has not accepted your calibration, or the value was outside what was expected. There are no readings until it is resolved.',
  'calibrar, calibracion, repetir calibracion, error calibracion':
      'calibrate, calibration, repeat calibration, calibration error',
  'Sigue las instrucciones de la pantalla: te pedirá calibrar de nuevo en 15 minutos.':
      'Follow the on-screen instructions: it will ask you to calibrate again in 15 minutes.',
  'En el receptor, si vuelve a fallar, introduce un valor más y espera 15 minutos.':
      'On the receiver, if it fails again, enter one more value and wait 15 minutes.',
  'Si siguen sin salir lecturas, cambia el sensor y llama al servicio técnico de Dexcom.':
      'If readings still don\'t appear, change the sensor and call Dexcom technical service.',
  'Fin de la sesión del sensor (10 días)':
      'End of the sensor session (10 days)',
  'La sesión del sensor dura 10 días. Recibes avisos 6 horas, 2 horas y 30 minutos antes del final, y sigues recibiendo lecturas hasta entonces.':
      'The sensor session lasts 10 days. You get notices 6 hours, 2 hours and 30 minutes before the end, and you keep receiving readings until then.',
  'fin de sesion, sensor caducado, diez dias, cambiar sensor':
      'end of session, expired sensor, ten days, change sensor',
  'Abre la app (o toca OK en el receptor) para confirmar el aviso.':
      'Open the app (or tap OK on the receiver) to confirm the notice.',
  'Quita el sensor viejo antes de empezar uno nuevo (mira la guía de cambio de sensor).':
      'Remove the old sensor before starting a new one (see the sensor change guide).',
  'Un sensor nuevo tarda unas 2 horas en calentarse antes de dar lecturas.':
      'A new sensor takes about 2 hours to warm up before giving readings.',
  'Batería del transmisor': 'Transmitter battery',
  'La batería del transmisor dura unos 3 meses. Tres semanas antes de agotarse empiezan los avisos con una cuenta atrás; con 10 días o menos no podrás iniciar una sesión nueva. Cuando se agota o falla, suena o vibra.':
      'The transmitter battery lasts about 3 months. Three weeks before it runs out, countdown notices begin; with 10 days or less you won\'t be able to start a new session. When it runs out or fails, it sounds or vibrates.',
  'transmisor, bateria, tres meses, fallo transmisor':
      'transmitter, battery, three months, transmitter failure',
  'Empareja un transmisor nuevo cuando el sistema te lo pida: necesitarás el código del sensor y el número de serie del transmisor.':
      'Pair a new transmitter when the system asks you to: you will need the sensor code and the transmitter serial number.',
  'Espera a que se confirme el emparejamiento antes de insertar el sensor y acoplar el transmisor.':
      'Wait for the pairing to be confirmed before inserting the sensor and attaching the transmitter.',
  'Si usas app y receptor, inicia la sesión en uno antes de emparejar el transmisor con el otro.':
      'If you use the app and the receiver, start the session on one before pairing the transmitter with the other.',
  '"Bajo" o "Alto" en lugar de un número':
      '"Low" or "High" instead of a number',
  'El G6 muestra "Bajo" por debajo de 40 mg/dL y "Alto" por encima de 400 mg/dL. Funciona correctamente.':
      'The G6 shows "Low" below 40 mg/dL and "High" above 400 mg/dL. It is working correctly.',
  'bajo, alto, lo, hi, sin numero': 'low, high, lo, hi, no number',
  'Mide con el medidor y trata la bajada o la subida.':
      'Measure with the meter and treat the low or the high.',
  'Cuando tu glucosa vuelva a estar entre 40 y 400 mg/dL, el G6 mostrará de nuevo las lecturas.':
      'When your glucose is back between 40 and 400 mg/dL, the G6 will show readings again.',
  'El parche se despega o me irrita la piel':
      'The patch comes off or irritates my skin',
  'Si el parche adhesivo no aguanta toda la sesión del sensor, o la piel se irrita, se puede prevenir cuidando la colocación.':
      'If the adhesive patch doesn\'t last the whole sensor session, or the skin gets irritated, it can be prevented by taking care with placement.',
  'parche, adhesivo, se despega, irritacion, alergia, aplicador':
      'patch, adhesive, coming off, irritation, allergy, applicator',
  'Pon el sensor en una zona plana, limpia y completamente seca, sin pliegues de piel ni cerca del cinturón, y con poco vello.':
      'Put the sensor on a flat, clean and completely dry area, without skin folds or near the belt, and with little hair.',
  'Antes de ponerlo, puedes usar un adhesivo cutáneo opcional; después, un cubreparche o cinta médica por encima.':
      'Before putting it on, you can use an optional skin adhesive; afterwards, an overpatch or medical tape on top.',
  'Si se moja, sécalo con suavidad, sin frotar. Si se despega, recorta lo despegado y pon cinta médica.':
      'If it gets wet, dry it gently without rubbing. If it comes off, trim the loose parts and put medical tape on.',
  'No uses el mismo sitio para dos sensores seguidos. Si la irritación es importante (picor, ardor, erupción), consulta con tu equipo médico.':
      'Don\'t use the same spot for two sensors in a row. If the irritation is significant (itching, burning, rash), talk to your medical team.',
  'Si el aplicador se te queda pegado, despega el parche con cuidado junto con el aplicador, comprueba que el sensor no se ha quedado en la piel y no lo reutilices.':
      'If the applicator stays stuck to you, carefully peel off the patch together with the applicator, check that the sensor hasn\'t stayed in your skin and don\'t reuse it.',
  'Sensor arrancando (60 minutos)': 'Sensor starting up (60 minutes)',
  'Después de escanear el sensor con el móvil, la aplicación muestra tu glucosa automáticamente a los 60 minutos. Después, el sensor envía una lectura nueva cada minuto.':
      'After scanning the sensor with the phone, the app shows your glucose automatically after 60 minutes. Then the sensor sends a new reading every minute.',
  'arranque, calentamiento, escanear, sin lecturas':
      'start-up, warm-up, scan, no readings',
  'Espera 60 minutos sin quitar el sensor.':
      'Wait 60 minutes without removing the sensor.',
  'Si el móvil no reconoce el sensor al escanear, muévelo despacio sobre él: cada modelo de móvil es distinto.':
      'If the phone doesn\'t recognise the sensor when scanning, move it slowly over it: every phone model is different.',
  'Alarmas de glucosa del Libre 3': 'Libre 3 glucose alarms',
  'Las alarmas vienen activadas de fábrica y son una función de seguridad importante. Se pueden cambiar o desactivar desde la aplicación.':
      'Alarms come switched on from the factory and are an important safety feature. They can be changed or turned off from the app.',
  'alarmas, descartar, desactivar, configurar':
      'alarms, dismiss, turn off, configure',
  'Abre la aplicación o toca Descartar para quitar la alarma.':
      'Open the app or tap Dismiss to clear the alarm.',
  'Abre la aplicación para ver más información de tu lectura.':
      'Open the app to see more information about your reading.',
  'Si quieres cambiar o desactivar alguna: Menú principal → Alarmas. Consúltalo antes con tu equipo médico.':
      'If you want to change or turn off any: Main menu → Alarms. Talk to your medical team first.',
  'Tu móvil no recibe lecturas del sensor. Si usas una bomba con ajuste automático, puede que deje de ajustar la insulina.':
      'Your phone isn\'t receiving readings from the sensor. If you use a pump with automatic adjustment, it may stop adjusting insulin.',
  'no conecta, sin senal, bluetooth, sin lecturas':
      'not connecting, no signal, bluetooth, no readings',
  'Acerca el móvil al sensor.': 'Bring the phone closer to the sensor.',
  'Apaga y enciende el Bluetooth del móvil y espera 15 minutos.':
      'Turn Bluetooth off and on on the phone and wait 15 minutes.',
  'Fuente: manual oficial de {manual}, p. {pagina}':
      'Source: official manual of {manual}, p. {pagina}',
  'Problema con la bomba': 'Problem with the pump',
  'Problema con el sensor': 'Problem with the sensor',
  'Elige el aviso que sale en la pantalla':
      'Choose the notice you see on the screen',
  'Ver otro aviso': 'See another notice',
  '¡Hola! Cuéntame qué problema tienes y te ayudo a resolverlo.':
      'Hi! Tell me what problem you have and I\'ll help you sort it out.',
  'Escribe lo que ves en la pantalla…': 'Type what you see on the screen…',
  'Viaje, zonas y soporte.': 'Travel, sites and support.',
};
