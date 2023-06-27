-- QUERY 1: Muestra la información de mantenimiento de los postes de luz realizados por un técnico especifico.
CREATE FUNCTION obtenerMantenimientosPorTecnico(idTecnico INT) RETURNS TABLE
(
  idTecnico INT,
  nombres VARCHAR,
  apellidos VARCHAR,
  idPosteLuz INT,
  fechaInstalacion DATE,
  detalle VARCHAR,
  fecha DATE,
  hora TIME,
  calidad VARCHAR
)
AS
BEGIN
    RETURN (
    SELECT m.idTecnico, t.nombres, t.apellidos, pl.idPosteLuz, pl.fechaInstalacion, m.detalle, m.fecha, m.hora, m.calidad
    FROM mantenimiento m
        INNER JOIN tecnico t ON m.idTecnico = t.idTecnico
        INNER JOIN poste_luz pl ON m.idPosteLuz = pl.idPosteLuz
    WHERE t.idTecnico = idTecnico
  );
END;
GO

-- QUERY 2: Esta Query sirve para consultar el consumo energético promedio de cada electrodoméstico.
CREATE FUNCTION obtenerConsumoPromedioPorElectrodomestico() RETURNS TABLE (
    nombreElec VARCHAR,
    consumoPromedio DECIMAL
)
AS
BEGIN
    RETURN (
    SELECT e.nombreElec, AVG(e.consumoEnergiaElec) AS consumoPromedio
    FROM electrodomestico e
    GROUP BY e.nombreElec
  );
END;
GO

-- QUERY 3: Esta consulta muestra los nombres y apellidos de los usuarios junto con la cantidad de avisos que han registrado, ordenados de mayor a menor cantidad de avisos.
CREATE FUNCTION obtenerCantidadAvisosPorUsuario() RETURNS TABLE (
    nombres VARCHAR,
    apellidos VARCHAR,
    cantidadAvisos INT
) AS
BEGIN
    RETURN (
    SELECT u.nombres, u.apellidos, COUNT(a.idAviso) AS cantidadAvisos
    FROM usuario u
        JOIN aviso a ON u.idUsuario = a.idUsuario
    GROUP BY u.nombres, u.apellidos
    ORDER BY cantidadAvisos DESC
  );
END;
GO
