  
**HERRAMIENTAS PARA LA INDUSTRIALIZACIÓN**  
**DEL DESARROLLO DE SOFTWARE**

** **  
   
**Informe técnico**  
**\<Nombre de Herramienta\>**  
**  **  
**Autores:**  
**\<Desarrolladores\>**  
** **

** **

**Medellín**  
**2025**  
** **  
**Historia**

| Versión | Fecha | Cambiar Descripción |
| :---: | :---: | ----- |
|  |  |  |
|  |  |  |

**CONTENIDO**

**Página**

[1\.	\<NOMBRE DE LA HERRAMIENTA\>	4](#\<nombre-de-la-herramienta\>)  
[1.1	Presentación de la Herramienta	5](#heading)  
[1.2	Arquitectura de la Herramienta	5](#heading=h.2xcytpi)  
[1.3	Plataforma	5](#heading-1)  
[2\.	PROCESO DE DESARROLLO EN \<NOMBRE DE LA HERRAMIENTA\>	6](#heading=h.1ci93xb)  
[2.1	Instalación	6](#heading-2)  
[2.2	Montaje de Modelos	6](#heading=h.3whwml4)  
[2.3	Orígenes de Datos	6](#heading-3)  
[2.4	Categorías de Controles y Funciones	6](#heading-4)  
[3\.	EVALUACIÓN DE \<NOMBRE DE LA HERRAMIENTA\>	8](#evaluación-de-\<nombre-de-la-herramienta\>)  
[3.1	Características Generales	8](#heading=h.2bn6wsx)  
[3.1.1	Documentación	8](#heading=h.qsh70q)  
[3.1.2	Usabilidad	8](#heading-5)  
[3.1.3	Despliegue e Internacionalización	8](#heading-6)  
[3.2	Características Comerciales	8](#heading=h.3as4poj)  
[3.2.1	Reconocimiento y Madurez	8](#heading-7)  
[3.2.2	Licencias	8](#heading-8)  
[3.2.3	Soporte	9](#heading=h.1pxezwc)  
[4\.	CONCLUSIONES DE \<NOMBRE DE LA HERRAMIENTA\>	10](#conclusiones-de-\<nombre-de-la-herramienta\>)

 **LISTA DE FIGURAS**

**Página**

[**Figure 1\.**	Logo de \<Nombre de la Herramienta\>.	4](#heading-9)

[**Figure 2\.**	Diagrama de la Arquitectura de \<Nombre de la Herramienta\>.	5](#heading=h.49x2ik5)

1.  **\<NOMBRE DE LA HERRAMIENTA\>**

Cada equipo de trabajo debe seleccionar una herramienta, plataforma, plugin, extensión, librería, etc. que permita generar, ejecutar y/o desplegar una aplicación; teniendo en cuenta que deben pertenecer a una técnica de industrialización del desarrollo de software como, por ejemplo: herramientas MDE, plataformas LowCode/NoCode, herramientas de metaprogramación/meta-modelado, etc. entre estas se cuentan:

* Extensiones de VS Code  
* Plugins de Eclipse  
* Microsoft PowerApps  
* Oracle Application Express  
* Open as Apps  
* Genexus by Globant  
* Mendix / Appian / Outsystems / Node-RED  
* …

Se deben evitar herramientas con énfasis en gestión de contenidos, comercio electrónico o similares, estilo Wix, Shopify, SalesForce, etc. Las herramientas deben enfatizar en la industrialización y la automatización del proceso de desarrollo de software para permitir la experimentación y el diligenciamiento de este reporte técnico.

También se debe evitar Google AppSheet pues es una de las herramientas que se trabajan en clase en las demostraciones y prácticas.

Para la presentación de este reporte técnico cada equipo debe preparar una presentación en PowerPoint. La estructura de la presentación se debe basar en los numerales de este documento.

1. **Presentación de la Herramienta**

\<información general de la herramienta, sitio, versión, etc.\>  
![][image1]

1. Logo de \<Nombre de la Herramienta\>.

   2. **Arquitectura de la Herramienta**

\<Explicación de la arquitectura de la herramienta\>  
![][image1]

2. Diagrama de la Arquitectura de \<Nombre de la Herramienta\>.

   3. **Plataforma**

\<Descripción breve de la plataforma de la herramienta (motores de bases de datos, sistemas operativos, lenguajes de programación, etc.)\>

## 2. PROCESO DE DESARROLLO EN NODE-RED

### 2.1 Instalación

Node-RED puede instalarse de tres formas principales, dependiendo del entorno y los requerimientos del equipo de desarrollo:

**Opción 1 — Instalación vía npm (local)**

Requiere Node.js instalado en el sistema. Es la forma más directa para desarrollo individual.

```bash
npm install -g --unsafe-perm node-red
node-red
```

Node-RED quedará disponible en http://localhost:1880.

**Opción 2 — Instalación en Raspberry Pi**

La imagen oficial de Raspberry Pi OS incluye un script de instalación que configura Node.js, Node-RED y sus dependencias automáticamente:

```bash
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
```

**Opción 3 — Instalación vía Docker (método utilizado en este proyecto)**

Es el método recomendado para trabajo en equipo, ya que garantiza que todos los integrantes trabajen con el mismo entorno sin importar el sistema operativo del desarrollador.

*Prerrequisitos:*
- Docker Engine o Docker Desktop instalado
- Docker Compose (incluido en Docker Desktop)

*Paso 1 — Crear el archivo `Dockerfile`*

Se crea una imagen personalizada basada en la imagen oficial de Node-RED, agregando el módulo `node-red-dashboard` para habilitar la construcción de interfaces de usuario:

```dockerfile
FROM nodered/node-red:latest

RUN npm install --unsafe-perm --no-update-notifier --no-fund \
    --prefix /usr/src/node-red \
    node-red-dashboard
```

*Paso 2 — Crear el archivo `docker-compose.yml`*

Este archivo define el servicio, el puerto expuesto, el volumen para persistir los flows y la zona horaria:

```yaml
services:
  node-red:
    build: .
    ports:
      - "1880:1880"
    volumes:
      - ./data:/data
    restart: unless-stopped
    environment:
      - TZ=America/Bogota
```

El volumen `./data:/data` sincroniza la carpeta local `data/` con el directorio interno de Node-RED, lo que permite versionar los flows con git.

*Paso 3 — Construir y levantar el contenedor*

```bash
docker compose up --build -d
```

*Paso 4 — Verificar la instalación*

- Editor de flows: http://localhost:1880
- Dashboard UI: http://localhost:1880/ui

Para detener el servicio:

```bash
docker compose down
```

*Ventaja del enfoque Docker para equipos:* cualquier integrante del equipo puede reproducir el entorno exacto ejecutando `git clone` del repositorio seguido de `docker compose up --build -d`, sin necesidad de instalar Node.js ni Node-RED manualmente.

### 2.2 Montaje de Modelos

En Node-RED, el "modelo" es un **flow** (flujo): una representación visual de un proceso compuesto por nodos conectados entre sí mediante cables. El entorno de modelado es el editor web integrado, accesible en http://localhost:1880 una vez levantado el servicio.

**Elementos del entorno de modelado**

El editor de Node-RED está compuesto por tres áreas principales:

- **Paleta de nodos** (panel izquierdo): catálogo de todos los nodos disponibles clasificados por categoría (common, function, network, dashboard, etc.). Desde aquí se arrastran los nodos al canvas.
- **Canvas** (área central): espacio de trabajo donde se construyen los flows. Cada flow es una pestaña independiente. Los nodos se conectan arrastrando cables desde el puerto de salida de uno hacia el puerto de entrada de otro.
- **Panel lateral** (panel derecho): muestra información del nodo seleccionado, el log de debug en tiempo real y la documentación del flow.

**Proceso de construcción de un flow**

1. Se arrastra un nodo desde la paleta al canvas
2. Se configura el nodo haciendo doble clic sobre él (nombre, parámetros, lógica)
3. Se conecta con otros nodos arrastrando desde su puerto de salida al puerto de entrada del siguiente
4. Se despliega el flow con el botón **Deploy** (esquina superior derecha)
5. El flow queda activo inmediatamente, sin necesidad de reiniciar el servidor

Cada flow se guarda automáticamente en un archivo `flows.json`, lo que permite versionarlo en un sistema de control de versiones como git y compartirlo entre los integrantes del equipo.

*[Captura de pantalla recomendada: vista general del editor mostrando la paleta, el canvas con un flow de ejemplo y el panel lateral]*

### 2.3 Orígenes de Datos

Node-RED no incluye un motor de base de datos propio. En su lugar, se conecta a fuentes de datos externas mediante nodos especializados que pueden instalarse desde su catálogo de paquetes (npm). Esto le da flexibilidad para integrarse con prácticamente cualquier origen de datos.
o
**Categorías de orígenes de datos soportados**

| Categoría | Ejemplos | Nodo disponible |
|---|---|---|
| Bases de datos relacionales | MySQL, PostgreSQL, SQLite, Microsoft SQL Server | `node-red-node-mysql`, `node-red-contrib-postgresql` |
| Bases de datos NoSQL | MongoDB, CouchDB, Redis | `node-red-node-mongodb`, `node-red-contrib-couchdb` |
| APIs REST | Cualquier servicio HTTP | `http request` (nodo nativo) |
| Protocolos IoT | MQTT, CoAP, Modbus | `mqtt in/out` (nativo), `node-red-contrib-modbus` |
| Servicios en la nube | AWS, Azure, IBM Cloud | `node-red-contrib-aws`, paquetes oficiales de cada proveedor |
| Archivos | CSV, JSON, XML | `file in/out` (nativo) |
| Almacenamiento en contexto | Memoria, sistema de archivos local | Contexto global/flow/node (nativo) |

**Mecanismo de conexión**

La conexión a una base de datos se configura directamente en el nodo correspondiente mediante un objeto de configuración reutilizable (nodo de tipo *config*). Este objeto almacena los parámetros de conexión (host, puerto, usuario, contraseña, nombre de la BD) y puede ser referenciado por múltiples nodos dentro del mismo proyecto sin necesidad de repetir la configuración.

**Ejemplo de flujo con base de datos**

Un flujo típico de consulta a una BD relacional se compone de:

```
[inject] ──→ [function: armar query] ──→ [mysql] ──→ [function: procesar resultado] ──→ [debug / ui_table]
```

**Almacenamiento utilizado en este proyecto**

Para el caso de estudio Evergreen, en esta etapa del proyecto se utiliza el **contexto global de Node-RED** como mecanismo de almacenamiento en memoria. Este contexto es nativo de Node-RED y permite compartir datos entre todos los flows sin necesidad de una base de datos externa:

```javascript
// Escribir datos
global.set('agrocadenas', lista);

// Leer datos
var lista = global.get('agrocadenas');
```

Los datos persisten mientras el contenedor está activo. Para una versión de producción, este almacenamiento debería reemplazarse por una base de datos como MongoDB o PostgreSQL mediante el nodo correspondiente.

*[Captura de pantalla recomendada: configuración de un nodo de base de datos (por ejemplo mysql o mongodb) mostrando el panel de parámetros de conexión]*

### 2.4 Categorías de Controles y Funciones

Node-RED organiza sus nodos en categorías dentro de la paleta del editor. Cada categoría agrupa nodos con una función similar. A continuación se describen las categorías principales:

**Common (Comunes)**
Nodos de uso general presentes en cualquier flow.

| Nodo | Función |
|---|---|
| `inject` | Dispara un mensaje manualmente o en intervalos de tiempo |
| `debug` | Muestra el contenido de un mensaje en el panel de debug |
| `complete` | Se activa cuando otro nodo termina su ejecución |
| `catch` | Captura errores lanzados por otros nodos |
| `comment` | Agrega notas de documentación en el canvas |

**Function (Funciones)**
Nodos para transformar y procesar mensajes con lógica personalizada.

| Nodo | Función |
|---|---|
| `function` | Ejecuta código JavaScript arbitrario sobre el mensaje |
| `switch` | Enruta el mensaje por diferentes salidas según condiciones |
| `change` | Modifica, elimina o convierte propiedades del mensaje |
| `range` | Escala un valor numérico de un rango a otro |
| `template` | Genera texto usando plantillas Mustache |
| `delay` | Retrasa o limita la frecuencia de los mensajes |
| `json` | Convierte entre string JSON y objeto JavaScript |

**Network (Red)**
Nodos para comunicación con servicios y protocolos externos.

| Nodo | Función |
|---|---|
| `http in` | Expone un endpoint HTTP (recibe peticiones) |
| `http response` | Envía una respuesta HTTP |
| `http request` | Realiza peticiones HTTP a servicios externos |
| `mqtt in/out` | Publica y suscribe mensajes en un broker MQTT |
| `websocket in/out` | Comunicación en tiempo real via WebSocket |
| `tcp/udp in/out` | Comunicación a bajo nivel por TCP o UDP |

**Storage (Almacenamiento)**
Nodos para leer y escribir datos persistentes.

| Nodo | Función |
|---|---|
| `file in` | Lee el contenido de un archivo |
| `file` | Escribe datos en un archivo |
| `watch` | Monitorea cambios en archivos o directorios |

**Dashboard (Interfaz de usuario)**
Nodos del plugin `node-red-dashboard` para construir interfaces web interactivas.

| Nodo | Función |
|---|---|
| `ui_button` | Botón interactivo |
| `ui_form` | Formulario con múltiples campos |
| `ui_text input` | Campo de texto individual |
| `ui_table` | Tabla para mostrar datos tabulares |
| `ui_chart` | Gráfica de líneas, barras o dispersión |
| `ui_gauge` | Indicador tipo velocímetro |
| `ui_toast` | Notificación emergente |
| `ui_text` | Texto estático o dinámico |
| `ui_tab` / `ui_group` | Estructura de pestañas y grupos del dashboard |

*[Captura de pantalla recomendada: paleta de nodos del editor mostrando las categorías expandidas]*

3. **EVALUACIÓN DE** \<NOMBRE DE LA HERRAMIENTA\> 

   1. **Características Generales**

      1. **Documentación**

\<Sitio de la herramienta y acceso a la documentación\>

2. **Usabilidad**

\< ¿Qué tan fácil es implementar un sistema con la herramienta? \>

3. **Despliegue e Internacionalización**

\<Plataforma de despliegue y localización de la herramienta y de la aplicación generada\>

2. **Características Comerciales**

   1. **Reconocimiento y Madurez**

\<Versión, casos de éxito y comunidad de soporte\>

2. **Licencias**

\<Versión libre y comercial de la herramienta\>

3. **Soporte**

\<Estrategia y costos del soporte\>

4. **CONCLUSIONES DE** \<NOMBRE DE LA HERRAMIENTA\>

\<Lista de principales conclusiones\>  
\<Consideraciones personales\>  


[image1]: <data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAAB+CAYAAADsphmiAAALjklEQVR4Xu2cPY4kRRCFa6+Bg40N19gDYOKgdTDx9wZcABvh4+CssFfCweQCXGOYaE30Rn8ZmRmZ9V+dT/rETHdXZbx4b3pmFmmmaWhoaOgQ+uvzywsfG3oiSQFGCZ5YWoBRhCcVCzBK8GRi+KMETyYGP0rwZGLohK8fupgYuAevGbqQGHYOXjd0ETHo77/+IQl/lODCYshSgFGCJxID1gKMEjyJGK4twCjBE4jBsgCjBBcXQ2X4owQXFwNl8KMEjzvic6cXw2TohK+/7GKmdDeX9EpzDNyD11xtMfTlwWtOKxpj2B6///Q5WcgVFkMvNXj9KUVTDNtDCnClEnD+Fniv04mGGLaHFuDsJeDMvfC+pxLNMGwPW4BSCY66HM5Yw/rmcwrPOI1ohGF7sAClxRxtOZytRM43X6fwrFOIJmjag+HXFnOk5XAuD/r1fPOao/kMiwZo2oPBn2kxnKvF+9m8hsThadqDiyC855GWwrminnO+ea+j+a2Kg9O0B5fgwfvy3L3EuaKeS755v6N5LopD07QHF+DB+/LcvcS5op5rvnnPI3kuikPTtAfNe/C+PHcvca6o54hv3pdnH1IcmqY9aNyD9+W5e4lzRT33+ObZh1TPMmjag/fluXuJc0U99/jm2YdUzzJo2oP35bl7iXNFPff45tmHVM8yaNqD9+W5e4lzRT33+ObZh1TPMmjag/fluXuJc0U99/jm2YdUzzJo2oP35bl7iXNFPff45tmHVM8yaNqD9+W5e4lzRT33+ObZhxEX0LoMmvbgfTnDXuJcUc89vnn27qJxD5r2oGkP3pez7CXOFfXc45tn7yqazkHTHjTtwftyniXFs1qhvxz06GHvyzl3Ew2XoGkPmvbgfTnTkuJZrdBfDnr0sPflnJuIB9NsDZr2oGkP3tfOtLR4Viv0l4MePex9Oefq8g6nWfN8QnQZNO3hnLeaeFYr9JeDHj3sfTnnaqIhO4DzWAian7OItZfR489eQ3856NFjK883cckRJmcZHjQ/ZxFv566mnL+/fvw28XV/zlxDfzno0WMTz1xuCxMW8fL3x5eX394n0PycRbydu5oeznoN3WO6SgG4WM8IB8FQj+E/SQH+eP/V+QvApeYMcKB/Pn268fOHDzemJy+A7sPuhB496NFjVc9cKgf0BqVRW4KrFEBUK4EUQEswCvDEBbDh293Qowc9eqzqmUvlgN6gXgHuQW9YgE3JFMB+/rQFuIeuwTsF4P0ITXtw1k1xCmDfBew7waW/BUi4avQh+FGAO1oA+Zg+CT162DmY32zRKAe0gyZh52h8++9ZxOY44ecKQOh1jm/mN1s0ygHtoEnQJS5eAIZcg357fTO/2aJRDmgHTUKucdECMNwI9Nvrm/nNFo1yQDtoEnCNUYAnL8BbCSI/FdO0B2fdCv2h91IFoEmFAyaBtvD21a8F+PXPlzs8h6ZzcN61sLK/3y/9swD9edi5mGOXaNYyO3TFBO8VgGWg6RqcewlymvBPvSxBTxG0DPTlYWdkls2i6YcFMMRenPAn+WfilzR8haYjcP45UDqv/FfmswXIlcCDoeegt5xPxNkmmr4ZZ3hzeQ3fBivhc6H68VFKQMksOqeg80nwdl6GnYNhl6A/erR5NikxzeCi4Pd78vHdu/uCrCazUMFqzRLI2ywfs3AenUMft7MR8cqwczDoGjl/XxJtFI0nwUZ4C9ku4SYTvpLT5LwDyOdcrsKwPejNoj9seWFzHvs55yDWq4Ysj1vNKUHO3z3QFnEpXQVwwlfD/74uzAbPRVDT25It9p72c4btYcOlT/sTt77Gm0U/pr8a6lt2oI9Z9ZaA/roLwIUsHb5ICyDiczlNhRLYj+0i9HU9BeBZFhX9tWBLQM0twb4FMN/frWGVDV/E5yOS109OMPJ4pAC8LoeWISeG2kLpXUDUU4LZBWDwzQXIhK8Gvbd+z3xNvLcwOQGWAqdH+5z9NlASZ2iB3wooCXSJAjSVgBc2FcCEzwKovAL0iMsk/Ion9GeJhq/i2S2U3gVYgJYS0JPArF3xIiEJOkemACqG3yourwQDJ/RoaS2AijNE4LuAoNJAe0pATwrzTsQLBDdofp4J3xqaWwArLpIwcEKPlpYC8NwetADet4JcCbQI/Lz0DqAw8wfxxQLDjaDmVEuGL+ISCQMn9GjZowC1dwGGXULmpifC3O/iCxUGXMKaE2m7RwF8bAGWKIHOTl8W5v4gvlhJvhU4b//WmKoUPl8bFZdoYdge9GaxBdizBFbJ9/hC8BZ6U5j5g/hiJQmfJXBU++rXBbTo9nrnnUdg0DnozcIl3hbpLFxhmD14BRDUr9BTgFwJmHkiXqAk4WsBCqoVICSel4FB56AvCxdYK4CgwTDYFrwCkNbwcyVg3q54kZIUoCL7LkCJqaJ4lhP6kQowpwhaAD5OeDZn9aBnZp2ISyGR4FW1AgiJGPzJCtBahMhXP4mGrwWwvpn3g7iQHFGVCiBSQ3cx9AMUoFYCBt9agp4CiA/OmIPemflNXESNqKIFEJLAiRN6a/hbFyBSgt0LwCW0oIeI7KEqNZYrgRpKwvZwgj9DAWolyBVAz7Yf20A5Yw56/xK8GHCWkIM3K2F19QJESsDQvfBtAXi+Fygfz/GQy+uuHgsQKEHuZiWsFimAE/qZCpArQe2r30N98PEc90zedpUWIFMC3sjeLILqCgUQGHpLARj81gWwu/ILYIrAG/BmUVS2APcSMOAaTug94QsMfasC8PNcAXguUR983IO7qhfgx/Lvl1xmDVsAIQk2imPkTAXIsWYBuKdwAUpF4DJr3MVAe3DM8LwIDD1agNeVJTuaE75FC8AzPdQHH7dwT10F0BLo8u3hEZIAl+BgBWCQS8BzifrQz+113I9HUwEEL4BbwJkwktCWxDHEgGsw9KMVQLFn28fVh33slpOzG4/mAiQl0CD42NI4wxOGG4GhzymAB4NcEp51z8fZTY6uAtwOYUBr4gzuwXAjMPSWAkRLIDC8teBOalQLkISxBc6gOeSHJQ2D4UZg6K0FEPQndu4uB0PbAu5NqRZASALqwTl8Drp0GwTDjcDQewrQU4IoDLIX7k+JFcC5MAm4BK+diS77iAU4Qgl4vcAdKtUCJGG24hw6B7voIxVg7RIIDLoF7lFZrwA4SJbNJXr/X4ABl2AADDcCQ1+qAFH4r388l3n0FoF5xAtgL2DImbAZvMIlinoLoH876EgFEDhnDS2AfFw6l7kQBi5kc2wqQEPYRO8hfx8nVwBRSwH4x6MsDDcCQ59TAP5xK87uUSvA/Y9rY6c1WAZmo1QLIPAiD15D+JeyLLIAPuYF7nGUAnAuYkO3PqUA9G7hnj24a8LXW7oKwOej0FwELpKcpQD0FYF7j8K983lLqABLQ6MluEiPqxWAIa3JLgUQaLoEl0muVAAGtDa7FUDhAjy4THL0AtBPDoazBbsW4Jdv0h/+PLhQcoUC/PfxuxsMaG12KYAEr3ARObjUqxZg6xJsWgAbfEsBuFAv/CsVYMsibFIAhh4Nn4v0OEMBFPojLMAWRVi1AAx86fCFoxRgqRIILMCaRVitAAzcC57LaYUBMNwIDH3tAtSolWDpIixeAAbO4GmYcKktMNwIDH1OAVqgb1IrAoPsZVIxyFYYOIP3CsClzIXhRmDoWxXAI1eCNYswqRhoFAYeDX8UIIX74f4Y/hJFmFQMNgIDzwU/ChCD++H+1ijCpGK4JRh4JPxRgDrcD/e3RgkmFUP2YNgeHPSqBbDwnrn7cl7C/XB/0QK0FGFSMezW4NcoAJfKxZcCiMKQjlSAUgkYdgmGHi4Aw43AQUcBvkB/hPtZqgClIkyqucHXCkBjowAp3M/SBfCKMKmWCF+g6cE6MNRWkgIwyFY44GAbGGwrswvAgQb7wGCjdBeAAwyOAQOu0VwAHjg4Jgw6R1MBeMjg+DBwci/A0PPqfwCuqKnScBMkAAAAAElFTkSuQmCC>