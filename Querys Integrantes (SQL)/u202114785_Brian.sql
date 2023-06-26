-- QUERY 1: Obtener la información de los electrodomésticos y de los usuarios que han generado al menos dos avisos de uso de electrodoméstico(s) entre el 20 y 30 de junio de 2023, así como la cantidad de reportes generados por ese electrodoméstico.
CREATE PROCEDURE usp_UsuariosConAvisosEnFecha
  @FechaInicio DATE,
  @FechaFin DATE,
  @CantidadMinimaAvisos INT
AS
BEGIN
  SELECT
    U.idUsuario AS [ID Usuario],
    U.nombres + ' ' + U.apellidos AS [Usuario],
    E.idElectrodomestico AS [ID Electrodomestico],
    E.nombreElec AS [Electrodomestico],
    COUNT(R.idReporteConsumoEnergia) AS [Cantidad de Reportes Generados]
  FROM usuario U
  INNER JOIN aviso A ON U.idUsuario = A.idUsuario
  INNER JOIN electrodomestico E ON A.idElectrodomestico = E.idElectrodomestico
  INNER JOIN reporte_consumo R ON E.idReporteConsumoEnergia = R.idReporteConsumoEnergia
  WHERE A.fecha BETWEEN @FechaInicio and @FechaFin
  GROUP BY U.idUsuario, U.nombres, U.apellidos, E.idElectrodomestico, E.nombreElec
  HAVING COUNT(DISTINCT A.idAviso) >= @CantidadMinimaAvisos
  ORDER BY U.idUsuario;
END;
-- Ejecución QUERY 1:
EXEC usp_UsuariosConAvisosEnFecha '2023-06-20', '2023-06-30', 2;
-- Sustentación QUERY 1:
SELECT * FROM aviso
WHERE idUsuario = 1 AND fecha BETWEEN '2023-06-20' AND '2023-06-30'
ORDER BY idElectrodomestico ASC;

-- QUERY 2.1: Obtener el nombre y apellidos del usuario o usuarios con más propiedades en una zona determinada, así como la cantidad total de propiedades totales de dicho usuario o usuarios; y la cantidad de propiedades en dicha zona.
CREATE PROCEDURE usp_CantidadPropiedadesEnZona
    @nombreZona NVARCHAR(100)
AS
BEGIN
  SELECT
    Z.nombreZona AS [Nombre de la Zona],
    U.nombres + ' ' + U.apellidos AS [Usuario],
    ( SELECT COUNT(*) FROM propiedad WHERE idUsuario = U.idUsuario ) AS [Propiedades Totales],
    COUNT(*) AS [Propiedades en la Zona]
  FROM usuario U
  JOIN propiedad P ON U.idUsuario = P.idUsuario
  JOIN zona Z ON P.idZona = Z.idZona
  JOIN distrito D ON Z.idDistrito = D.idDistrito
  JOIN ciudad C ON D.idCiudad = C.idCiudad
  WHERE Z.nombreZona = @nombreZona
  GROUP BY U.nombres, U.apellidos, Z.nombreZona, U.idUsuario
  ORDER BY COUNT(*) DESC;
END
-- QUERY 2.2: Mostrar los detalles de la propiedad en esa zona, así como el dueño de la propiedad, el tipo de propiedad, el nombre de la zona donde se ubica la propiedad, el id del dispositivo medidor y la cantidad de electrodomésticos instalados en dicha propiedad.
CREATE PROCEDURE usp_DetallesPropiedadEnZona
    @nombreZona NVARCHAR(100)
AS
BEGIN
  SELECT
    CONCAT(U.nombres, ' ', U.apellidos) AS [Usuario de la Propiedad],
    P.idPropiedad AS [ID de la Propiedad],
    Z.nombreZona AS [Zona de la Propiedad],
    P.tipoPropiedad AS [Tipo de Propiedad],
    DM.idDispositivoMedidor AS [ID de Dispositivo Medidor],
    COUNT(E.idElectrodomestico) AS [Cantidad de Electrodomésticos]
  FROM propiedad P
  INNER JOIN zona Z ON P.idZona = Z.idZona
  INNER JOIN dispositivo_medidor DM ON P.idDispositivoMedidor = DM.idDispositivoMedidor
  LEFT JOIN electrodomestico E ON DM.idDispositivoMedidor = E.idDispositivoMedidor
  INNER JOIN usuario U ON P.idUsuario = U.idUsuario
  WHERE Z.nombreZona = @nombreZona
  GROUP BY P.idPropiedad, Z.nombreZona, P.tipoPropiedad, U.nombres, U.apellidos, DM.idDispositivoMedidor;
END
-- Ejecución QUERY 2:
EXEC usp_CantidadPropiedadesEnZona 'Parque Kennedy';
EXEC usp_DetallesPropiedadEnZona 'Parque Kennedy';
-- Sustentación QUERY 2:
SELECT
  u.nombres + ' ' + u.apellidos AS nombre,
  p.idPropiedad AS idPropiedad,
  p.tipoPropiedad AS TipoPropiedad,
  z.nombreZona AS nombreZona
FROM propiedad p
  INNER JOIN zona z ON p.idZona = z.idZona
  INNER JOIN usuario u ON p.idUsuario = u.idUsuario

-- QUERY 3: Mostrar el detalle de los mantenimientos realizados en un rango de fechas de instalacion específico.
CREATE PROCEDURE usp_DetallesMantenimientoPosteXFecha
  @FechaInicio DATE,
  @FechaFin DATE
AS
BEGIN
  SELECT
    P.idPosteLuz AS [ID Poste de Luz],
    TM.tipoMantenimiento AS [Tipo de Mantenimiento],
    P.fechaInstalacion AS [Instalación del Poste],
    Z.latitud AS [Latitud del Poste],
    Z.longitud AS [Longitud del Poste],
    T.nombres + ' ' + T.apellidos AS [Técnico Encargado],
    CONVERT(varchar(10), M.fecha, 103) AS [Fecha del Mantenimiento],
    CONVERT(varchar(5), M.hora, 108) + ' ' +
    CASE
      WHEN M.hora >= '00:00' AND M.hora < '06:00' THEN '(madrugada)'
      WHEN M.hora >= '06:00' AND M.hora < '12:00' THEN '(mañana)'
      WHEN M.hora >= '12:00' AND M.hora < '19:00' THEN '(tarde)'
      WHEN M.hora >= '19:00' THEN '(noche)'
    END AS [Hora del Mantenimiento],
    M.calidad AS [Calidad del Mantenimiento],
    M.detalle AS [Detalle del Mantenimiento]
  FROM tecnico T
  INNER JOIN mantenimiento M ON T.idTecnico = M.idTecnico
  INNER JOIN poste_luz P ON M.idPosteLuz = P.idPosteLuz
  INNER JOIN tipo_mantenimiento TM ON M.idTipoMantenimiento = TM.idTipoMantenimiento
  INNER JOIN zona Z ON P.idZona = Z.idZona
  WHERE P.fechaInstalacion BETWEEN @FechaInicio AND @FechaFin
  GROUP BY P.idPosteLuz, TM.tipoMantenimiento, P.fechaInstalacion, Z.latitud, Z.longitud, T.nombres, T.apellidos, M.fecha, M.hora, M.calidad, M.detalle
  ORDER BY P.idPosteLuz ASC;
END
-- Ejecución QUERY 3: Ultimos 4 años
EXEC usp_DetallesMantenimientoPosteXFecha '2019-01-01', '2023-01-01';