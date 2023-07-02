-- Crear base de datos
CREATE DATABASE wolex;
GO

-- Usar la base de datos
USE wolex;
GO

-- TABLES
-- Table: aviso
CREATE TABLE aviso
(
    idAviso INT NOT NULL,
    fecha DATE NOT NULL,
    mensaje VARCHAR(100) NOT NULL,
    descripcionDetallada VARCHAR(500) NOT NULL,
    idUsuario INT NOT NULL,
    idElectrodomestico INT NOT NULL,
    CONSTRAINT aviso_pk PRIMARY KEY  (idAviso)
);

-- Table: calificacion
CREATE TABLE calificacion
(
    idPosteLuz INT NOT NULL,
    idUsuario INT NOT NULL,
    cantEstrellas CHAR(5) NOT NULL,
    comentario VARCHAR(240) NOT NULL,
    CONSTRAINT calificacion_pk PRIMARY KEY  (idPosteLuz,idUsuario)
);

-- Table: ciudad
CREATE TABLE ciudad
(
    idCiudad INT NOT NULL,
    nombreCiudad VARCHAR(50) NOT NULL,
    codigoPostal CHAR(5) NOT NULL,
    CONSTRAINT ciudad_pk PRIMARY KEY  (idCiudad)
);

-- Table: dispositivo_medidor
CREATE TABLE dispositivo_medidor
(
    idDispositivoMedidor INT NOT NULL,
    modeloMedidor VARCHAR(40) NOT NULL,
    marcaMedidor VARCHAR(40) NOT NULL,
    tipoMedidor VARCHAR(20) NOT NULL,
    capacidadMedidor DECIMAL(10,6) NOT NULL,
    CONSTRAINT dispositivo_medidor_pk PRIMARY KEY  (idDispositivoMedidor)
);

-- Table: distrito
CREATE TABLE distrito
(
    idDistrito INT NOT NULL,
    nombreDistrito VARCHAR(50) NOT NULL,
    codigoDistrital CHAR(6) NOT NULL,
    idCiudad INT NOT NULL,
    CONSTRAINT distrito_pk PRIMARY KEY  (idDistrito)
);

-- Table: electrodomestico
CREATE TABLE electrodomestico
(
    idElectrodomestico INT NOT NULL,
    idDispositivoMedidor INT NOT NULL,
    idReporteConsumoEnergia INT NOT NULL,
    nombreElec VARCHAR(50) NOT NULL,
    marcaElec VARCHAR(60) NOT NULL,
    modeloElec VARCHAR(60) NOT NULL,
    tipoElec VARCHAR(50) NOT NULL,
    descripcionElec VARCHAR(300) NOT NULL,
    minutosDeUsoElec INT NOT NULL,
    consumoEnergiaElec INT NOT NULL,
    CONSTRAINT electrodomestico_pk PRIMARY KEY  (idElectrodomestico)
);

-- Table: empresa_proveedora
CREATE TABLE empresa_proveedora
(
    idEmpresaProveedora INT NOT NULL,
    nombreProveedora VARCHAR(50) NOT NULL,
    informacion VARCHAR(777) NOT NULL,
    idEmpresaReguladora INT NOT NULL,
    CONSTRAINT empresa_proveedora_pk PRIMARY KEY  (idEmpresaProveedora)
);

-- Table: empresa_reguladora
CREATE TABLE empresa_reguladora
(
    idEmpresaReguladora INT NOT NULL,
    nombreReguladora VARCHAR(50) NOT NULL,
    informacion VARCHAR(777) NOT NULL,
    CONSTRAINT empresa_reguladora_pk PRIMARY KEY  (idEmpresaReguladora)
);

-- Table: estabilidad_poste
CREATE TABLE estabilidad_poste
(
    idEstabilidadPoste INT NOT NULL,
    tipoEstabilidad VARCHAR(60) NOT NULL,
    detalle VARCHAR(777) NOT NULL,
    CONSTRAINT estabilidad_poste_pk PRIMARY KEY  (idEstabilidadPoste)
);

-- Table: mantenimiento
CREATE TABLE mantenimiento
(
    idTecnico INT NOT NULL,
    idPosteLuz INT NOT NULL,
    detalle VARCHAR(400) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME(6) NOT NULL,
    calidad VARCHAR(20) NOT NULL,
    idTipoMantenimiento INT NOT NULL,
    CONSTRAINT mantenimiento_pk PRIMARY KEY  (idTecnico,idPosteLuz)
);

-- Table: medidor_luz
CREATE TABLE medidor_luz
(
    idMedidorLuz INT NOT NULL,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    fechaInstalacion DATE NOT NULL,
    capacidad DECIMAL(10,4) NOT NULL,
    consumoMes DECIMAL(10,4) NOT NULL,
    idEmpresaProveedora INT NOT NULL,
    CONSTRAINT medidor_luz_pk PRIMARY KEY  (idMedidorLuz)
);

-- Table: poste_luz
CREATE TABLE poste_luz
(
    idPosteLuz INT NOT NULL,
    fechaInstalacion DATE NOT NULL,
    idEstabilidadPoste INT NOT NULL,
    idEmpresaReguladora INT NOT NULL,
    idZona INT NOT NULL,
    CONSTRAINT poste_luz_pk PRIMARY KEY  (idPosteLuz)
);

-- Table: propiedad
CREATE TABLE propiedad
(
    idPropiedad INT NOT NULL,
    tipoPropiedad VARCHAR(100) NOT NULL,
    idZona INT NOT NULL,
    idUsuario INT NOT NULL,
    idDispositivoMedidor INT NOT NULL,
    idEmpresaProveedora INT NOT NULL,
    CONSTRAINT propiedad_pk PRIMARY KEY  (idPropiedad)
);

-- Table: reporte_consumo
CREATE TABLE reporte_consumo
(
    idReporteConsumoEnergia INT NOT NULL,
    fechaExacta DATE NOT NULL,
    idUsuario INT NOT NULL,
    idPropiedad INT NOT NULL,
    idDispositivoMedidor INT NOT NULL,
    CONSTRAINT reporte_consumo_pk PRIMARY KEY  (idReporteConsumoEnergia)
);

-- Table: reporte_consumo_proveedora
CREATE TABLE reporte_consumo_proveedora
(
    idReporteConsumoProveedora INT NOT NULL,
    idMedidorLuz INT NOT NULL,
    consumoTotal INT NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT reporte_consumo_proveedora_pk PRIMARY KEY  (idReporteConsumoProveedora)
);

-- Table: tecnico
CREATE TABLE tecnico
(
    idTecnico INT NOT NULL,
    nombres VARCHAR(40) NOT NULL,
    apellidos VARCHAR(40) NOT NULL,
    telefono CHAR(9) NOT NULL,
    dni CHAR(8) NOT NULL,
    aniosServicio INT NOT NULL,
    mesesServicio INT NOT NULL,
    empresa VARCHAR(60) NOT NULL,
    CONSTRAINT tecnico_pk PRIMARY KEY  (idTecnico)
);

-- Table: tipo_mantenimiento
CREATE TABLE tipo_mantenimiento
(
    idTipoMantenimiento INT NOT NULL,
    tipoMantenimiento VARCHAR(60) NOT NULL,
    detalle VARCHAR(777) NOT NULL,
    CONSTRAINT tipo_mantenimiento_pk PRIMARY KEY  (idTipoMantenimiento)
);

-- Table: usuario
CREATE TABLE usuario
(
    idUsuario INT NOT NULL,
    nombres VARCHAR(40) NOT NULL,
    apellidos VARCHAR(40) NOT NULL,
    telefono CHAR(9) NOT NULL,
    dni CHAR(8) NOT NULL,
    CONSTRAINT usuario_pk PRIMARY KEY  (idUsuario)
);

-- Table: zona
CREATE TABLE zona
(
    idZona INT NOT NULL,
    nombreZona VARCHAR(50) NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    idDistrito INT NULL,
    CONSTRAINT zona_pk PRIMARY KEY  (idZona)
);

-- foreign keys
-- Reference: aviso_electrodomestico (table: aviso)
ALTER TABLE aviso ADD CONSTRAINT aviso_electrodomestico
    FOREIGN KEY (idElectrodomestico)
    REFERENCES electrodomestico (idElectrodomestico);

-- Reference: aviso_usuario (table: aviso)
ALTER TABLE aviso ADD CONSTRAINT aviso_usuario
    FOREIGN KEY (idUsuario)
    REFERENCES usuario (idUsuario);

-- Reference: calificacion_poste_luz (table: calificacion)
ALTER TABLE calificacion ADD CONSTRAINT calificacion_poste_luz
    FOREIGN KEY (idPosteLuz)
    REFERENCES poste_luz (idPosteLuz);

-- Reference: calificacion_usuario (table: calificacion)
ALTER TABLE calificacion ADD CONSTRAINT calificacion_usuario
    FOREIGN KEY (idUsuario)
    REFERENCES usuario (idUsuario);

-- Reference: distrito_ciudad (table: distrito)
ALTER TABLE distrito ADD CONSTRAINT distrito_ciudad
    FOREIGN KEY (idCiudad)
    REFERENCES ciudad (idCiudad);

-- Reference: electrodomestico_dispositivo_medidor (table: electrodomestico)
ALTER TABLE electrodomestico ADD CONSTRAINT electrodomestico_dispositivo_medidor
    FOREIGN KEY (idDispositivoMedidor)
    REFERENCES dispositivo_medidor (idDispositivoMedidor);

-- Reference: electrodomestico_reporte_consumo (table: electrodomestico)
ALTER TABLE electrodomestico ADD CONSTRAINT electrodomestico_reporte_consumo
    FOREIGN KEY (idReporteConsumoEnergia)
    REFERENCES reporte_consumo (idReporteConsumoEnergia);

-- Reference: empresa_proveedora_empresa_reguladora (table: empresa_proveedora)
ALTER TABLE empresa_proveedora ADD CONSTRAINT empresa_proveedora_empresa_reguladora
    FOREIGN KEY (idEmpresaReguladora)
    REFERENCES empresa_reguladora (idEmpresaReguladora);

-- Reference: mantenimiento_poste_luz (table: mantenimiento)
ALTER TABLE mantenimiento ADD CONSTRAINT mantenimiento_poste_luz
    FOREIGN KEY (idPosteLuz)
    REFERENCES poste_luz (idPosteLuz);

-- Reference: mantenimiento_tecnico (table: mantenimiento)
ALTER TABLE mantenimiento ADD CONSTRAINT mantenimiento_tecnico
    FOREIGN KEY (idTecnico)
    REFERENCES tecnico (idTecnico);

-- Reference: mantenimiento_tipo_mantenimiento (table: mantenimiento)
ALTER TABLE mantenimiento ADD CONSTRAINT mantenimiento_tipo_mantenimiento
    FOREIGN KEY (idTipoMantenimiento)
    REFERENCES tipo_mantenimiento (idTipoMantenimiento);

-- Reference: medidor_luz_empresa_proveedora (table: medidor_luz)
ALTER TABLE medidor_luz ADD CONSTRAINT medidor_luz_empresa_proveedora
    FOREIGN KEY (idEmpresaProveedora)
    REFERENCES empresa_proveedora (idEmpresaProveedora);

-- Reference: poste_luz_estabilidad_poste (table: poste_luz)
ALTER TABLE poste_luz ADD CONSTRAINT poste_luz_estabilidad_poste
    FOREIGN KEY (idEstabilidadPoste)
    REFERENCES estabilidad_poste (idEstabilidadPoste);

-- Reference: poste_luz_zona (table: poste_luz)
ALTER TABLE poste_luz ADD CONSTRAINT poste_luz_zona
    FOREIGN KEY (idZona)
    REFERENCES zona (idZona);

-- Reference: propiedad_dispositivo_medidor (table: propiedad)
ALTER TABLE propiedad ADD CONSTRAINT propiedad_dispositivo_medidor
    FOREIGN KEY (idDispositivoMedidor)
    REFERENCES dispositivo_medidor (idDispositivoMedidor);

-- Reference: propiedad_empresa_proveedora (table: propiedad)
ALTER TABLE propiedad ADD CONSTRAINT propiedad_empresa_proveedora
    FOREIGN KEY (idEmpresaProveedora)
    REFERENCES empresa_proveedora (idEmpresaProveedora);

-- Reference: propiedad_usuario (table: propiedad)
ALTER TABLE propiedad ADD CONSTRAINT propiedad_usuario
    FOREIGN KEY (idUsuario)
    REFERENCES usuario (idUsuario);

-- Reference: propiedad_zona (table: propiedad)
ALTER TABLE propiedad ADD CONSTRAINT propiedad_zona
    FOREIGN KEY (idZona)
    REFERENCES zona (idZona);

-- Reference: psote_luz_empresa_reguladora (table: poste_luz)
ALTER TABLE poste_luz ADD CONSTRAINT psote_luz_empresa_reguladora
    FOREIGN KEY (idEmpresaReguladora)
    REFERENCES empresa_reguladora (idEmpresaReguladora);

-- Reference: reporte_consumo_energia_dispositivo_medidor (table: reporte_consumo)
ALTER TABLE reporte_consumo ADD CONSTRAINT reporte_consumo_energia_dispositivo_medidor
    FOREIGN KEY (idDispositivoMedidor)
    REFERENCES dispositivo_medidor (idDispositivoMedidor);

-- Reference: reporte_consumo_propiedad (table: reporte_consumo)
ALTER TABLE reporte_consumo ADD CONSTRAINT reporte_consumo_propiedad
    FOREIGN KEY (idPropiedad)
    REFERENCES propiedad (idPropiedad);

-- Reference: reporte_consumo_proveedora_medidor_luz (table: reporte_consumo_proveedora)
ALTER TABLE reporte_consumo_proveedora ADD CONSTRAINT reporte_consumo_proveedora_medidor_luz
    FOREIGN KEY (idMedidorLuz)
    REFERENCES medidor_luz (idMedidorLuz);

-- Reference: reporte_consumo_usuario (table: reporte_consumo)
ALTER TABLE reporte_consumo ADD CONSTRAINT reporte_consumo_usuario
    FOREIGN KEY (idUsuario)
    REFERENCES usuario (idUsuario);

-- Reference: zona_distrito (table: zona)
ALTER TABLE zona ADD CONSTRAINT zona_distrito
    FOREIGN KEY (idDistrito)
    REFERENCES distrito (idDistrito);