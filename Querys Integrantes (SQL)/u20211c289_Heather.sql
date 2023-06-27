-- QUERY 1: Obtener todos los avisos con información de usuario y electrodoméstico.
CREATE PROCEDURE usp_avisos_con_informacion_usuario_electrodomestico
AS
BEGIN
    SELECT a.*, u.nombres, u.apellidos, e.nombreElec, e.marcaElec
    FROM aviso a
        INNER JOIN usuario u ON a.idUsuario = u.idUsuario
        INNER JOIN electrodomestico e ON a.idElectrodomestico = e.idElectrodomestico;
END;
GO
EXEC usp_avisos_con_informacion_usuario_electrodomestico;
GO

-- QUERY 2: Obtener  los nombres, apellidos, fecha, mensaje y descripción detallada de los usuarios y sus respectivos avisos.
CREATE PROCEDURE usp_GetUsuariosAvisos
AS
BEGIN
    SELECT u.nombres, u.apellidos, a.fecha, a.mensaje, a.descripcionDetallada
    FROM usuario u
        JOIN aviso a ON u.idUsuario = a.idUsuario;
END;
GO
EXEC usp_GetUsuariosAvisos;
GO

-- QUERY 3: Esta vista mostrará el nombre del técnico, el id del poste de luz, la fecha de instalación del poste, el tipo de estabilidad del poste, el nombre de la empresa reguladora, el nombre de la zona y el nombre del distrito para los técnicos que realizaron mantenimiento durante el mes de junio.
CREATE VIEW v_TecnicosMantenimientoJunio
AS
    SELECT t.nombres AS Tecnico, pl.idPosteLuz, pl.fechaInstalacion, ep.tipoEstabilidad, er.nombreReguladora, z.nombreZona, d.nombreDistrito
    FROM tecnico t
        JOIN mantenimiento m ON t.idTecnico = m.idTecnico
        JOIN poste_luz pl ON m.idPosteLuz = pl.idPosteLuz
        JOIN estabilidad_poste ep ON pl.idEstabilidadPoste = ep.idEstabilidadPoste
        JOIN empresa_reguladora er ON pl.idEmpresaReguladora = er.idEmpresaReguladora
        JOIN zona z ON pl.idZona = z.idZona
        JOIN distrito d ON z.idDistrito = d.idDistrito
    WHERE MONTH(m.fecha) = 6;
GO
SELECT *
FROM v_TecnicosMantenimientoJunio;
GO
