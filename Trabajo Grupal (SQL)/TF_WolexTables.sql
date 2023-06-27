-- Crear base de datos
CREATE DATABASE wolex;

-- Usar la base de datos
USE wolex;

-- TABLES
-- Table: aviso
CREATE TABLE aviso (
    idAviso int  NOT NULL,
    fecha date  NOT NULL,
    mensaje varchar(100)  NOT NULL,
    descripcionDetallada varchar(500)  NOT NULL,
    idUsuario int  NOT NULL,
    idElectrodomestico int  NOT NULL,
    CONSTRAINT aviso_pk PRIMARY KEY  (idAviso)
);

-- Table: calificacion
CREATE TABLE calificacion (
    idPosteLuz int  NOT NULL,
    idUsuario int  NOT NULL,
    cantEstrellas char(5)  NOT NULL,
    comentario varchar(240)  NOT NULL,
    CONSTRAINT calificacion_pk PRIMARY KEY  (idPosteLuz,idUsuario)
);

-- Table: ciudad
CREATE TABLE ciudad (
    idCiudad int  NOT NULL,
    nombreCiudad varchar(50)  NOT NULL,
    codigoPostal char(5)  NOT NULL,
    CONSTRAINT ciudad_pk PRIMARY KEY  (idCiudad)
);

-- Table: dispositivo_medidor
CREATE TABLE dispositivo_medidor (
    idDispositivoMedidor int  NOT NULL,
    modeloMedidor varchar(40)  NOT NULL,
    marcaMedidor varchar(40)  NOT NULL,
    tipoMedidor varchar(20)  NOT NULL,
    capacidadMedidor decimal(10,6)  NOT NULL,
    CONSTRAINT dispositivo_medidor_pk PRIMARY KEY  (idDispositivoMedidor)
);

-- Table: distrito
CREATE TABLE distrito (
    idDistrito int  NOT NULL,
    nombreDistrito varchar(50)  NOT NULL,
    codigoDistrital char(6)  NOT NULL,
    idCiudad int  NOT NULL,
    CONSTRAINT distrito_pk PRIMARY KEY  (idDistrito)
);

-- Table: electrodomestico
CREATE TABLE electrodomestico (
    idElectrodomestico int  NOT NULL,
    idDispositivoMedidor int  NOT NULL,
    idReporteConsumoEnergia int  NOT NULL,
    nombreElec varchar(50)  NOT NULL,
    marcaElec varchar(60)  NOT NULL,
    modeloElec varchar(60)  NOT NULL,
    tipoElec varchar(50)  NOT NULL,
    descripcionElec varchar(300)  NOT NULL,
    minutosDeUsoElec int  NOT NULL,
    consumoEnergiaElec int  NOT NULL,
    CONSTRAINT electrodomestico_pk PRIMARY KEY  (idElectrodomestico)
);

-- Table: empresa_proveedora
CREATE TABLE empresa_proveedora (
    idEmpresaProveedora int  NOT NULL,
    nombreProveedora varchar(50)  NOT NULL,
    informacion varchar(777)  NOT NULL,
    idEmpresaReguladora int  NOT NULL,
    CONSTRAINT empresa_proveedora_pk PRIMARY KEY  (idEmpresaProveedora)
);

-- Table: empresa_reguladora
CREATE TABLE empresa_reguladora (
    idEmpresaReguladora int  NOT NULL,
    nombreReguladora varchar(50)  NOT NULL,
    informacion varchar(777)  NOT NULL,
    CONSTRAINT empresa_reguladora_pk PRIMARY KEY  (idEmpresaReguladora)
);

-- Table: estabilidad_poste
CREATE TABLE estabilidad_poste (
    idEstabilidadPoste int  NOT NULL,
    tipoEstabilidad varchar(60)  NOT NULL,
    detalle varchar(777)  NOT NULL,
    CONSTRAINT estabilidad_poste_pk PRIMARY KEY  (idEstabilidadPoste)
);

-- Table: mantenimiento
CREATE TABLE mantenimiento (
    idTecnico int  NOT NULL,
    idPosteLuz int  NOT NULL,
    detalle varchar(400)  NOT NULL,
    fecha date  NOT NULL,
    hora time(6)  NOT NULL,
    calidad varchar(20)  NOT NULL,
    idTipoMantenimiento int  NOT NULL,
    CONSTRAINT mantenimiento_pk PRIMARY KEY  (idTecnico,idPosteLuz)
);

-- Table: medidor_luz
CREATE TABLE medidor_luz (
    idMedidorLuz int  NOT NULL,
    marca varchar(100)  NOT NULL,
    modelo varchar(100)  NOT NULL,
    fechaInstalacion date  NOT NULL,
    capacidad decimal(10,4)  NOT NULL,
    consumoMes decimal(10,4)  NOT NULL,
    idEmpresaProveedora int  NOT NULL,
    CONSTRAINT medidor_luz_pk PRIMARY KEY  (idMedidorLuz)
);

-- Table: poste_luz
CREATE TABLE poste_luz (
    idPosteLuz int  NOT NULL,
    fechaInstalacion date  NOT NULL,
    idEstabilidadPoste int  NOT NULL,
    idEmpresaReguladora int  NOT NULL,
    idZona int  NOT NULL,
    CONSTRAINT poste_luz_pk PRIMARY KEY  (idPosteLuz)
);

-- Table: propiedad
CREATE TABLE propiedad (
    idPropiedad int  NOT NULL,
    tipoPropiedad varchar(100)  NOT NULL,
    idZona int  NOT NULL,
    idUsuario int  NOT NULL,
    idDispositivoMedidor int  NOT NULL,
    idEmpresaProveedora int  NOT NULL,
    CONSTRAINT propiedad_pk PRIMARY KEY  (idPropiedad)
);

-- Table: reporte_consumo
CREATE TABLE reporte_consumo (
    idReporteConsumoEnergia int  NOT NULL,
    fechaExacta date  NOT NULL,
    idUsuario int  NOT NULL,
    idPropiedad int  NOT NULL,
    idDispositivoMedidor int  NOT NULL,
    CONSTRAINT reporte_consumo_pk PRIMARY KEY  (idReporteConsumoEnergia)
);

-- Table: reporte_consumo_proveedora
CREATE TABLE reporte_consumo_proveedora (
    idReporteConsumoProveedora int  NOT NULL,
    idMedidorLuz int  NOT NULL,
    consumoTotal int  NOT NULL,
    fecha date  NOT NULL,
    CONSTRAINT reporte_consumo_proveedora_pk PRIMARY KEY  (idReporteConsumoProveedora)
);

-- Table: tecnico
CREATE TABLE tecnico (
    idTecnico int  NOT NULL,
    nombres varchar(40)  NOT NULL,
    apellidos varchar(40)  NOT NULL,
    telefono char(9)  NOT NULL,
    dni char(8)  NOT NULL,
    aniosServicio int  NOT NULL,
    mesesServicio int  NOT NULL,
    empresa varchar(60)  NOT NULL,
    CONSTRAINT tecnico_pk PRIMARY KEY  (idTecnico)
);

-- Table: tipo_mantenimiento
CREATE TABLE tipo_mantenimiento (
    idTipoMantenimiento int  NOT NULL,
    tipoMantenimiento varchar(60)  NOT NULL,
    detalle varchar(777)  NOT NULL,
    CONSTRAINT tipo_mantenimiento_pk PRIMARY KEY  (idTipoMantenimiento)
);

-- Table: usuario
CREATE TABLE usuario (
    idUsuario int  NOT NULL,
    nombres varchar(40)  NOT NULL,
    apellidos varchar(40)  NOT NULL,
    telefono char(9)  NOT NULL,
    dni char(8)  NOT NULL,
    CONSTRAINT usuario_pk PRIMARY KEY  (idUsuario)
);

-- Table: zona
CREATE TABLE zona (
    idZona int  NOT NULL,
    nombreZona varchar(50)  NULL,
    latitud decimal(9,6)  NOT NULL,
    longitud decimal(9,6)  NOT NULL,
    idDistrito int  NULL,
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