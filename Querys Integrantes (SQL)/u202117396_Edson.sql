-- QUERY 1
--Cantidad de postes de luz cercanos a un usuario determinado
--agrupado por calificación

CREATE PROCEDURE usp_cant_postes_segun_usuario_por_calificacion
@idUsuario int
AS
select cantEstrellas, count(P.idPosteLuz)Cant_postes
from poste_luz P 
	join zona Z on P.idZona = Z.idZona
	join Propiedad Pr on Z.idZona = Pr.idZona
	join usuario U on Pr.idUsuario = U.idUsuario
	join calificacion C on U.idUsuario = C.idUsuario
where U.idUsuario = @idUsuario
group by cantEstrellas

dbo.usp_cant_postes_segun_usuario_por_calificacion 1

-- QUERY 2
--Mostrar los postes de luz según zona de acuerdo a determinado tipo
--de mantenimiento en determinado mes y año de la fecha de mantenimiento

CREATE PROCEDURE usp_inf_poste_luz_segun_zona_por_determinado_mantenimiento_y_fecha
	@mes int,
	@anio int,
	@tipo_mantenimiento varchar(60)
AS
	select nombreZona, P.idPosteLuz, fechaInstalacion from poste_luz P
		join zona Z on Z.idZona = P.idZona
		join mantenimiento M on M.idPosteLuz = P.idPosteLuz
		join tipo_mantenimiento TM on TM.idTipoMantenimiento = M.idTipoMantenimiento
	where month(M.fecha) = @mes AND year(M.fecha) = @anio AND TM.tipoMantenimiento = @tipo_mantenimiento

EXEC dbo.usp_inf_poste_luz_segun_zona_por_determinado_mantenimiento_y_fecha 5, 2011, 'Mantenimiento de limpieza'

-- QUERY 3
--Imprimir total de consumo de un determinado usuario desde la primera fecha por electrodomestico

CREATE PROCEDURE usp_imprimir_total_consumo_por_electrodomestico_por_determinado_usuario
	@idusuario int
as
begin
	declare @nombre_electrodomestico varchar(50)
	declare @total_consumo int
	declare cursor_elecconsumo cursor for
	select nombreElec, SUM(consumoEnergiaElec)total_consumo from electrodomestico E
	join aviso A on A.idElectrodomestico = E.idElectrodomestico
	join usuario U on A.idUsuario = U.idUsuario
	where U.idUsuario = @idusuario
	group by nombreElec
	
	open cursor_elecconsumo
	fetch cursor_elecconsumo into @nombre_electrodomestico, @total_consumo
	
	while(@@FETCH_STATUS = 0)
		begin
			print ('Electrodomestico : ' + @nombre_electrodomestico + ', total de consumo : ' + CAST(@total_consumo AS varchar))
		end
	close cursor_elecconsumo
	deallocate cursor_elecconsumo
end

exec dbo.usp_imprimir_total_consumo_por_electrodomestico_por_determinado_usuario 2
