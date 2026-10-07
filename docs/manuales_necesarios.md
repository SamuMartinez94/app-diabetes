# Manuales oficiales

*Actualizado: 7 de octubre de 2026.*

Todo el contenido de DiaGuía (guías de recambio y alarmas) tiene que salir de un manual oficial. Este documento recoge qué manuales tenemos, cuáles usa la app y cuáles faltan o conviene sustituir.

**Organización de `Manuales/`:** una carpeta por fabricante. Cada nombre de archivo sigue el formato `Dispositivo - Tipo de documento (idioma, edición) [ESTADO]`, donde el estado es uno de estos:
- `[ACTUAL]`: la edición más reciente que tenemos.
- `[ANTIGUO]`: hay otra más nueva o el producto ya no se usa.
- `[NO OFICIAL]`: copia de manualslib u otra web recopiladora.
- `[OTRA REGIÓN]`: edición de otro país.

El archivo `Manuales/_renombrados.txt` guarda la correspondencia con los nombres originales. Los duplicados exactos que aparezcan se mueven a `Manuales/_duplicados/` para que los revises y los borres.

**Requisitos de un manual nuevo:** que sea oficial (web del fabricante o caja del producto), en español de España si existe, de la edición más reciente y exactamente del modelo que se va a añadir.

---

## 1. Manuales que usa la app

| Dispositivo | Manual en `Manuales/` | Qué sale de él |
|---|---|---|
| YpsoPump | `mylife YpsoPump/YpsoPump - Guía del usuario (ES, REF 700012540, 2025-09)` | Alarmas y pasos de bomba de las guías |
| myOrbit Soft / Micro | `mylife YpsoPump/myOrbit … (1ª gen y 2.0, 2026-01)` | Guías de myOrbit Soft y myOrbit Micro |
| myInset | `mylife YpsoPump/myInset - Instrucciones de uso (V03 2020-04)` | Guía del myInset (de nuevo en el selector) |
| Omnipod 5 | `Insulet Omnipod/Omnipod 5 - Guía técnica del usuario (ES-España, 2026-03)` | Guía de cambio de Pod y todas las alarmas de Omnipod, incluidas las del Libre 2 Plus |
| FreeStyle Libre 2 Plus | `Abbott FreeStyle/FreeStyle Libre 2 y 2 Plus - Manual del lector (ART52179, 2025)` | Guía del Libre 2 Plus con Omnipod 5 (nuevo) |
| FreeStyle Libre 3 / 3 Plus | `Abbott FreeStyle/FreeStyle Libre 3 y 3 Plus - Manual del lector (ART52185, 2025)` | Guía y alarmas del Libre 3, ahora contrastadas |
| MiniMed 780G | `MiniMed/MiniMed 780G - Guía del usuario del sistema (EN, 2025-08)` | Alarmas de la bomba y de los sensores, y lista de catéteres compatibles (pp. 44-45) |
| Instinct | `MiniMed/Instinct - Guía del usuario del sensor (EN, 2026-04)` | Guía del Instinct |
| Guardian 4 | `MiniMed/Guardian 4 - Guía del usuario del sensor (EN, 2025-08)` y la del transmisor | Guía del Guardian 4 (añadidos la cinta oval y el transmisor) |
| Simplera Sync | `MiniMed/Simplera Sync - Guía del usuario del sensor (EN, 2025-08)` | Guía del Simplera Sync |
| Catéter Extended | `MiniMed/Extended - Instrucciones de uso del catéter (multi, 2021-09)` | Guía del Extended, ahora paso a paso |
| t:slim X2 | `Tandem/t-slim X2 - Guía del usuario (ES, Control-IQ 7.8.1, 2025)` | Guía de cambio de cartucho y alarmas del t:slim X2 |
| Tandem Mobi | `Tandem/Tandem Mobi - Guía del usuario (ES, Control-IQ 7.9, 2026-04)` | Guía de cambio de cartucho y alarmas de la Mobi (nueva) |
| Catéteres de Tandem | `Tandem/AutoSoft 90`, `AutoSoft 30`, `TruSteel` y `VariSoft - Instrucciones de uso del catéter` | Inserción de cada catéter en el t:slim X2 y la Mobi. VariSoft es nuevo; TruSteel corregido (se conecta con un clic a su carcasa de acoplamiento) |
| CamAPS FX (myLoop) | `mylife YpsoPump/CamAPS FX - Manual del usuario (ES, 2026-07)` | Sensores de la YpsoPump y aviso de iniciar el Libre 3 con CamAPS FX |
| Dexcom G6 y G7 | Copias de manualslib (ver apartado 3) | Guías y alarmas de esos sensores |

### Sensores que admite cada bomba

Según el manual vigente de cada bomba. La app solo ofrece estas combinaciones.

| Bomba | Sensores | Manual |
|---|---|---|
| MiniMed 780G | Guardian 4, Simplera Sync, Instinct | Guía del sistema (EN, 2025-08) |
| Omnipod 5 | Dexcom G6, Dexcom G7, FreeStyle Libre 2 Plus | Guía técnica para España (2026-03) |
| t:slim X2 | Dexcom G6, Dexcom G7 | Guía del usuario (ES, Control-IQ 7.8.1, 2025) |
| Tandem Mobi | Dexcom G6, Dexcom G7 | Guía del usuario (ES, Control-IQ 7.9, 2026-04) |
| YpsoPump | Dexcom G6, Dexcom G7, FreeStyle Libre 3 / 3 Plus | Manual de CamAPS FX (ES, 2026-07), anexo B |

Las instrucciones del cartucho (t:slim X2 y Mobi) y de la funda adhesiva de la Mobi también están en `Manuales/Tandem/`, pero solo como consulta: los pasos de llenado ya vienen en la guía de cada bomba.

### Catéteres que admite cada bomba

| Bomba | Catéteres en la app | Fuente |
|---|---|---|
| MiniMed 780G | Extended, Quick-set, Silhouette, Sure-T, Mio 30 | Guía del sistema (EN, 2025-08), pp. 44-45. El Mio clásico no aparece y se ha quitado. Falta el Mio Advance |
| t:slim X2 y Tandem Mobi | AutoSoft 90, AutoSoft 30, VariSoft, TruSteel | Guías del usuario, especificaciones técnicas. Falta el AutoSoft XC |
| YpsoPump | myOrbit Soft, myOrbit Micro, myInset | Guía de compatibilidad (V02 2026) |
| Omnipod 5 | Pod (sin catéter aparte) | Guía técnica para España |

---

## 2. Manuales que faltan

| Manual | Para qué | Prioridad |
|---|---|---|
| **MiniMed 780G, guía del usuario del sistema en español, edición actual** (con Simplera e Instinct) | Las guías españolas que tenemos son de 2020-2021, más antiguas que la inglesa de 2025 que usa la app. Con la actual se podrían poner como título de cada alarma el texto exacto que sale en pantalla ("Infusión bloqueada", "Señal perdida sensor"…). | Media |
| **Instinct, guía del sensor en español** | La inglesa sirve, pero la española confirmaría los nombres de pantalla. | Baja |
| **Simplera Sync, guía del sensor en español** | La que tenemos está en inglés. En `Descargas` hay `Sensor-Simplera-Guía-del-usuario-del-sistema.pdf`: conviene revisarlo y pasarlo a `Manuales/MiniMed/`. | Baja |
| **Instrucciones de uso de Quick-set, Silhouette, Sure-T y Mio 30** | Sus guías en la app no salen todavía de sus instrucciones oficiales (solo el Extended). Con ellas se podrían contrastar paso a paso, como se ha hecho con los de Tandem y mylife. | Media |
| **Mio Advance, instrucciones de uso** | Es compatible con la 780G según su guía, pero no está en la app. Con su manual se podría añadir. | Baja |
| **AutoSoft XC** | Tandem lo vende en algunos países, pero no hay instrucciones de uso entre las descargadas. Si lo usa alguien, haría falta su IFU para añadirlo. | Baja |
| **Dexcom G6 y Dexcom G7, ediciones oficiales** | Los que tenemos son copias de manualslib. | Media |
| **App FreeStyle Libre 3** (manual de la aplicación del móvil) | El manual oficial que tenemos es el del lector. La app del móvil funciona igual en lo esencial, pero algunos textos de pantalla pueden cambiar. | Baja |

---

## 3. Manuales no oficiales o antiguos (no se usan)

- `mylife YpsoPump - Guía del usuario (manualslib, 2017)`: sustituido por la guía oficial.
- `FreeStyle Libre 2 (no Plus) - Manual del usuario (manualslib, 2019)`: era el que venía como "Libre 2 Plus"; sustituido por el ART52179 oficial.
- `FreeStyle Libre 3 - Guía de inicio rápido (manualslib, 2022)`: sustituido por el ART52185.
- `MiniMed 780G con Guardian Sensor 3 …`: ese sensor ya no está en la app.
- `MiniMed 780G con Guardian 4 - Guía del usuario (ES, 2021)` y `Principales alertas y alarmas (2020)`: anteriores a la guía inglesa de 2025.
- `Omnipod 5 - Guía del usuario resumida (ES-EEUU-Latam)`: sustituida por la guía técnica española.
- `Tandem Mobi - Guía del usuario (ES, Control-IQ 7.9, 2026-02)`: mismo documento (AW-1017619) que la edición de abril, pero de febrero. Desde la página 300 sus números van dos por delante, así que las páginas que cita la app son las de abril.

Se pueden borrar o archivar fuera del proyecto cuando quieras; no he borrado nada.

---

## 4. Para bombas nuevas (más adelante)

Ver [informe_nuevas_bombas.md](informe_nuevas_bombas.md).

| Bomba | Manuales necesarios |
|---|---|
| MiniMed Flex | Guía del usuario del sistema MiniMed Flex, guía de la app MiniMed y las instrucciones del reservorio y el catéter Extended |
| Medtrum TouchCare Nano | Guía del usuario de la bomba Nano, de la app EasyPatch y del sensor Nano CGM |
