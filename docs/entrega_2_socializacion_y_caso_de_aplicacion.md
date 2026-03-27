**HERRAMIENTAS PARA LA INDUSTRIALIZACIÓN**  
**DEL DESARROLLO DE SOFTWARE**  
**(Caso de Aplicación)**

** **  
   
**Informe técnico**  
**Node-RED**  
**  **  
**Autores:**  
**Daniel Alejandro Garcia Zuluaica**  
**Simon Ortiz Ohoa**  
**Juan Esteban Quintero Herrera**  
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
[1.1	Presentación de la Herramienta	4](#heading)  
[1.2	Arquitectura de la Herramienta	5](#heading=h.2bn6wsx)  
[1.3	Plataforma	5](#heading-1)  
[2\.	PROCESO DE DESARROLLO EN \<NOMBRE DE LA HERRAMIENTA\>	6](#heading=h.qsh70q)  
[2.1	Instalación	6](#heading-2)  
[2.2	Montaje de Modelos	6](#heading=h.3as4poj)  
[2.3	Orígenes de Datos	6](#heading-3)  
[2.4	Categorías de Controles y Funciones	6](#heading-4)  
[2.5	Aplicación en el Caso de Estudio	7](#heading-5)  
[2.6	Uso de DSLs en la Herramienta	7](#heading=h.1pxezwc)  
[2.7	Resultados Obtenidos	7](#heading=h.49x2ik5)  
[3\.	EVALUACIÓN DE \<NOMBRE DE LA HERRAMIENTA\>	8](#evaluación-de-\<nombre-de-la-herramienta\>)  
[3.1	Características Generales	8](#heading=h.2p2csry)  
[3.1.1	Documentación	8](#heading=h.147n2zr)  
[3.1.2	Usabilidad	8](#heading-6)  
[3.1.3	Despliegue e Internacionalización	8](#heading-7)  
[3.2	Características Comerciales	8](#heading=h.3o7alnk)  
[3.2.1	Reconocimiento y Madurez	8](#heading-8)  
[3.2.2	Licencias	8](#heading-9)  
[3.2.3	Soporte	9](#heading=h.23ckvvd)  
[4\.	CONCLUSIONES DE \<NOMBRE DE LA HERRAMIENTA\>	10](#conclusiones-de-\<nombre-de-la-herramienta\>)

 **LISTA DE FIGURAS**

**Página**

[**Figure 1\.**	Logo de \<Nombre de la Herramienta\>.	4](#heading-10)

[**Figure 2\.**	Diagrama de la Arquitectura de \<Nombre de la Herramienta\>.	5](#heading=h.ihv636)

1.  **NODE-RED**

Node-RED es una herramienta de programación visual basada en flujos (*flow-based programming*) desarrollada originalmente por el equipo de IBM Emerging Technology en 2013 y actualmente mantenida por la **OpenJS Foundation** como proyecto de código abierto. Permite construir aplicaciones, integraciones y automatizaciones conectando nodos mediante una interfaz visual de tipo *drag-and-drop*, sin necesidad de escribir código en la mayoría de los casos de uso.

  1. **Presentación de la Herramienta**

Node-RED es una plataforma Low-Code/No-Code de código abierto para la programación visual orientada a eventos. Está construida sobre Node.js y permite diseñar flujos de procesamiento de datos conectando nodos en un editor web, simplificando la integración de dispositivos, servicios y APIs.

| Característica | Detalle |
|---|---|
| Sitio oficial | https://nodered.org |
| Versión utilizada | **4.1.7** |
| Módulo de UI | node-red-dashboard 2.30.0 |
| Licencia | Apache 2.0 |
| Runtime base | Node.js 20.x |
| Organización mantenedora | OpenJS Foundation |

\[Figura 1: Logo de Node-RED\]

   2. **Arquitectura de la Herramienta**

La arquitectura de Node-RED se divide en tres componentes principales que trabajan de forma coordinada:

**Editor (capa de diseño):** Interfaz web accesible desde el navegador en el puerto 1880. Permite diseñar flows arrastrando nodos al canvas, configurarlos y conectarlos mediante cables. Se comunica con el runtime mediante HTTP y WebSocket.

**Runtime (capa de ejecución):** Motor basado en Node.js que ejecuta los flows desplegados. Gestiona el ciclo de vida de los nodos, el enrutamiento de mensajes (`msg`) entre nodos y el API REST interno.

**Almacenamiento (capa de persistencia):** Los flows se almacenan en el sistema de archivos local en el archivo `flows.json`, que puede versionarse con git. El contexto de variables (global, flow, node) se gestiona en memoria durante la ejecución.

```
┌─────────────────────────────────────────────────────┐
│                   Navegador web                     │
│           Editor de flows (puerto 1880)             │
│   Paleta  ││  Canvas (flows.json)  ││  Panel debug  │
└───────────────────────┬─────────────────────────────┘
                        │ HTTP/WS
┌───────────────────────▼─────────────────────────────┐
│               Motor Node-RED (Node.js)               │
│  Runtime de nodos  ││  Context Store  ││  API REST   │
└───────────────────────┬─────────────────────────────┘
                        │
          ┌─────────────┴─────────────┐
          │  data/flows.json          │
          │  data/settings.js         │
          └───────────────────────────┘
```

\[Figura 2: Diagrama de la Arquitectura de Node-RED\]

   3. **Plataforma**

Node-RED está construido sobre Node.js, lo que lo hace multiplataforma y permite ejecutarlo en una amplia variedad de entornos:

| Dimensión | Detalle |
|---|---|
| **Runtime** | Node.js 18.x / 20.x (LTS) |
| **Sistemas operativos** | Linux, macOS, Windows, Raspberry Pi OS, Docker |
| **Lenguajes embebidos** | JavaScript (nodos `function`), Mustache (nodos `template`) |
| **Bases de datos soportadas** | MySQL, PostgreSQL, MongoDB, SQLite, Redis, CouchDB (via nodos npm) |
| **Protocolos de red** | HTTP/HTTPS, MQTT, WebSocket, TCP, UDP |
| **Plataformas de despliegue** | Local, Docker, Raspberry Pi, AWS, Azure, IBM Cloud, FlowFuse |

En este proyecto se utilizó **Docker** como plataforma de despliegue, con Node.js 20.x como runtime base y node-red-dashboard 2.30.0 como módulo adicional para la construcción de la interfaz de usuario del caso de estudio.

2. **PROCESO DE DESARROLLO EN** NODE-RED

El proceso de desarrollo en Node-RED se centra en la construcción visual de flows, su despliegue inmediato y su refinamiento incremental. En este proyecto se siguió un flujo de trabajo compuesto por instalación del entorno con Docker, modelado visual de procesos en el editor web, almacenamiento temporal de entidades mediante contexto global y validación funcional en el dashboard.

\[Figura recomendada: canva.png con el flujo general de desarrollo en Node-RED\]

1. **Instalación**

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
- Docker Compose

*Paso 1 — Crear el archivo `Dockerfile`*

Se crea una imagen personalizada basada en la imagen oficial de Node-RED, agregando el módulo `node-red-dashboard` para habilitar la construcción de interfaces de usuario:

```dockerfile
FROM nodered/node-red:latest

RUN npm install --unsafe-perm --no-update-notifier --no-fund \
      --prefix /usr/src/node-red \
      node-red-dashboard
```

*Paso 2 — Crear el archivo `docker-compose.yml`*

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

La principal ventaja de este enfoque es la reproducibilidad: cualquier integrante del equipo puede levantar exactamente el mismo entorno a partir del repositorio.

2. **Montaje de Modelos**

En Node-RED, el modelo corresponde a un **flow**, es decir, un proceso representado visualmente mediante nodos y conexiones. El entorno de modelado es el editor web accesible desde http://localhost:1880.

**Elementos del entorno de modelado**

- **Paleta de nodos:** panel izquierdo que agrupa los nodos por categorías (`common`, `function`, `network`, `dashboard`, entre otras).
- **Canvas:** área central donde se arrastran, organizan y conectan los nodos para construir cada flow.
- **Panel lateral:** panel derecho con pestañas de información, depuración y ayuda contextual.

**Proceso de construcción de un flow**

1. Se arrastra un nodo desde la paleta al canvas.
2. Se configura el nodo con doble clic, definiendo nombre, parámetros o lógica interna.
3. Se conectan los nodos mediante cables para modelar el flujo de mensajes.
4. Se despliega el flow con el botón **Deploy**.
5. El flow queda activo inmediatamente en el runtime.

Cada flow se guarda automáticamente en el archivo `data/flows.json`, lo que permite versionarlo con git. Para este proyecto se implementaron cinco tabs principales: `AgroCadenas`, `Usuarios`, `Control de Acceso`, `Tablas Maestro` y `Módulos`.

\[Captura recomendada: editor con paleta, canvas y panel lateral\]

3. **Orígenes de Datos**

Node-RED no incorpora un motor de base de datos propio. En su lugar, se conecta a fuentes de datos externas mediante nodos especializados instalables desde npm, lo que le permite integrarse con múltiples tecnologías.

| Categoría | Ejemplos | Nodo disponible |
|---|---|---|
| Bases de datos relacionales | MySQL, PostgreSQL, SQLite, SQL Server | `node-red-node-mysql`, `node-red-contrib-postgresql` |
| Bases de datos NoSQL | MongoDB, CouchDB, Redis | `node-red-node-mongodb`, `node-red-contrib-couchdb` |
| APIs REST | Servicios HTTP | `http request` |
| Protocolos IoT | MQTT, CoAP, Modbus | `mqtt in/out`, `node-red-contrib-modbus` |
| Archivos | CSV, JSON, XML | `file`, `file in` |
| Contexto interno | Memoria o sistema de archivos local | `global`, `flow`, `context` |

En el caso de estudio Evergreen se utilizó el **contexto global de Node-RED** como mecanismo de almacenamiento temporal en memoria. Por ejemplo:

```javascript
global.set('roles', listaRoles);
var roles = global.get('roles') || [];
```

Esta decisión simplificó el desarrollo del prototipo académico, aunque implica una limitación de persistencia. En un escenario productivo se recomienda reemplazar este mecanismo por una base de datos externa.

Como refinamiento derivado de la retroalimentación, se incorpora además el **diagrama de clases del dominio del módulo ADM de Evergreen**, construido a partir de la propuesta de dominio suministrada para el caso de estudio y refinado durante la implementación de los flows en Node-RED. Este diagrama permite representar de manera explícita las entidades, atributos y relaciones que sirven como base conceptual para el prototipo desarrollado.

En el diagrama se integran las entidades de gestión de usuarios, control de acceso, navegación del sistema, AgroCadenas y tablas maestro. De esta manera, el modelo conceptual facilita la trazabilidad entre el problema del dominio, las historias de usuario asignadas al equipo y las estructuras de datos manipuladas dentro de los flows.

Durante la implementación se ajustó la relación de acceso para reflejar la lógica real del sistema: el acceso a las opciones no ocurre directamente desde el rol Invitado, sino que está mediado por los permisos asignados al rol correspondiente. Por ello, la cadena de acceso implementada y representada en el modelo es: **Usuario → Rol → Permiso → Opción**.

![Figura 3. Diagrama de clases del dominio del módulo ADM de Evergreen.](img/diagrama_clases_adm_cuadrado.png)

**Figura 3.** Diagrama de clases del dominio del módulo ADM de Evergreen.

El diagrama anterior orientó la construcción de los flows y la definición de las estructuras almacenadas en el contexto global de Node-RED, sirviendo como referencia para la implementación de formularios, validaciones, tablas y relaciones entre entidades.

4. **Categorías de Controles y Funciones**

Node-RED organiza sus nodos en categorías dentro de la paleta del editor. Cada categoría agrupa nodos con una función similar:

**Common (Comunes)**

| Nodo | Función |
|---|---|
| `inject` | Dispara mensajes manualmente o por temporizador |
| `debug` | Muestra mensajes en el panel de depuración |
| `catch` | Captura errores de otros nodos |
| `complete` | Se activa cuando otro nodo finaliza |
| `comment` | Agrega documentación en el canvas |

**Function (Transformación y lógica)**

| Nodo | Función |
|---|---|
| `function` | Ejecuta código JavaScript sobre `msg` |
| `switch` | Enruta mensajes según condiciones |
| `change` | Modifica propiedades del mensaje |
| `template` | Genera texto con Mustache |
| `json` | Convierte entre string JSON y objeto |

**Network (Red)**

| Nodo | Función |
|---|---|
| `http in` / `http response` | Expone endpoints HTTP |
| `http request` | Consume APIs externas |
| `mqtt in/out` | Publica y consume mensajes MQTT |
| `websocket in/out` | Comunicación en tiempo real |

**Storage (Almacenamiento)**

| Nodo | Función |
|---|---|
| `file` | Escribe archivos |
| `file in` | Lee archivos |
| `watch` | Monitorea cambios de archivos |

**Dashboard (Interfaz de usuario)**

| Nodo | Función |
|---|---|
| `ui_button` | Botón interactivo |
| `ui_form` | Formulario con múltiples campos |
| `ui_table` | Tabla para visualizar registros |
| `ui_toast` | Notificación emergente |
| `ui_text` | Texto estático o dinámico |
| `ui_tab` / `ui_group` | Estructura de navegación y agrupación |

En el caso de estudio, los nodos más utilizados fueron `ui_form`, `ui_table`, `ui_toast`, `function` e `inject`, pues permitieron modelar validaciones, almacenamiento y visualización de las entidades del módulo ADM.

5. **Aplicación en el Caso de Estudio**

Para el módulo de Administración (ADM) del sistema Evergreen, se implementó en Node-RED un conjunto de flujos que permiten gestionar las entidades centrales del módulo: AgroCadenas y etapas productivas, usuarios del sistema, roles y permisos, catálogos maestros y módulos de navegación. A continuación se describe la implementación de cada historia de usuario asignada al equipo.

---

**HU1 – Simón Ortiz**

Para el macroproceso de Administración (ADM) del sistema Evergreen, se implementó una solución utilizando Node-RED que permite gestionar AgroCadenas y sus respectivas etapas productivas, alineándose con la propuesta de entidades del dominio definida para el sistema.

En este contexto, se desarrolló la siguiente historia de usuario:

**HU1 – Registro de AgroCadena**
Como usuario del sistema Evergreen, quiero registrar una nueva AgroCadena junto con sus etapas productivas, para tener un registro centralizado de las cadenas agroalimentarias activas y poder consultarlas en cualquier momento.

**Descripción de la solución**

La solución consiste en la construcción de un flujo en Node-RED que permite registrar AgroCadenas, asociarles etapas productivas y visualizar la información en tiempo real mediante una interfaz gráfica. Para la persistencia de datos se utilizó el contexto global de Node-RED, el cual permite almacenar la información en memoria y simular el comportamiento de una base de datos.

**Modelado del dominio**

De acuerdo con la propuesta de entidades del dominio, se identificó la entidad AgroCadena como elemento principal del sistema dentro del macroproceso ADM. Asimismo, se modeló la entidad Etapa, la cual representa cada una de las fases del proceso productivo. La relación entre ambas entidades es de tipo composición (1:N), donde una AgroCadena puede contener múltiples etapas. Esta relación se implementó mediante un arreglo de etapas dentro de cada objeto AgroCadena, respetando la composición definida en el modelo de dominio.

**Funcionamiento del flujo**

1. *Inicialización del almacenamiento:* Se implementó un nodo de inicialización que configura las estructuras de almacenamiento en el contexto global. En este paso se crea la variable `agrocadenas` en caso de que no exista, garantizando la correcta ejecución del sistema.

2. *Registro de AgroCadenas:* El usuario ingresa los datos de la AgroCadena (nombre, descripción y estado) a través de un formulario (`ui_form`). Estos datos son procesados mediante un nodo `function`, donde se valida la estructura del mensaje recibido, se genera un identificador único utilizando `Date.now()` y se almacena la AgroCadena en el arreglo global. Posteriormente, el sistema envía una notificación de confirmación al usuario (`ui_toast`) y actualiza la tabla de visualización.

3. *Gestión de etapas:* Se desarrolló un flujo que permite agregar etapas a una AgroCadena existente. El usuario proporciona el identificador de la AgroCadena y los datos de la etapa. Luego, se busca la AgroCadena correspondiente, se valida su existencia, se inicializa el arreglo de etapas en caso de no existir y se agrega la nueva etapa. Esto garantiza la correcta asociación entre entidades y evita errores en la ejecución.

4. *Visualización de la información:* Se implementó una tabla (`ui_table`) que muestra las AgroCadenas registradas. Un nodo `function` transforma los datos almacenados en el contexto global en un formato adecuado para su visualización. La tabla se actualiza automáticamente cada vez que se registra una AgroCadena o se agrega una etapa, sin necesidad de recargar la página.

**Componentes utilizados**

- Nodos de interfaz (`ui_form`, `ui_table`, `ui_button`) para interacción con el usuario.
- Nodos `function` para la lógica de negocio (validación, almacenamiento y transformación de datos).
- Nodos de notificación (`ui_toast`) para retroalimentación.
- Contexto global (`global`) como mecanismo de almacenamiento en memoria.

**Consideraciones técnicas**

El sistema utiliza almacenamiento en memoria mediante variables globales, lo cual permite una implementación sencilla y funcional para fines académicos. Sin embargo, esta solución no garantiza persistencia a largo plazo, por lo que en un entorno productivo se recomienda el uso de una base de datos externa que permita escalabilidad, integridad y recuperación de la información.

\[Captura: Flujo de implementación en Node-RED para la gestión de AgroCadenas y etapas\]

\[Captura: Interfaz de usuario para el registro de AgroCadenas y gestión de etapas\]

\[Captura: Implementación de la lógica de negocio mediante nodos function en Node-RED\]

---

**HU2 – Juan Esteban Quintero**

Para el macroproceso de Administración (ADM) del sistema Evergreen, se implementó en Node-RED una solución orientada al registro y consulta de usuarios del sistema. Esta funcionalidad permite mantener un directorio actualizado de personas con acceso a la aplicación, registrando su información básica, credenciales y tipo de usuario, y mostrando los resultados en una tabla dinámica dentro del dashboard.

En este contexto, se desarrolló la siguiente historia de usuario:

**HU2 – Registro y consulta de usuarios**
Como usuario del sistema Evergreen, quiero registrar nuevos usuarios con su información básica y tipo, para mantener un directorio actualizado de las personas que tienen acceso al sistema y poder consultarlo en cualquier momento.

**Descripción de la solución**

La solución se construyó mediante un flujo en Node-RED ubicado en la pestaña Usuarios, compuesto por un formulario de captura, nodos de validación, almacenamiento en memoria y una tabla de visualización. El flujo permite ingresar nombre, apellido, nombre de usuario, clave, tipo de usuario y estado, procesar la información y mostrarla inmediatamente en la interfaz sin necesidad de recargar la página. Para la persistencia temporal se utilizó el contexto global de Node-RED, almacenando la información en una estructura llamada `global.usuarios`.

**Modelado del dominio**

Dentro del módulo ADM, la entidad principal implementada en esta historia de usuario es `Usuario`. Esta entidad concentra la información básica de cada persona registrada en el sistema: nombres, apellidos, nombre de usuario, clave, tipo de usuario, estado y fecha de registro. A su vez, la solución se relaciona con la entidad `TipoUsuario`, cuyos valores son cargados desde los catálogos o tablas maestras ya definidos en el sistema. Por razones de privacidad, la clave se almacena en la estructura interna pero no se expone en la tabla de consulta.

**Funcionamiento del flujo**

1. *Inicialización del almacenamiento:* Se implementó un nodo de inicialización que verifica si existe la estructura `global.usuarios`; en caso contrario, la crea como un arreglo vacío. De manera similar, se valida la disponibilidad de la lista de tipos de usuario proveniente de los catálogos del módulo ADM.

2. *Registro del usuario:* El usuario diligencia el formulario con los campos nombre, apellido, usuario, clave, tipo de usuario y estado. Estos datos son enviados a un nodo `function`, donde se valida que los campos obligatorios estén presentes y que el nombre de usuario no esté repetido dentro del arreglo global.

3. *Validación de duplicados:* Antes de almacenar la información, el sistema recorre `global.usuarios` y compara el valor del campo `usuario` con los registros existentes. Si encuentra coincidencia, emite una notificación de error mediante `ui_toast` con el mensaje "usuario ya existe" y no realiza el guardado. Si no existe duplicado, crea el nuevo objeto usuario, asigna la fecha de registro y lo agrega al almacenamiento.

4. *Visualización de la información:* Un nodo `function` transforma los datos registrados en un formato apto para la tabla `ui_table`, ocultando el campo clave y mostrando únicamente la información necesaria para consulta. La tabla se actualiza automáticamente después de cada inserción válida.

**Componentes utilizados**

- Nodos de interfaz (`ui_form`, `ui_table`, `ui_toast`) para capturar datos, mostrar resultados y retroalimentar al usuario.
- Nodos `function` para implementar la lógica de validación, control de duplicados, almacenamiento y preparación de la información.
- Contexto global (`global`) como mecanismo de almacenamiento en memoria.

**Consideraciones técnicas**

La solución implementada cumple adecuadamente con fines académicos y de demostración funcional, pero presenta una limitación importante: el almacenamiento se realiza en memoria, por lo que los datos pueden perderse si el sistema se reinicia o si no se configura persistencia adicional. En un entorno productivo, sería recomendable integrar una base de datos relacional o documental para garantizar persistencia, integridad y escalabilidad.

\[Captura: Flujo de implementación en Node-RED para el registro y consulta de usuarios\]

\[Captura: Interfaz para el registro y visualización de usuarios\]

\[Captura: Interfaz para cambiar el estado de usuario y asignar rol\]

---

**HU3 – Daniel Garcia**

Para el macroproceso de Administración (ADM) del sistema Evergreen, se implementó en Node-RED una solución orientada al control de acceso del sistema. Esta funcionalidad permite crear roles, definirles permisos y asignarlos a los usuarios registrados, estableciendo así qué acciones puede realizar cada persona dentro del sistema.

En este contexto, se desarrolló la siguiente historia de usuario:

**HU3 – Asignación de roles y permisos**
Como usuario del sistema Evergreen, quiero crear roles, definirles permisos y asignarlos a los usuarios registrados, para controlar qué acciones puede realizar cada persona dentro del sistema.

**Descripción de la solución**

La solución se construyó mediante un flujo en Node-RED ubicado en la pestaña Control de Acceso, compuesto por tres grupos funcionales: gestión de roles, gestión de permisos y asignación de permisos a roles. Cada grupo cuenta con su propio formulario de captura, nodos de validación, almacenamiento en memoria y tabla de visualización. Para la persistencia temporal se utilizó el contexto global de Node-RED, almacenando los datos en las estructuras `global.roles` y `global.permisos`, y consultando `global.paginas` para validar la vinculación de permisos con opciones.

**Modelado del dominio**

Dentro del módulo ADM, las entidades implementadas en esta historia de usuario son `Rol` y `Permiso`. La entidad `Rol` es abstracta en el modelo de dominio y se concreta en dos tipos: `Admin` (acceso total al sistema) e `Invitado` (acceso restringido a opciones específicas). La entidad `Permiso` representa una habilitación concreta sobre una acción del sistema y se asocia a los roles mediante una relación de asignación; además, puede vincularse a una o más opciones del sistema mediante `opcion_ids`. La cadena de acceso resultante es: `Usuario → Rol → Permiso → Opcion`, lo que permite un control granular sobre las funcionalidades disponibles para cada usuario.

Ambas entidades, `Admin` e `Invitado`, vienen precargadas en el sistema desde el nodo de inicialización (`fn-init-storage`), junto con tres permisos base: Ver, Editar y Eliminar.

**Funcionamiento del flujo**

1. *Inicialización del almacenamiento:* El nodo `fn-init-storage` siembra las estructuras globales al arrancar el sistema. Los roles `Admin` e `Invitado` se crean con IDs fijos (`'1'` y `'2'`) y con un arreglo vacío de permisos. Los permisos Ver, Editar y Eliminar se precrean con IDs `'1'`, `'2'` y `'3'` respectivamente. Si las estructuras ya existen (por ejemplo, tras un reinicio), no se sobreescriben.

2. *Creación de roles:* El usuario ingresa el nombre del nuevo rol mediante un formulario (`ui_form`). Un nodo `function` valida que el campo no esté vacío y que el nombre no esté duplicado (comparación sin distinción de mayúsculas). Si la validación es exitosa, se crea el objeto rol con un ID generado por `Date.now()`, fecha de creación y arreglo de permisos vacío, y se almacena en `global.roles`. El sistema emite una notificación de éxito (`ui_toast`) y actualiza automáticamente la tabla de roles.

3. *Creación de permisos:* De forma análoga a los roles, el usuario puede registrar nuevos permisos con nombre personalizado. Además, el formulario permite enviar un `opcion_id` opcional para vincular el permiso con una opción existente del módulo de navegación. El flujo valida duplicados antes de almacenar y valida que el `opcion_id` exista; luego, guarda la relación en `opcion_ids`. La tabla de permisos se actualiza tras cada creación exitosa, mostrando el ID, nombre, cantidad de opciones asociadas y fecha de creación.

4. *Asignación de permisos a roles:* El usuario proporciona el ID del rol y el ID del permiso a través de un formulario. El nodo `function` correspondiente valida que ambos existan en el almacenamiento global, verifica que el permiso no haya sido asignado previamente al rol (evitando duplicados), y en caso de ser válido, agrega el ID del permiso al arreglo `rol.permisos`. Tras la asignación exitosa, la tabla de roles se refresca automáticamente mostrando los nombres de los permisos asignados a cada rol.

**Componentes utilizados**

- Nodos de interfaz (`ui_form`, `ui_table`, `ui_button`, `ui_toast`) para captura de datos, visualización y retroalimentación.
- Nodos `function` (`fn-guardar-rol`, `fn-guardar-permiso`, `fn-asignar-permiso-rol`, `fn-refrescar-roles`, `fn-refrescar-permisos`) para la lógica de validación, almacenamiento y transformación de datos.
- Contexto global (`global.get` / `global.set`) como mecanismo de almacenamiento en memoria compartida entre todos los flujos.
- Nodo `inject` vinculado al nodo `fn-init-storage` para la inicialización automática al desplegar el flow.

**Consideraciones técnicas**

La solución implementada es funcional para el prototipo académico requerido. La principal limitación es el almacenamiento en memoria: los roles y permisos creados durante la sesión se pierden si el contenedor Docker se reinicia sin configurar persistencia en el archivo `settings.js` de Node-RED. En un escenario productivo, se recomendaría persistir los datos en una base de datos relacional (PostgreSQL, MySQL) o documental (MongoDB), accesible desde Node-RED mediante nodos de conexión como `node-red-contrib-postgresql` o el nodo nativo `http request` hacia una API externa.

\[Captura: Flujo de implementación en Node-RED para la gestión de roles y permisos\]

\[Captura: Interfaz del dashboard — sección Roles con Admin e Invitado precargados\]

\[Captura: Interfaz del dashboard — sección Asignar Permiso a Rol y resultado en tabla\]

6. **Uso de DSLs en la Herramienta**

Node-RED utiliza dos niveles complementarios de DSL dentro de la herramienta.

**DSL visual basado en grafos**

El primer nivel es el propio lenguaje visual de Node-RED. Cada flow se modela como un grafo dirigido donde:

- Cada **nodo** representa una operación de entrada, procesamiento, decisión o salida.
- Cada **wire** representa el flujo de mensajes entre nodos.
- El mensaje circula como un objeto JavaScript `msg`, cuya propiedad central es `msg.payload`.

Este DSL es declarativo y visual: la lógica general se entiende observando la topología del flow. Por ejemplo, en la historia de usuario HU3 el recorrido `ui_form -> function -> ui_toast -> ui_table` expresa el proceso de creación y asignación de permisos sin necesidad de una sintaxis textual compleja.

**DSL imperativo embebido en nodos `function`**

El segundo nivel aparece en los nodos `function`, donde se escribe JavaScript para implementar reglas de negocio. En este proyecto se utilizó para validar duplicados, consultar el contexto global y transformar datos para las tablas.

Ejemplo simplificado del nodo `fn-asignar-permiso-rol`:

```javascript
if (!msg.payload || !msg.payload.rol_id || !msg.payload.permiso_id) { return null; }
var roles = global.get('roles') || [];
var permisos = global.get('permisos') || [];
var rol = roles.find(function(r){ return r.id === msg.payload.rol_id; });
var permiso = permisos.find(function(p){ return p.id === msg.payload.permiso_id; });
if (!rol || !permiso) {
   msg.payload = 'Error en IDs enviados';
   return msg;
}
if (!rol.permisos) rol.permisos = [];
if (rol.permisos.includes(permiso.id)) {
   msg.payload = 'Permiso ya asignado';
   return msg;
}
rol.permisos.push(permiso.id);
global.set('roles', roles);
msg.payload = 'Permiso asignado correctamente';
return msg;
```

La diferencia entre ambos niveles es que el flow visual describe la estructura general del proceso, mientras que el nodo `function` contiene la lógica imperativa puntual que no puede expresarse solo con conexiones.

\[Captura recomendada: canvas mostrando un flow y un nodo `function` abierto con código\]

7. **Resultados Obtenidos**

La implementación del caso de estudio permitió construir un prototipo funcional del módulo ADM de Evergreen en Node-RED, con interfaz web operativa en `http://localhost:1880/ui` y lógica de negocio distribuida en flows visuales.

Los resultados se resumen en la siguiente tabla de pruebas por historia de usuario:

| HU | Entrada de prueba | Resultado esperado | Resultado obtenido |
|---|---|---|---|
| HU1 | Registrar AgroCadena con nombre, descripción y estado | La AgroCadena aparece en la tabla con ID generado | Correcto. La tabla se actualiza automáticamente |
| HU1 | Agregar etapa a una AgroCadena existente | La etapa queda asociada a la cadena | Correcto. La asociación se guarda en el arreglo `etapas` |
| HU2 | Registrar usuario con todos los campos | El usuario queda visible en tabla con fecha de registro | Correcto |
| HU2 | Registrar usuario duplicado | El sistema bloquea el registro y muestra error | Correcto. Se emite notificación "usuario ya existe" |
| HU3 | Crear rol nuevo | El rol aparece en la tabla de roles | Correcto |
| HU3 | Crear permiso con `opcion_id` válido | El permiso se crea y queda vinculado a la opción indicada | Correcto. Se almacena en `opcion_ids` y aumenta el contador de opciones |
| HU3 | Asignar permiso existente a rol válido | El rol muestra el permiso asignado | Correcto. La tabla se refresca automáticamente |
| HU3 | Repetir la misma asignación | El sistema muestra error por duplicado | Correcto. Se evita la duplicación |

**Análisis de resultados**

- El dashboard cumple con el objetivo académico de demostrar interacción, validación y visualización inmediata.
- La lógica de negocio quedó correctamente separada por tabs y por entidad principal.
- El uso de contexto global permitió compartir estado entre flows de manera simple.
- La principal limitación encontrada es la persistencia en memoria, que no es adecuada para producción sin un backend externo.

\[Captura pendiente: Dashboard de AgroCadenas en ejecución\]

\[Captura pendiente: Dashboard de Usuarios en ejecución\]

\[Captura pendiente: Dashboard de Control de Acceso en ejecución\]

3. **EVALUACIÓN DE** NODE-RED 

   1. **Características Generales**

      1. **Documentación**

   Node-RED cuenta con documentación oficial amplia, organizada y actualizada en https://nodered.org/docs. El sitio incluye guías de instalación, desarrollo de nodos, uso del editor, manejo del contexto y despliegue. Además, la comunidad mantiene ejemplos, tutoriales y foros que facilitan el aprendizaje. La documentación del dashboard clásico sigue disponible en la Flow Library, aunque se indica su estado de deprecación.

2. **Usabilidad**

   La usabilidad de Node-RED es alta para prototipos, automatizaciones e integraciones. Su interfaz visual reduce la barrera de entrada y permite construir flujos funcionales rápidamente. Sin embargo, a medida que la lógica crece, mantener flows grandes exige disciplina en la organización del canvas, nombrado de nodos y separación por tabs.

3. **Despliegue e Internacionalización**

   Node-RED puede desplegarse en entornos locales, Raspberry Pi, contenedores Docker y nubes públicas. En este proyecto se desplegó mediante Docker Compose, lo que simplificó la estandarización del entorno. En cuanto a internacionalización, la herramienta soporta múltiples idiomas en ciertos componentes y permite construir interfaces localizables, aunque no ofrece por defecto un framework avanzado de i18n para dashboards complejos.

2. **Características Comerciales**

   1. **Reconocimiento y Madurez**

   Node-RED es una herramienta madura, con comunidad consolidada y adopción amplia en integración de sistemas, IoT, automatización industrial y prototipado rápido. La versión utilizada en este proyecto fue la 4.1.7. Su respaldo por la OpenJS Foundation y su ecosistema de nodos publicados en npm le otorgan estabilidad y continuidad.

2. **Licencias**

   Node-RED se distribuye bajo licencia **Apache 2.0**, lo que permite su uso, modificación y redistribución sin costo. Existen alternativas comerciales y de soporte empresarial alrededor del ecosistema, como FlowFuse, pero el núcleo de la herramienta permanece libre y abierto.

3. **Soporte**

   El soporte de Node-RED puede abordarse desde dos enfoques: comunitario y empresarial. El soporte comunitario se apoya en la documentación oficial, foros, GitHub y la comunidad global sin costo directo. Para organizaciones que requieren soporte formal, gestión centralizada y operación multiinstancia, existen ofertas comerciales como FlowFuse con planes de pago.

   **Tabla resumen de evaluación**

   | Criterio | Valoración | Justificación breve |
   |---|---|---|
   | Documentación | Alto | Documentación oficial extensa y fácil de consultar |
   | Usabilidad | Alto | El modelado visual acelera el desarrollo de prototipos |
   | Despliegue | Alto | Docker, nube y ejecución local simplifican la operación |
   | Internacionalización | Medio | Posible, pero no es una fortaleza central del dashboard |
   | Reconocimiento y madurez | Alto | Proyecto estable, respaldado por OpenJS y amplia comunidad |
   | Licencias | Alto | Apache 2.0, libre y abierta |
   | Soporte | Medio | Muy bueno a nivel comunitario, más estructurado con opciones comerciales |

   4. **CONCLUSIONES DE** NODE-RED

   - **Hallazgo:** Node-RED permitió implementar rápidamente las historias de usuario del módulo ADM mediante flows visuales. **Implicación:** es una herramienta adecuada para prototipos funcionales y validación temprana de procesos de negocio.
   - **Hallazgo:** La combinación entre nodos visuales y lógica en `function` ofreció suficiente flexibilidad para modelar validaciones, transformaciones y reglas específicas. **Implicación:** la herramienta logra un equilibrio útil entre low-code y programación imperativa.
   - **Hallazgo:** El dashboard permitió construir una interfaz web simple, pero suficiente para operar el caso de estudio sin desarrollar frontend adicional. **Implicación:** se redujo el esfuerzo de implementación para demostrar resultados del módulo ADM.
   - **Hallazgo:** El almacenamiento en contexto global simplificó el desarrollo, pero no garantiza persistencia ni escalabilidad. **Implicación:** para un entorno productivo sería necesario integrar una base de datos externa y fortalecer el modelo de seguridad.
   - **Hallazgo:** La organización por tabs y entidades mejoró la claridad del proyecto y su relación con el modelo de dominio. **Implicación:** la trazabilidad entre diagrama de clases, historias de usuario y flows quedó más clara para la evaluación académica.

   **Tabla de H de U por integrante**

   | Integrante | Historia de Usuario | Horas de uso planeadas |
   |---|---|---|
   | Daniel Alejandro Garcia Zuluaica | HU3 — Asignación de roles y permisos | 8 horas |
   | Simon Ortiz Ohoa | HU1 — Registro de AgroCadena | 8 horas |
   | Juan Esteban Quintero Herrera | HU2 — Registro y consulta de usuarios | 8 horas |

   **Referencias**

   1. OpenJS Foundation. (2025). *Node-RED*. https://nodered.org
   2. OpenJS Foundation. (2025). *Node-RED Documentation*. https://nodered.org/docs
   3. npm, Inc. (2025). *node-red-dashboard*. https://www.npmjs.com/package/node-red-dashboard
   4. GitHub. (2025). *node-red/node-red*. https://github.com/node-red/node-red
   5. FlowFuse Inc. (2025). *FlowFuse for Node-RED*. https://flowfuse.com


[image1]: <data:image/png;base64,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>