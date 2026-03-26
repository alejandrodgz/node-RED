# Guía Entrega 2 – Caso ADM con Node-RED

## 1. Qué es la Entrega 2

En esta entrega ya no es solo teoría.  
Ahora deben **construir algo funcional** usando la herramienta (Node-RED) aplicado al caso EverGreen, específicamente al módulo ADM (Administración).

La idea es demostrar que:
- Entendieron la herramienta
- Saben aplicarla en un caso real
- Pueden modelar una solución funcional

---

## 2. Qué deben hacer (Resumen claro)

- Corregir el informe de la entrega 1 (si hubo feedback)
- Construir una **aplicación funcional en Node-RED**
- Cada integrante desarrolla una parte (historia de usuario)
- Documentar cómo lo hicieron
- Mostrar resultados reales (capturas o pruebas)

---

## 3. Qué es el módulo ADM (Administración)

El módulo ADM se encarga de:

- Gestión de usuarios
- Autenticación (login)
- Validaciones (correo, teléfono)
- Control de acceso (roles y permisos)

En su caso, ya definieron servicios como:
- Validar número de teléfono
- Validar correo
- Login

---

## 4. Historias de Usuario (lo más importante)

Deben convertir eso en **historias de usuario reales**.

### HU1: Validar correo
Como sistema,  
quiero validar si un correo es válido  
para evitar registros incorrectos.

### HU2: Validar teléfono
Como sistema,  
quiero validar el número de teléfono  
para asegurar datos correctos del usuario.

### HU3: Login
Como usuario,  
quiero iniciar sesión  
para acceder al sistema con mis permisos.

---

## 5. Qué deben construir en Node-RED

Deben hacer un flujo tipo:

1. Entrada de datos (correo, teléfono, usuario)
2. Validación de correo (API apilayer)
3. Validación de teléfono
4. Simulación de login
5. Asignación de rol (admin, invitado, etc.)
6. Salida con resultado

Ejemplo de flujo:

Input → Validar Email → Validar Teléfono → Login → Asignar Rol → Output

---

## 6. Cómo se conecta con el informe

### 2.5 Aplicación en el caso de estudio

Aquí explican:

- Qué flujo hicieron
- Qué nodos usaron
- Cómo funciona la lógica
- Cómo se conecta con ADM

---

### 2.6 Uso de DSLs

Aquí explican:

- Node-RED es un DSL visual (flujo por nodos)
- También usan JavaScript en nodos function
- No escriben backend tradicional → es flujo declarativo

---

### 2.7 Resultados obtenidos

Aquí muestran:

- Capturas del flujo
- Ejecución funcionando
- Inputs y outputs
- Validaciones correctas

---

## 7. Entregables

Deben entregar:

- Informe actualizado
- Flujo funcional en Node-RED
- Evidencias (capturas)
- Presentación (PowerPoint)

---

## 8. Qué espera el profesor (CLAVE)

No espera algo perfecto, espera:

- Que funcione
- Que tenga sentido con ADM
- Que esté bien explicado
- Que conecte teoría + práctica

---

## Conclusión

Lo que están haciendo es:

Construir un mini sistema de administración usando Node-RED,  
simulando validaciones, login y control de usuarios,  
y demostrando cómo una arquitectura se implementa en la práctica.
