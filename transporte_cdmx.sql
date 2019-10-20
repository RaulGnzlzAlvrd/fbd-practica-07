USE master;

-- Crea la base de datos si no existe, en caso contrario la elimina antes de crearla.
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'transporte_cdmx')
BEGIN
  PRINT "YA EXISTE LA BASE DE DATOS: 'transporte_cdmx'";
  PRINT "ELIMINANDO...";
  DROP DATABASE transporte_cdmx;
  PRINT "BASE DE DATOS ELIMINADA.";
END

PRINT "CREANDO BASE DE DATOS: 'transporte_cdmx'";
CREATE DATABASE transporte_cdmx
  ON PRIMARY (
    NAME = transporte_cdmx,
    FILENAME = '/fbd/fundamentos/transporte_cdmx.mdf',
    SIZE = 10MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 50%
  )
  LOG ON (
    NAME = transporte_cdmx_log,
    FILENAME = '/fbd/fundamentos/transporte_cdmx_Log.ldf',
    SIZE = 2MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 2MB
  );
GO
PRINT "BASE DE DATOS CREADA: 'transporte_cdmx'";

-- Crea la tabla usuario.
CREATE TABLE transporte_cdmx.dbo.usuario (
  id_usuario varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  correo_electronico varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  password varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  nombre varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  apellido_paterno varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  apellido_materno varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  saldo money NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL
);

-- Crea la tabla distancia.
CREATE TABLE transporte_cdmx.dbo.distancia (
  id_usuario varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  nombre_estacion varchar(100) COLLATE Modern_Spanish_CI_AS NULL
);

-- Crea la tabla estacion
CREATE TABLE transporte_cdmx.dbo.estacion (
  nombre_estacion varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  horario time(1) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  calle varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero int NULL,
  municipio varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ciudad varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  codigo_postal varchar(5) COLLATE Modern_Spanish_CI_AS NULL
);

-- Crea la tabla pertenecer_ruta
CREATE TABLE transporte_cdmx.dbo.pertenecer_ruta (
  nombre_estacion varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  numero_ruta integer NULL,
  tipo_transporte varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  disponible bit NULL,
  razon varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_disponible datetime NULL
);

-- Crea la tabla linea_ruta
CREATE TABLE transporte_cdmx.dbo.linea_ruta (
  numero_ruta integer NULL,
  tipo_transporte varchar(50) COLLATE Modern_Spanish_CI_AS NULL
);

-- Crea la tabla colectivo
CREATE TABLE transporte_cdmx.dbo.colectivo (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero_ruta integer NULL,
  tipo_transporte varchar(50) COLLATE Modern_Spanish_CI_AS NULL
);

-- Crea la tabla empleado
CREATE TABLE transporte_cdmx.dbo.empleado (
  id_empleado varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  nombre varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  apellido_paterno varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  apellido_materno varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_nacimiento datetime NULL,
  grado_maximi_estudios varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  genero char(1) COLLATE Modern_Spanish_CI_AS NULL,
  horario time NULL,
  calle varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero int NULL,
  municipio varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ciudad varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  codigo_postal varchar(5) COLLATE Modern_Spanish_CI_AS NULL,
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL
);

-- Crea la tabla licencia
CREATE TABLE transporte_cdmx.dbo.licencia (
  id_empleado varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  folio varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  tipo char(1) NULL,
  fecha_expedicion datetime NULL,
  fecha_vencimiento datetime NULL
);

-- Crea la tabla examen_medico
CREATE TABLE transporte_cdmx.dbo.examen_medico (
  id_empleado varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha datetime NULL,
  cedula char(8) NULL,
  estatus varchar(10) COLLATE Modern_Spanish_CI_AS NULL,
  talla float(1) NULL,
  presion varchar(10) NULL, 
  peso float(1) NULL
);

-- Crea la tabla reparacion
CREATE TABLE transporte_cdmx.dbo.reparacion (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  id_taller varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ingreso datetime NULL,
  salida datetime NULL,
  motivo varchar(100) NULL
);

-- Crea la tabla taller
CREATE TABLE transporte_cdmx.dbo.taller (
  id_taller varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  razon_social varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  horario datetime NULL,
  calle varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero int NULL,
  municipio varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ciudad varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  codigo_postal varchar(5) COLLATE Modern_Spanish_CI_AS NULL
);

-- Crea la tabla telefono_taller
CREATE TABLE transporte_cdmx.dbo.telefono_taller (
  id_taller varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  telefono varchar(10) NULL
);

-- Crea la tabla metro
CREATE TABLE transporte_cdmx.dbo.metro (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  ICCID int NULL,
  fecha_asignacion_sim datetime NULL
);

-- Crea la tabla metrobus
CREATE TABLE transporte_cdmx.dbo.metrobus (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  ICCID int NULL,
  fecha_asignacion_sim datetime NULL
);

-- Crea la tabla trolebus
CREATE TABLE transporte_cdmx.dbo.trolebus (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  ICCID int NULL,
  fecha_asignacion_sim datetime NULL
);

-- Crea la tabla tren_ligero
CREATE TABLE transporte_cdmx.dbo.tren_ligero (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  ICCID int NULL,
  fecha_asignacion_sim datetime NULL
);

-- Crea la tabla rtp
CREATE TABLE transporte_cdmx.dbo.rtp (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  ICCID int NULL,
  fecha_asignacion_sim datetime NULL
);

-- Crea la tabla microbus
CREATE TABLE transporte_cdmx.dbo.microbus (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  ICCID int NULL,
  fecha_asignacion_sim datetime NULL
);

-- Crea la tabla taxi
CREATE TABLE transporte_cdmx.dbo.taxi (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  ICCID int NULL,
  fecha_asignacion_sim datetime NULL,
  numero_sitio int NULL
);

-- Crea la tabla sitio
CREATE TABLE transporte_cdmx.dbo.sitio (
  numero_sitio int NULL,
  nombre varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  telefono varchar(10) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  calle varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero int NULL,
  municipio varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ciudad varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  codigo_postal varchar(5) COLLATE Modern_Spanish_CI_AS NULL
);

-- Crea la tabla sim
CREATE TABLE transporte_cdmx.dbo.sim (
  ICCID int NULL,
  tipo_de_red varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  asignada bit NULL
);