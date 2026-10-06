# Manuales oficiales

*Actualizado: 6 de octubre de 2026.*

Todo el contenido de DiaGuía (guías de recambio y alarmas) tiene que salir de un manual oficial. Este documento recoge qué manuales tenemos, cuáles usa la app y cuáles faltan o conviene sustituir.

**Organización de `Manuales/`:** una carpeta por fabricante. Cada nombre de archivo sigue el formato `Dispositivo - Tipo de documento (idioma, edición) [ESTADO]`, donde el estado es uno de estos:
- `[ACTUAL]`: la edición más reciente que tenemos.
- `[ANTIGUO]`: hay otra más nueva o el producto ya no se usa.
- `[NO OFICIAL]`: copia de manualslib u otra web recopiladora.
- `[OTRA REGIÓN]`: edición de otro país.

El archivo `Manuales/_renombrados.txt` guarda la correspondencia con los nombres originales. Los duplicados exactos están en `Manuales/_duplicados/`.

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
| MiniMed 780G | `MiniMed/MiniMed 780G - Guía del usuario del sistema (EN, 2025-08)` | Alarmas de la bomba y de los sensores |
| Instinct | `MiniMed/Instinct - Guía del usuario del sensor (EN, 2025-09)` | Guía del Instinct (nuevo) |
| Guardian 4 / Simplera Sync | `MiniMed/Guardian 4 …` y `MiniMed/Simplera Sync …` | Guías de esos sensores |
| t:slim X2, Dexcom G6 y G7 | Copias de manualslib (ver apartado 3) | Guías y alarmas de esos dispositivos |

---

## 2. Manuales que faltan

| Manual | Para qué | Prioridad |
|---|---|---|
| **MiniMed 780G, guía del usuario del sistema en español, edición actual** (con Simplera e Instinct) | Las guías españolas que tenemos son de 2020-2021, más antiguas que la inglesa de 2025 que usa la app. Con la actual se podrían poner como título de cada alarma el texto exacto que sale en pantalla ("Infusión bloqueada", "Señal perdida sensor"…). | Media |
| **Instinct, guía del sensor en español** | La inglesa sirve, pero la española confirmaría los nombres de pantalla. | Baja |
| **Simplera Sync, guía del sensor en español** | La que tenemos está en inglés. En `Descargas` hay `Sensor-Simplera-Guía-del-usuario-del-sistema.pdf`: conviene revisarlo y pasarlo a `Manuales/MiniMed/`. | Baja |
| **t:slim X2, Dexcom G6 y Dexcom G7, ediciones oficiales** | Los que tenemos son copias de manualslib. | Media |
| **App FreeStyle Libre 3** (manual de la aplicación del móvil) | El manual oficial que tenemos es el del lector. La app del móvil funciona igual en lo esencial, pero algunos textos de pantalla pueden cambiar. | Baja |

---

## 3. Manuales no oficiales o antiguos (no se usan)

- `mylife YpsoPump - Guía del usuario (manualslib, 2017)`: sustituido por la guía oficial.
- `FreeStyle Libre 2 (no Plus) - Manual del usuario (manualslib, 2019)`: era el que venía como "Libre 2 Plus"; sustituido por el ART52179 oficial.
- `FreeStyle Libre 3 - Guía de inicio rápido (manualslib, 2022)`: sustituido por el ART52185.
- `MiniMed 780G con Guardian Sensor 3 …`: ese sensor ya no está en la app.
- `MiniMed 780G con Guardian 4 - Guía del usuario (ES, 2021)` y `Principales alertas y alarmas (2020)`: anteriores a la guía inglesa de 2025.
- `Omnipod 5 - Guía del usuario resumida (ES-EEUU-Latam)`: sustituida por la guía técnica española.

Se pueden borrar o archivar fuera del proyecto cuando quieras; no he borrado nada.

---

## 4. Para bombas nuevas (más adelante)

Ver [informe_nuevas_bombas.md](informe_nuevas_bombas.md).

| Bomba | Manuales necesarios |
|---|---|
| Tandem Mobi | Guía del usuario de Tandem Mobi (edición española o europea) |
| MiniMed Flex | Guía del usuario del sistema MiniMed Flex, guía de la app MiniMed y las instrucciones del reservorio y el catéter Extended |
| Medtrum TouchCare Nano | Guía del usuario de la bomba Nano, de la app EasyPatch y del sensor Nano CGM |
