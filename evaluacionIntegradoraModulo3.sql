CREATE DATABASE IF NOT EXISTS AlkeWallet;
USE AlkeWallet;
--
/*Creación de tablas */
--
CREATE TABLE IF NOT EXISTS Usuario (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    correo_electronico VARCHAR(255),
    contrasena VARCHAR(255),
    saldo DECIMAL(10, 2)
);
CREATE TABLE IF NOT EXISTS Moneda (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(255),
    currency_symbol VARCHAR(10)
);
CREATE TABLE IF NOT EXISTS Transaccion (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_user_id INT,
    receiver_user_id INT,
    CURRENCY_id INT,
    importe DECIMAL(10, 2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (CURRENCY_id) REFERENCES Moneda(currency_id)
);

--
/*Poblado de Tablas */
--
--Tabla Usuario
INSERT INTO Usuario (nombre, correo_electronico, contrasena, saldo) VALUES
('Juan Pérez', 'juan@example.com', 'contraseña123', 100.00),
('María García', 'maria@example.com', 'password456', 150.50),
('Pedro López', 'pedro@example.com', 'clave789', 75.25),
('Ana Martínez', 'ana@example.com', 'pass123', 200.00),
('Luis Rodríguez', 'luis@example.com', 'clave456', 300.75),
('Sofía Gómez', 'sofia@example.com', 'password789', 150.25);

--Tabla Moneda
INSERT INTO Moneda (currency_name, currency_symbol) VALUES
('Dólar estadounidense', 'USD'),
('Euro', 'EUR'),
('Libra esterlina', 'GBP'),
('Yen japonés', 'JPY'),
('Dólar canadiense', 'CAD'),
('Peso mexicano', 'MXN');

--Tabla Transaccion
INSERT INTO Transaccion (sender_user_id, receiver_user_id, CURRENCY_id, importe) VALUES
(1, 2, 1, 50.00), -- Juan Pérez envía $50 a María García
(2, 1, 2, 30.00), -- María García envía €30 a Juan Pérez
(3, 1, 3, 25.00), -- Pedro López envía £25 a Juan Pérez
(1, 3, 2, 40.00), -- Juan Pérez envía €40 a Sofía Gómez
(4, 2, 1, 75.00), -- Ana Martínez envía $75 a María García
(5, 3, 3, 20.50); -- Luis Rodríguez envía MXN 20.50 a Sofía Gómez


--
/*Consultas */
--

-- Consulta para obtener el nombre de la moneda elegida por un usuario especifico
-- En este caso llamamos al user_id "1"
SELECT u.nombre AS nombreUsuario, mo.currency_name AS nombreMoneda FROM usuario u
JOIN transaccion tr
ON u.user_id = tr.sender_user_id
JOIN moneda mo
ON tr.CURRENCY_id = mo.currency_id
WHERE u.user_id = 1;

-- Consulta para obtener todas las transacciones registradas
SELECT * FROM transaccion;

-- Consulta para obtener todas las transacciones realizadas por un usuario específico
-- el usuario escogido es el de id = 1
SELECT u.nombre AS nombreUsuario, tr.transaction_id AS idTransaccion, tr.sender_user_id AS idSenderUser,
tr.receiver_user_id AS idReceiverUser, tr.CURRENCY_id AS idMoneda, 
tr.importe AS montoImporte, transaction_date AS fechaTransaccion
FROM usuario u
JOIN transaccion tr
ON u.user_id = tr.sender_user_id
WHERE u.user_id = 1;

-- Sentencia DMLpara modificar correo electronico de un usuario específico
-- El usuario específico
UPDATE usuario
SET correo_electronico = "juanitoperezmodificado@alkewallet.com"
WHERE user_id = 1;

-- Sentencia para eliminar los datos de una transacción, eliminar la fila completa
-- La transaccion escogida es la de id "1"
DELETE FROM transaccion
WHERE transaction_id = 1;
