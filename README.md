# 🚗 AutoRent

Sistema de alquiler de vehículos desarrollado en Java aplicando patrones de diseño (GoF) y arquitectura DAO, con persistencia de datos en PostgreSQL.

---

# Descripción

AutoRent es una aplicación de consola que permite gestionar el proceso completo de alquiler de vehículos.

El sistema ofrece dos tipos de usuarios:

- Cliente
- Administrador

Cada uno posee funcionalidades específicas para administrar reservas, pagos, vehículos y reportes.

---

# Funcionalidades

## Cliente

- Registro de usuarios
- Inicio de sesión
- Consulta automática de datos mediante RENIEC (Proxy)
- Visualización del catálogo de vehículos
- Creación de reservas
- Verificación de disponibilidad por fechas
- Selección de servicios adicionales
  - GPS
  - Seguro
  - Conductor adicional
- Procesamiento de pagos
  - Tarjeta
  - Yape
  - PayPal
- Historial de reservas
- Cancelación de reservas
- Consulta de perfil

---

## Administrador

- Gestión de usuarios
- Gestión de reservas
- Gestión de vehículos
- Activación y desactivación de vehículos
- Modificación de precios
- Administración del stock
- Historial financiero
- Reportes estadísticos
- Visualización de logs del sistema

---

# Patrones de Diseño Implementados

## Singleton

Utilizado para garantizar una única instancia de:

- Conexión a la base de datos
- Logger del sistema
- Sesión del usuario

---

## Factory Method

Creación dinámica de:

- Usuarios
- Métodos de pago

---

## Proxy

Implementado para:

- Consulta a RENIEC
- Validación de reservas

---

## Decorator

Permite agregar servicios opcionales al alquiler:

- GPS
- Seguro
- Conductor adicional

sin modificar la clase base.

---

## Composite

Organización jerárquica del catálogo de vehículos por categorías.

---

## State

Control del ciclo de vida de una reserva:

- Pendiente
- Confirmada
- Cancelada

---

## DAO (Data Access Object)

Separación de la lógica de acceso a datos para:

- Usuarios
- Vehículos
- Reservas
- Pagos
- Administradores
- Logs

---

# Tecnologías utilizadas

- Java
- PostgreSQL
- JDBC
- Apache NetBeans
- Git
- GitHub

---

# Base de Datos

El sistema utiliza PostgreSQL.

Tablas principales:

- usuarios
- administradores
- vehiculos
- reservas
- pagos
- logs

---

# Estructura del proyecto

```
src
│
├── composite
├── dao
├── decorator
├── factory
├── log
├── menu
├── modelo
├── pago
├── proxy
├── sesion
├── singleton
├── state
└── Main.java
```

---

# Flujo general del sistema

1. Registro o inicio de sesión.
2. Consulta del catálogo de vehículos.
3. Verificación de disponibilidad.
4. Creación de la reserva.
5. Selección de servicios adicionales.
6. Procesamiento del pago.
7. Confirmación de la reserva.
8. Administración de reservas y vehículos por parte del administrador.

---

# Características adicionales

- Validación de disponibilidad por fechas.
- Restauración automática del stock al cancelar una reserva.
- Registro de eventos mediante Logger.
- Reportes financieros.
- Historial de pagos.
- Gestión de estados de las reservas.

---

# Requisitos

- Java JDK 17 o superior.
- PostgreSQL.
- NetBeans IDE.
- Driver JDBC para PostgreSQL.

---

# Ejecución

1. Clonar el repositorio.

```bash
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git
```

2. Crear la base de datos PostgreSQL.

3. Ejecutar el script SQL del proyecto.

4. Configurar la conexión en la clase `ConexionBD`.

5. Ejecutar `Main.java`.

---

# Información académica

**Universidad Tecnológica del Perú (UTP)**

**Curso:** Patrones de Diseño

---
