-- QUERY 1: Esta query permitirá listar a las personas que contrataron el servicio desde antes del 2020 y se mostrará su distrito.
SELECT u.nombres, u.apellidos, d.nombreDistrito
FROM usuario u
    INNER JOIN propiedad p ON u.idUsuario = p.idUsuario
    INNER JOIN distrito d ON p.idDistrito = d.idDistrito
WHERE YEAR(u.fechaContratacion) < 2020;

-- QUERY 2: En esta 2da query se calculará cuántas personas cuentan con un medidor vencido por distrito.
SELECT d.nombreDistrito, COUNT(*) AS cantidadPersonas
FROM usuario u
    INNER JOIN propiedad p ON u.idUsuario = p.idUsuario
    INNER JOIN distrito d ON p.idDistrito = d.idDistrito
    INNER JOIN medidor_luz m ON p.idDispositivoMedidor = m.idDispositivoMedidor
WHERE m.fechaVencimiento < GETDATE()
GROUP BY d.nombreDistrito;

-- QUERY 3: Se calculará la cantidad de electrodomésticos por cada distrito.
SELECT d.nombreDistrito, e.tipoElec, COUNT(*) AS cantidadElectrodomesticos
FROM propiedad p
    INNER JOIN distrito d ON p.idDistrito = d.idDistrito
    INNER JOIN electrodomestico e ON p.idDispositivoMedidor = e.idDispositivoMedidor
GROUP BY d.nombreDistrito, e.tipoElec;
