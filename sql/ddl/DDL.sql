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
  id_usuario varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL,
  correo_electronico varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  password varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  nombre varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  apellido_paterno varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  apellido_materno varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  saldo money NULL,
  latitud decimal(6,3) NULL,
  longitud decimal(6,3) NULL,
  CONSTRAINT PK_Usuario PRIMARY KEY 
  (
    id_usuario
  ) 
);

-- Crea la tabla estacion
CREATE TABLE transporte_cdmx.dbo.estacion (
  nombre_estacion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL,
  horario time(1) NULL,
  latitud decimal(6,3) NULL,
  longitud decimal(6,3) NULL,
  calle varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero int NULL,
  municipio varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ciudad varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  codigo_postal varchar(5) COLLATE Modern_Spanish_CI_AS NULL,
  CONSTRAINT PK_Estacion PRIMARY KEY 
  (
    nombre_estacion
  ) 
);

-- Crea la tabla distancia.
CREATE TABLE transporte_cdmx.dbo.distancia (
  id_usuario varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL,
  nombre_estacion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL,
  CONSTRAINT PK_Distancia PRIMARY KEY 
  (
    id_usuario,
    nombre_estacion
  ),
  CONSTRAINT FK_Distancia_Usuario FOREIGN KEY
  (
    id_usuario
  ) REFERENCES transporte_cdmx.dbo.usuario (
    id_usuario
  ),
  CONSTRAINT FK_Distancia_Estacion FOREIGN KEY
  (
    nombre_estacion
  ) REFERENCES transporte_cdmx.dbo.estacion (
    nombre_estacion
  )
);

-- Crea la tabla taller
CREATE TABLE transporte_cdmx.dbo.taller (
  id_taller varchar(50) COLLATE Modern_Spanish_CI_AS NOt NULL,
  razon_social varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  horario datetime NULL,
  calle varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero int NULL,
  municipio varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ciudad varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  codigo_postal varchar(5) COLLATE Modern_Spanish_CI_AS NULL,
  CONSTRAINT PK_taller PRIMARY KEY 
  (
    id_taller
  )
);

-- Crea la tabla telefono_taller
CREATE TABLE transporte_cdmx.dbo.telefono_taller (
  id_taller varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  telefono varchar(10) NOT NULL,
  CONSTRAINT PK_telefono_taller PRIMARY KEY 
  (
    id_taller,
    telefono
  ),
  CONSTRAINT FK_Telefono_Taller FOREIGN KEY
  (
    id_taller
  ) REFERENCES transporte_cdmx.dbo.taller (
    id_taller
  )
);

-- Crea la tabla vehículo
CREATE TABLE transporte_cdmx.dbo.vehiculo (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  fecha_de_inicio datetime NULL,
  capacidad_pasajeros int NULL,
  tipo_combustible varchar(50) NULL,
  latitud decimal(6,3) NULL,
  longitud decimal(6,3) NULL,
  ICCID int NOT NULL,
  fecha_asignacion_sim datetime NULL
  CONSTRAINT PK_vehiculo PRIMARY KEY 
  (
    id_vehiculo
  )
)

-- Crea la tabla reparacion
CREATE TABLE transporte_cdmx.dbo.reparacion (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  id_taller varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  ingreso datetime NULL,
  salida datetime NULL,
  motivo varchar(100) NULL,
  CONSTRAINT PK_Reparacion PRIMARY KEY 
  (
    id_vehiculo,
    id_taller
  ),
  CONSTRAINT FK_Taller_Reparacion FOREIGN KEY
  (
    id_taller
  ) REFERENCES transporte_cdmx.dbo.taller (
    id_taller
  ),
  CONSTRAINT FK_Vehiculo_Reparacion FOREIGN KEY
  (
    id_vehiculo
  ) REFERENCES transporte_cdmx.dbo.vehiculo (
    id_vehiculo
  )
);

-- Crea la tabla empleado
CREATE TABLE transporte_cdmx.dbo.empleado (
  id_empleado varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
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
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  CONSTRAINT PK_Empleado PRIMARY KEY
  (
    id_empleado
  ),
  CONSTRAINT FK_Empleado_Vehiculo FOREIGN KEY
  (
    id_vehiculo
  ) REFERENCES transporte_cdmx.dbo.vehiculo (
    id_vehiculo
  )
);

-- Crea la tabla licencia
CREATE TABLE transporte_cdmx.dbo.licencia (
  id_empleado varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  folio varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL,
  tipo char(1) NULL,
  fecha_expedicion datetime NULL,
  fecha_vencimiento datetime NULL, 
  CONSTRAINT PK_Licencia PRIMARY KEY
  (
    folio
  ),
  CONSTRAINT FK_Empleado_Licencia FOREIGN KEY
  (
    id_empleado
  ) REFERENCES transporte_cdmx.dbo.empleado (
    id_empleado
  )
);

-- Crea la tabla examen_medico
CREATE TABLE transporte_cdmx.dbo.examen_medico (
  id_empleado varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  fecha datetime NOT NULL,
  cedula char(8) NULL,
  estatus varchar(10) COLLATE Modern_Spanish_CI_AS NULL,
  talla float(1) NULL,
  presion varchar(10) NULL, 
  peso float(1) NULL,
  CONSTRAINT PK_Examen PRIMARY KEY
  (
    id_empleado,
    fecha
  ),
  CONSTRAINT FK_Empleado_Examen FOREIGN KEY
  (
    id_empleado
  ) REFERENCES transporte_cdmx.dbo.empleado (
    id_empleado
  )
);

-- Crea la tabla sitio
CREATE TABLE transporte_cdmx.dbo.sitio (
  numero_sitio int NOT NULL,
  nombre varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  telefono varchar(10) NULL,
  latitud decimal(6,2) NULL,
  longitud decimal(6,2) NULL,
  calle varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  numero int NULL,
  municipio varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  ciudad varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  codigo_postal varchar(5) COLLATE Modern_Spanish_CI_AS NULL,
  CONSTRAINT PK_Sitio PRIMARY KEY 
  (
    numero_sitio
  )
);

-- Crea la tabla linea_ruta
CREATE TABLE transporte_cdmx.dbo.linea_ruta (
  numero_ruta integer NOT NULL,
  tipo_transporte varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  CONSTRAINT PK_LineaRuta PRIMARY KEY
  (
    numero_ruta,
    tipo_transporte
  )
);

-- Crea la tabla colectivo
CREATE TABLE transporte_cdmx.dbo.colectivo (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  numero_ruta integer NULL,
  tipo_transporte varchar(50) COLLATE Modern_Spanish_CI_AS NULL,
  CONSTRAINT PK_Colectivo PRIMARY KEY 
  (
    id_vehiculo
  ),
  CONSTRAINT FK_IDColectivo FOREIGN KEY
  (
    id_vehiculo
  ) REFERENCES transporte_cdmx.dbo.vehiculo (
    id_vehiculo
  ),
  CONSTRAINT FK_Colectivo_Ruta FOREIGN KEY
  (
    numero_ruta,
    tipo_transporte
  ) REFERENCES transporte_cdmx.dbo.linea_ruta (
    numero_ruta,
    tipo_transporte
  )
);

-- Crea la tabla pertenecer_ruta
CREATE TABLE transporte_cdmx.dbo.pertenecer_ruta (
  nombre_estacion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL,
  numero_ruta integer NOT NULL,
  tipo_transporte varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  disponible bit NULL,
  razon varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
  fecha_disponible datetime NULL,
  CONSTRAINT PK_Pertenecer_Ruta PRIMARY KEY 
  (
    nombre_estacion,
    numero_ruta,
    tipo_transporte
  ),
  CONSTRAINT FK_Pertenecer_Estacion FOREIGN KEY
  (
    nombre_estacion
  ) REFERENCES transporte_cdmx.dbo.estacion (
    nombre_estacion
  ),
  CONSTRAINT FK_Pertencer_LineaRuta FOREIGN KEY
  ( 
    numero_ruta,
    tipo_transporte
  ) REFERENCES transporte_cdmx.dbo.linea_ruta (
    numero_ruta,
    tipo_transporte
  )
);

-- Crea la tabla taxi
CREATE TABLE transporte_cdmx.dbo.taxi (
  id_vehiculo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL,
  numero_sitio int NULL,
  CONSTRAINT PK_Taxi PRIMARY KEY 
  (
    id_vehiculo
  ),
  CONSTRAINT FK_Taxi FOREIGN KEY
  (
    id_vehiculo
  ) REFERENCES transporte_cdmx.dbo.vehiculo (
    id_vehiculo
  )
);
PRINT "TODAS LAS TABLAS CREADAS CON ÉXITO"
