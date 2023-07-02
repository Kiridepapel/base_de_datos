-- QUERY 1: Muestra la cantidad de postes de luz cercanos a un usuario y los agrupa por calificación.
CREATE PROCEDURE usp_cant_postes_segun_usuario_por_calificacion
    @idUsuario INT
AS
BEGIN
    SELECT cantEstrellas, count(P.idPosteLuz)Cant_postes
    FROM poste_luz P
        INNER JOIN zona Z on P.idZona = Z.idZona
        INNER JOIN Propiedad Pr on Z.idZona = Pr.idZona
        INNER JOIN usuario U on Pr.idUsuario = U.idUsuario
        INNER JOIN calificacion C on U.idUsuario = C.idUsuario
    WHERE U.idUsuario = @idUsuario
    GROUP by cantEstrellas
END;
GO
dbo.usp_cant_postes_segun_usuario_por_calificacion 1
GO

-- QUERY 2: Muestra los postes de luz de una zona de acuerdo con el tipo de mantenimiento dado en un determinado mes y año de la fecha de mantenimiento.
CREATE PROCEDURE usp_inf_poste_luz_segun_zona_por_determinado_mantenimiento_y_fecha
    @mes INT,
    @anio INT,
    @tipo_mantenimiento VARCHAR(60)
AS
BEGIN
    SELECT nombreZona, P.idPosteLuz, fechaInstalacion
    FROM poste_luz P
        INNER JOIN zona Z on Z.idZona = P.idZona
        INNER JOIN mantenimiento M on M.idPosteLuz = P.idPosteLuz
        INNER JOIN tipo_mantenimiento TM on TM.idTipoMantenimiento = M.idTipoMantenimiento
    WHERE month(M.fecha) = @mes AND year(M.fecha) = @anio AND TM.tipoMantenimiento = @tipo_mantenimiento
END;
GO
EXEC dbo.usp_inf_poste_luz_segun_zona_por_determinado_mantenimiento_y_fecha 5, 2011, 'Mantenimiento de limpieza'
GO

-- QUERY 3: Muestra el total de consumo eléctrico que ha realizado un usuario desde la primera fecha por electrodoméstico.
CREATE PROCEDURE usp_imprimir_total_consumo_por_electrodomestico_por_determinado_usuario
    @idusuario INT
AS
BEGIN
    DECLARE @nombre_electrodomestico VARCHAR(50)
    DECLARE @total_consumo INT
    DECLARE cursor_elecconsumo cursor for
SELECT nombreElec, SUM(consumoEnergiaElec)total_consumo
    FROM electrodomestico E
        INNER JOIN aviso A on A.idElectrodomestico = E.idElectrodomestico
        INNER JOIN usuario U on A.idUsuario = U.idUsuario
    WHERE U.idUsuario = @idusuario
    GROUP by nombreElec
    OPEN cursor_elecconsumo
    FETCH cursor_elecconsumo into @nombre_electrodomestico, @total_consumo
    WHILE(@@FETCH_STATUS = 0)
BEGIN
        PRINT('Electrodomestico : ' + @nombre_electrodomestico + ', total de consumo : ' + CAST(@total_consumo AS varchar))
    end
END
cursor_elecconsumo
DELLOCATE cursor_elecconsumo
END;
GO
EXEC dbo.usp_imprimir_total_consumo_por_electrodomestico_por_determinado_usuario 2
GO
