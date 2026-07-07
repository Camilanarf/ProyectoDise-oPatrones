-- Borrar tablas respetando las llaves foraneas
DROP TABLE IF EXISTS logs;
DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS usuarios;

-- Crear tablas
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dni VARCHAR(8) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    celular VARCHAR(9),
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    rol VARCHAR(20) NOT NULL
        CHECK (rol IN ('Cliente', 'Admin')),
    estado VARCHAR(15) NOT NULL DEFAULT 'Activo'
        CHECK (estado IN ('Activo', 'Inactivo', 'Suspendido')),
    licencia_numero VARCHAR(20),
    licencia_categoria VARCHAR(20),
	licencia_fecha_expedicion DATE,
    licencia_fecha_vencimiento DATE,
    licencia_estado VARCHAR(20) NOT NULL DEFAULT 'No registrada'
        CHECK (licencia_estado IN ('No registrada', 'Vigente', 'No vigente')),
    licencia_restricciones VARCHAR(200),
    licencia_ultima_consulta TIMESTAMP
);

CREATE TABLE vehiculos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    categoria VARCHAR(30) NOT NULL
        CHECK (categoria IN ('Económico', 'Gama media', 'Premium')),
    pasajeros INT,
    precio_dia NUMERIC(10,2),
    cantidad_disponible INT NOT NULL DEFAULT 0
        CHECK (cantidad_disponible >= 0)
);

CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    usuario_id INT,
    vehiculo_id INT,
    fecha_recojo DATE,
    hora_recojo VARCHAR(10),
    fecha_entrega DATE,
    hora_entrega VARCHAR(10),
    total NUMERIC(10,2),

    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente'
        CHECK (estado IN (
            'Pendiente',
            'Confirmada',
            'En curso',
            'Finalizada',
            'Cancelada'
        )),

    seguro BOOLEAN NOT NULL DEFAULT FALSE,
    conductor BOOLEAN NOT NULL DEFAULT FALSE,
    gps BOOLEAN NOT NULL DEFAULT FALSE,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(id)
);

CREATE TABLE pagos (
    id SERIAL PRIMARY KEY,
    reserva_id INTEGER NOT NULL REFERENCES reservas(id),
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
    metodo VARCHAR(20) NOT NULL,
    monto NUMERIC(10,2) NOT NULL CHECK (monto > 0),
    referencia VARCHAR(100) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    fecha_solicitud TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_revision TIMESTAMP,

    CONSTRAINT ck_pago_metodo
        CHECK (metodo IN ('Yape', 'PayPal', 'Tarjeta')),

    CONSTRAINT ck_pago_estado
        CHECK (estado IN ('Pendiente', 'Aprobado', 'Rechazado'))
);

CREATE UNIQUE INDEX uq_pago_activo_reserva
ON pagos(reserva_id)
WHERE estado IN ('Pendiente', 'Aprobado');

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    evento TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO usuarios (
    nombre,
    dni,
    password,
    rol,
    licencia_numero,
    licencia_categoria,
    licencia_fecha_expedicion,
    licencia_fecha_vencimiento,
    licencia_estado,
    licencia_restricciones,
    licencia_ultima_consulta
)
VALUES (
    'PRUEBA USER',
    '12345678',
    '123',
    'Cliente',
    'LIC-123456',
    'A-II',
    '2024-01-15',
    '2029-01-15',
    'Vigente',
    'Sin restricciones',
    CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nombre, dni, password, rol, estado)
VALUES ('Administrador', '01234567', 'admin123', 'Admin', 'Activo');

-- Insertar vehiculos
INSERT INTO vehiculos (nombre, categoria, pasajeros, precio_dia, cantidad_disponible)
VALUES
('Toyota Corolla', 'Económico', 5, 120.00, 5),
('Kia Rio', 'Económico', 5, 110.00, 4),
('Hyundai Accent', 'Económico', 5, 100.00, 3),
('Chevrolet Spark', 'Económico', 4, 90.00, 6),
('Nissan Versa', 'Económico', 5, 105.00, 3),
('Toyota Camry', 'Gama media', 5, 180.00, 3),
('Mazda 6', 'Gama media', 5, 200.00, 2),
('Kia Sportage', 'Gama media', 7, 220.00, 4),
('Honda CR-V', 'Gama media', 5, 210.00, 3),
('Hyundai Tucson', 'Gama media', 5, 195.00, 2),
('BMW Serie 5', 'Premium', 5, 400.00, 2),
('Mercedes Clase E', 'Premium', 5, 450.00, 1),
('Audi A6', 'Premium', 5, 430.00, 2),
('Porsche Cayenne', 'Premium', 5, 600.00, 1),
('Range Rover Sport', 'Premium', 5, 550.00, 2);

SELECT * FROM vehiculos;
SELECT * FROM usuarios;
SELECT * FROM reservas;
SELECT * FROM pagos;
SELECT * FROM logs;

