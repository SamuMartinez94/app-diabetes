# Informe: bombas de insulina nuevas o en camino

*Fecha del informe: 6 de octubre de 2026. Documento interno de planificación: aquí sí se usan los nombres comerciales para poder identificar cada dispositivo.*

> **Cómo leerlo.** Solo se incluyen bombas con un hito confirmado (marcado CE, aprobación FDA o fecha de lanzamiento anunciada por el fabricante). Las fuentes son notas de prensa de los fabricantes y medios especializados del sector. Antes de añadir cualquier guía o alarma a DiaGuía hay que trabajar sobre el **manual oficial** de cada dispositivo, igual que con las bombas actuales.

---

## Resumen

| Bomba | Fabricante | Tipo | Estado en Europa | ¿España? | Prioridad para DiaGuía |
|---|---|---|---|---|---|
| **MiniMed Flex** | MiniMed (antes Medtronic Diabetes) | Con tubo, sin pantalla, control por app | Marcado CE el 1 sep. 2026; lanzamiento europeo en **noviembre de 2026** | Sin confirmar | **Alta** |
| **Tandem Mobi** | Tandem Diabetes Care | Con tubo, miniatura, control por app | Marcado CE en mayo de 2025; lanzamiento en países seleccionados en el **2.º semestre de 2026** | Sin confirmar | **Alta** |
| **Kaleido + DBLG2** | ViCentra + Diabeloop | Parche | Ya vendida en Alemania, Países Bajos y Francia; nueva versión con DBLG2 desde jul. 2026 en Alemania | No | Media |
| **Medtrum TouchCare Nano (300 U)** | Medtrum | Parche sin tubo | Vendida en varios países; versión de 300 U llegando a Alemania | La marca dice estar presente en España | Media |
| **Omnipod 6** | Insulet | Parche sin tubo | Algoritmo aprobado por la FDA (jun. 2026); lanzamiento previsto en **2027** | No | Media (a vigilar) |
| **MiniMed Fit** | MiniMed | Parche, 300 U | Enviada a la FDA el 1 sep. 2026; lanzamiento previsto en verano de 2027 (EE. UU.) | No | Baja (a vigilar) |
| **twiist** | Sequel Med Tech | Con tubo | Solo EE. UU.; la vía europea pasa por el algoritmo DBLG2 de Diabeloop, sin fecha | No | Baja |
| **Mint** | Beta Bionics | Parche, 300 U | Solo EE. UU., previsto para el 2.º trimestre de 2027 | No | Baja |

---

## 1. MiniMed Flex: prioridad alta

**Lo que se sabe:**
- Unas **dos veces más pequeña** que la MiniMed 780G: 9,7 × 2,5 × 3,6 cm y 73 g.
- **No tiene pantalla**: se controla por completo desde la **app MiniMed** (iOS y Android).
- **Reservorio de 300 unidades** (Extended MMT-342) y **catéter Extended de 7 días**, con un cambio de equipo a la semana.
- El algoritmo es el mismo de la 780G (**SmartGuard**, con detección de comidas y ajustes cada 5 minutos).
- **Sensores:** Simplera Sync (6 días + 24 h de margen) e **Instinct** (fabricado por Abbott, hasta 15 días).
- Batería recargable: carga completa en unos 30 minutos y dura al menos 7 días.
- Sumergible hasta 2,4 m durante 1 h 45 min.
- Indicaciones: tipo 1 a partir de 7 años y tipo 2 a partir de 18.
- Hitos: lanzamiento en EE. UU. a finales de junio de 2026, marcado CE el 1 de septiembre de 2026 y **lanzamiento europeo en noviembre de 2026**.

**Qué supondría en DiaGuía:**
- Una bomba nueva (p. ej. `bminimedflex`) con un único catéter, `cextended`, que ya existe en la app.
- Los pasos de llenado del reservorio se parecen a los de la 780G, pero **todas las acciones en la bomba pasan a ser acciones en la app**. Habrá que reescribir los bloques de preparación, carga y cebado.
- Sus alarmas saldrán de su propio manual (los textos de pantalla de la app serán distintos de los de la 780G).
- Sensores: `ssimplera` y uno nuevo, `sinstinct`.

---

## 2. Tandem Mobi: prioridad alta

> **Ya añadida a la app** (7 de octubre de 2026), con la guía del usuario española (Control-IQ 7.9, abril de 2026): guías de cambio con los cuatro catéteres de Tandem, sensores Dexcom G6 y G7 y sus alarmas.

**Lo que se sabe:**
- Presentada como la bomba con tubo más pequeña del mercado: 5,1 × 3,7 × 1,4 cm y unos 30 g.
- **Cartucho de 200 unidades**.
- **Se controla desde la app del móvil**.
- Carga **inalámbrica** y actualizaciones de software a distancia.
- Usa los **mismos catéteres de Tandem que la t:slim X2** (AutoSoft 90, AutoSoft 30 y TruSteel, ya en la app), más una opción de tubo corto de 5 pulgadas (≈13 cm) pensada para ella.
- Algoritmo **Control-IQ+**: 5–200 U/día, 9–200 kg de peso y bolos extendidos de hasta 8 h.
- Sensores Dexcom G6 y G7.
- Sumergible hasta 2,4 m durante 2 h (IP28).
- Hitos: marcado CE en mayo de 2025, ampliado en junio de 2026 a tipo 2 y a embarazo. Tandem anuncia el lanzamiento en «países seleccionados» de Europa en el **segundo semestre de 2026**, sin decir cuáles.

**Qué supondría en DiaGuía:**
- Es la que **más reaprovecha lo que ya existe**: los mismos catéteres (`cautosoft90`, `cautosoft30`, `ctrusteel`) y los mismos sensores (`sdexg6`, `sdexg7`).
- El llenado del cartucho con jeringa es parecido al de la t:slim X2, pero los pasos en la bomba («OPCIONES → Cargar…») pasan a hacerse en la app. Hay que adaptar `_tandemComun`.
- Las alarmas, en principio, serán parecidas a las de la t:slim X2, pero hay que comprobarlo con su manual.

---

## 3. Kaleido + DBLG2 (ViCentra / Diabeloop): prioridad media

**Lo que se sabe:**
- Bomba parche pequeña y ligera, con carcasas de aluminio en 10 colores.
- Funciona con los algoritmos de Diabeloop: DBLG1 y el nuevo **DBLG2**, que permite el lazo cerrado desde el móvil. DBLG2 obtuvo el marcado CE en junio de 2026.
- Sensores Dexcom.
- Disponible en **Alemania, Francia y Países Bajos**. La versión con DBLG2 llega a Alemania en julio de 2026 y después a Países Bajos.
- No hay planes anunciados para España.

**Qué supondría en DiaGuía:** una bomba con su propio sistema de recambio. Habría que revisar con el manual cómo se cambia el reservorio y el equipo de infusión antes de valorar el trabajo. Esperaría a que haya fecha para España.

---

## 4. Medtrum TouchCare Nano (300 U): prioridad media

**Lo que se sabe:**
- **Bomba parche sin tubo** de 200 U, y ahora de **300 U** para quien necesita más insulina.
- Se controla con un mando (PDM) o con la **app EasyPatch**.
- Tiene su propio sensor (**Nano CGM**) y algoritmo híbrido (**APGO**), con un modo «Auto-Meal» en el que basta con avisar de la comida, sin contar hidratos.
- Medtrum dice que ya está presente en España, y hay una comunicación de primera experiencia en España en el congreso de la SEEN. **No he encontrado nada sobre su financiación pública.**
- La versión de 300 U está a punto de llegar a Alemania (DDG 2026).

**Qué supondría en DiaGuía:** una bomba con catéter integrado (como el `cpod` de Omnipod) y un sensor nuevo de la misma marca. Es la candidata con más opciones de que ya haya usuarios en España, así que conviene confirmarlo con algún equipo de endocrinología.

---

## 5. Omnipod 6: a vigilar (2027)

**Lo que se sabe:**
- Algoritmo **adaptativo** que aprende de los patrones de cada persona. La FDA lo aprobó el 29 de junio de 2026 para tipo 1 a partir de 2 años y tipo 2 a partir de 18.
- **Pod configurable** pensado para funcionar con cualquier sensor del mercado.
- Nueva app y nuevo controlador, objetivo de glucosa más bajo (100 mg/dl) y mejor gestión de las alarmas.
- Insulet prevé lanzarlo en **2027** (primero en EE. UU.). No hay fecha para Europa.

**Qué supondría en DiaGuía:** una variante de `bomnipod` con alarmas y menús nuevos. La guía de cambio del Pod probablemente se parezca mucho a la actual.

---

## 6. En el radar (fuera de Europa por ahora)

- **MiniMed Fit:** bomba parche de 300 U y hasta 7 días de uso, orientada a la diabetes tipo 2. Se envió a la FDA el 1 de septiembre de 2026 y se espera para el verano de 2027 en EE. UU.
- **Sequel twiist:** a la venta en EE. UU. desde 2025 y en todo el país desde marzo de 2026. Mide el volumen de insulina que realmente pone y avisa de bloqueos. Para Europa depende de su acuerdo con Diabeloop (algoritmo DBLG2), sin fecha.
- **Beta Bionics Mint:** bomba parche de 300 U con el algoritmo del iLet (solo pide el peso). Prevista para el 2.º trimestre de 2027 en EE. UU.
- **Accu-Chek Solo (Roche):** microbomba parche en comercialización piloto en Austria, Polonia, Suiza y Reino Unido. Sin datos para España.

---

## 7. Cambios que afectan a las bombas que **ya están** en la app

Esto puede ser más urgente que añadir bombas nuevas:

1. **Omnipod 5 en España (julio de 2026).** El lanzamiento oficial en España es con **FreeStyle Libre 2 Plus y Dexcom G7**, no con el G6. En la app, el Omnipod solo ofrece `sdexg6` y `sdexg7`. Conviene añadir **Libre 2 Plus** y revisar si el G6 sigue teniendo sentido para Omnipod en España. En España se usa con el **Controlador** (no se menciona la app del móvil), para tipo 1 a partir de 2 años. Ya se está implantando en hospitales públicos (Ramón y Cajal, barnaclínic+).
2. **mylife pasa a ser una empresa independiente de Ypsomed (2026).** Cambian nombres de productos:
   - mylife YpsoPump → **YpsoPump**
   - mylife Loop → **myLoop**
   - catéteres mylife YpsoPump Orbit → **myOrbit**
   - La **app mylife se retira el 1 de diciembre de 2026**, y los usuarios pasan a myLoop (CamAPS FX).

   Afecta a la cita del manual en las alarmas (`'mylife YpsoPump'`), a la ficha de soporte (`Ypsomed — mylife`, web) y a los nombres de los catéteres Orbit.
3. **Sensor Instinct para la MiniMed 780G.** Fabricado por Abbott, dura hasta 15 días. Tiene marcado CE desde marzo de 2026 y se lanza de forma escalonada en Europa desde junio de 2026. Sería un tercer sensor para `bmedtronic`, junto a Guardian 4 y Simplera Sync. MiniMed también lanzó **MiniMed Go** (pluma inteligente) con el sensor Instinct Go; no es una bomba, así que queda fuera.
4. **Medtronic Diabetes es ahora MiniMed**, una empresa separada que cotiza por su cuenta. Habría que revisar el nombre y la web en `soporte.dart`.
5. **Contexto de España:** la Red de Evaluación de Tecnologías Sanitarias recomendó financiar los sistemas de asa cerrada en julio de 2024, y cada comunidad decide cuántos compra. Andalucía, por ejemplo, prevé llegar al 70 % de los niños con tipo 1 en 2026 y a todos en 2027. Esto hará que crezca el número de usuarios de bomba.

---

## 8. Orden de trabajo recomendado

1. Corregir lo del apartado 7: Libre 2 Plus en Omnipod, nombres de mylife y sensor Instinct.
2. **Tandem Mobi**: reaprovecha catéteres, sensores y gran parte de la guía.
3. **MiniMed Flex**: reaprovecha el catéter Extended y los sensores; hay que reescribir los pasos para la app.
4. Confirmar si hay usuarios de **Medtrum Nano** en España antes de dedicarle tiempo.
5. Revisar en 2027: Omnipod 6, Kaleido (si llega a España) y MiniMed Fit.

---

## Fuentes

- [Insulet: lanzamiento de Omnipod 5 en España (jul. 2026)](https://investors.insulet.com/news/news-details/2026/Insulet-Accelerates-Global-Growth-with-Launch-of-Omnipod-5-and-Omnipod-Discover-in-Spain-Expanding-Access-to-Tubeless-Diabetes-Technology/default.aspx)
- [Crónica del Henares: Omnipod 5 en el Ramón y Cajal (oct. 2026)](https://www.cronicadelhenares.com/2026/10/insulina-automatica-sin-tubos-ramon-y-cajal-diabetes-tipo-1.html)
- [MedTech Dive: MiniMed envía la Fit a la FDA; CE y lanzamiento europeo de la Flex](https://www.medtechdive.com/news/minimed-submits-new-patch-pump-for-fda-clearance/829313/)
- [MiniMed: ficha profesional de MiniMed Flex](https://www.professional.minimed.com/en-us/product-portfolio/minimed-flex-insulin-pump-system)
- [MiniMed: lanzamiento del sensor Instinct en Europa (jun. 2026)](https://news.minimed.com/2026-06-23-MiniMed-launches-Instinct-sensors-in-Europe-giving-people-with-diabetes-more-sensor-choice-with-the-same-proven-outcomes)
- [MiniMed: marcado CE de la 780G con Instinct (mar. 2026)](https://news.minimed.com/2026-03-10-MiniMed-expands-sensor-portfolio-in-Europe-with-CE-Mark-for-MiniMed-TM-780G-system-with-the-Instinct-sensor,-made-by-Abbott)
- [Drug Delivery Business: marcado CE de Tandem para tipo 2 y embarazo (jun. 2026)](https://www.drugdeliverybusiness.com/tandem-ce-mark-aid-type-2-pregnancy/)
- [Diabetes Technology: Tandem Mobi, especificaciones](https://www.diabetesnet.com/diabetes-technology/automated-insulin-delivery-systems/tandem-mobi-aid/)
- [Diabetotech: novedades de lazo cerrado en ADA 2026](https://www.diabetotech.com/blog/closed-loop-updates-from-ada-2026)
- [Drug Delivery Business: novedades de ATTD 2026](https://www.drugdeliverybusiness.com/biggest-diabetes-tech-news-attd-2026/)
- [Drug Delivery Business: ViCentra lanzará la nueva Kaleido](https://www.drugdeliverybusiness.com/vicentra-launch-next-gen-kaleido-pump-2026/)
- [Innovation Industries: inversión en ViCentra / Kaleido](https://www.innovationindustries.com/news/innovation-industries-leads-85m-investment-in-vicentra-to-scale-manufacturing-and-accelerate-market-penetration-of-kaleido-insulin-patch-pump)
- [Medtrum: TouchCare Nano 300 U en DDG 2026](https://www.medtrum.com/news/medtrum-touchcare-nano-300u-aid-system)
- [Medtrum y el sistema TouchCare Nano](https://www.medtrum.com/news/Medtrum-and-the-TouchCare-Nano-System)
- [FDA (vía Innolitics): algoritmo Omnipod 6, K261461](https://fda.innolitics.com/device/K261461)
- [MassDevice: Insulet Investor Day, Omnipod 6 en 2027](https://www.massdevice.com/insulet-investor-day-omnipod-6-2027/)
- [Diabettech: Sequel twiist y Diabeloop](https://www.diabettech.com/a-twiist-of-fate-why-sequel-is-moving-beyond-tidepool-to-embrace-diabeloop/)
- [Drug Delivery Business: mylife se independiza de Ypsomed](https://www.drugdeliverybusiness.com/mylife-diabetes-care-completes-transition-independent-company/)
- [mylife: retirada de la app mylife](https://www.mylife-diabetescare.com/en-AU/products/therapy-management/mylife-digital/mylife-app-phase-out)
- [Kaio-dia: bombas parche en Europa en 2026](https://kaio-dia.eu/blogs/our-blog/insulin-patch-pumps-in-2026)
- [Servicio Andaluz de Salud: acceso universal a sistemas automatizados desde 2026](https://www.sspa.juntadeandalucia.es/servicioandaluzdesalud/todas-noticia/sanidad-garantiza-el-acceso-universal-sistemas-automatizados-de-infusion-de-insulina-desde-2026)
