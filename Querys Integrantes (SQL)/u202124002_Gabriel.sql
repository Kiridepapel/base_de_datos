-- QUERY 1: Muestra un listado de los postes de luz con un rango de estrellas del 1 al 3 y sus detalles.
CREATE PROCEDURE usp_VerPostesMenorCalificacion
AS
BEGIN
    SELECT p.idPosteLuz, c.cantEstrellas, c.comentario , p.fechaInstalacion, e.nombreReguladora
    FROM poste_luz p
        INNER JOIN calificacion c ON p.idPosteLuz = c.idPosteLuz
        INNER JOIN empresa_reguladora e ON p.idEmpresaReguladora = e.idEmpresaReguladora
    WHERE c.cantEstrellas < 4
    ORDER BY c.cantEstrellas ASC;
END;
GO
EXEC usp_VerPostesMenorCalificacion;
GO

-- QUERY 2: Muestra un listado de propiedad(es) que posee un usuario en específico (se ingresa el id del usuario a consultar) con la información básica tanto del usuario como de la propiedad. En orden alfabético según el tipo de propiedad(es).
CREATE PROCEDURE usp_VerPropiedadesDeUsuario
    @idUsuario INT
AS
BEGIN
    SELECT p.idUsuario, CONCAT(u.apellidos, ', ', u.nombres) AS Usuario, p.idPropiedad, p.tipoPropiedad, p.idZona, z.nombreZona, p.idEmpresaProveedora, e.nombreProveedora
    FROM propiedad p
        INNER JOIN usuario u ON p.idUsuario = u.idUsuario
        INNER JOIN empresa_proveedora e ON p.idEmpresaProveedora = e.idEmpresaProveedora
        INNER JOIN zona z ON p.idZona = z.idZona
    WHERE p.idUsuario = @idUsuario
    ORDER BY p.tipoPropiedad ASC;
END;
GO
EXEC usp_VerPropiedadesDeUsuario @idUsuario = 1;
GO

-- QUERY 3: Muestra un listado con información básica de un usuario en específico mediante su id, obteniendo los datos de su propiedad o propiedades y consumo total de dicha(s) propiedad(es).
CREATE PROCEDURE usp_VerReporteConsumoPorUsuario
    @idUsuario INT
AS
BEGIN
    SELECT u.idUsuario, CONCAT(u.apellidos, ', ', u.nombres) AS Usuario, p.idPropiedad, p.tipoPropiedad, z.nombreZona, e.nombreProveedora, r.consumoTotal, r.fecha
    FROM usuario u
        INNER JOIN propiedad p ON u.idUsuario = p.idUsuario
        INNER JOIN zona z ON p.idZona = z.idZona
        INNER JOIN empresa_proveedora e ON p.idEmpresaProveedora = e.idEmpresaProveedora
        INNER JOIN medidor_luz m ON p.idEmpresaProveedora = m.idEmpresaProveedora
        INNER JOIN reporte_consumo_proveedora r ON m.idMedidorLuz = r.idMedidorLuz
    WHERE u.idUsuario = @idUsuario
    ORDER BY p.tipoPropiedad ASC;
END;
GO
EXEC usp_VerReporteConsumoPorUsuario @idUsuario = 1;
GO
